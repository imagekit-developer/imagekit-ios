//
//  SignatureApi.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 27/07/20.
//

import Foundation

class SignatureAPI {
    public static func getSignature(expire: String, headerMap: [String: String]?, completion: @escaping (Result<(HTTPURLResponse?, SignatureAPIResponse?), Error>) -> Void) {
        let endpoint = UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_AUTHENTICATION_ENDPOINT)!
        URLSession.shared.dataTask(with: URL(string: endpoint)!) {(data, response, error) in
                if let error = error {
                    completion(Result.failure(IKError.HTTPError.transportError(error)))
                    return
                }
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    completion(Result.failure(IKError.HTTPError.serverSideError(status)))
                    return
                }
                completion(Result.success((response, try? IKJSONDecoder().decode(SignatureAPIResponse.self, from: data!))))
        }.resume()
    }
}
