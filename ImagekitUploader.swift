//
//  ImagekitUploader.swift
//  imagekit
//
//  Created by Akshit New on 28/01/20.
//

import Foundation


class ImageKitUploader {

        /**
         * Method to upload an image to ImageKit.
         * @param image The image bitmap that is to be uploaded
         * @param fileName The name with which the file has to be uploaded
         * @param signature HMAC-SHA1 signature generated for the file upload.
         * See <a href="https://docs.imagekit.io/#server-side-image-upload">https://docs.imagekit.io/#server-side-image-upload</a>
         * for more information.
         * @param timestamp UTC timestamp in seconds. The request will be valid for 30 minutes from this timestamp.
         * @param useUniqueFilename “true” or “false”. If set to true, ImageKit will add a unique code to the filename parameter
         * to get a unique filename. If false, the image is uploaded with the filename parameter as name. If an image exists
         * with the same name, this new image will override it. Default is “true”
         * @param tags Array of tags e.g tag1,tag2,tag3. The maximum length of all characters should not exceed 500.
         * % is not allowed. If this field is not specified and the file is overwritten then tags will be removed.
         * @param folder The folder path (eg- /images/folder/) in which the image has to be uploaded. Default is “/”
         * @param imageKitCallback Callback to communicate the result of the upload operation
         */
        
        public func uploadImage(_ image: Data, fileName: String, signature: String, timestamp: Date, useUniqueFilename: Bool = true, tags: Array<String>?, folder: String?, completionHandler: @escaping (_ data: UploadResponse?, _ isSuccessful: Bool, _ error: UploadError?) -> Void) {
            let mRepository = Repository.init()
            mRepository.uploadImage(image, fileName: fileName, signature: signature, timestamp: timestamp, tags: tags, folder: folder, completionHandler: completionHandler)
        }
        
        
        /**
         * Method to upload an image to ImageKit.
         * @param file The file that is to be uploaded. Supported formats: PDF, JS, CSS and TXT
         * @param fileName The name with which the file has to be uploaded
         * @param signature HMAC-SHA1 signature generated for the file upload.
         * See <a href="https://docs.imagekit.io/#server-side-image-upload">https://docs.imagekit.io/#server-side-image-upload</a>
         * for more information. * @param timestamp UTC timestamp in seconds. The request will be valid for 30 minutes from this timestamp.
         * @param useUniqueFilename “true” or “false”. If set to true, ImageKit will add a unique code to the filename parameter
         * to get a unique filename. If false, the image is uploaded with the filename parameter as name. If an image exists
         * with the same name, this new image will override it. Default is “true”
         * @param tags Array of tags e.g tag1,tag2,tag3. The maximum length of all characters should not exceed 500.
         * % is not allowed. If this field is not specified and the file is overwritten then tags will be removed.
         * @param folder The folder path (eg- /images/folder/) in which the image has to be uploaded. Default is “/”
         * @param imageKitCallback Callback to communicate the result of the upload operation
         */
        public func uploadFile(_ file: URL, fileName: String, signature: String, timestamp: Date, useUniqueFilename: Bool = true, tags: Array<String>?, folder: String?, completionHandler: @escaping (_ data: UploadResponse?, _ isSuccessful: Bool, _ error: UploadError?) -> Void) {
            let mRepository = Repository.init()
    //        mRepository.uploadImage(file, fileName: fileName, signature: signature, timestamp: timestamp, tags: tags, folder: folder, completionHandler: completionHandler)
        }
}
