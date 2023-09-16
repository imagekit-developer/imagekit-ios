//
//  UploadAuthService.swift
//  ImageKit_Example
//
//  Created by Animesh Verma on 16/09/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

class UploadAuthService {
    static let dispatchGroup = DispatchGroup()
    
    static func getUploadToken(payload: [String : Any]) -> [String : String]? {
        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: URLSession.shared.delegate, delegateQueue: URLSession.shared.delegateQueue)
        var request = URLRequest(url: URL(string: "https://a19c-125-63-122-172.ngrok-free.app")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        var tokenResponse: [String : String]? = nil
        guard let body = try? JSONSerialization.data(withJSONObject: TokenRequest(uploadPayload: payload, expire: 60, publicKey: "public_5P5QM23aRv9XkOcfJO1okZ0DzOw=")) else {
            return nil
        }
        dispatchGroup.enter()
        DispatchQueue.global().async {
            let task = urlSession.dataTask(with: request) { data, response, error in
                guard let error = error else {
                    dispatchGroup.leave()
                    return
                }
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    dispatchGroup.leave()
                    return
                }
                if let data = data {
                    tokenResponse = try? (JSONSerialization.jsonObject(with: data) as! [String : String])
                }
                dispatchGroup.leave()
            }
            task.resume()
        }
        dispatchGroup.wait()
        return tokenResponse
    }
}
