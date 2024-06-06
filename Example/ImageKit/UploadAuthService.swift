//
//  UploadAuthService.swift
//  ImageKit_Example
//
//  Created by Animesh Verma on 25/09/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

class UploadAuthService {
    static let dispatchGroup = DispatchGroup()
    
    static func getUploadToken(payload: [String : String]) -> [String : String]? {
        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: URLSession.shared.delegate, delegateQueue: URLSession.shared.delegateQueue)
        var request = URLRequest(url: URL(string: AUTH_SERVER_API_ENDPOINT)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        var tokenResponse: [String : String]? = nil
        guard let body = try? JSONSerialization.data(withJSONObject: ["uploadPayload": payload, "expire": 60, "publicKey": "IK_PUBLIC_KEY"] as [String : Any]) else {
            return nil
        }
        request.httpBody = body
        dispatchGroup.enter()
        DispatchQueue.global().async {
            let task = urlSession.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    dispatchGroup.leave()
                    print(error)
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
