
# Change Log
All notable changes to ImageKit iOS SDK will be documented in this file. The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).


## [3.0.0] - 2024-06-11
  
Version 3.0.0 is a major release that includes a number of breaking changes.
 
### Added

- Upload Policy represents a set of conditions that must be met for an upload request to be executed.

- Upload Image and Video Preprocessors to apply transformations before uploading the file to ImageKit.
 
### Changed
  
- **Overlay syntax update** (Breaking Change)
  - In Version 3.0.0, we've removed the old overlay syntax parameters for transformations, such as oi, ot, obg, and [more](https://docs.imagekit.io/features/image-transformations/overlay). These parameters are deprecated and will start returning errors when used in URLs. Please migrate to the new layers syntax that supports overlay nesting, provides better positional control, and allows more transformations at the layer level. You can start with [examples](https://docs.imagekit.io/features/image-transformations/overlay-using-layers#examples) to learn quickly.
  - You can migrate to the new layers syntax using the `raw` transformation parameter.

- **Authentication Changes** (Breaking Change)
  - In Version 3.0.0, the `UploadApi` utilizes `Secure client side upload - V2`, please refer [docs](https://docs.imagekit.io/api-reference/upload-file-api/secure-client-side-file-upload) to implement the server side component.

- Updated Sample App to include the updated SDK features.
