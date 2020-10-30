[<img width="250" alt="ImageKit.io" src="https://raw.githubusercontent.com/imagekit-developer/imagekit-javascript/master/assets/imagekit-light-logo.svg"/>](https://imagekit.io)

# ImageKit.io iOS SDK

[![Version](https://img.shields.io/cocoapods/v/ImageKitIO.svg?label=Pod&style=flat)](https://cocoapods.org/pods/ImageKitIO)
[![Swift CI](https://github.com/imagekit-developer/imagekit-ios/workflows/Swift%20CI/badge.svg)](https://github.com/imagekit-developer/imagekit-ios/actions?query=workflow%3A%22Swift+CI%22)
[![codecov](https://codecov.io/gh/imagekit-developer/imagekit-ios/branch/master/graph/badge.svg?token=BeabJwhQoh)](https://codecov.io/github/imagekit-developer/imagekit-ios)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Twitter Follow](https://img.shields.io/twitter/follow/imagekitio?label=Follow&style=social)](https://twitter.com/ImagekitIo)

ImageKit iOS Pod allows you to use real-time [image resizing](https://docs.imagekit.io/features/image-transformations), [optimization](https://docs.imagekit.io/features/image-optimization), and [file uploading](https://docs.imagekit.io/api-reference/upload-file-api/client-side-file-upload) in the client-side.

## Requirements
The library requires Swift 4.0 or above.

### CocoaPods

You can use CocoaPods to install ImageKit by adding it to your Podfile:

```ruby
use_frameworks!

target 'target_name' do
    pod 'ImageKitIO', '~> 1.1.0'
end
```

## Initialization
You need to initialize the SDK by providing the  `publicKey` and the `urlEndpoint`. You can do this either in your application or launcher activity. This needs to be called before any other function in the SDK, or else an exception would be thrown.

`authenticationEndpoint` is only required if you want to use the upload functionality.

_Note: Do not include your Private Key in any client-side code, including this SDK or its initialization._

```swift
// AppDelegate.swift

ImageKit.init(
    clientPublicKey: "your_public_api_key=", 
    imageKitEndpoint: "https://ik.imagekit.io/your_imagekit_id", transformationPosition: "path", 
    authenticationEndpoint: "http://www.yourserver.com/auth")
```

## Sample application
This project has a sample application under the [Example folder](/Example). The sample application demonstrates the use of this SDK.

To run the sample application, add Public Key to `Example/ImageKit/AppDelegate.swift` and add Private Key to `Server/.env`. We also need to run a backend server for implementing `authenticationEndpoint` for client-side upload to work.

```bash
npm install
node index.js
```

## Usage
### URL construction
#### Using image path
```swift
//https://ik.imagekit.io/your_imagekit_id/default-image.jpg?tr=h-400.00,ar-3-2
ImageKit.shared.url(
            path: "default-image.jpg",
            transformationPosition: "query"
        )
        .height(height: 400)
        .aspectRatio(width: 3, height: 2)
        .create()
```

#### Using full image URL
```swift
// https://ik.imagekit.io/your_imagekit_id/medium_cafe_B1iTdD0C.jpg?tr=oi-logo-white_SJwqB4Nfe.png,ox-10,oy-20
ImageKit.shared.url(
            src: "https://ik.imagekit.io/your_imagekit_id/medium_cafe_B1iTdD0C.jpg",
            transformationPosition: "path"
        )
        .overlayImage("logo-white_SJwqB4Nfe.png")
        .overlayX(10)
        .overlayY(20)
        .create()
```

#### Using a custom parameter
```swift
// https://ik.imagekit.io/your_imagekit_id/plant.jpeg?tr=w-400,ot-Hand with a green plant,otc-264120,ots-30,ox-10,oy-10
ImageKit.shared.url(
    src : "https://ik.imagekit.io/your_imagekit_id/plant.jpeg?tr=oi-logo-white_SJwqB4Nfe.png,ox-10,oy-20"
    )
        .addCustomTransformation("w", "400")
        .overlayText("Hand with a green plant")
        .overlayTextColor("264120")
        .overlayTextSize(30)
        .overlayX(10)
        .overlayY(10)
        .create()
```

### List of supported transformations
The complete list of transformations supported and their usage in ImageKit can be found [here](https://docs.imagekit.io/imagekit-docs/image-transformations). The SDK provides a function for each transformation parameter, making the code simpler and readable. If a transformation is supported in ImageKit, but if a name for it cannot be found in the table below, then use the `addCustomTransformation` function and pass the transformation code from ImageKit docs as the first parameter and value as the second parameter. For example - `.addCustomTransformation("w", "400")`

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
| border                        | b                      |
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
The SDK provides a simple interface using the `ImageKit.shared.uploader().upload` method to upload files to the ImageKit Media Library. It accepts all the parameters supported by the [ImageKit Upload API](https://docs.imagekit.io/api-reference/upload-file-api/client-side-file-upload#request-structure-multipart-form-data).

Make sure that you have specified `authenticationEndpoint` during SDK initialization. The SDK makes an HTTP GET request to this endpoint and expects a JSON response with three fields i.e. `signature`, `token`, and `expire`.  

[Learn how to implement authenticationEndpoint](https://docs.imagekit.io/api-reference/upload-file-api/client-side-file-upload#how-to-implement-authenticationendpoint-endpoint) on your server.

#### Upload file from UIImage
``` swift
let image: UIImage
ImageKit.shared.uploader().upload(
  file: image,
  fileName: "sample-image.jpg",
  useUniqueFilename: true,
  tags: ["demo"],
  folder: "/",
  isPrivateFile: false,
  customCoordinates: "",
  responseFields: "",
  signatureHeaders: ["x-test-header":"Test"],
  progress: { progress in
  	// Handle Progress
  },
  completion: { result in 
  	// Handle Upload Response
  }
)
```

#### Upload file from a remote URL
``` swift
ImageKit.shared.uploader().upload(
  file: "https://www.example.com/sample-image.jpg",
  fileName: "sample-image.jpg",
  useUniqueFilename: true,
  tags: ["demo"],
  folder: "/",
  isPrivateFile: false,
  customCoordinates: "",
  responseFields: "",
  signatureHeaders: ["x-test-header":"Test"],
  progress: { progress in
  	// Handle Progress
  },
  completion: { result in 
  	// Handle Upload Response
  }
)
```

#### Upload file using Data
```swift
let data : Data
ImageKit.shared.uploader().upload(
  file: data,
  fileName: "sample-image.jpg",
  useUniqueFilename: true,
  tags: ["demo"],
  folder: "/",
  isPrivateFile: false,
  customCoordinates: "",
  responseFields: "",
  signatureHeaders: ["x-test-header":"Test"],
  progress: { progress in
  	// Handle Progress
  },
  completion: { result in 
  	// Handle Upload Response
  }
)
```

## Support
For any feedback or to report any issues or general implementation support, please reach out to [support@imagekit.io](mailto:support@imagekit.io)

## Links
* [Documentation](https://docs.imagekit.io)
* [Main website](https://imagekit.io)

## License
Released under the MIT license.
