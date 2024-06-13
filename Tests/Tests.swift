import Quick
import Nimble
@testable import ImageKitIO
import Swifter


//class URLGenerationSpec: QuickSpec {
//    
//    override func spec() {
//        
//        beforeSuite {
//            _ = ImageKit.init(publicKey: "Dummy public key", urlEndpoint: "https://ik.imagekit.io/demo", transformationPosition: TransformationPosition.PATH)
//        }
//        
//        it("Overriding urlEndpoint Parameter") {
//            let actual = ImageKit.shared
//                .url(urlEndpoint: "https://ik.imagekit.io/modified_imagekitid", path: "medium_cafe_B1iTdD0C.jpg")
//                .create()
//            expect(actual).to(equal(String(format: "https://ik.imagekit.io/modified_imagekitid/medium_cafe_B1iTdD0C.jpg")))
//        }
//        
//        it("Removal of double slashes in urlEndpoint") {
//            let actual = ImageKit.shared
//                .url(urlEndpoint: "https://ik.imagekit.io/demo/", path: "medium_cafe_B1iTdD0C.jpg")
//                .create()
//            expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg")))
//        }
//        
//        it("Removal of double slashes in path") {
//            let actual = ImageKit.shared
//                .url(urlEndpoint: "https://ik.imagekit.io/demo/", path: "/medium_cafe_B1iTdD0C.jpg")
//                .create()
//            expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg")))
//        }
//        
//        it("New transformation parameter") {
//            let actual = ImageKit.shared
//                .url(urlEndpoint: "https://ik.imagekit.io/demo", path: "medium_cafe_B1iTdD0C.jpg")
//                .addCustomTransformation(key: "test", value: "test")
//                .create()
//            expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:test-test/medium_cafe_B1iTdD0C.jpg")))
//        }
//        
//        it("SDK Version as Query Parameter") {
//            let actual = ImageKit.shared
//                .url(urlEndpoint: "https://ik.imagekit.io/demo", path: "medium_cafe_B1iTdD0C.jpg")
//                .create()
//            expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg")))
//        }
//        
//        it("Query Transformations") {
//            let actual = ImageKit.shared
//                .url(path: "medium_cafe_B1iTdD0C.jpg", transformationPosition: TransformationPosition.QUERY)
//                .width(width: 300)
//                .height(height: 300)
//                .create()
//            expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?tr=w-300,h-300")))
//        }
//        
//        it("Chained Transformation") {
//            let actual = ImageKit.shared
//                .url(urlEndpoint: "https://ik.imagekit.io/demo", path: "medium_cafe_B1iTdD0C.jpg")
//                .height(height: 300)
//                .chainTransformation()
//                .rotation(rotation: Rotation.VALUE_90)
//                .create()
//            expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:h-300:rt-90/medium_cafe_B1iTdD0C.jpg")))
//        }
//        
//        it("Source URL") {
//            let actual = ImageKit.shared
//                .url(src: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg")
//                .create()
//            expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg")))
//        }
//        
//        it("Custom Query Parameter") {
//            let actual = ImageKit.shared
//                .url(src: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg")
//                .addCustomQueryParameter(key: "x-test-header", value: "Test")
//                .create()
//            expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?x-test-header=Test")))
//        }
//        
//        it("Source URL with Path Transforms") {
//            let actual = ImageKit.shared
//                .url(src: "https://ik.imagekit.io/demo/tr:h-300.00,w-300.00:rt-90/medium_cafe_B1iTdD0C.jpg")
//                .height(height: 300)
//                .width(width: 300)
//                .chainTransformation()
//                .rotation(rotation: Rotation.VALUE_90)
//                .create()
//            expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?tr=h-300,w-300:rt-90")))
//        }
//        
//        it("Custom Query Parameter with Transforms") {
//            let actual = ImageKit.shared
//                .url(src: "https://ik.imagekit.io/demo/tr:h-300.00,w-300.00:rt-90/medium_cafe_B1iTdD0C.jpg?t1=v")
//                .height(height: 300)
//                .width(width: 300)
//                .chainTransformation()
//                .rotation(rotation: Rotation.VALUE_90)
//                .addCustomQueryParameters(params: ["x-test-header": "Test"])
//                .create()
//            expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?t1=v&tr=h-300,w-300:rt-90&x-test-header=Test")))
//        }
//        
//        it("Appending Custom Query Parameter") {
//            let actual = ImageKit.shared
//                .url(src: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg")
//                .addCustomQueryParameter(key: "t1", value: "v")
//                .addCustomQueryParameters(params: ["x-test-header": "Test"])
//                .create()
//            expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?t1=v&x-test-header=Test")))
//        }
//    }
//}
//class UnitTestSpec: QuickSpec {
//    override func spec() {
//        describe("Basic URL Generation") {
//            it("Path") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Url Endpoint and Path") {
//                let actual = ImageKit.shared
//                    .url(urlEndpoint: "https://ik.imagekit.io/demo", path: "medium_cafe_B1iTdD0C.jpg")
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Source") {
//                let actual = ImageKit.shared
//                    .url(src: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg")
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg")))
//            }
//        }
//        
//        describe("Transformations") {
//            it("Width: 300") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .width(width: 300)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:w-300/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Height: 300") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .height(height: 300)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:h-300/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Aspect Ratio: 2 by 3") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .aspectRatio(width: 2, height: 3)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:ar-2-3/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Crop: maintain_ratio") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .crop(cropType: CropType.MAINTAIN_RATIO)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:c-maintain_ratio/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Crop: force") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .crop(cropType: CropType.FORCE)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:c-force/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Crop: at_least") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .crop(cropType: CropType.AT_LEAST)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:c-at_least/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Crop: at_max") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .crop(cropType: CropType.AT_MAX)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:c-at_max/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Crop Mode: resize") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .cropMode(cropMode: .RESIZE)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:cm-resize/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Crop Mode: extract") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .cropMode(cropMode: .EXTRACT)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:cm-extract/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Crop Mode: pad_extract") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .cropMode(cropMode: .PAD_EXTRACT)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:cm-pad_extract/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Crop Mode: pad_resize") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .cropMode(cropMode: .PAD_RESIZE)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:cm-pad_resize/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Focus Type: center") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .focus(focusType: .CENTER)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:fo-center/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Focus Type: top") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .focus(focusType: .TOP)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:fo-top/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Focus Type: left") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .focus(focusType: .LEFT)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:fo-left/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Focus Type: bottom") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .focus(focusType: .BOTTOM)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:fo-bottom/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Focus Type: right") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .focus(focusType: .RIGHT)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:fo-right/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Focus Type: top_left") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .focus(focusType: .TOP_LEFT)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:fo-top_left/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Focus Type: top_right") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .focus(focusType: .TOP_RIGHT)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:fo-top_right/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Focus Type: bottom_left") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .focus(focusType: .BOTTOM_LEFT)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:fo-bottom_left/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Focus Type: bottom_right") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .focus(focusType: .BOTTOM_RIGHT)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:fo-bottom_right/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Focus Type: auto") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .focus(focusType: .AUTO)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:fo-auto/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Focus: 100, 300") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .width(width: 300)
//                    .height(height: 300)
//                    .cropMode(cropMode: .EXTRACT)
//                    .focus(x: 100, y: 300)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:w-300,h-300,cm-extract,x-100,y-300/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Quality: 50") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .quality(quality: 50)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:q-50/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Format: auto") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .format(format: .AUTO)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:f-auto/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Format: webp") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .format(format: .WEBP)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:f-webp/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Format: jpg") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .format(format: .JPG)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:f-jpg/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Format: jpeg") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .format(format: .JPEG)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:f-jpeg/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Format: png") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .format(format: .PNG)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:f-png/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Blur: 50") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .blur(blur: 50)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:bl-50/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Grayscale") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .effectGray(flag: true)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:e-grayscale/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("DPR: 2.5") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .dpr(dpr: 2.5)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:dpr-2.50/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Named Transform: test") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .named(namedTransformation: "test")
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:n-test/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Default Image: medium_cafe_B1iTdD0C.jpg") {
//                let actual = ImageKit.shared
//                    .url(path: "non_existent_image.jpg")
//                    .defaultImage(defaultImage: "medium_cafe_B1iTdD0C.jpg")
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:di-medium_cafe_B1iTdD0C.jpg/non_existent_image.jpg")))
//            }
//            it("Progressive") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .progressive(flag: true)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:pr-true/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Lossless") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .lossless(flag: true)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:lo-true/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Trim") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .trim(flag: true)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:t-true/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Trim: 50") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .trim(value: 50)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:t-50/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Color Profile") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .colorProfile(flag: true)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:cp-true/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Metadata") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .metadata(flag: true)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:md-true/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Rotation: auto") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .rotation(rotation: .AUTO)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:rt-auto/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Rotation: 0") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .rotation(rotation: .VALUE_0)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:rt-0/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Rotation: 90") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .rotation(rotation: .VALUE_90)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:rt-90/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Rotation: 180") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .rotation(rotation: .VALUE_180)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:rt-180/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Rotation: 270") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .rotation(rotation: .VALUE_270)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:rt-270/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Rotation: 360") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .rotation(rotation: .VALUE_360)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:rt-360/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Radius: 5") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .radius(radius: 5)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:r-5/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Round") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .round()
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:r-max/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Background: 00AAFF55") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .background(backgroundColor: "00AAFF55")
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:bg-00AAFF55/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Background: UIColor.black") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .background(backgroundColor: UIColor.black)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:bg-000000/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Border: 5, 00AAFF55") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .border(borderWidth: 5, borderColor: "00AAFF55")
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:b-5_00AAFF55/medium_cafe_B1iTdD0C.jpg")))
//            }
//            
//            it("Border: 5, UIColor.blue") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .border(borderWidth: 5, borderColor: UIColor.blue)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:b-5_0000FF/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Contrast") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .effectContrast(flag: true)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:e-contrast/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Sharpen: 5") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .effectSharpen(value: 5)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:e-sharpen-5/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("USM") {
//                let actual = ImageKit.shared
//                    .url(path: "medium_cafe_B1iTdD0C.jpg")
//                    .effectUSM(radius: 5, sigma: 5, amount: 5, threshold: 5)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:e-usm-5.00-5.00-5.00-5.00/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Chain Transformation") {
//                let actual = ImageKit.shared
//                    .url(urlEndpoint: "https://ik.imagekit.io/demo", path: "medium_cafe_B1iTdD0C.jpg")
//                    .height(height: 300)
//                    .chainTransformation()
//                    .rotation(rotation: Rotation.VALUE_90)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:h-300:rt-90/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Custom Transfomation: w 300") {
//                let actual = ImageKit.shared
//                    .url(urlEndpoint: "https://ik.imagekit.io/demo", path: "medium_cafe_B1iTdD0C.jpg")
//                    .addCustomTransformation(key: "w", value: "300")
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:w-300/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("With raw transforms string") {
//                let actual = ImageKit.shared
//                    .url(src: "https://ik.imagekit.io/demo/img/plant.jpeg")
//                    .raw(params: "w-400:l-text,i-Hand%20with%20a%20green%20plant,co-264120,fs-30,lx-10,ly-20,l-end")
//                    .create()
//                expect(actual).to(equal("https://ik.imagekit.io/demo/img/plant.jpeg?tr=w-400:l-text,i-Hand%20with%20a%20green%20plant,co-264120,fs-30,lx-10,ly-20,l-end"))
//            }
//        }
//        
//        describe("Image Path with Transformations height: 300, width: 300 and rotate: 90") {
//            it("Path Transformations") {
//                let actual = ImageKit.shared
//                    .url(urlEndpoint: "https://ik.imagekit.io/demo", path: "medium_cafe_B1iTdD0C.jpg")
//                    .height(height: 300)
//                    .width(width: 300)
//                    .chainTransformation()
//                    .rotation(rotation: Rotation.VALUE_90)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:h-300,w-300:rt-90/medium_cafe_B1iTdD0C.jpg")))
//            }
//            it("Query Transformations") {
//                let actual = ImageKit.shared
//                    .url(urlEndpoint: "https://ik.imagekit.io/demo", path: "medium_cafe_B1iTdD0C.jpg", transformationPosition: TransformationPosition.QUERY)
//                    .height(height: 300)
//                    .width(width: 300)
//                    .chainTransformation()
//                    .rotation(rotation: Rotation.VALUE_90)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?tr=h-300,w-300:rt-90")))
//            }
//        }
//        describe("Src with Transformations height: 300, width: 300 and rotate: 90") {
//            it("Without Transforms") {
//                let actual = ImageKit.shared
//                    .url(src: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg")
//                    .height(height: 300)
//                    .width(width: 300)
//                    .chainTransformation()
//                    .rotation(rotation: Rotation.VALUE_90)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?tr=h-300,w-300:rt-90")))
//            }
//            it("With Path Transforms") {
//                let actual = ImageKit.shared
//                    .url(src: "https://ik.imagekit.io/demo/tr:h-300.00,w-300.00:rt-90/medium_cafe_B1iTdD0C.jpg")
//                    .height(height: 300)
//                    .width(width: 300)
//                    .chainTransformation()
//                    .rotation(rotation: Rotation.VALUE_90)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?tr=h-300,w-300:rt-90")))
//            }
//            it("With Query Transforms") {
//                let actual = ImageKit.shared
//                    .url(src: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?tr=h-300.00,w-300.00:rt-90")
//                    .height(height: 300)
//                    .width(width: 300)
//                    .chainTransformation()
//                    .rotation(rotation: Rotation.VALUE_90)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?tr=h-300,w-300:rt-90")))
//            }
//            it("Empty URL") {
//                let actual = ImageKit.shared
//                    .url(src: "")
//                    .create()
//                expect(actual).to(equal(String(format: "")))
//            }
//        }
//        
//        describe("Video URL for adaptive streaming") {
//            it("DASH format with path params") {
//                let actual = ImageKit.shared
//                    .url(path: "sample_video.mp4", transformationPosition: .PATH)
//                    .setAdaptiveStreaming(format: .DASH, resolutions: [360, 480, 720, 1080])
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:sr-360_480_720_1080/sample_video.mp4/ik-master.mpd")))
//            }
//            it("HLS format with path params") {
//                let actual = ImageKit.shared
//                    .url(path: "sample_video.mp4", transformationPosition: .PATH)
//                    .setAdaptiveStreaming(format: .HLS, resolutions: [360, 480, 720, 1080])
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/tr:sr-360_480_720_1080/sample_video.mp4/ik-master.m3u8")))
//            }
//            it("DASH format with query params") {
//                let actual = ImageKit.shared
//                    .url(path: "sample_video.mp4", transformationPosition: .QUERY)
//                    .setAdaptiveStreaming(format: .DASH, resolutions: [360, 480, 720, 1080])
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/sample_video.mp4/ik-master.mpd?tr=sr-360_480_720_1080")))
//            }
//            it("HLS format with query params") {
//                let actual = ImageKit.shared
//                    .url(path: "sample_video.mp4", transformationPosition: .QUERY)
//                    .setAdaptiveStreaming(format: .HLS, resolutions: [360, 480, 720, 1080])
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/sample_video.mp4/ik-master.m3u8?tr=sr-360_480_720_1080")))
//            }
//        }
//        
//        describe("Responsive URL loading for UIViews") {
//            it("With default params") {
//                let view = UIView()
//                let dpr = String(format: "%.2f", Float(UIScreen.main.scale.rounded(.toNearestOrAwayFromZero)))
//                view.frame = CGRect(x: 0, y: 0, width: 400, height: 300)
//                let actual = try! ImageKit.shared
//                    .url(src: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg")
//                    .setResponsive(view: view)
//                    .create()
//                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?tr=w-400,h-300,dpr-\(dpr),cm-resize,fo-center")))
//            }
//        }
//    }
//}
//
//class MimeDetectorSpec: QuickSpec {
//    override func spec() {
//        describe(".readBytes() when we want to read 4 bytes of string data") {
//            let str = "hello"
//            let data = str.data(using: .utf8)!
//            let mimeDetector = MimeDetector(data: data)
//            let bytes = mimeDetector.readBytes(count: 4)
//            
//            it("should return 4 bytes") {
//                expect(bytes.count) == 4
//            }
//            
//            it("should return correct bytes") {
//                let endIndex = str.index(str.startIndex, offsetBy: 4)
//                let substr = str[..<endIndex]
//                let expectation = [UInt8](substr.utf8)
//                
//                expect(bytes) == expectation
//            }
//        }
//        
//        describe("MimeDetector.mimeType(data:)") {
//            let extensions = [
//                "7z",
//                "amr",
//                "ar",
//                "avi",
//                "bmp",
//                "bz2",
//                "cab",
//                "cr2",
//                "crx",
//                "deb",
//                "dmg",
//                "eot",
//                "epub",
//                "exe",
//                "flac",
//                "flif",
//                "flv",
//                "gif",
//                "ico",
//                "jpg",
//                "jxr",
//                "m4a",
//                "m4v",
//                "mid",
//                "mkv",
//                "mov",
//                "mp3",
//                "mp4",
//                "mpg",
//                "msi",
//                "mxf",
//                "nes",
//                "ogg",
//                "opus",
//                "otf",
//                "pdf",
//                "png",
//                "ps",
//                "psd",
//                "rar",
//                "rpm",
//                "rtf",
//                "sqlite",
//                "swf",
//                "tar",
//                "tar.Z",
//                "tar.gz",
//                "tar.lz",
//                "tar.xz",
//                "ttf",
//                "wav",
//                "webm",
//                "webp",
//                "wmv",
//                "woff",
//                "woff2",
//                "xpi",
//                "zip"
//            ]
//            
//            let mimeTypeByExtension = [
//                "tar.Z": "application/x-compress",
//                "tar.gz": "application/gzip",
//                "tar.lz": "application/x-lzip",
//                "tar.xz": "application/x-xz"
//            ]
//            
//            for ext in extensions {
//                context("when extension is \(ext)") {
//                    it("shoud guess the correct mime type") {
//                        let data = loadFileData(path: "/Tests/fixtures/fixture.\(ext)")
//                        let mimeType = MimeDetector.mimeType(data: data)
//                        
//                        if let mime = mimeTypeByExtension[ext] {
//                            expect(mimeType?.mime) == mime
//                        } else {
//                            expect(mimeType?.ext) == ext
//                        }
//                    }
//                }
//            }
//        }
//        
//        describe("MimeDetector.mimeType(bytes:)") {
//            context("when given jpeg bytes") {
//                it("should return image/jpeg mime type") {
//                    let bytes: [UInt8] = [255, 216, 255]
//                    let mimeType = MimeDetector.mimeType(bytes: bytes)
//                    
//                    expect(mimeType?.mime) == "image/jpeg"
//                }
//            }
//            
//            context("when given 7z bytes") {
//                it("should return application/x-7z-compressed") {
//                    let bytes: [UInt8] = [55, 122, 188, 175, 39, 28]
//                    let mimeType = MimeDetector.mimeType(bytes: bytes)
//                    
//                    expect(mimeType?.mime) == "application/x-7z-compressed"
//                }
//            }
//        }
//        
//        describe("MimeDetector.mimeType(bytes:).type") {
//            context("when file type is image/jpeg") {
//                it("should return true") {
//                    let data: Data = loadFileData(path: "/Tests/fixtures/fixture.jpg")
//                    let mimeType = MimeDetector.mimeType(data: data)
//                    
//                    expect(mimeType?.type) == .jpg
//                }
//            }
//            
//            context("when file type is application/pdf") {
//                it("should return true") {
//                    let data: Data = loadFileData(path: "/Tests/fixtures/fixture.pdf")
//                    let mimeType = MimeDetector.mimeType(data: data)
//                    
//                    expect(mimeType?.type) == .pdf
//                }
//            }
//            
//            context("when file type is not image/jpeg") {
//                it("should return true") {
//                    let data: Data = loadFileData(path: "/Tests/fixtures/fixture.png")
//                    let mimeType = MimeDetector.mimeType(data: data)
//                    
//                    expect(mimeType?.type) != .jpg
//                }
//            }
//        }
//    }
//}
//
//func loadFileData(path: String) -> Data {
//    let projectDir = URL(fileURLWithPath: #file).pathComponents.prefix(while: { $0 != "Tests" }).joined(separator: "/").dropFirst()
//    print(projectDir)
//    let absolutePath = "\(projectDir)\(path)"
//    print(absolutePath)
//    let url = URL(fileURLWithPath: absolutePath, isDirectory: false)
//    return try! Data(contentsOf: url)
//}

class UploadSpec: QuickSpec {
    
    private var server: HttpServer = HttpServer()
    
    override func spec() {
        beforeSuite {
            _ = ImageKit.init(publicKey: "Dummy public key", urlEndpoint: "https://ik.imagekit.io/demo", transformationPosition: TransformationPosition.PATH)
            self.server = HttpServer()
            self.server["/test"] = { request in
                return .ok(.text("Mock response"))
            }
            do {
                try self.server.start(8003, forceIPv4: true)
                UploadAPI.baseUrl = "http://127.0.0.1:8003"
                NSLog("Mocker server started at: \(try self.server.port())")
            } catch {
                fail("Mocker server failed to start: \(error)")
            }
        }
        
        afterSuite {
            self.server.stop()
            NSLog("Mocker server stopped")
        }
                
        describe("Successful Upload") {
            let sampleExtensions = [
                ["name" : "remove-bg", "options" : ["add_shadow" : true]],
                ["name": "google-auto-tagging", "minConfidence": 80, "maxTags": 5]
            ]
            let sampleMetadata = ["device_name": "Emulator", "uid": 167434]
            it("Upload From Url") {
                self.server["/api/v2/files/upload"] = { request in
                    var bodyParts = request.parseMultiPartFormData()
                    expect(String(bytes: bodyParts.first { $0.name == "file" }?.body ?? [], encoding: .utf8))
                        .to(equal("https://ik.imagekit.io/demo/default-image.jpg"))
                    expect(String(bytes: bodyParts.first { $0.name == "token" }?.body ?? [], encoding: .utf8))
                        .to(equal("test1"))
                    expect(String(bytes: bodyParts.first { $0.name == "fileName" }?.body ?? [], encoding: .utf8))
                        .to(equal("default-image-test.jpg"))
                    expect(String(bytes: bodyParts.first { $0.name == "tags" }?.body ?? [], encoding: .utf8))
                        .to(equal("test,image"))
                    expect(String(bytes: bodyParts.first { $0.name == "folder" }?.body ?? [], encoding: .utf8))
                        .to(equal("/tmp/test"))
                    expect(String(bytes: bodyParts.first { $0.name == "customCoordinates" }?.body ?? [], encoding: .utf8))
                        .to(equal("10,10,100,100"))
                    expect(String(bytes: bodyParts.first { $0.name == "responseFields" }?.body ?? [], encoding: .utf8))
                        .to(equal("tags,customCoordinates,isPrivateFile"))
                    let receivedExt = try! JSONSerialization.data(withJSONObject: try! JSONSerialization.jsonObject(with: Data(bytes: bodyParts.first { $0.name == "extensions" }?.body ?? [])), options: .sortedKeys)
                    let expectedExt = try! JSONSerialization.data(withJSONObject: sampleExtensions, options: .sortedKeys)
                    expect(String(data: receivedExt, encoding: .utf8)).to(equal(String(data: expectedExt, encoding: .utf8)))
                    expect(String(bytes: bodyParts.first { $0.name == "webhookUrl" }?.body ?? [], encoding: .utf8))
                        .to(equal("https://dummy.io/hook"))
                    expect(String(bytes: bodyParts.first { $0.name == "overwriteFile" }?.body ?? [], encoding: .utf8))
                        .to(equal("false"))
                    expect(String(bytes: bodyParts.first { $0.name == "overwriteAITags" }?.body ?? [], encoding: .utf8))
                        .to(equal("false"))
                    expect(String(bytes: bodyParts.first { $0.name == "overwriteTags" }?.body ?? [], encoding: .utf8))
                        .to(equal("true"))
                    expect(String(bytes: bodyParts.first { $0.name == "overwriteCustomMetadata" }?.body ?? [], encoding: .utf8))
                        .to(equal("true"))
                    let receivedMeta = try! JSONSerialization.data(withJSONObject: try! JSONSerialization.jsonObject(with: Data(bytes: bodyParts.first { $0.name == "customMetadata" }?.body ?? [])), options: .sortedKeys)
                    let expectedMeta = try! JSONSerialization.data(withJSONObject: sampleMetadata, options: .sortedKeys)
                    expect(String(data: receivedMeta, encoding: .utf8)).to(equal(String(data: expectedMeta, encoding: .utf8)))
                    return HttpResponse.ok(.json([
                        "fileId": "5f881125ce8f14336dda25b6",
                        "name": "default-image-test_1JO5mllWR.jpg",
                        "size": 146974,
                        "filePath": "/default-image-test_1JO5mllWR.jpg",
                        "url": "https://ik.imagekit.io/demo/default-image-test_1JO5mllWR.jpg",
                        "fileType": "image",
                        "height": 1000,
                        "width": 1000,
                        "thumbnailUrl": "https://ik.imagekit.io/demo/tr:n-media_library_thumbnail/default-image-test_1JO5mllWR.jpg"
                    ]))
                }
                
                waitUntil(timeout: DispatchTimeInterval.seconds(60)){ done in
                    let urlConfiguration = URLSessionConfiguration.default
                    ImageKit.shared.uploader().upload(
                        file: "https://ik.imagekit.io/demo/default-image.jpg",
                        token: "test1",
                        fileName: "default-image-test.jpg",
                        tags: ["test", "image",],
                        folder: "/tmp/test",
                        customCoordinates: "10,10,100,100",
                        responseFields: "tags,customCoordinates,isPrivateFile",
                        extensions: sampleExtensions,
                        webhookUrl: "https://dummy.io/hook",
                        overwriteFile: false,
                        overwriteAITags: false,
                        overwriteTags: true,
                        overwriteCustomMetadata: true,
                        customMetadata: sampleMetadata,
                        urlConfiguration: urlConfiguration,
                        completion: { result in
                            switch result{
                            case .success((_, let uploadAPIResponse)):
                                if let uploadAPIResponse = uploadAPIResponse{
                                    expect(uploadAPIResponse.fileId).to(equal("5f881125ce8f14336dda25b6"))
                                    expect(uploadAPIResponse.name).to(equal("default-image-test_1JO5mllWR.jpg"))
                                    expect(uploadAPIResponse.size).to(equal(146974))
                                    expect(uploadAPIResponse.filePath).to(equal("/default-image-test_1JO5mllWR.jpg"))
                                    expect(uploadAPIResponse.url).to(equal("https://ik.imagekit.io/demo/default-image-test_1JO5mllWR.jpg"))
                                    expect(uploadAPIResponse.fileType).to(equal("image"))
                                    expect(uploadAPIResponse.height).to(equal(1000))
                                    expect(uploadAPIResponse.width).to(equal(1000))
                                    expect(uploadAPIResponse.thumbnailUrl).to(equal("https://ik.imagekit.io/demo/tr:n-media_library_thumbnail/default-image-test_1JO5mllWR.jpg"))
                                }
                                break;
                            case .failure( _ as UploadAPIError):
                                fail("Should not throw Error")
                                break;
                            case .failure( _):
                                fail("Should not throw Error")
                                break;
                            }
                            done()
                    })
                }
            }
            it("Upload UIImage") {
                self.server["/api/v2/files/upload"] = { request in
                    var bodyParts = request.parseMultiPartFormData()
                    expect(String(bytes: bodyParts.first { $0.name == "token" }?.body ?? [], encoding: .utf8))
                        .to(equal("test2"))
                    expect(String(bytes: bodyParts.first { $0.name == "fileName" }?.body ?? [], encoding: .utf8))
                        .to(equal("default-image-test.jpg"))
                    expect(String(bytes: bodyParts.first { $0.name == "tags" }?.body ?? [], encoding: .utf8))
                        .to(equal("test,image"))
                    expect(String(bytes: bodyParts.first { $0.name == "folder" }?.body ?? [], encoding: .utf8))
                        .to(equal("/tmp/test"))
                    expect(String(bytes: bodyParts.first { $0.name == "customCoordinates" }?.body ?? [], encoding: .utf8))
                        .to(equal("10,10,100,100"))
                    expect(String(bytes: bodyParts.first { $0.name == "responseFields" }?.body ?? [], encoding: .utf8))
                        .to(equal("tags,customCoordinates,isPrivateFile"))
                    let receivedExt = try! JSONSerialization.data(withJSONObject: try! JSONSerialization.jsonObject(with: Data(bytes: bodyParts.first { $0.name == "extensions" }?.body ?? [])), options: .sortedKeys)
                    let expectedExt = try! JSONSerialization.data(withJSONObject: sampleExtensions, options: .sortedKeys)
                    expect(String(data: receivedExt, encoding: .utf8)).to(equal(String(data: expectedExt, encoding: .utf8)))
                    expect(String(bytes: bodyParts.first { $0.name == "webhookUrl" }?.body ?? [], encoding: .utf8))
                        .to(equal("https://dummy.io/hook"))
                    expect(String(bytes: bodyParts.first { $0.name == "overwriteFile" }?.body ?? [], encoding: .utf8))
                        .to(equal("false"))
                    expect(String(bytes: bodyParts.first { $0.name == "overwriteAITags" }?.body ?? [], encoding: .utf8))
                        .to(equal("false"))
                    expect(String(bytes: bodyParts.first { $0.name == "overwriteTags" }?.body ?? [], encoding: .utf8))
                        .to(equal("true"))
                    expect(String(bytes: bodyParts.first { $0.name == "overwriteCustomMetadata" }?.body ?? [], encoding: .utf8))
                        .to(equal("true"))
                    let receivedMeta = try! JSONSerialization.data(withJSONObject: try! JSONSerialization.jsonObject(with: Data(bytes: bodyParts.first { $0.name == "customMetadata" }?.body ?? [])), options: .sortedKeys)
                    let expectedMeta = try! JSONSerialization.data(withJSONObject: sampleMetadata, options: .sortedKeys)
                    expect(String(data: receivedMeta, encoding: .utf8)).to(equal(String(data: expectedMeta, encoding: .utf8)))
                    return HttpResponse.ok(.json([
                        "fileId": "5f881125ce8f14336dda25b6",
                        "name": "default-image-test_1JO5mllWR.jpg",
                        "size": 146974,
                        "filePath": "/default-image-test_1JO5mllWR.jpg",
                        "url": "https://ik.imagekit.io/demo/default-image-test_1JO5mllWR.jpg",
                        "fileType": "image",
                        "height": 1000,
                        "width": 1000,
                        "thumbnailUrl": "https://ik.imagekit.io/demo/tr:n-media_library_thumbnail/default-image-test_1JO5mllWR.jpg"
                    ]))
                }
                let image = getImageWithColor(color: .red, size: .init(width: 200, height: 200))
                waitUntil(timeout: DispatchTimeInterval.seconds(60)){ done in
                    let urlConfiguration = URLSessionConfiguration.default
                    ImageKit.shared.uploader().upload(
                        file: image,
                        token: "test2",
                        fileName: "default-image-test.jpg",
                        tags: ["test", "image",],
                        folder: "/tmp/test",
                        customCoordinates: "10,10,100,100",
                        responseFields: "tags,customCoordinates,isPrivateFile",
                        extensions: sampleExtensions,
                        webhookUrl: "https://dummy.io/hook",
                        overwriteFile: false,
                        overwriteAITags: false,
                        overwriteTags: true,
                        overwriteCustomMetadata: true,
                        customMetadata: sampleMetadata,
                        urlConfiguration: urlConfiguration,
                        completion: { result in
                            switch result{
                            case .success((_, let uploadAPIResponse)):
                                if let uploadAPIResponse = uploadAPIResponse{
                                    expect(uploadAPIResponse.fileId).to(equal("5f881125ce8f14336dda25b6"))
                                    expect(uploadAPIResponse.name).to(equal("default-image-test_1JO5mllWR.jpg"))
                                    expect(uploadAPIResponse.size).to(equal(146974))
                                    expect(uploadAPIResponse.filePath).to(equal("/default-image-test_1JO5mllWR.jpg"))
                                    expect(uploadAPIResponse.url).to(equal("https://ik.imagekit.io/demo/default-image-test_1JO5mllWR.jpg"))
                                    expect(uploadAPIResponse.fileType).to(equal("image"))
                                    expect(uploadAPIResponse.height).to(equal(1000))
                                    expect(uploadAPIResponse.width).to(equal(1000))
                                    expect(uploadAPIResponse.thumbnailUrl).to(equal("https://ik.imagekit.io/demo/tr:n-media_library_thumbnail/default-image-test_1JO5mllWR.jpg"))
                                }
                                break;
                            case .failure( _ as UploadAPIError):
                                fail("Should not throw Error")
                                break;
                            case .failure( _):
                                fail("Should not throw Error")
                                break;
                            }
                            done()
                    })
                }
            }
            it("Upload Data"){
                self.server["/api/v2/files/upload"] = { request in
                    var bodyParts = request.parseMultiPartFormData()
                    expect(String(bytes: bodyParts.first { $0.name == "token" }?.body ?? [], encoding: .utf8))
                        .to(equal("test3"))
                    expect(String(bytes: bodyParts.first { $0.name == "fileName" }?.body ?? [], encoding: .utf8))
                        .to(equal("default-image-test.jpg"))
                    expect(String(bytes: bodyParts.first { $0.name == "tags" }?.body ?? [], encoding: .utf8))
                        .to(equal("test,image"))
                    expect(String(bytes: bodyParts.first { $0.name == "folder" }?.body ?? [], encoding: .utf8))
                        .to(equal("/tmp/test"))
                    expect(String(bytes: bodyParts.first { $0.name == "customCoordinates" }?.body ?? [], encoding: .utf8))
                        .to(equal("10,10,100,100"))
                    expect(String(bytes: bodyParts.first { $0.name == "responseFields" }?.body ?? [], encoding: .utf8))
                        .to(equal("tags,customCoordinates,isPrivateFile"))
                    let receivedExt = try! JSONSerialization.data(withJSONObject: try! JSONSerialization.jsonObject(with: Data(bytes: bodyParts.first { $0.name == "extensions" }?.body ?? [])), options: .sortedKeys)
                    let expectedExt = try! JSONSerialization.data(withJSONObject: sampleExtensions, options: .sortedKeys)
                    expect(String(data: receivedExt, encoding: .utf8)).to(equal(String(data: expectedExt, encoding: .utf8)))
                    expect(String(bytes: bodyParts.first { $0.name == "webhookUrl" }?.body ?? [], encoding: .utf8))
                        .to(equal("https://dummy.io/hook"))
                    expect(String(bytes: bodyParts.first { $0.name == "overwriteFile" }?.body ?? [], encoding: .utf8))
                        .to(equal("false"))
                    expect(String(bytes: bodyParts.first { $0.name == "overwriteAITags" }?.body ?? [], encoding: .utf8))
                        .to(equal("false"))
                    expect(String(bytes: bodyParts.first { $0.name == "overwriteTags" }?.body ?? [], encoding: .utf8))
                        .to(equal("true"))
                    expect(String(bytes: bodyParts.first { $0.name == "overwriteCustomMetadata" }?.body ?? [], encoding: .utf8))
                        .to(equal("true"))
                    let receivedMeta = try! JSONSerialization.data(withJSONObject: try! JSONSerialization.jsonObject(with: Data(bytes: bodyParts.first { $0.name == "customMetadata" }?.body ?? [])), options: .sortedKeys)
                    let expectedMeta = try! JSONSerialization.data(withJSONObject: sampleMetadata, options: .sortedKeys)
                    expect(String(data: receivedMeta, encoding: .utf8)).to(equal(String(data: expectedMeta, encoding: .utf8)))
                    return HttpResponse.ok(.json([
                        "fileId": "5f881125ce8f14336dda25b6",
                        "name": "default-image-test_1JO5mllWR.jpg",
                        "size": 146974,
                        "filePath": "/default-image-test_1JO5mllWR.jpg",
                        "url": "https://ik.imagekit.io/demo/default-image-test_1JO5mllWR.jpg",
                        "fileType": "image",
                        "height": 1000,
                        "width": 1000,
                        "thumbnailUrl": "https://ik.imagekit.io/demo/tr:n-media_library_thumbnail/default-image-test_1JO5mllWR.jpg"
                    ]))
                }
                let image = getImageWithColor(color: .red, size: .init(width: 200, height: 200))
                waitUntil(timeout: DispatchTimeInterval.seconds(60)){ done in
                    let urlConfiguration = URLSessionConfiguration.default
                    ImageKit.shared.uploader().upload(
                        file: UIImagePNGRepresentation(image)!,
                        token: "test3",
                        fileName: "default-image-test.jpg",
                        tags: ["test", "image",],
                        folder: "/tmp/test",
                        customCoordinates: "10,10,100,100",
                        responseFields: "tags,customCoordinates,isPrivateFile",
                        extensions: sampleExtensions,
                        webhookUrl: "https://dummy.io/hook",
                        overwriteFile: false,
                        overwriteAITags: false,
                        overwriteTags: true,
                        overwriteCustomMetadata: true,
                        customMetadata: sampleMetadata,
                        urlConfiguration: urlConfiguration,
                        completion: { result in
                            switch result{
                            case .success((_, let uploadAPIResponse)):
                                if let uploadAPIResponse = uploadAPIResponse{
                                    expect(uploadAPIResponse.fileId).to(equal("5f881125ce8f14336dda25b6"))
                                    expect(uploadAPIResponse.name).to(equal("default-image-test_1JO5mllWR.jpg"))
                                    expect(uploadAPIResponse.size).to(equal(146974))
                                    expect(uploadAPIResponse.filePath).to(equal("/default-image-test_1JO5mllWR.jpg"))
                                    expect(uploadAPIResponse.url).to(equal("https://ik.imagekit.io/demo/default-image-test_1JO5mllWR.jpg"))
                                    expect(uploadAPIResponse.fileType).to(equal("image"))
                                    expect(uploadAPIResponse.height).to(equal(1000))
                                    expect(uploadAPIResponse.width).to(equal(1000))
                                    expect(uploadAPIResponse.thumbnailUrl).to(equal("https://ik.imagekit.io/demo/tr:n-media_library_thumbnail/default-image-test_1JO5mllWR.jpg"))
                                }
                                break;
                            case .failure( _ as UploadAPIError):
                                fail("Should not throw Error")
                                break;
                            case .failure( _):
                                fail("Should not throw Error")
                                break;
                            }
                            done()
                    })
                }
            }
        }
    }
}

//class UploadPolicySpec: QuickSpec {
//    
//    override func spec() {
//        beforeSuite {
//            _ = ImageKit.init(publicKey: "Dummy public key", urlEndpoint: "https://ik.imagekit.io/demo", transformationPosition: TransformationPosition.PATH)
//        }
//                
//        describe("Retry timeouts") {
//            it("With linear backoff") {
//                let backoffPolicy = UploadPolicy.Builder()
//                    .backoffCriteria(backoffMillis: 200, backoffPolicy: .LINEAR)
//                    .build()
//                expect(UploadAPI.getRetryTimeOut(backoffPolicy, 0)).to(equal(0))
//                expect(UploadAPI.getRetryTimeOut(backoffPolicy, 1)).to(equal(200))
//                expect(UploadAPI.getRetryTimeOut(backoffPolicy, 2)).to(equal(400))
//                expect(UploadAPI.getRetryTimeOut(backoffPolicy, 3)).to(equal(600))
//                expect(UploadAPI.getRetryTimeOut(backoffPolicy, 4)).to(equal(800))
//            }
//            it("With exponential backoff") {
//                let backoffPolicy = UploadPolicy.Builder()
//                    .backoffCriteria(backoffMillis: 200, backoffPolicy: .EXPONENTIAL)
//                    .build()
//                expect(UploadAPI.getRetryTimeOut(backoffPolicy, 0)).to(equal(0))
//                expect(UploadAPI.getRetryTimeOut(backoffPolicy, 1)).to(equal(200))
//                expect(UploadAPI.getRetryTimeOut(backoffPolicy, 2)).to(equal(400))
//                expect(UploadAPI.getRetryTimeOut(backoffPolicy, 3)).to(equal(800))
//                expect(UploadAPI.getRetryTimeOut(backoffPolicy, 4)).to(equal(1600))
//            }
//        }
//    }
//}
//
//class UploadPreprocessorSpec: QuickSpec {
//    override func spec() {
//        beforeSuite {
//            _ = ImageKit.init(publicKey: "Dummy public key", urlEndpoint: "https://ik.imagekit.io/demo", transformationPosition: TransformationPosition.PATH)
//        }
//        
//        describe("Image preprocessor") {
//            let image = getImageWithColor(color: .black, size: CGSize(width: 1500, height: 800))
//            it("Image dimensions limiting") {
//                let imageData = ImageUploadPreprocessor<UIImage>.Builder()
//                    .limit(width: 1366, height: 768)
//                    .format(format: .PNG)
//                    .build()
//                    .outputFile(input: image, fileName: "test1.png")
//                let output = UIImage(data: imageData)
//                expect(output?.size.width).to(equal(1366))
//                expect(output?.size.height).to(equal(768))
//            }
//            it("Image rotation") {
//                let imageData = ImageUploadPreprocessor<UIImage>.Builder()
//                    .rotate(degrees: 30)
//                    .format(format: .PNG)
//                    .build()
//                    .outputFile(input: image, fileName: "test2.png")
//                let output = UIImage(data: imageData)
//                let outputDimensions = CGRect(origin: CGPoint.zero, size: CGSize(width: 1500, height: 800))
//                    .applying(CGAffineTransform(rotationAngle: 30 * Double.pi / 180))
//                expect(output?.size.width).to(equal(floor(outputDimensions.width)))
//                expect(output?.size.height).to(equal(floor(outputDimensions.height)))
//            }
//            it("Image crop") {
//                let cropSrc = getImageWithGradient(colors: [UIColor.red, UIColor.green, UIColor.blue], size: CGSize(width: 1500, height: 800))
//                let imageData = ImageUploadPreprocessor<UIImage>.Builder()
//                    .crop(p1: CGPoint(x: 20, y: 40), p2: CGPoint(x: 160, y: 200))
//                    .format(format: .PNG)
//                    .build()
//                    .outputFile(input: cropSrc, fileName: "test2.png")
//                let output = UIImage(data: imageData)
//                for x in 20...160 {
//                    for y in 40...200 {
//                        expect(output?[x - 20, y - 40]).to(equal(cropSrc[x, y]))
//                    }
//                }
//            }
//        }
//    }
//}
//
func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 1)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
}
//
//func getImageWithGradient(colors: [UIColor], size: CGSize) -> UIImage {
//    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//    UIGraphicsBeginImageContextWithOptions(size, false, 1)
//    let gradientLayer = CAGradientLayer()
//    gradientLayer.colors = colors
//    gradientLayer.frame = rect
//    gradientLayer.draw(in: UIGraphicsGetCurrentContext()!)
//    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//    UIGraphicsEndImageContext()
//    return image
//}
//
//extension UIImage {
//    subscript (x: Int, y: Int) -> UIColor? {
//        guard x >= 0 && x < Int(size.width) && y >= 0 && y < Int(size.height),
//            let cgImage = cgImage,
//            let provider = cgImage.dataProvider,
//            let providerData = provider.data,
//            let data = CFDataGetBytePtr(providerData) else {
//            return nil
//        }
//
//        let numberOfComponents = 4
//        let pixelData = ((Int(size.width) * y) + x) * numberOfComponents
//
//        let r = CGFloat(data[pixelData]) / 255.0
//        let g = CGFloat(data[pixelData + 1]) / 255.0
//        let b = CGFloat(data[pixelData + 2]) / 255.0
//        let a = CGFloat(data[pixelData + 3]) / 255.0
//
//        return UIColor(red: r, green: g, blue: b, alpha: a)
//    }
//}
