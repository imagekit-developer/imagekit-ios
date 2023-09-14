//
//  ImageKitUploader.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 27/07/20.
//

import Foundation

public class ImageKitUploader {

    public func upload(
        file: Data,
        token: String,
        fileName: String,
        useUniqueFilename: Bool = true,
        tags: [String] = [],
        folder: String? = "/",
        isPrivateFile: Bool? = false,
        customCoordinates: String? = "",
        responseFields: String? = "",
        progress: ((Progress) -> Void)? = nil,
        urlConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
        completion: @escaping (Result<(HTTPURLResponse?, UploadAPIResponse?), Error>) -> Void) {
            UploadAPI.upload(
                file: file,
                token: token,
                fileName: fileName,
                useUniqueFileName: useUniqueFilename,
                tags: tags.joined(separator: ","),
                folder: folder,
                isPrivateFile: isPrivateFile!,
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
        useUniqueFilename: Bool = true,
        tags: [String] = [],
        folder: String? = "/",
        isPrivateFile: Bool? = false,
        customCoordinates: String? = "",
        responseFields: String? = "",
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
        useUniqueFilename: Bool = true,
        tags: [String] = [],
        folder: String? = "/",
        isPrivateFile: Bool? = false,
        customCoordinates: String? = "",
        responseFields: String? = "",
        progress: ((Progress) -> Void)? = nil,
        urlConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
        completion: @escaping (Result<(HTTPURLResponse?, UploadAPIResponse?), Error>) -> Void) {
            self.upload(file: file.data(using: .utf8)!, token: token, fileName: fileName, useUniqueFilename: useUniqueFilename, tags: tags, folder: folder, isPrivateFile: isPrivateFile, customCoordinates: customCoordinates, responseFields: responseFields, progress: progress, urlConfiguration: urlConfiguration, completion: completion)
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
