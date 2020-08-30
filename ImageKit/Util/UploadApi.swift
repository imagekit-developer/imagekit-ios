//
//  UploadApi.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 13/08/20.
//

import Foundation
import Alamofire

class UploadAPI {
    public static func upload(
        file: Data,
        publicKey: String,
        signature: SignatureAPIResponse,
        fileName: String,
        useUniqueFileName: Bool,
        tags: String,
        folder: String? = "",
        isPrivateFile: Bool,
        customCoordinates: String? = "",
        responseFields: String? = "",
        progressClosure: ((Progress) -> ())? = nil,
        completion: @escaping (Result<UploadAPIResponse>) -> ()){
        
        let endpoint = "https://upload.imagekit.io/api/v1/files/upload"
        let mimeType = MimeDetector.mimeType(data: file)?.mime ?? "image/png"
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(file, withName: "file", fileName: fileName, mimeType: mimeType)
            multipartFormData.append(publicKey.data(using: String.Encoding.utf8)!, withName: "publicKey")
            multipartFormData.append(signature.signature.data(using: String.Encoding.utf8)!, withName: "signature")
            multipartFormData.append(String(signature.expire).data(using: String.Encoding.utf8)!, withName: "expire")
            multipartFormData.append(signature.token.data(using: String.Encoding.utf8)!, withName: "token")
            multipartFormData.append(fileName.data(using: String.Encoding.utf8)!, withName: "fileName")
            multipartFormData.append(String(useUniqueFileName).data(using: String.Encoding.utf8)!, withName: "useUniqueFileName")
            multipartFormData.append(tags.data(using: String.Encoding.utf8)!, withName: "tags")
            multipartFormData.append(folder!.data(using: String.Encoding.utf8)!, withName: "folder")
            multipartFormData.append(String(isPrivateFile).data(using: String.Encoding.utf8)!, withName: "isPrivateFile")
            multipartFormData.append(customCoordinates!.data(using: String.Encoding.utf8)!, withName: "customCoordinates")
            multipartFormData.append(responseFields!.data(using: String.Encoding.utf8)!, withName: "responseFields")
        }, to: endpoint, method: .post){ result in
            switch result{
                case .success(let upload, _, _):
                    if progressClosure != nil{
                        upload.uploadProgress(closure: progressClosure!)
                    }
                    upload.responseUploadAPIResponse{ uploadApiResponse in
                        completion(uploadApiResponse.result)
                    }
                case .failure(let encodingError):
                    completion(Result.failure(encodingError))
            }
        }
    }
}
