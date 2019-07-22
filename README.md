# ImageKit.IO

[![CI Status](https://img.shields.io/travis/rungtaakki/imagekit.svg?style=flat)](https://travis-ci.org/rungtaakki/imagekit)
[![Version](https://img.shields.io/cocoapods/v/imagekit.svg?style=flat)](https://cocoapods.org/pods/imagekit)
[![License](https://img.shields.io/cocoapods/l/imagekit.svg?style=flat)](https://cocoapods.org/pods/imagekit)
[![Platform](https://img.shields.io/cocoapods/p/imagekit.svg?style=flat)](https://cocoapods.org/pods/imagekit)


Swift package that wraps [ImageKit.io](https://imagekit.io) upload APIs and URL builder logic with easy to use interfaces.

ImageKit.io provides ready-to-use image optimisation servers along with dedicated image storage, global CDN, on-the-fly image transformation like resize, crop, rotate directly from the URL and image uploads.

By using ImageKit, you can experience about 30% improvement in page load time thanks to the tons of image optimizations that work out of the box without you putting in any effort. Migrating to ImageKit is super simple and takes just a few minutes with our Plug-and-Play technology. Images are delivered across the globe using a CDN ensuring lightning fast experience for your users.

## Installation

### CocoaPods

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

## Requirements

### Setup

Initialise the ImageKit SDK with the by applying for the ImageKit ID & Key from ....

```swift
var ImageKit = ImageKit(clientPublicKey: "<publicKey>", imageKitId: "<kitID>")
```

### Uploading Images using base64

Images can be uploaded to your ImageKit Media Library using the uploadImage() function. 
<!--The uploadImage() function accepts two arguments - the image to be uploaded and an additional object with different upload options.-->

The image to be uploaded should be passed as a base64 encoded string.

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

An image instance has to be created before it can be subject to transforms or turned into a URL or HTML. The image instance is made up of the image name that has to be fetched and other optional parameters.

```swift

var img = ImagekitUrlConstructor(endpoint: String, imagePath: String)

```

#### Optional parameters for image instance

The URL pattern which has to be used to fetch the image. URL patterns help identify the original sources of the image. You can read more about patterns and sources in [ImageKit Documentation](https://docs.imagekit.io)

#### Transforms in image URL

All transforms that are available in ImageKit can be added by using the transform function. The transform function works on an image instance.

Input to transform function is a key-value map with the transformation name as the key against the transformation value. Transformation name is passed in capital letters.


```swift

var img = ImagekitUrlConstructor(endpoint: String, imagePath: String).width(width: Float)

```

#### Output

The image instance or its transform can be used to generate the image URL

URL

```swift

var img = ImagekitUrlConstructor(endpoint: String, imagePath: String).width(width: Float)

//generates an image URL.
var img = ImagekitUrlConstructor(endpoint: String, imagePath: String).width(width: Float).create()

```



## Author

[ImageKit.io](https://imagekit.io)

## License

ImageKit is available under the MIT license. See the LICENSE file for more info.
