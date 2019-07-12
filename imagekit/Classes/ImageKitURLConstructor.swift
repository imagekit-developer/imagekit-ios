//
//  ImageKitURLConstructor.swift
//  Alamofire
//
//  Created by Akshit New on 03/07/19.
//

import Foundation

public class ImagekitUrlConstructor {
    
    private var endpoint: String!
    private var imagePath: String!
    
    private var transformationList = [String]()
    private var transformationMap = [String : Any]()
    
    init(endpoint: String, imagePath: String) {
        self.endpoint = endpoint
        self.imagePath = imagePath
    }
    
    /**
     * Method to specify the width of the output image.
     * @param width Accepts integer value greater than 1 and if a value between 0 and 1 is specified, then it acts as a percentage width.
     * For eg, 0.1 means 10% of the original width, 0.2 means 20% of the original width.
     * @return the current ImagekitUrlConstructor object.
     */
    func width(width: Float) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.width] = width
        transformationList.append(String(format: "%s-%.2f", TranformationMapping.width, width))
        return self
    }
    
    /**
     * Method to specify the height of the output image.
     * @param height Accepts integer value greater than 1 and if a value between 0 and 1 is specified, then it acts as a percentage height.
     * For eg, 0.1 means 10% of the original height, 0.2 means 20% of the original height.
     * @return the current ImagekitUrlConstructor object.
     */
    func height(height: Float) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.height] = height
        transformationList.append(String(format: "%s-%.2f", TranformationMapping.height, height))
        return self
    }
    
    /**
     * Method to specify the aspect ratio of the output image or the ratio of width to height of the output image.
     * This transform must be used along with either the height or the width transform.
     * @param width Accepts integer value greater than equal to 1
     * @param height Accepts integer value greater than equal to 1
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if both width and height are not provided.
     */
    func aspectRatio(width: Int, height: Int) throws -> ImagekitUrlConstructor {
        
        if (!transformationMap.keys.contains(TranformationMapping.width) &&
            !transformationMap.keys.contains(TranformationMapping.height)
            ) {
            throw ImagekitException.message(ErrorMessages.error_required_transform_value_not_specified)
        }
        
        let s = String(format: "%s-%d-%d", TranformationMapping.aspectRatio, width, height)
        transformationMap[TranformationMapping.aspectRatio] = s
        transformationList.append(s)
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
    func crop(cropType: CropType) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.crop] = cropType
        transformationList.append(String(format: "%s-%s", TranformationMapping.crop, cropType.rawValue))
        return self
    }
    
    /**
     * Method used to specify the strategy of how the input image is used for cropping to get the output image.
     * @param cropMode Accepts value of type CropMode. Possible values include resize, extract, pad_extract and pad_resize.
     * Default value - resize
     * @see CropMode
     * @return the current ImagekitUrlConstructor object.
     */
    func cropMode(cropMode: CropMode) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.cropMode] = cropMode
        transformationList.append(String(format: "%s-%s", TranformationMapping.cropMode, cropMode.rawValue))
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
    func focus(focusType: FocusType) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.focus] = focusType
        transformationList.append(String(format: "%s-%s", TranformationMapping.focus, focusType.rawValue))
        return self
    }
    
    /**
     * Method to specify the output quality of the lossy formats like JPG and WebP. A higher quality number means a
     * larger size of the output image with high quality. A smaller number means low quality image at a smaller size.
     * @param quality Accepts integer value between 1 and 100.
     * Default value is picked from the dashboard settings. It is set to 80.
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if quality is outside the 1 to 100 range.
     */
    func quality(quality: Int) throws -> ImagekitUrlConstructor {
        if (quality < 1 || quality > 100) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_out_of_range)
        }
        
        transformationMap[TranformationMapping.quality] = quality
        transformationList.append(String(format: "%s-%d", TranformationMapping.quality, quality))
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
    func format(format: Format) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.format] = format
        transformationList.append(String(format: "%s-%s", TranformationMapping.format, format.rawValue))
        return self
    }
    
    /**
     * Method to specify the Gaussian blur that has to be applied to the image. The value of blur decides the radius of
     * the Gaussian blur that is applied. Higher the value, higher is the radius of Gaussian blur.
     * @param blur Accepts integer value between 1 and 100.
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if quality is outside the 1 to 100 range.
     */
    func blur(blur: Int) throws -> ImagekitUrlConstructor {
        if (blur < 1 || blur > 100) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_out_of_range)
        }
        
        transformationMap[TranformationMapping.blur] = blur
        transformationList.append(String(format: "%s-%d", TranformationMapping.blur, blur))
        return self
    }
    
    /**
     * Method to turn an image into its grayscale version.
     * @param flag Accepts Bool value of either true or false. Default value is false.
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if quality is outside the 1 to 100 range.
     */
    func showInGrayscale(flag: Bool) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.eGrayscale] = flag
        
        if (flag) {
            transformationList.append(String(format: "%s", TranformationMapping.eGrayscale))
        }
        
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
     * @throws ImagekitException if quality is outside the 0.1 to 5.0 range.
     */
    func devicePixelRatio(dpr: Float) throws -> ImagekitUrlConstructor {
        if (dpr < 0.1 || dpr > 5) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_out_of_range)
        }
        
        transformationMap[TranformationMapping.dpr] = dpr
        transformationList.append(String(format: "%s-%f", TranformationMapping.dpr, dpr))
        return self
    }
    
    /**
     * Method to specify the Named transformations which is an alias for the entire transformation string.
     * E.g we can create a named transform media_library_thumbnail for transformation string tr:w-150,h-150,f-center,c-at_max
     * @param namedTransformation
     * @return the current ImagekitUrlConstructor object.
     */
    func namedTransformation(namedTransformation: String) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.namedTransformation] = namedTransformation
        transformationList.append(String(format: "%s-%s", TranformationMapping.namedTransformation, namedTransformation))
        return self
    }
    
    /**
     * Method to specify the default image which is delivered in case the image that is requested using ImageKit does not exist.
     * @param defaultImage
     * @return the current ImagekitUrlConstructor object.
     */
    func defaultImage(defaultImage: String) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.defaultImage] = defaultImage
        transformationList.append(String(format: "%s-%s", TranformationMapping.defaultImage, defaultImage))
        return self
    }
    
    /**
     * Method to specify if the output JPEG image should be rendered progressively. In progressive rendering,
     * the client instead of downloading the image row-wise (baseline loading), renders a low-quality pixelated
     * full image and then gradually keeps on adding more pixels and information to the image. It gives faster-perceived load times.
     * @param flag Possible values include true and false. Default value - false
     * @return the current ImagekitUrlConstructor object.
     */
    func isProgressiveJPEG(flag: Bool) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.progressiveJPEG] = flag
        transformationList.append(String(format: "%s-%b", TranformationMapping.progressiveJPEG, flag))
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
    func isLossless(flag: Bool) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.lossless] = flag
        transformationList.append(String(format: "%s-%b", TranformationMapping.lossless, flag))
        return self
    }
    
    /**
     * Method to specify if the redundant pixels of the original image need to be removed. It uses a default logic
     * to identify the redundant surrounding region and removes it. This transformation is useful for images that have
     * a solid / nearly-solid background and the object in the center. This transformation will trim
     * the background from the edges, leaving only the central object in the picture.
     * @param flag Possible values include true and false.
     * @return the current ImagekitUrlConstructor object.
     * @see trimEdges
     */
    func trimEdges(flag: Bool) throws -> ImagekitUrlConstructor {
        if (transformationMap.keys.contains(TranformationMapping.trimEdges)) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_already_exists)
        }
        
        transformationMap[TranformationMapping.trimEdges] = flag
        transformationList.append(String(format: "%s-%b", TranformationMapping.trimEdges, flag))
        return self
    }
    
    /**
     * Method to specify the number of redundant pixels of the original image that need to be removed.
     * This transformation is useful for images that have a solid / nearly-solid background and the object in the center.
     * This transformation will trim the background from the edges, leaving only the central object in the picture.
     * @param value Number of pixels from the edge that need to be removed across all four sides.
     * @return the current ImagekitUrlConstructor object.
     * @see trimEdges
     */
    func trimEdges(value: Int) throws -> ImagekitUrlConstructor {
        if (transformationMap.keys.contains(TranformationMapping.trimEdges)) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_already_exists)
        } else if (value < 1 || value > 99) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_out_of_range)
        }
        
        transformationMap[TranformationMapping.trimEdges] = value
        transformationList.append(String(format: "%s-%d", TranformationMapping.trimEdges, value))
        return self
    }
    
    /**
     * Method to specify an image to overlay over another image. This will help you generate watermarked images if needed.
     * @param overlayImage
     * @return the current ImagekitUrlConstructor object.
     */
    func overlayImage(overlayImage: String) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.overlayImage] = overlayImage
        transformationList.append(String(format: "%s-%s", TranformationMapping.overlayImage, overlayImage))
        return self
    }
    
    /**
     * Method used to specify the position of the overlaid image relative to the input image.
     * @param overlayFocus Possible values include center, top, left, bottom, right, top_left, top_right, bottom_left and bottom_right.
     * Default value - center
     * @see OverlayFocusType
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if not a single overlay is specified or the overlay coordinates have already been applied
     * using either overlayPosX() or overlayPosY()
     */
    func overlayFocus(overlayFocus: OverlayFocusType) throws -> ImagekitUrlConstructor {
        if (!transformationMap.keys.contains(TranformationMapping.overlayImage)
            || !transformationMap.keys.contains(TranformationMapping.overlayText)
            || !transformationMap.keys.contains(TranformationMapping.overlayBackground)
            ) {
            throw ImagekitException.message(ErrorMessages.error_required_transform_value_not_specified)
        } else if (transformationMap.keys.contains(TranformationMapping.overlayX)
            || transformationMap.keys.contains(TranformationMapping.overlayY)
            ) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_already_exists)
        }
        
        transformationMap[TranformationMapping.overlayFocus] = overlayFocus
        transformationList.append(String(format: "%s-%s", TranformationMapping.overlayFocus, overlayFocus.rawValue))
        return self
    }
    
    /**
     * Method used to provide more granular control over the positioning of the overlay image on the input image.
     * The top left corner of the input image is considered as (0,0) and the bottom right corner is considered as (w, h)
     * where w is the width and h is the height of the input image.
     * @param overlayPosX Possible values include zero and positive integers.
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if not a single overlay is specified
     * or the overlay focus has already been applied
     * or overlayPosX is less than 0.
     */
    func overlayPosX(overlayPosX: Int) throws -> ImagekitUrlConstructor {
        if (!transformationMap.keys.contains(TranformationMapping.overlayImage)
            || !transformationMap.keys.contains(TranformationMapping.overlayText)
            || !transformationMap.keys.contains(TranformationMapping.overlayBackground)
            ) {
            throw ImagekitException.message(ErrorMessages.error_required_transform_value_not_specified)
        } else if (transformationMap.keys.contains(TranformationMapping.overlayFocus)) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_already_exists)
        } else if (overlayPosX < 0) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_out_of_range)
        }
        
        transformationMap[TranformationMapping.overlayX] = overlayPosX
        transformationList.append(String(format: "%s-%d", TranformationMapping.overlayX, overlayPosX))
        return self
    }
    
    /**
     * Method used to provide more granular control over the positioning of the overlay image on the input image.
     * The top left corner of the input image is considered as (0,0) and the bottom right corner is considered as (w, h)
     * where w is the width and h is the height of the input image.
     * @param overlayPosY Possible values include zero and positive integers.
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if not a single overlay is specified
     * or the overlay focus has already been applied
     * or overlayPosY is less than 0.
     */
    func overlayPosY(overlayPosY: Int)  throws -> ImagekitUrlConstructor {
        if (!transformationMap.keys.contains(TranformationMapping.overlayImage)
            || !transformationMap.keys.contains(TranformationMapping.overlayText)
            || !transformationMap.keys.contains(TranformationMapping.overlayBackground)
            ) {
            throw ImagekitException.message(ErrorMessages.error_required_transform_value_not_specified)
        } else if (transformationMap.keys.contains(TranformationMapping.overlayFocus)) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_already_exists)
        } else if (overlayPosY < 0) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_out_of_range)
        }
        
        transformationMap[TranformationMapping.overlayY] = overlayPosY
        transformationList.append(String(format: "%s-%d", TranformationMapping.overlayY, overlayPosY))
        return self
    }
    
    /**
     * Method used to provide more granular control over the positioning of the overlay image on the input image.
     * Negative values are supported with a leading capital N in front of the value provided. The value provided
     * is subtracted from the original dimension of the image & positioned accordingly.
     * @param overlayNegX Possible values include integers less than zero.
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if not a single overlay is specified
     * or the overlay focus has already been applied
     * or overlayPosY is not a negative integer.
     * @see overlayPosX
     */
    func overlayNegX(overlayNegX: Int) throws -> ImagekitUrlConstructor {
        if (!transformationMap.keys.contains(TranformationMapping.overlayImage)
            || !transformationMap.keys.contains(TranformationMapping.overlayText)
            || !transformationMap.keys.contains(TranformationMapping.overlayBackground)
            ) {
            throw ImagekitException.message(ErrorMessages.error_required_transform_value_not_specified)
        } else if (transformationMap.keys.contains(TranformationMapping.overlayFocus)) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_already_exists)
        } else if (overlayNegX >= 0) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_out_of_range)
        }
        
        let s = String(format: "%s-N%s", TranformationMapping.overlayX, overlayNegX)
        transformationMap[TranformationMapping.overlayX] = s
        transformationList.append(s)
        return self
    }
    
    /**
     * Method used to provide more granular control over the positioning of the overlay image on the input image.
     * Negative values are supported with a leading capital N in front of the value provided. The value provided
     * is subtracted from the original dimension of the image & positioned accordingly.
     * @param overlayNegY Possible values include integers less than zero.
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if not a single overlay is specified
     * or the overlay focus has already been applied
     * or overlayPosY is not a negative integer.
     * @see overlayPosY
     */
    func overlayNegY(overlayNegY: Int) throws -> ImagekitUrlConstructor {
        if (!transformationMap.keys.contains(TranformationMapping.overlayImage)
            || !transformationMap.keys.contains(TranformationMapping.overlayText)
            || !transformationMap.keys.contains(TranformationMapping.overlayBackground)
            ) {
            throw ImagekitException.message(ErrorMessages.error_required_transform_value_not_specified)
        } else if (transformationMap.keys.contains(TranformationMapping.overlayFocus)) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_already_exists)
        } else if (overlayNegY >= 0) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_out_of_range)
        }
        
        let s = String(format: "%s-N%s", TranformationMapping.overlayY, overlayNegY)
        transformationMap[TranformationMapping.overlayY] = s
        transformationList.append(s)
        return self
    }
    
    /**
     * Method used to specify the width of the overlaid image.
     * @param overlayWidth
     * @return the current ImagekitUrlConstructor object.
     */
    func overlayWidth(overlayWidth: Float) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.overlayWidth] = overlayWidth
        transformationList.append(String(format: "%s-%f", TranformationMapping.overlayWidth, overlayWidth))
        return self
    }
    
    /**
     * Method used to specify the height of the overlaid image.
     * @param overlayHeight
     * @return the current ImagekitUrlConstructor object.
     */
    func overlayHeight(overlayHeight: Float) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.overlayHeight] = overlayHeight
        transformationList.append(String(format: "%s-%f", TranformationMapping.overlayHeight, overlayHeight))
        return self
    }
    
    /**
     * Method used to overlay text over an image. Our current support is limited to alphanumberic & special characters _ & - only.
     * @param overlayText
     * @return the current ImagekitUrlConstructor object.
     */
    func overlayText(overlayText: String) throws -> ImagekitUrlConstructor {
        let regex = "[\\w\\s-]+"
        if !overlayText.matches(regex) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_invalid)
        }
        
        transformationMap[TranformationMapping.overlayText] = overlayText
        transformationList.append(String(format: "%s-%s", TranformationMapping.overlayText, overlayText))
        return self
    }
    
    /**
     * Method used to specify the color of the overlaid text on the image.
     * @param overlayTextColor Possible value is a valid valid RGB Hex Code
     * @return the current ImagekitUrlConstructor object.
     */
    func overlayTextColor(overlayTextColor: String)  throws -> ImagekitUrlConstructor {
        if (!transformationMap.keys.contains(TranformationMapping.overlayText)) {
            throw ImagekitException.message(ErrorMessages.error_required_transform_value_not_specified)
        } else if (overlayTextColor.count != 6 || !overlayTextColor.matches("[A-Fa-f0-9]+")) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_invalid)
        }
        
        transformationMap[TranformationMapping.overlayTextColor] = overlayTextColor.uppercased()
        transformationList.append(
            String(format:
                "%s-%s",
                   TranformationMapping.overlayTextColor,
                   overlayTextColor.uppercased()
            )
        )
        return self
    }
    
    /**
     * Method used to specify the font family for the overlaid text.
     * @param overlayTextFont
     * @return the current ImagekitUrlConstructor object.
     * @see <a href="https://docs.imagekit.io/#server-side-image-upload">Supported fonts</a>.
     * @see OverlayTextFont
     */
    func overlayTextFont(overlayTextFont: OverlayTextFont) throws -> ImagekitUrlConstructor {
        if (!transformationMap.keys.contains(TranformationMapping.overlayText)) {
            throw ImagekitException.message(ErrorMessages.error_required_transform_value_not_specified)
        }
        
        transformationMap[TranformationMapping.overlayTextFont] = overlayTextFont
        transformationList.append(String(format: "%s-%s", TranformationMapping.overlayFocus, overlayTextFont.rawValue))
        return self
    }
    
    /**
     * Method used to specify the size of the overlaid text.
     * @param overlayTextSize Possible values include any integer. Default value - 14px
     * @return the current ImagekitUrlConstructor object.
     */
    func overlayTextSize(overlayTextSize: Int)  throws -> ImagekitUrlConstructor {
        if (!transformationMap.keys.contains(TranformationMapping.overlayText)) {
            throw ImagekitException.message(ErrorMessages.error_required_transform_value_not_specified)
        }
        
        transformationMap[TranformationMapping.overlayTextSize] = overlayTextSize
        transformationList.append(String(format: "%s-%d", TranformationMapping.overlayTextSize, overlayTextSize))
        return self
    }
    
    /**
     * Method used to specify the typography of the font family used for the overlaid text. Possible values include bold b and italics i.
     * Note Bold & Italics are not supported for all provided fonts.
     * @param overlayTextTypography
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if overlay text has not been specified
     * @see <a href="https://docs.imagekit.io/#server-side-image-upload">Supported fonts</a>.
     * @see OverlayTextTypography
     */
    func overlayTextTypography(overlayTextTypography: OverlayTextTypography) throws -> ImagekitUrlConstructor {
        if (!transformationMap.keys.contains(TranformationMapping.overlayText)) {
            throw ImagekitException.message(ErrorMessages.error_required_transform_value_not_specified)
        }
        
        transformationMap[TranformationMapping.overlayTextTypography] = overlayTextTypography
        transformationList.append(
            String(format:
                "%s-%s",
                   TranformationMapping.overlayTextTypography,
                   overlayTextTypography.rawValue
            )
        )
        return self
    }
    
    /**
     * Method used to specify the colour of background canvas to be overlaid. Possible values include a valid RGB Hex code.
     * @param overlayBackgroundColor
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if color is not a valid RGB Hex code.
     */
    func overlayBackgroundColor(overlayBackgroundColor: String)  throws -> ImagekitUrlConstructor {
        if (overlayBackgroundColor.count != 6 || !overlayBackgroundColor.matches("[A-Fa-f0-9]+")) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_invalid)
        }
        
        transformationMap[TranformationMapping.overlayBackground] = overlayBackgroundColor.uppercased()
        transformationList.append(
            String(format:
                "%s-%s",
                   TranformationMapping.overlayBackground,
                   overlayBackgroundColor.uppercased()
            )
        )
        return self
    }
    
    /**
     * Method used to specify the transparency level for the overlaid image.
     * Note Overlay transparency is currently supported for overlay texts & backgrounds only.
     * @param overlayTransparency Possible values include integer from 1 to 9.
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if neither an overlay text nor background is specified
     */
    func overlayTransparency(overlayTransparency: Int) throws -> ImagekitUrlConstructor {
        if (!transformationMap.keys.contains(TranformationMapping.overlayText)
            || !transformationMap.keys.contains(TranformationMapping.overlayBackground)
            ) {
            throw ImagekitException.message(ErrorMessages.error_required_transform_value_not_specified)
        } else if !((1...9).contains(overlayTransparency)) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_out_of_range)
        }
        
        transformationMap[TranformationMapping.overlayTransparency] = overlayTransparency
        transformationList.append(String(format: "%s-%d", TranformationMapping.overlayTransparency, overlayTransparency))
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
    func includeColorProfile(flag: Bool) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.colorProfile] = flag
        transformationList.append(String(format: "%s-%b", TranformationMapping.colorProfile, flag))
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
    func includeImageMetadata(flag: Bool) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.imageMetadata] = flag
        transformationList.append(String(format: "%s-%b", TranformationMapping.imageMetadata, flag))
        return self
    }
    
    /**
     * Method used to specify the degrees by which the output image has to be rotated or specifies the use of
     * EXIF Orientation tag for the rotation of the image using auto.
     * @param rotation Possible values include 0, 90, 180, 270, 360 and auto.
     * Default value - center
     * @see Rotation
     * @return the current ImagekitUrlConstructor object.
     */
    func rotate(rotation: Rotation) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.rotate] = rotation
        transformationList.append(String(format: "%s-%s", TranformationMapping.rotate, rotation.rawValue))
        return self
    }
    
    /**
     * Method used to specify the radius to be used to get a rounded corner image.
     * This option is applied after resizing of the image, if any.
     * @param radius Possible values include positive integer.
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if radius has already been specified
     */
    func radius(radius: Int) throws -> ImagekitUrlConstructor {
        if (transformationMap.keys.contains(TranformationMapping.radius)) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_already_exists)
        }
        
        transformationMap[TranformationMapping.radius] = radius
        transformationList.append(String(format: "%s-%d", TranformationMapping.radius, radius))
        return self
    }
    
    /**
     * Method used to get a perfectly rounded image.
     * This option is applied after resizing of the image, if any.
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if radius has already been specified
     */
    func round() throws -> ImagekitUrlConstructor {
        if (transformationMap.keys.contains(TranformationMapping.radius)) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_already_exists)
        }
        
        transformationMap[TranformationMapping.radius] = "max"
        transformationList.append(String(format: "%s-%s", TranformationMapping.radius, "max"))
        return self
    }
    
    /**
     * Method used to specify the background color as RGB hex code (e.g. FF0000) to be used for the image.
     * @param backgroundHexColor Default value - Black 000000
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if color is not a valid RGB Hex code.
     */
    func backgroundHexColor(backgroundHexColor: String) throws -> ImagekitUrlConstructor {
        if (backgroundHexColor.count != 6 || !backgroundHexColor.matches("[A-Fa-f0-9]+")) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_invalid)
        }
        
        transformationMap[TranformationMapping.backgroundColor] = backgroundHexColor.uppercased()
        transformationList.append(
            String(format:
                "%s-%s",
                   TranformationMapping.backgroundColor,
                   backgroundHexColor.uppercased()
            )
        )
        return self
    }
    
    /**
     * Method used to specify the background color as an RGBA code (e.g. FFAABB50) to be used for the image.
     * @param backgroundRGBAColor If you specify an 8-character background, the last two characters should be numbers from
     * 00 to 99 which indicate the opacity level of the background. 00 corresponds to an opacity of 0.00,
     * 01 corresponds to an opacity of 0.01 and so on.
     * Default value - Black 000000
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if color is not a valid RGBA code.
     */
    func backgroundRGBAColor(backgroundRGBAColor: String) throws -> ImagekitUrlConstructor {
        if (backgroundRGBAColor.count != 8 || !backgroundRGBAColor.matches("[A-Fa-f0-9]{6}[0-9]{2}+")) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_invalid)
        }
        
        transformationMap[TranformationMapping.backgroundColor] = backgroundRGBAColor.uppercased()
        transformationList.append(
            String(format:
                "%s-%s",
                   TranformationMapping.backgroundColor,
                   backgroundRGBAColor.uppercased()
            )
        )
        return self
    }
    
    /**
     * Method used to specify the width and color of the border that is added around the image.
     * The width is a positive integer that specifies the border width in pixels.
     * The border color is specified as a standard RGB hex code e.g b-<width>_<color>
     * @param borderWidth width of the border
     * @param borderColor color of the border as RGB hex code
     * @return the current ImagekitUrlConstructor object.
     * @throws ImagekitException if color is not a valid RGB hex code.
     */
    func border(borderWidth: Int, borderColor: String) throws -> ImagekitUrlConstructor {
        if (borderColor.count != 6 || !borderColor.matches("[A-Fa-f0-9]+")) {
            throw ImagekitException.message(ErrorMessages.error_transform_value_invalid)
        }
        
        let s = String(format: "%s-%d_%s", TranformationMapping.border, borderWidth, borderColor.uppercased())
        transformationMap[TranformationMapping.border] = s
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
    func stretchContrast(flag: Bool) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.contrastStretch] = flag
        
        if (flag) {
            transformationList.append(String(format: "%s", TranformationMapping.contrastStretch))
        }
        
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
    func sharpen(value: Int = 0) -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.sharpen] = value
        transformationList.append(String(format: "%s-%d", TranformationMapping.sharpen, value))
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
    func applyUnsharpMask(radius: Float, sigma: Float, amount: Float, threshold: Float) -> ImagekitUrlConstructor {
        let s = String(format: "%s-%f-%f-%f-%f", TranformationMapping.unsharpMask, radius, sigma, amount, threshold)
        transformationMap[TranformationMapping.unsharpMask] = s
        transformationList.append(s)
        return self
    }
    
    /**
     * Some transformations are dependent on the sequence in which they are carried out.
     * Method used to add sequence dependent steps in a transform chain to obtain predictable results.
     * @see <a href="https://docs.imagekit.io/#chained-transformations">Chained Transformations</a>.
     * @return the current ImagekitUrlConstructor object.
     */
    func addTransformationStep() -> ImagekitUrlConstructor {
        transformationMap[TranformationMapping.transformationStep] = ":"
        transformationList.append(":")
        
        return self
    }
    
    /**
     * Used to create the url using the transformations specified before invoking this method.
     * @return the Url used to fetch an image after applying the specified transformations.
     */
    func create() -> String {
        var url = endpoint
        
        if !transformationList.isEmpty {
            url = String(format: "%s/tr:", url!)
            for t in 0...transformationList.count {
//                url = when {
//                    transformationList[t].contentEquals(":") -> String(format: "%s%s", url, transformationList[t])
//                    url.endsWith(":") -> String(format: "%s%s", url, transformationList[t])
//                    else -> String(format: "%s,%s", url, transformationList[t])
//                }
            }
        }
        
        url = String(format: "%s/%s", url!, imagePath)
        return url!
    }
    
    
    
}


/*
 * Regular Expression matching function for Strings
 */

extension String {
    
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
}
