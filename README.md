# ImageKit.IO

[![CI Status](https://img.shields.io/travis/rungtaakki/imagekit.svg?style=flat)](https://travis-ci.org/rungtaakki/imagekit)
[![Version](https://img.shields.io/cocoapods/v/imagekit.svg?style=flat)](https://cocoapods.org/pods/imagekit)
[![License](https://img.shields.io/cocoapods/l/imagekit.svg?style=flat)](https://cocoapods.org/pods/imagekit)
[![Platform](https://img.shields.io/cocoapods/p/imagekit.svg?style=flat)](https://cocoapods.org/pods/imagekit)


Description about ImageKit and what this Library does

## Requirements

### Setup

Initialise the ImageKit SDK with the by applying for the ImageKit ID & Key from ....

```swift
ImageKit(clientPublicKey: "<publicKey>", imageKitId: "<kitID>")
```

### Uploading Image

Uploading an image to ImageKit.
- image --> The image data that is to be uploaded
- fileName --> The name with which the file has to be uploaded
- signature --> HMAC-SHA1 signature generated for the file upload. See [https://docs.imagekit.io/#server-side-image-upload](https://docs.imagekit.io/#server-side-image-upload) for more information.
- timestamp --> UTC timestamp in seconds. The request will be valid for 30 minutes from this timestamp.
- useUniqueFilename --> “true” or “false”. If set to true, ImageKit will add a unique code to the filename parameter to get a unique filename. If false, the image is uploaded with the filename parameter as name. If an image exists with the same name, this new image will override it. Default is “true”
- tags --> Array of tags e.g tag1,tag2,tag3. The maximum length of all characters should not exceed 500. % is not allowed. If this field is not specified and the file is overwritten then tags will be removed.
- folder --> The folder path (eg- /images/folder/) in which the image has to be uploaded. Default is “/”
- completionHandler --> Callback to communicate the result of the upload operation

```swift
public func uploadImage(_ image: Data, fileName: String, signature: String, timestamp: Date, useUniqueFilename: Bool = true, tags: Array<String>?, folder: String?, completionHandler: @escaping (_ data: UploadResponse?, _ isSuccessful: Bool, _ error: UploadError?) -> Void)
```

### Upload File

Uploading an image to ImageKit.
- file --> The file that is to be uploaded. Supported formats: PDF, JS, CSS and TXT
- fileName --> The name with which the file has to be uploaded
- signature --> HMAC-SHA1 signature generated for the file upload. See [https://docs.imagekit.io/#server-side-image-upload](https://docs.imagekit.io/#server-side-image-upload) for more information.
- timestamp --> UTC timestamp in seconds. The request will be valid for 30 minutes from this timestamp.
- useUniqueFilename --> “true” or “false”. If set to true, ImageKit will add a unique code to the filename parameter to get a unique filename. If false, the image is uploaded with the filename parameter as name. If an image exists with the same name, this new image will override it. Default is “true”
- tags --> Array of tags e.g tag1,tag2,tag3. The maximum length of all characters should not exceed 500. % is not allowed. If this field is not specified and the file is overwritten then tags will be removed.
- folder --> The folder path (eg- /images/folder/) in which the image has to be uploaded. Default is “/”
- completionHandler --> Callback to communicate the result of the upload operation

```swift
public func uploadFile(_ file: URL, fileName: String, signature: String, timestamp: Date, useUniqueFilename: Bool = true, tags: Array<String>?, folder: String?, completionHandler: @escaping (_ data: UploadResponse?, _ isSuccessful: Bool, _ error: UploadError?) -> Void)
```

### Generating URL

```swift

```

### Installation

CocoaPods

You can use CocoaPods to install ImageKit by adding it to your Podfile:

```ruby
use_frameworks!
platform :ios, '8.0'

target 'target_name' do
    pod 'imagekit'
end
```

To use the ImageKit library in your app, import ImageKit into the file(s) where you want to use it.

```swift
import imagekit
```

## Author

[ImageKit.io](https://imagekit.io)

## License

ImageKit is available under the MIT license. See the LICENSE file for more info.
