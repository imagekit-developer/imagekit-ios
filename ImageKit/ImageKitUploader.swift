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
        fileName: String,
        useUniqueFilename: Bool = true,
        tags: [String] = [],
        folder: String? = "/",
        isPrivateFile: Bool? = false,
        customCoordinates: String? = "",
        responseFields: String? = "",
        signatureHeaders: [String: String]? = [String: String](),
        progress: ((Progress) -> Void)? = nil,
        urlConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
        policy: UploadPolicy = ImageKit.shared.defaultUploadPolicy,
        completion: @escaping (Result<(HTTPURLResponse?, UploadAPIResponse?), Error>) -> Void) {
        let publicKey = UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_CLIENT_PUBLIC_KEY)
        let authEndpoint = UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_AUTHENTICATION_ENDPOINT)
        if publicKey != nil &&  authEndpoint != nil && publicKey?.isEmpty == false && authEndpoint?.isEmpty == false {
            let expire = String(format: "%.0f", NSDate().timeIntervalSince1970 * 1000)
            SignatureAPI.getSignature(expire: expire, headerMap: signatureHeaders, completion: { result in
                switch result {
                    case .success((_, let signatureApiResponse)):
                        if let signatureApiResponse = signatureApiResponse {
                            if self.checkUploadPolicy(policy, completion) {
                                UploadAPI.upload(
                                    file: file,
                                    publicKey: publicKey!,
                                    signature: signatureApiResponse,
                                    fileName: fileName,
                                    useUniqueFileName: useUniqueFilename,
                                    tags: tags.joined(separator: ","),
                                    folder: folder,
                                    isPrivateFile: isPrivateFile!,
                                    progressClosure: progress,
                                    urlConfiguration: urlConfiguration,
                                    uploadPolicy: policy,
                                    completion: { uploadResult in
                                        completion(uploadResult)
                                })
                            } else {
                                print("Upload policy check failed")
                            }
                        } else {
                            completion(Result.failure(IKError.SignatureError.invalidSignatureResponse("Invalid Signature")))
                        }
                    case .failure(let error):
                        completion(Result.failure(error))
                }
            })
        } else {
            fatalError("Public Key / Authentication Endpoint is not defined while initalizing the SDK")
        }

    }

    public func upload(
        file: UIImage,
        fileName: String,
        useUniqueFilename: Bool = true,
        tags: [String] = [],
        folder: String? = "/",
        isPrivateFile: Bool? = false,
        customCoordinates: String? = "",
        responseFields: String? = "",
        signatureHeaders: [String: String]? = [String: String](),
        progress: ((Progress) -> Void)? = nil,
        urlConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
        completion: @escaping (Result<(HTTPURLResponse?, UploadAPIResponse?), Error>) -> Void) {
        let image = UIImagePNGRepresentation(file)!
        self.upload(file: image, fileName: fileName, useUniqueFilename: useUniqueFilename, tags: tags, folder: folder, isPrivateFile: isPrivateFile, customCoordinates: customCoordinates, responseFields: responseFields, signatureHeaders: signatureHeaders, progress: progress, urlConfiguration: urlConfiguration, completion: completion)
    }

    public func upload(
        file: String,
        fileName: String,
        useUniqueFilename: Bool = true,
        tags: [String] = [],
        folder: String? = "/",
        isPrivateFile: Bool? = false,
        customCoordinates: String? = "",
        responseFields: String? = "",
        signatureHeaders: [String: String]? = [String: String](),
        progress: ((Progress) -> Void)? = nil,
        urlConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
        completion: @escaping (Result<(HTTPURLResponse?, UploadAPIResponse?), Error>) -> Void) {
        self.upload(file: file.data(using: .utf8)!, fileName: fileName, useUniqueFilename: useUniqueFilename, tags: tags, folder: folder, isPrivateFile: isPrivateFile, customCoordinates: customCoordinates, responseFields: responseFields, signatureHeaders: signatureHeaders, progress: progress, urlConfiguration: urlConfiguration, completion: completion)
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
