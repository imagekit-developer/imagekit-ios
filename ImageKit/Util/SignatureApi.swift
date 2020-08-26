//
//  SignatureApi.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 27/07/20.
//

import Foundation
import Alamofire

class SignatureAPI {
    public static func getSignature(expire: String, headerMap: [String: String]?, completion: @escaping (Result<SignatureAPIResponse>) -> ()){
        let endpoint = UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_AUTHENTICATION_ENDPOINT)!
        Alamofire.request(endpoint, headers: headerMap).validate(statusCode: 200...299).responseSignatureAPIResponse{ response in
            switch response.result{
                case .success(let signatureAPIResponse):
                    completion(Result.success(signatureAPIResponse))
                case .failure(let error):
                    completion(Result.failure(error))
            }
        }
    }
}

