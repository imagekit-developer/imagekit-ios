//
//  ImageKitUploader.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 27/07/20.
//

import Foundation
import Alamofire

public class ImageKitUploader{
    
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
        completion: @escaping (Result<UploadAPIResponse>)-> Void) {
        if let publicKey = UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_CLIENT_PUBLIC_KEY), let _ = UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_AUTHENTICATION_ENDPOINT) {
            let expire = String(format: "%.0f", NSDate().timeIntervalSince1970 * 1000)
            SignatureAPI.getSignature(expire: expire, headerMap: signatureHeaders, completion: { result in
                switch result{
                    case .success(let signatureApiResponse):
                        UploadAPI.upload(
                            file: file,
                            publicKey: publicKey,
                            signature: signatureApiResponse,
                            fileName: fileName,
                            useUniqueFileName: useUniqueFilename,
                            tags: tags.joined(separator: ","),
                            folder: folder,
                            isPrivateFile: isPrivateFile!,
                            progressClosure: progress,
                            completion: { uploadResult in
                                completion(uploadResult)
                        })
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
        completion: @escaping (Result<UploadAPIResponse>)-> Void) {
        let image = UIImagePNGRepresentation(file)!
        self.upload(file: image, fileName: fileName, useUniqueFilename: useUniqueFilename, tags: tags, folder: folder, isPrivateFile: isPrivateFile, customCoordinates: customCoordinates, responseFields: responseFields, signatureHeaders: signatureHeaders, progress: progress, completion: completion)
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
        completion: @escaping (Result<UploadAPIResponse>)-> Void) {
        self.upload(file: file.data(using: .utf8)!, fileName: fileName, useUniqueFilename: useUniqueFilename, tags: tags, folder: folder, isPrivateFile: isPrivateFile, customCoordinates: customCoordinates, responseFields: responseFields, signatureHeaders: signatureHeaders, progress: progress, completion: completion)
    }
}
