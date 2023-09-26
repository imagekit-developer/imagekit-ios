//
//  ImagekitUrlConstructor.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 16/07/20.
//
import Foundation

public class ImagekitUrlConstructor {
    
    private var endpoint: String = ""
    private var imagePath: String = ""
    private var transformationPosition: TransformationPosition!
    private var queryParams: [String: String] = [:]
    
    private var isSource: Bool = false
    private var source: String = ""
    
    private var transformationList = [String]()
    private var transformationMap = [String: Any]()
    
    private var streamingParam: [String : String] = [:]
    private var rawParams: String? = nil
    
    init(endpoint: String, imagePath: String, transformationPosition: TransformationPosition, queryParams: [String: String] = [:]) {
        self.endpoint = endpoint.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        self.imagePath = imagePath.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        self.transformationPosition = transformationPosition
        self.queryParams = queryParams
    }
    
    init(src: String, transformationPosition: TransformationPosition, queryParams: [String: String] = [:]) {
        self.source = src
        self.transformationPosition = transformationPosition
        self.isSource = true
        self.queryParams = queryParams
    }
    
    /**
     * Method to specify the height of the output image.
     * @param height Accepts integer value greater than 1 and if a value between 0 and 1 is specified, then it acts as a percentage height.
     * For eg, 0.1 means 10% of the original height, 0.2 means 20% of the original height.
     * @return the current ImagekitUrlConstructor object.
     */
    public func height(height: Int) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.height] = height
        transformationList.append(String(format: "%@-%d", TransformationMapping.height, height))
        return self
    }
    
    /**
     * Method to specify the width of the output image.
     * @param width Accepts integer value greater than 1 and if a value between 0 and 1 is specified, then it acts as a percentage width.
     * For eg, 0.1 means 10% of the original width, 0.2 means 20% of the original width.
     * @return the current ImagekitUrlConstructor object.
     */
    public func width(width: Int) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.width] = width
        transformationList.append(String(format: "%@-%d", TransformationMapping.width, width))
        return self
    }
    
    /**
     * Method to specify the aspect ratio of the output image or the ratio of width to height of the output image.
     * This transform must be used along with either the height or the width transform.
     * @param width Accepts integer value greater than equal to 1
     * @param height Accepts integer value greater than equal to 1
     * @return the current ImagekitUrlConstructor object.
     */
    public func aspectRatio(width: Int, height: Int) -> ImagekitUrlConstructor {
        let s = String(format: "%@-%d-%d", TransformationMapping.aspectRatio, width, height)
        transformationMap[TransformationMapping.aspectRatio] = s
        transformationList.append(s)
        return self
    }
    
    /**
     * Method to specify the output quality of the lossy formats like JPG and WebP. A higher quality number means a
     * larger size of the output image with high quality. A smaller number means low quality image at a smaller size.
     * @param quality Accepts integer value between 1 and 100.
     * Default value is picked from the dashboard settings. It is set to 80.
     * @return the current ImagekitUrlConstructor object.
     */
    public func quality(quality: Int) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.quality] = quality
        transformationList.append(String(format: "%@-%d", TransformationMapping.quality, quality))
        return self
    }
    
    /**
     * Method to decide the final value of height and width of the output image based on the aspect ratio of the input
     * image and the requested transform.
     * @param cropType Accepts value of type CropType. Possible values include maintain_ratio, force, at_least and at_max.
     * Default value - maintain_ratio
     * @see CropType
     * @return the current ImagekitUrlConstructor object.
     */
    public func crop(cropType: CropType) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.crop] = cropType
        transformationList.append(String(format: "%@-%@", TransformationMapping.crop, cropType.rawValue))
        return self
    }
    
    /**
     * Method used to specify the strategy of how the input image is used for cropping to get the output image.
     * @param cropMode Accepts value of type CropMode. Possible values include resize, extract, pad_extract and pad_resize.
     * Default value - resize
     * @see CropMode
     * @return the current ImagekitUrlConstructor object.
     */
    public func cropMode(cropMode: CropMode) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.cropMode] = cropMode
        transformationList.append(String(format: "%@-%@", TransformationMapping.cropMode, cropMode.rawValue))
        return self
    }
    
    /**
     * Method used to specify the focus using cropped image coordinates
     * @param x Accepts value of x coordinate for focus.
     * @param y Accepts value of y coordinate for focus.
     * @return the current ImagekitUrlConstructor object.
     */
    public func focus(x: Int, y: Int) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.x] = x
        transformationMap[TransformationMapping.y] = y
        transformationList.append(String(format: "%@-%d", TransformationMapping.x, x))
        transformationList.append(String(format: "%@-%d", TransformationMapping.y, y))
        return self
    }
    
    
    /**
     * Method used to specify the focus which is coupled with the extract type of crop mode (crop mode is not needed
     * if you are using auto focus) to get the area of the input image that should be focussed on to get the output image.
     * @param focusType Accepts value of type FocusType. Possible values include center, top, left, bottom, right,
     * top_left, top_right, bottom_left, bottom_right and auto.
     * Default value - center
     * @see FocusType
     * @return the current ImagekitUrlConstructor object.
     */
    public func focus(focusType: FocusType) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.focus] = focusType
        transformationList.append(String(format: "%@-%@", TransformationMapping.focus, focusType.rawValue))
        return self
    }
    
    /**
     * Method used to specify the format of the output image. If no output format is specified and
     * the “Dynamic image format selection” option is selected in your dashboard settings, then the output format is
     * decided on the basis of the user’s device capabilities and input image format. If dynamic image format selction
     * is switched off, and no output format is specified then the format of the output image is same as that of the input image.
     * @param format Accepts value of type FocusType. Possible values include auto, webp, jpg, jpeg and pnt.
     * Default value - auto
     * @see Format
     * @return the current ImagekitUrlConstructor object.
     */
    public func format(format: Format) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.format] = format
        transformationList.append(String(format: "%@-%@", TransformationMapping.format, format.rawValue))
        return self
    }
    
    /**
     * Method used to specify the radius to be used to get a rounded corner image.
     * This option is applied after resizing of the image, if any.
     * @param radius Possible values include positive integer.
     * @return the current ImagekitUrlConstructor object.
     */
    public func radius(radius: Int) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.radius] = radius
        transformationList.append(String(format: "%@-%d", TransformationMapping.radius, radius))
        return self
    }
    
    /**
     * Method used to specify the background color as RGB hex code (e.g. FF0000) or an RGBA code (e.g. FFAABB50)
     * to be used for the image.
     * @param backgroundColor Default value - Black 000000
     * @return the current ImagekitUrlConstructor object.
     */
    public func background(backgroundColor: String) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.background] = backgroundColor.uppercased()
        transformationList.append(String(format: "%@-%@", TransformationMapping.background, backgroundColor.uppercased()))
        return self
    }
    
    /**
     * Method used to specify the background color as RGB hex code (e.g. FF0000) or an RGBA code (e.g. FFAABB50)
     * to be used for the image.
     * @param backgroundColor Default value - Black 000000
     * @return the current ImagekitUrlConstructor object.
     */
    public func background(backgroundColor: UIColor) -> ImagekitUrlConstructor {
        return self.background(backgroundColor: self.UIColorToHexString(backgroundColor))
    }
    
    /**
     * Method used to specify the width and color of the border that is added around the image.
     * The width is a positive integer that specifies the border width in pixels.
     * The border color is specified as a standard RGB hex code e.g b-{width}_{color}
     * @param borderWidth width of the border
     * @param borderColor color of the border as RGB hex code
     * @return the current ImagekitUrlConstructor object.
     */
    public func border(borderWidth: Int, borderColor: String) -> ImagekitUrlConstructor {
        let s = String(format: "%@-%d_%@", TransformationMapping.border, borderWidth, borderColor.uppercased())
        transformationMap[TransformationMapping.border] = s
        transformationList.append(s)
        return self
    }
    
    /**
     * Method used to specify the width and color of the border that is added around the image.
     * The width is a positive integer that specifies the border width in pixels.
     * The border color is specified as a standard RGB hex code e.g b-{width}_{color}
     * @param borderWidth width of the border
     * @param borderColor color of the border as RGB hex code
     * @return the current ImagekitUrlConstructor object.
     */
    public func border(borderWidth: Int, borderColor: UIColor) -> ImagekitUrlConstructor {
        return self.border(borderWidth: borderWidth, borderColor: self.UIColorToHexString(borderColor))
    }
    
    /**
     * Method used to specify the degrees by which the output image has to be rotated or specifies the use of
     * EXIF Orientation tag for the rotation of the image using auto.
     * @param rotation Possible values include 0, 90, 180, 270, 360 and auto.
     * Default value - center
     * @see Rotation
     * @return the current ImagekitUrlConstructor object.
     */
    public func rotation(rotation: Rotation) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.rotation] = rotation
        transformationList.append(String(format: "%@-%@", TransformationMapping.rotation, rotation.rawValue))
        return self
    }
    
    
    /**
     * Method to specify the Gaussian blur that has to be applied to the image. The value of blur decides the radius of
     * the Gaussian blur that is applied. Higher the value, higher is the radius of Gaussian blur.
     * @param blur Accepts integer value between 1 and 100.
     * @return the current ImagekitUrlConstructor object.
     */
    public func blur(blur: Int) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.blur] = blur
        transformationList.append(String(format: "%@-%d", TransformationMapping.blur, blur))
        return self
    }
    
    /**
     * Method to specify the Named transformations which is an alias for the entire transformation string.
     * E.g we can create a named transform media_library_thumbnail for transformation string tr:w-150,h-150,f-center,c-at_max
     * @param namedTransformation
     * @return the current ImagekitUrlConstructor object.
     */
    public func named(namedTransformation: String) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.named] = namedTransformation
        transformationList.append(String(format: "%@-%@", TransformationMapping.named, namedTransformation))
        return self
    }
    
    /**
     * Method to specify if the output JPEG image should be rendered progressively. In progressive rendering,
     * the client instead of downloading the image row-wise (baseline loading), renders a low-quality pixelated
     * full image and then gradually keeps on adding more pixels and information to the image. It gives faster-perceived load times.
     * @param flag Possible values include true and false. Default value - false
     * @return the current ImagekitUrlConstructor object.
     */
    public func progressive(flag: Bool) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.progressive] = flag
        transformationList.append(String(format: "%@-%@", TransformationMapping.progressive, String(flag)))
        return self
    }
    
    /**
     * Method to specify if the output image (if in PNG or WebP format) should be compressed losslessly.
     * In lossless compression, the output file size would be larger than the regular lossy compression but at the same time,
     * the perceived quality can be better in certain cases, especially for computer generated graphics.
     * Using lossless compression is not recommended for photographs.
     * @param flag Possible values include true and false. Default value - false
     * @return the current ImagekitUrlConstructor object.
     */
    public func lossless(flag: Bool) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.lossless] = flag
        transformationList.append(String(format: "%@-%@", TransformationMapping.lossless, String(flag)))
        return self
    }
    
    /**
     * Method to specify if the redundant pixels of the original image need to be removed. It uses a default logic
     * to identify the redundant surrounding region and removes it. This transformation is useful for images that have
     * a solid / nearly-solid background and the object in the center. This transformation will trim
     * the background from the edges, leaving only the central object in the picture.
     * @param flag Possible values include true and false.
     * @return the current ImagekitUrlConstructor object.
     * @see trim
     */
    public func trim(flag: Bool) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.trim] = flag
        transformationList.append(String(format: "%@-%@", TransformationMapping.trim, String(flag)))
        return self
    }
    
    /**
     * Method to specify the number of redundant pixels of the original image that need to be removed.
     * This transformation is useful for images that have a solid / nearly-solid background and the object in the center.
     * This transformation will trim the background from the edges, leaving only the central object in the picture.
     * @param value Number of pixels from the edge that need to be removed across all four sides.
     * @return the current ImagekitUrlConstructor object.
     * @see trim
     */
    public func trim(value: Int) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.trim] = value
        transformationList.append(String(format: "%@-%d", TransformationMapping.trim, value))
        return self
    }
    
    /**
     * Method used to specify if the output image should contain all the metadata that is initially available from
     * the original image. Enabling this is not recommended because this metadata is not relevant for rendering on the
     * web and mobile apps. The only reason where you should enable the metadata option is when you have knowingly wanted
     * the additional data like camera information, lens information and other image profiles attached to your image.
     * Possible values include true and false.
     * @param flag Default value - false
     * @return the current ImagekitUrlConstructor object.
     */
    public func metadata(flag: Bool) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.metadata] = flag
        transformationList.append(String(format: "%@-%@", TransformationMapping.metadata, String(flag)))
        return self
    }
    
    
    /**
     * Method used to specify if the output image should contain the color profile that is initially available
     * from the original image. It is recommended to remove the color profile before serving the image on web and apps.
     * However, in cases where you feel that the image looks faded or washed-out after using ImageKit and want to preserve
     * the colors in your image, then you should set this option to true. Possible values include true and false.
     * @param flag Default value - false
     * @return the current ImagekitUrlConstructor object.
     */
    public func colorProfile(flag: Bool) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.colorProfile] = flag
        transformationList.append(String(format: "%@-%@", TransformationMapping.colorProfile, String(flag)))
        return self
    }
    
    /**
     * Method to specify the default image which is delivered in case the image that is requested using ImageKit does not exist.
     * @param defaultImage
     * @return the current ImagekitUrlConstructor object.
     */
    public func defaultImage(defaultImage: String) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.defaultImage] = defaultImage
        transformationList.append(String(format: "%@-%@", TransformationMapping.defaultImage, defaultImage))
        return self
    }
    
    /**
     * Method to specify the device pixel ratio to be used to calculate the dimension of the output image. It is useful
     * when creating image transformations for devices with high density screens (DPR greater than 1) like the iPhone.
     * The DPR option works only when either the height or the width or both are specified for resizing the image
     * If the resulting height or width after considering the specified DPR value is less than 1px or more than 5000px
     * then the value of DPR is not considered and the normal height or width specified in the transformation string is used.
     * @param dpr Possible values: 0.1 to 5.0
     * @return the current ImagekitUrlConstructor object.
     */
    public func dpr(dpr: Float) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.dpr] = dpr
        transformationList.append(String(format: "%@-%.2f", TransformationMapping.dpr, dpr))
        return self
    }
    
    /**
     * Method sharpens the input image. It is useful to highlight the edges and finer details in the image.
     * If just e-sharpen is used, then a default sharpening is performed on the image. This behavior can be controlled
     * by specifying a number that controls the extent of sharpening performed - higher the number,
     * more the sharpening
     * @param value
     * @return the current ImagekitUrlConstructor object.
     */
    public func effectSharpen(value: Int = 0) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.effectSharpen] = value
        transformationList.append(String(format: "%@-%d", TransformationMapping.effectSharpen, value))
        return self
    }
    
    /**
     * Unsharp masking (USM) is an image sharpening technique.
     * Method allows you to apply and control unsharp mask on your images. The amount of sharpening can be controlled
     * by varying the 4 parameters - radius, sigma, amount and threshold. This results in perceptually better images
     * compared to just e-sharpen.
     * @param radius Possible values include positive floating point values.
     * @param sigma Possible values include positive floating point values.
     * @param amount Possible values include positive floating point values.
     * @param threshold Possible values include positive floating point values.
     * @return the current ImagekitUrlConstructor object.
     */
    public func effectUSM(radius: Float, sigma: Float, amount: Float, threshold: Float) -> ImagekitUrlConstructor {
        let s = String(format: "%@-%.2f-%.2f-%.2f-%.2f", TransformationMapping.effectUSM, radius, sigma, amount, threshold)
        transformationMap[TransformationMapping.effectUSM] = s
        transformationList.append(s)
        return self
    }
    
    /**
     * Method used to automatically enhance the contrast of the image by using the full range of intensity values
     * that a particular image format allows. This basically means that the lighter portions of the image would become
     * even lighter and the darker portions of the image would become even brighter, thereby enhancing the contrast.
     * @param flag
     * @return the current ImagekitUrlConstructor object.
     */
    public func effectContrast(flag: Bool) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.effectContrast] = flag
        if flag {
            transformationList.append(String(format: "%@", TransformationMapping.effectContrast))
        }
        return self
    }
    
    
    /**
     * Method to turn an image into its grayscale version.
     * @param flag Accepts boolean value of either true or false. Default value is false.
     * @return the current ImagekitUrlConstructor object.
     */
    public func effectGray(flag: Bool) -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.effectGray] = flag
        if flag {
            transformationList.append(String(format: "%@", TransformationMapping.effectGray))
        }
        return self
    }
    
    /**
     * Add the raw transformation options passed as a string to the transformations list.
     * @param params The string containing the comma-separated transformation parameters.
     * @return the current ImagekitUrlConstructor object.
     */
    public func raw(params: String) -> ImagekitUrlConstructor {
        rawParams = params
        return self
    }
    
    /**
     * Set the parameters to fetch the video in an adaptive streaming format.
     * @param format The desired streaming format to be fetched (HLS or DASH).
     * @param resolutions The list of video resolutions to be made available to choose from during video streaming.
     * @return the current ImagekitUrlConstructor object.
     */
    public func setAdaptiveStreaming(
        format: StreamingFormat,
        resolutions: [Int]
    ) -> ImagekitUrlConstructor {
        streamingParam["ik-master"] = format.rawValue

        transformationMap[TransformationMapping.streamingResolution] = resolutions
        transformationList.append(
            String(format: "%@-%@",
                TransformationMapping.streamingResolution,
                resolutions.map { String($0) }.joined(separator: "_")
            )
        )
        return self
    }
    
    /**
     * Method used to get a perfectly rounded image.
     * This option is applied after resizing of the image, if any.
     * @return the current ImagekitUrlConstructor object.
     */
    public func round() -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.radius] = "max"
        transformationList.append(String(format: "%@-%@", TransformationMapping.radius, "max"))
        return self
    }
    
    /**
     * Some transformations are dependent on the sequence in which they are carried out.
     * Method used to add sequence dependent steps in a transform chain to obtain predictable results.
     * @see https://docs.imagekit.io/#chained-transformations
     * @return the current ImagekitUrlConstructor object.
     */
    public func chainTransformation() -> ImagekitUrlConstructor {
        transformationMap[TransformationMapping.transformationStep] = ":"
        transformationList.append(":")
        return self
    }
    
    /**
     * Method allows adding custom transformations to the image.
     * @return the current ImagekitUrlConstructor object.
     */
    public func addCustomTransformation(key: String, value: String) -> ImagekitUrlConstructor {
        transformationMap[key] = value
        transformationList.append(String(format: "%@-%@", key, value))
        return self
    }
    
    /**
     * Method allows adding custom Query Parameter to the image.
     * @return the current ImagekitUrlConstructor object.
     */
    public func addCustomQueryParameter(key: String, value: String) -> ImagekitUrlConstructor {
        queryParams[key] = value
        return self
    }
    
    /**
     * Method allows adding custom Query Parameters to the image.
     * @return the current ImagekitUrlConstructor object.
     */
    public func addCustomQueryParameters(params: [String: String]) -> ImagekitUrlConstructor {
        params.forEach{ (key, value) in queryParams[key] = value }
        return self
    }
    
    /**
     * Set the image size and crop of the image to be responsive to the target view/window.
     * Method allows you to automatically set the height, width and DPR parameters of images according to the target View specified. The height and width can be constrained
     * by varying the parameters - minSize, maxSize, and step. the default crop mode and focus area values can also be overridden by passing the crop and focus arguments, else.
     * @param view The reference of the view of which the dimensions are to be taken into consideration for image sizing.
     * @param minSize Minimum allowed size for image width/height.
     * @param maxSize Maximum allowed size for image width/height.
     * @param step Possible values include positive integer values.
     * @param cropMode Possible values include the values defined in enum CropMode.
     * @param focus Possible values include the values defined in enum FocusType.
     * @return the current ImagekitUrlConstructor object.
     */
    public func setResponsive(
        view: UIView,
        minSize: Int = 0,
        maxSize: Int = 5000,
        step: Int = 100,
        cropMode: CropMode = CropMode.RESIZE,
        focus: FocusType = FocusType.CENTER
    ) throws -> ImagekitUrlConstructor {
        guard minSize >= 0 && maxSize >= 0 && step >= 0 else {
            throw InvalidArgumentError(message: "minSize, maxSize and step cannot be negative")
        }
        var screen: UIScreen
        if #available(iOS 13.0, *) {
            screen = view.window?.windowScene?.screen ?? UIScreen.main
        } else {
            screen = UIScreen.main
        }
        var targetWidth = Int(view.frame.width - view.layoutMargins.left - view.layoutMargins.right)
        var targetHeight = Int(view.frame.height - view.layoutMargins.top - view.layoutMargins.bottom)
        if targetWidth <= 0 {
            targetWidth = Int(screen.bounds.width - view.layoutMargins.left - view.layoutMargins.right)
        }
        if targetHeight <= 0 {
            targetHeight = Int(screen.bounds.height - view.layoutMargins.top - view.layoutMargins.bottom)
        }
        return self.width(width: max(minSize, min(roundUpSize(targetWidth, step), maxSize)))
            .height(height: max(minSize, min(roundUpSize(targetHeight, step), maxSize)))
            .dpr(dpr: Float(screen.scale.rounded(.toNearestOrAwayFromZero)))
            .cropMode(cropMode: cropMode)
            .focus(focusType: focus)
    }
    
    private func roundUpSize(_ size: Int, _ step: Int) -> Int {
        return ((size - 1) / step + 1) * step
    }
    
    /**
     * Used to create the url using the transformations specified before invoking this method.
     * @return the Url used to fetch an image after applying the specified transformations.
     */
    public func create() -> String {
        var url = self.source
        
        if (rawParams != nil) {
            transformationList.append(contentsOf: rawParams?.split(separator: ",").map { String($0) } ?? [])
        }
        
        if !transformationList.isEmpty {
            let transforms = transformationList.joined(separator: ",").replacingOccurrences(of: ",:,", with: ":")
            if self.isSource {
                url = self.source
                
                if self.source.contains("/tr:") {
                    let urlComponents = url.components(separatedBy: "/tr:")
                    var path = urlComponents[1]
                    let index = path.range(of: "/")?.upperBound
                    path.removeSubrange(path.startIndex..<index!)
                    url = String("\(urlComponents[0])/\(path)")
                }
                
                if let urlParams = URLComponents.init(string: url)!.queryItems {
                    for item in urlParams {
                        if (item.name != "tr"){
                            queryParams[item.name] = item.value!
                        }
                    }
                    url = url.components(separatedBy: "?")[0]
                }
                if (streamingParam.keys.contains("ik-master")) {
                    url = url + "/ik-master.\(streamingParam["ik-master"] ?? "")"
                }
                
                queryParams["tr"] = transforms
                
            } else {
                url = self.endpoint
                if (self.transformationPosition == .PATH){
                    url = String("\(url)/tr:\(transforms)/\(self.imagePath)")
                    if (streamingParam.keys.contains("ik-master")) {
                        url = url + "/ik-master.\(streamingParam["ik-master"] ?? "")"
                    }
                }
                if (self.transformationPosition == .QUERY){
                    url = String("\(url)/\(self.imagePath)")
                    if (streamingParam.keys.contains("ik-master")) {
                        url = url + "/ik-master.\(streamingParam["ik-master"] ?? "")"
                    }
                    queryParams["tr"] = transforms
                }
            }
        } else {
            if !self.isSource {
                url = String("\(self.endpoint)/\(self.imagePath)")
            }
        }
        guard url.isEmpty == false else {
            return ""
        }
        
        var urlComponents = URLComponents.init(string: url)!
        var queryItems = (urlComponents.queryItems ?? []) + self.queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        queryItems = queryItems.sorted(by: { first, second in return first.name < second.name })
        let urlParams = queryItems.map({ (queryItem) -> String in return "\(queryItem.name)=\(queryItem.value ?? "")" }).joined(separator: "&")
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
        urlComponents.percentEncodedQuery = urlParams.isEmpty ? nil : urlParams
        
        return urlComponents.string!
    }
    
    private func UIColorToHexString(_ color: UIColor) -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let multiplier = CGFloat(255.999999)
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        if alpha == 1.0 {
            return String(
                format: "%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        return String(
            format: "%02lX%02lX%02lX%02lX",
            Int(red * multiplier),
            Int(green * multiplier),
            Int(blue * multiplier),
            Int(alpha * multiplier)
        )
    }
}
