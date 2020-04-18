# [WIP] ImageKit SDK for iOS

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Twitter Follow](https://img.shields.io/twitter/follow/imagekitio?label=Follow&style=social)](https://twitter.com/ImagekitIo)

iOS Pod for [ImageKit.io](https://imagekit.io) which implements client-side upload and URL generation for use inside an iOS application.

ImageKit is a complete image optimization and transformation solution that comes with an [image CDN](https://imagekit.io/features/imagekit-infrastructure) and media storage. It can be integrated with your existing infrastructure - storages like AWS S3, web servers, your CDN and custom domain names, allowing you to deliver optimized images in minutes with minimal code changes.

Swift client for Imagekit Integration

## Requirements
The library requires Swift 4.0 or above.

### CocoaPods

You can use CocoaPods to install ImageKit by adding it to your Podfile:

```ruby
use_frameworks!
platform :ios, '8.0'

target 'target_name' do
pod 'imagekit'
end
```

## Initialization
You need to initialize the sdk by providing the  `publicKey` and the `urlEndpoint`. You can do this either in your application or launcher activity. This needs to be called before any other function in the SDK or else an exception would be thrown.

`authenticationEndpoint` is only required if you want to use the upload functionality.

_Note: Do not include your Private Key in any client side code, including this SDK or its initialization._

```swift
ImageKit.init(
            publicKey = "your_public_api_key",
            urlEndpoint = "https://ik.imagekit.io/your_imagekit_id",
            transformationPosition = "path",
            authenticationEndpoint = "http://www.yourserver.com/auth"
        )
```

## Sample application
This project has a sample application under `sample` folder. The sample application demonstrates the use of this SDK.

## Usage
### URL construction
#### Using image path
```swift
//https://ik.imagekit.io/your_imagekit_id/default-image.jpg?tr=h-400.00,ar-3-2
ImageKit.getInstance()
        .url(
            path = "default-image.jpg",
            transformationPosition = TransformationPosition.QUERY
        )
        .height(400f)
        .aspectRatio(3, 2)
        .create()
```

#### Using full image URL
```swift
// https://ik.imagekit.io/your_imagekit_id/medium_cafe_B1iTdD0C.jpg?tr=oi-logo-white_SJwqB4Nfe.png,ox-10,oy-20
ImageKit.getInstance()
        .url(
            src = https://ik.imagekit.io/your_imagekit_id/medium_cafe_B1iTdD0C.jpg",
            transformationPosition = TransformationPosition.PATH
        )
        .overlayImage("logo-white_SJwqB4Nfe.png")
        .overlayPosX(10)
        .overlayPosY(20)
        .create()
```

#### Using a custom parameter
```swift
// https://ik.imagekit.io/your_imagekit_id/plant.jpeg?tr=w-400,ot-Hand with a green plant,otc-264120,ots-30,ox-10,oy-10
ImageKit.getInstance()
        .url(src = "https://ik.imagekit.io/your_imagekit_id/plant.jpeg?tr=oi-logo-white_SJwqB4Nfe.png,ox-10,oy-20")
        .addCustomTransformation("w", "400")
        .overlayText("Hand with a green plant")
        .overlayTextColor("264120")
        .overlayTextSize(30)
        .overlayPosX(10)
        .overlayPosY(10)
        .create()
```

### List of supported transformations
The complete list of transformations supported and their usage in ImageKit can be found [here](https://docs.imagekit.io/imagekit-docs/image-transformations). The SDK provides a function for each transformation parameter, making the code simpler and readable. If a transformation is supported in ImageKit, but a name for it cannot be found in the table below, then use the `addCustomTransformation` function and pass the transformation code from ImageKit docs as the first parameter and value as second paramter. For example - `.addCustomTransformation("w", "400")`

| Supported Transformation Function | Translates to parameter |
| ----------------------------- | ----------------------- |
| height                        | h                       |
| width                         | w                       |
| aspectRatio                   | ar                      |
| quality                       | q                       |
| crop                          | c                       |
| cropMode                      | cm                      |
| focus                         | fo                      |
| format                        | f                       |
| radius                        | r                       |
| background                    | bg                      |
| border                        | bo                      |
| rotation                      | rt                      |
| blur                          | bl                      |
| named                         | n                       |
| overlayImage                  | oi                      |
| overlayX                      | ox                      |
| overlayY                      | oy                      |
| overlayFocus                  | ofo                     |
| overlayHeight                 | oh                      |
| overlayWidth                  | ow                      |
| overlayText                   | ot                      |
| overlayTextFontSize           | ots                     |
| overlayTextFontFamily         | otf                     |
| overlayTextColor              | otc                     |
| overlayAlpha                  | oa                      |
| overlayTextTypography         | ott                     |
| overlayBackground             | obg                     |
| progressive                   | pr                      |
| lossless                      | lo                      |
| trim                          | t                       |
| metadata                      | md                      |
| colorProfile                  | cp                      |
| defaultImage                  | di                      |
| dpr                           | dpr                     |
| effectSharpen                 | e-sharpen               |
| effectUSM                     | e-usm                   |
| effectContrast                | e-contrast              |
| effectGray                    | e-grayscale             |

### File Upload
The SDK provides a simple interface using the `ImageKit.getInstance().uploader().upload` method to upload files to the ImageKit Media Library. It accepts all the parameters supported by the [ImageKit Upload API](https://docs.imagekit.io/api-reference/upload-file-api/client-side-file-upload#request-structure-multipart-form-data).

Make sure that you have specified `authenticationEndpoint` during SDK initialization. The SDK makes an HTTP GET request to this endpoint and expects a JSON response with three fields i.e. `signature`, `token` and `expire`.  

[Learn how to implement authenticationEndpoint](https://docs.imagekit.io/api-reference/upload-file-api/client-side-file-upload#how-to-implement-authenticationendpoint-endpoint) on your server.

#### Upload file from bitmap
``` swift
val filename = "file-name.jpg"
val timestamp = System.currentTimeMillis()
ImageKit.getInstance().uploadImage(
    file = bitmap!!
    , fileName = filename
    , useUniqueFilename = false
    , tags = arrayOf("nice", "copy", "books")
    , folder = "/dummy/folder/"
    , imageKitCallback = this
)
```

#### Upload file from a remote URL
``` swift
val filename = "file-name.jpg"
val timestamp = System.currentTimeMillis()
ImageKit.getInstance().uploader().upload(
    file = "https://ik.imagekit.io/demo/img/default-image.jpg"
    , fileName = filename
    , useUniqueFilename = false
    , tags = arrayOf("nice", "copy", "books")
    , folder = "/dummy/folder/"
    , imageKitCallback = this
)
```

#### Upload file using binary
```swift
ImageKit.getInstance().uploader().upload(
    file = file!!
    , fileName = file!!.name
    , useUniqueFilename = true
    , tags = arrayOf("nice", "copy", "books")
    , folder = "/dummy/folder/"
    , imageKitCallback = this
)
```

## Support

For any feedback or to report any issues or general implementation support please reach out to [support@imagekit.io](mailto:support@imagekit.io)

## Links
* [Documentation](https://docs.imagekit.io)
* [Main website](https://imagekit.io)

## License

Released under the MIT license.
