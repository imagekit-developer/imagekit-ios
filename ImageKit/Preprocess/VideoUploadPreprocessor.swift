//
//  VideoUploadPreprocessor.swift
//  ImageKitIO
//
//  Created by Animesh Verma on 18/10/23.
//

import Foundation
import AVFoundation

public final class VideoUploadPreprocessor : UploadPreprocessor<Data> {
    
    private let limit: (Int, Int)
    private let frameRate: Int
    private let keyFramesInterval: Int
    private let targetAudioBitrate: Int
    private let targetVideoBitrate: Int
    
    private lazy var completionListener: (Data) -> Void = {_ in }
    var listener: (Data) -> Void {
        get {
            completionListener
        }
        set {
            completionListener = newValue
        }
    }

    private init(limit: (Int, Int), frameRate: Int, keyFramesInterval: Int, targetAudioBitrate: Int, targetVideoBitrate: Int) {
        self.limit = limit
        self.frameRate = frameRate
        self.keyFramesInterval = keyFramesInterval
        self.targetAudioBitrate = targetAudioBitrate
        self.targetVideoBitrate = targetVideoBitrate
    }
    
    override internal func outputFile(input: Data, fileName: String) -> Data {
        let tempUrl = FileManager.default.temporaryDirectory.appendingPathComponent("\(NSUUID().uuidString).mp4")
        try! input.write(to: tempUrl)
        let asset = AVAsset(url: tempUrl)
        let tracks = asset.tracks
        print("tracks count: \(tracks.count)")
        let videoTrack = asset.tracks(withMediaType: .video).first!
        let audioTrack = asset.tracks(withMediaType: .audio).first
        let dimensions = videoTrack.naturalSize.applying(videoTrack.preferredTransform)
        let size = CGSize(width: fabs(dimensions.width), height: fabs(dimensions.height))
        print("dimensions: width: \(fabs(dimensions.width)), height: \(fabs(dimensions.height))")
        print("fps: \(videoTrack.minFrameDuration.seconds)")
        
        var audioWriteFinished = false
        var videoWriteFinished = false
        
              
        let reader = try! AVAssetReader(asset: asset)
        let assetReaderVideoTrackOutput = AVAssetReaderTrackOutput(track: videoTrack, outputSettings: [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32ARGB])
        var assetReaderAudioTrackOutput: AVAssetReaderTrackOutput?
        var audioWriterInput: AVAssetWriterInput?
        if audioTrack != nil {
            assetReaderAudioTrackOutput = AVAssetReaderTrackOutput(track: audioTrack!, outputSettings: nil)
            reader.add(assetReaderAudioTrackOutput!)
        } else {
            audioWriteFinished = true
        }
        reader.add(assetReaderVideoTrackOutput)
        
        let videoDispatchQueue = DispatchQueue(label: "video_dispatcher")
        let audioDispatchQueue = DispatchQueue(label: "audio_dispatcher")
        
        let processedVideoUrl = FileManager.default.temporaryDirectory.appendingPathComponent("\(NSUUID().uuidString).mp4")
        let writer = try! AVAssetWriter(url: processedVideoUrl, fileType: .mp4)
        let videoWriterInput = AVAssetWriterInput(
            mediaType: .video,
            outputSettings: [
                AVVideoCodecKey : AVVideoCodecType.h264,
                AVVideoWidthKey : min(Int(size.width), limit.0),
                AVVideoHeightKey : min(Int(size.height), limit.1),
                AVVideoCompressionPropertiesKey: [
                    AVVideoAverageNonDroppableFrameRateKey: frameRate,
                    AVVideoMaxKeyFrameIntervalKey: keyFramesInterval,
                    AVVideoAverageBitRateKey: targetVideoBitrate
                ]
            ]
        )
        writer.add(videoWriterInput)
        if audioTrack != nil {
            let pointee = CMAudioFormatDescriptionGetStreamBasicDescription(audioTrack!.formatDescriptions[0] as! CMAudioFormatDescription)!.pointee
            audioWriterInput = AVAssetWriterInput(
                mediaType: .audio,
                outputSettings: [
                    AVFormatIDKey: pointee.mFormatID,
                    AVEncoderBitRateKey: targetAudioBitrate,
                    AVSampleRateKey: pointee.mSampleRate
                ]
            )
            writer.add(audioWriterInput!)
        }
        writer.startWriting()
        reader.startReading()
        writer.startSession(atSourceTime: kCMTimeZero)
        
        videoWriterInput.requestMediaDataWhenReady(on: videoDispatchQueue, using: {
            while videoWriterInput.isReadyForMoreMediaData {
                guard let sample = assetReaderVideoTrackOutput.copyNextSampleBuffer() else {
                    guard writer.inputs.contains(videoWriterInput) == true else { return }
                    videoWriterInput.markAsFinished()
                    videoWriteFinished = true
                    if videoWriteFinished && audioWriteFinished {
                        writer.finishWriting(completionHandler: {
                            reader.cancelReading()
                            self.completionListener(try! Data(contentsOf: processedVideoUrl))
                        })
                    }
                    break
                }
                videoWriterInput.append(sample)
            }
        })
        
        if audioTrack != nil {
            audioWriterInput?.requestMediaDataWhenReady(on: audioDispatchQueue, using: {
                while audioWriterInput!.isReadyForMoreMediaData {
                    guard let sample = assetReaderAudioTrackOutput?.copyNextSampleBuffer() else {
                        guard writer.inputs.contains(audioWriterInput!) == true else { return }
                        audioWriterInput!.markAsFinished()
                        audioWriteFinished = true
                        if videoWriteFinished && audioWriteFinished {
                            writer.finishWriting(completionHandler: {
                                reader.cancelReading()
                                self.completionListener(try! Data(contentsOf: processedVideoUrl))
                            })
                        }
                        break
                    }
                    audioWriterInput!.append(sample)
                }
            })
        }
        
        return Data()
    }
    
    public class Builder {
        private var maxLimits: (Int, Int) = (Int.max, Int.max)
        private var frameRate: Int = 30
        private var keyFrameInterval: Int = 3
        private var audioBitrate: Int = 128
        private var videoBitrate: Int = 640
        
        public init() {}
        
        public func limit(width: Int, height: Int) -> Builder {
            maxLimits = (width, height)
            return self
        }
        
        public func frameRate(frameRateValue: Int) -> Builder {
            frameRate = frameRateValue
            return self
        }
        
        public func keyFramesInterval(interval: Int) -> Builder {
            keyFrameInterval = interval
            return self
        }
        
        public func targetAudioBitrateKbps(targetAudioBitrateKbps: Int) -> Builder {
            audioBitrate = targetAudioBitrateKbps * 1024
            return self
        }
        
        public func targetVideoBitrateKbps(targetVideoBitrateKbps: Int) -> Builder {
            videoBitrate = targetVideoBitrateKbps * 1024
            return self
        }
        
        public func build() -> VideoUploadPreprocessor {
            return VideoUploadPreprocessor(
                limit: maxLimits,
                frameRate: frameRate,
                keyFramesInterval: keyFrameInterval,
                targetAudioBitrate: audioBitrate,
                targetVideoBitrate: videoBitrate
            )
        }
    }
}
