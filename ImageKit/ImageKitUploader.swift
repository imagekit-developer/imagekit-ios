//
//  ImageKitUploader.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 27/07/20.
//

import Foundation
import Network
import Reachability

public class ImageKitUploader {

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
        extensions: [String : Any]? = nil,
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
                file: file,
                token: token,
                fileName: fileName,
                useUniqueFileName: useUniqueFilename,
                tags: tags?.joined(separator: ","),
                folder: folder,
                isPrivateFile: isPrivateFile,
                progressClosure: progress,
                urlConfiguration: urlConfiguration,
                completion: { uploadResult in
                    completion(uploadResult)
                }
            )
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
        extensions: [String : Any]? = nil,
        webhookUrl: String? = nil,
        overwriteFile: Bool? = nil,
        overwriteAITags: Bool? = nil,
        overwriteTags: Bool? = nil,
        overwriteCustomMetadata: Bool? = nil,
        customMetadata: [String : Any]? = nil,
        progress: ((Progress) -> Void)? = nil,
        urlConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
        completion: @escaping (Result<(HTTPURLResponse?, UploadAPIResponse?), Error>) -> Void) {
        let image = UIImagePNGRepresentation(file)!
            self.upload(file: image, token: token, fileName: fileName, useUniqueFilename: useUniqueFilename, tags: tags, folder: folder, isPrivateFile: isPrivateFile, customCoordinates: customCoordinates, responseFields: responseFields, progress: progress, urlConfiguration: urlConfiguration, completion: completion)
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
        extensions: [String : Any]? = nil,
        webhookUrl: String? = nil,
        overwriteFile: Bool? = nil,
        overwriteAITags: Bool? = nil,
        overwriteTags: Bool? = nil,
        overwriteCustomMetadata: Bool? = nil,
        customMetadata: [String : Any]? = nil,
        progress: ((Progress) -> Void)? = nil,
        urlConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
        completion: @escaping (Result<(HTTPURLResponse?, UploadAPIResponse?), Error>) -> Void) {
            self.upload(file: file.data(using: .utf8)!, token: token, fileName: fileName, useUniqueFilename: useUniqueFilename, tags: tags, folder: folder, isPrivateFile: isPrivateFile, customCoordinates: customCoordinates, responseFields: responseFields, progress: progress, urlConfiguration: urlConfiguration, completion: completion)
    }
    
    internal func checkUploadPolicy(_ policy: UploadPolicy, _ completion: @escaping (Result<(HTTPURLResponse?, UploadAPIResponse?), Error>) -> Void) -> Bool {
        if policy.networkType == UploadPolicy.NetworkType.UNMETERED {
            var isNetworkMetered = false
            if #available(iOS 12.0, *) {
                isNetworkMetered = NWPathMonitor().currentPath.isExpensive
            } else {
                isNetworkMetered = (try? Reachability())?.connection != .wifi
            }
            if isNetworkMetered {
                completion(Result.failure(UploadAPIError(message: "POLICY_ERROR_METERED_NETWORK", help: nil)))
                return false
            }
        }
        if policy.requiresCharging && UIDevice.current.batteryState == UIDevice.BatteryState.unplugged {
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
