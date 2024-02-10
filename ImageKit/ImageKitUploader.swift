//
//  ImageKitUploader.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 27/07/20.
//

import Foundation
import Network

public class ImageKitUploader {
    
    var currentNetworkPath: NWPath
    
    public init() {
        let monitor = NWPathMonitor()
        currentNetworkPath = monitor.currentPath
        monitor.pathUpdateHandler = { path in
            self.currentNetworkPath = path
        }
        monitor.start(queue: .main)
        UIDevice.current.isBatteryMonitoringEnabled = true
    }

    public func upload(
        file: Data,
        token: String,
        fileName: String,
        useUniqueFilename: Bool? = nil,
        tags: [String]? = nil,
        folder: String? = nil,
        isPrivateFile: Bool? = nil,
        customCoordinates: String? = nil,
        responseFields: String? = nil,
        extensions: [[String : Any]]? = nil,
        webhookUrl: String? = nil,
        overwriteFile: Bool? = nil,
        overwriteAITags: Bool? = nil,
        overwriteTags: Bool? = nil,
        overwriteCustomMetadata: Bool? = nil,
        customMetadata: [String : Any]? = nil,
        progress: ((Progress) -> Void)? = nil,
        urlConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
        policy: UploadPolicy = ImageKit.shared.defaultUploadPolicy,
        preprocessor: UploadPreprocessor<Data>? = nil,
        completion: @escaping (Result<(HTTPURLResponse?, UploadAPIResponse?), Error>) -> Void) {
            if checkUploadPolicy(policy, completion) {
                DispatchQueue.global(qos: .default).async {
                    var fileData = file
                    if let imageProcessor = preprocessor as? ImageUploadPreprocessor<Data> {
                        fileData = imageProcessor.outputFile(input: file, fileName: fileName)
                    } else if let videoProcessor = preprocessor as? VideoUploadPreprocessor {
                        videoProcessor.listener = { data in
                            UploadAPI.upload(
                                file: data,
                                token: token,
                                fileName: fileName,
                                useUniqueFileName: useUniqueFilename,
                                tags: tags?.joined(separator: ","),
                                folder: folder,
                                isPrivateFile: isPrivateFile,
                                customCoordinates: customCoordinates,
                                responseFields: responseFields,
                                extensions: extensions,
                                webhookUrl: webhookUrl,
                                overwriteFile: overwriteFile,
                                overwriteAITags: overwriteAITags,
                                overwriteTags: overwriteTags,
                                overwriteCustomMetadata: overwriteCustomMetadata,
                                customMetadata: customMetadata,
                                progressClosure: progress,
                                urlConfiguration: urlConfiguration,
                                uploadPolicy: policy,
                                completion: { uploadResult in
                                    completion(uploadResult)
                                }
                            )
                        }
                        _ = videoProcessor.outputFile(input: file, fileName: fileName)
                        return
                    }
                    UploadAPI.upload(
                        file: fileData,
                        token: token,
                        fileName: fileName,
                        useUniqueFileName: useUniqueFilename,
                        tags: tags?.joined(separator: ","),
                        folder: folder,
                        isPrivateFile: isPrivateFile,
                        customCoordinates: customCoordinates,
                        responseFields: responseFields,
                        extensions: extensions,
                        webhookUrl: webhookUrl,
                        overwriteFile: overwriteFile,
                        overwriteAITags: overwriteAITags,
                        overwriteTags: overwriteTags,
                        overwriteCustomMetadata: overwriteCustomMetadata,
                        customMetadata: customMetadata,
                        progressClosure: progress,
                        urlConfiguration: urlConfiguration,
                        uploadPolicy: policy,
                        completion: { uploadResult in
                            completion(uploadResult)
                        }
                    )
                }
            }
        }

    public func upload(
        file: UIImage,
        token: String,
        fileName: String,
        useUniqueFilename: Bool? = nil,
        tags: [String]? = nil,
        folder: String? = nil,
        isPrivateFile: Bool? = nil,
        customCoordinates: String? = nil,
        responseFields: String? = nil,
        extensions: [[String : Any]]? = nil,
        webhookUrl: String? = nil,
        overwriteFile: Bool? = nil,
        overwriteAITags: Bool? = nil,
        overwriteTags: Bool? = nil,
        overwriteCustomMetadata: Bool? = nil,
        customMetadata: [String : Any]? = nil,
        progress: ((Progress) -> Void)? = nil,
        urlConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
        policy: UploadPolicy = ImageKit.shared.defaultUploadPolicy,
        preprocessor: ImageUploadPreprocessor<UIImage>? = nil,
        completion: @escaping (Result<(HTTPURLResponse?, UploadAPIResponse?), Error>) -> Void) {
            if checkUploadPolicy(policy, completion) {
                DispatchQueue.global(qos: .default).async {
                    let image = preprocessor != nil ? preprocessor!.outputFile(input: file, fileName: fileName) : UIImagePNGRepresentation(file)!
                    UploadAPI.upload(
                        file: image,
                        token: token,
                        fileName: fileName,
                        useUniqueFileName: useUniqueFilename,
                        tags: tags?.joined(separator: ","),
                        folder: folder,
                        isPrivateFile: isPrivateFile,
                        customCoordinates: customCoordinates,
                        responseFields: responseFields,
                        extensions: extensions,
                        webhookUrl: webhookUrl,
                        overwriteFile: overwriteFile,
                        overwriteAITags: overwriteAITags,
                        overwriteTags: overwriteTags,
                        overwriteCustomMetadata: overwriteCustomMetadata,
                        customMetadata: customMetadata,
                        progressClosure: progress,
                        urlConfiguration: urlConfiguration,
                        uploadPolicy: policy,
                        completion: { uploadResult in
                            completion(uploadResult)
                        }
                    )
                }
            }
        }

    public func upload(
        file: String,
        token: String,
        fileName: String,
        useUniqueFilename: Bool? = nil,
        tags: [String]? = nil,
        folder: String? = nil,
        isPrivateFile: Bool? = nil,
        customCoordinates: String? = nil,
        responseFields: String? = nil,
        extensions: [[String : Any]]? = nil,
        webhookUrl: String? = nil,
        overwriteFile: Bool? = nil,
        overwriteAITags: Bool? = nil,
        overwriteTags: Bool? = nil,
        overwriteCustomMetadata: Bool? = nil,
        customMetadata: [String : Any]? = nil,
        progress: ((Progress) -> Void)? = nil,
        urlConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
        policy: UploadPolicy = ImageKit.shared.defaultUploadPolicy,
        completion: @escaping (Result<(HTTPURLResponse?, UploadAPIResponse?), Error>) -> Void) {
            UploadAPI.upload(
                file: file.data(using: .utf8)!,
                token: token,
                fileName: fileName,
                useUniqueFileName: useUniqueFilename,
                tags: tags?.joined(separator: ","),
                folder: folder,
                isPrivateFile: isPrivateFile,
                customCoordinates: customCoordinates,
                responseFields: responseFields,
                extensions: extensions,
                webhookUrl: webhookUrl,
                overwriteFile: overwriteFile,
                overwriteAITags: overwriteAITags,
                overwriteTags: overwriteTags,
                overwriteCustomMetadata: overwriteCustomMetadata,
                customMetadata: customMetadata,
                progressClosure: progress,
                urlConfiguration: urlConfiguration,
                uploadPolicy: policy,
                completion: { uploadResult in
                    completion(uploadResult)
                }
            )
        }
    
    internal func checkUploadPolicy(_ policy: UploadPolicy, _ completion: @escaping (Result<(HTTPURLResponse?, UploadAPIResponse?), Error>) -> Void) -> Bool {
        if policy.networkType == .UNMETERED && currentNetworkPath.isExpensive {
            completion(Result.failure(UploadAPIError(message: "POLICY_ERROR_METERED_NETWORK", help: nil)))
            return false
        }
        if policy.requiresCharging && UIDevice.current.batteryState == .unplugged {
            completion(Result.failure(UploadAPIError(message: "POLICY_ERROR_BATTERY_DISCHARGING", help: nil)))
            return false
        }
        return true
    }
}

// MARK: - Helper functions for creating encoders and decoders
internal func IKJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}
