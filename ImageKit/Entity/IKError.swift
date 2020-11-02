//
//  IKError.swift
//  ImageKitIO
//
//  Created by Abhinav Dhiman on 29/09/20.
//

import Foundation

public enum IKError: Error {
    public enum SignatureError: Error {
        case invalidSignatureResponse(String)
    }

    public enum HTTPError: Error {
        case transportError(Error)
        case serverSideError(Int)
    }

    public enum MultipartEncodingFailureReason {
        case inputStreamReadFailed(error: Error)
    }

    case multipartEncodingFailed(reason: MultipartEncodingFailureReason)
}
