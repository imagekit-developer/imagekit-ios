//
//  UploadApi.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 13/08/20.
//

import Foundation

class UploadAPI: NSObject, URLSessionTaskDelegate {
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
        progressClosure: ((Progress) -> Void)? = nil,
        urlConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
        uploadPolicy: UploadPolicy,
        completion: @escaping (Result<(HTTPURLResponse?, UploadAPIResponse?), Error>) -> Void,
        retryCount: Int = 0
    ) {
        
        let mimeType = MimeDetector.mimeType(data: file)?.mime ?? "image/png"

        var request = URLRequest(url: URL(string: "https://upload.imagekit.io/api/v1/files/upload")!)
        request.httpMethod = "POST"

        let formData = MultipartFormData()
        formData.append(file, withName: "file", fileName: fileName, mimeType: mimeType)
        formData.append(publicKey.data(using: String.Encoding.utf8)!, withName: "publicKey")
        formData.append(signature.signature.data(using: String.Encoding.utf8)!, withName: "signature")
        formData.append(String(signature.expire).data(using: String.Encoding.utf8)!, withName: "expire")
        formData.append(signature.token.data(using: String.Encoding.utf8)!, withName: "token")
        formData.append(fileName.data(using: String.Encoding.utf8)!, withName: "fileName")
        formData.append(String(useUniqueFileName).data(using: String.Encoding.utf8)!, withName: "useUniqueFileName")
        formData.append(tags.data(using: String.Encoding.utf8)!, withName: "tags")
        formData.append(folder!.data(using: String.Encoding.utf8)!, withName: "folder")
        formData.append(String(isPrivateFile).data(using: String.Encoding.utf8)!, withName: "isPrivateFile")
        formData.append(customCoordinates!.data(using: String.Encoding.utf8)!, withName: "customCoordinates")
        formData.append(responseFields!.data(using: String.Encoding.utf8)!, withName: "responseFields")

        request.setValue(formData.contentType, forHTTPHeaderField: "Content-Type")

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(getRetryTimeOut(uploadPolicy, retryCount))) {
            do {
                let multipartData = try formData.encode()
                request.httpBody = multipartData
                let uploadDelegate = UploadTaskDelegate()
                let urlSession = URLSession(configuration: urlConfiguration, delegate: URLSession.shared.delegate, delegateQueue: URLSession.shared.delegateQueue)
                uploadDelegate.uploadProgressHandler = progressClosure
                let task = urlSession.dataTask(with: request) { data, response, error in
                    if let error = error {
                        completion(Result.failure(error))
                        return
                    }
                    let response = response as! HTTPURLResponse
                    let status = response.statusCode
                    if (200...299).contains(status) {
                        completion(Result.success((response, try? IKJSONDecoder().decode(UploadAPIResponse.self, from: data!))))
                    } else if (400..<500).contains(status) || retryCount == uploadPolicy.maxErrorRetries {
                        let uploadApiError = try? IKJSONDecoder().decode(UploadAPIError.self, from: data!)
                        completion(Result.failure(uploadApiError!))
                    } else {
                        upload(
                            file: file,
                            publicKey: publicKey,
                            signature: signature,
                            fileName: fileName,
                            useUniqueFileName: useUniqueFileName,
                            tags: tags,
                            folder: folder,
                            isPrivateFile: isPrivateFile,
                            progressClosure: progressClosure,
                            urlConfiguration: urlConfiguration,
                            uploadPolicy: uploadPolicy,
                            completion: completion,
                            retryCount: retryCount + 1
                        )
                    }
                }
                task.resume()
            } catch let error {
                completion(Result.failure(error))
            }
        }
    }
    
    private static func getRetryTimeOut(_ policy: UploadPolicy, _ retryCount: Int) -> Int {
        return policy.backoffPolicy == UploadPolicy.BackoffPolicy.LINEAR
            ? policy.backoffMillis * retryCount
            : policy.backoffPolicy == UploadPolicy.BackoffPolicy.EXPONENTIAL && retryCount > 0
                ? policy.backoffMillis * Int(pow(2.0, Double(retryCount - 1)))
                : 0
    }

    public typealias HTTPHeaders = [String: String]

    private class MultipartFormData {

        public var boundary: String
        private var bodyParts: [BodyPart]
        private let streamBufferSize: Int

        open lazy var contentType: String = "multipart/form-data; boundary=\(self.boundary)"

        public var contentLength: UInt64 { return bodyParts.reduce(0) { $0 + $1.bodyContentLength } }

        public init() {
            self.boundary = "Boundary-\(UUID().uuidString)"
            self.bodyParts = []
            self.streamBufferSize = 1024
        }

        class BodyPart {
            let headers: HTTPHeaders
            let bodyStream: InputStream
            let bodyContentLength: UInt64
            var hasInitialBoundary = false
            var hasFinalBoundary = false

            init(headers: HTTPHeaders, bodyStream: InputStream, bodyContentLength: UInt64) {
                self.headers = headers
                self.bodyStream = bodyStream
                self.bodyContentLength = bodyContentLength
            }
        }

        public func append(_ data: Data, withName name: String) {
            let headers = contentHeaders(withName: name)
            let stream = InputStream(data: data)
            let length = UInt64(data.count)

            append(stream, withLength: length, headers: headers)
        }

        public func append(_ data: Data, withName name: String, fileName: String, mimeType: String) {
            let headers = contentHeaders(withName: name, fileName: fileName, mimeType: mimeType)
            let stream = InputStream(data: data)
            let length = UInt64(data.count)

            append(stream, withLength: length, headers: headers)
        }

        public func append(_ stream: InputStream, withLength length: UInt64, headers: HTTPHeaders) {
            let bodyPart = BodyPart(headers: headers, bodyStream: stream, bodyContentLength: length)
            bodyParts.append(bodyPart)
        }

        public func encode() throws -> Data {

            var encoded = Data()

            bodyParts.first?.hasInitialBoundary = true
            bodyParts.last?.hasFinalBoundary = true

            for bodyPart in bodyParts {
                let encodedData = try encode(bodyPart)
                encoded.append(encodedData)
            }

            return encoded
        }

        private func encode(_ bodyPart: BodyPart) throws -> Data {
            var encoded = Data()

            let initialData = bodyPart.hasInitialBoundary ? initialBoundaryData() : encapsulatedBoundaryData()
            encoded.append(initialData.data(using: .utf8)!)

            let headerData = encodeHeaders(for: bodyPart)
            encoded.append(headerData)

            let bodyStreamData = try encodeBodyStream(for: bodyPart)
            encoded.append(bodyStreamData)

            if bodyPart.hasFinalBoundary {
                encoded.append(finalBoundaryData().data(using: .utf8)!)
            }

            return encoded
        }

        private func contentHeaders(withName name: String, fileName: String? = nil, mimeType: String? = nil) -> [String: String] {
            var disposition = "form-data; name=\"\(name)\""
            if let fileName = fileName { disposition += "; filename=\"\(fileName)\"" }

            var headers: [String: String] = [:]
            if let mimeType = mimeType { headers["Content-Type"] = mimeType }
            headers["Content-Disposition"] = disposition

            return headers
        }

        private func encodeHeaders(for bodyPart: BodyPart) -> Data {
            var headerText = ""

            for (key, value) in bodyPart.headers {
                headerText += "\(key): \(value)\r\n"
            }
            headerText += "\r\n"

            return headerText.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        }

        private func encodeBodyStream(for bodyPart: BodyPart) throws -> Data {
            let inputStream = bodyPart.bodyStream
            inputStream.open()
            defer { inputStream.close() }

            var encoded = Data()

            while inputStream.hasBytesAvailable {
                var buffer = [UInt8](repeating: 0, count: streamBufferSize)
                let bytesRead = inputStream.read(&buffer, maxLength: streamBufferSize)

                if let error = inputStream.streamError {
                    throw IKError.multipartEncodingFailed(reason: .inputStreamReadFailed(error: error))
                }

                if bytesRead > 0 {
                    encoded.append(buffer, count: bytesRead)
                } else {
                    break
                }
            }

            return encoded
        }

        private func initialBoundaryData() -> String {
            return "--\(boundary)\r\n"
        }

        private func encapsulatedBoundaryData() -> String {
            return "\r\n--\(boundary)\r\n"
        }

        private func finalBoundaryData() -> String {
            return "\r\n--\(boundary)--\r\n"
        }
    }
}

class UploadTaskDelegate: NSObject, URLSessionDataDelegate {

    var uploadProgress: Progress
    var uploadProgressHandler: ((Progress) -> Void)?

    override init() {
        uploadProgress = Progress(totalUnitCount: 0)
        super.init()
    }

    func reset() {
        uploadProgress = Progress(totalUnitCount: 0)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {

        uploadProgress.totalUnitCount = totalBytesExpectedToSend
        uploadProgress.completedUnitCount = totalBytesSent

        if let uploadProgressHandler = uploadProgressHandler {
            DispatchQueue.main.async { uploadProgressHandler(self.uploadProgress) }
        }

    }
}
