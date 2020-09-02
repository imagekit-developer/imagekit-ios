// https://github.com/Quick/Quick

import Quick
import Nimble
import ImageKit

class URLGenerationSpec: QuickSpec {
    
    override func spec() {
        let apiVersion: String = API_VERSION
        beforeSuite {
            ImageKit.init(clientPublicKey: "Dummy public key", imageKitEndpoint: "https://ik.imagekit.io/demo", transformationPosition: "path")
        }
        describe("Image Path with Transformations height: 300, width: 300 and rotate: 90"){
            it("Path Transformations") {
                let actual = ImageKit.shared
                    .url(urlEndpoint: "https://ik.imagekit.io/demo", path: "medium_cafe_B1iTdD0C.jpg")
                    .height(height: 300)
                    .width(width: 300)
                    .chainTransformation()
                    .rotation(rotation: Rotation.VALUE_90)
                    .create()
                expect(actual).to(equal(String(format:"https://ik.imagekit.io/demo/tr:h-300.00,w-300.00:rt-90/medium_cafe_B1iTdD0C.jpg?ik-sdk-version=ios-%@", apiVersion)))
            }
            it("Query Transformations") {
                let actual = ImageKit.shared
                    .url(urlEndpoint: "https://ik.imagekit.io/demo", path: "medium_cafe_B1iTdD0C.jpg", transformationPosition: "query")
                    .height(height: 300)
                    .width(width: 300)
                    .chainTransformation()
                    .rotation(rotation: Rotation.VALUE_90)
                    .create()
                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?tr=h-300.00,w-300.00:rt-90&ik-sdk-version=ios-%@", apiVersion)))
            }
        }
        describe("Src with Transformations height: 300, width: 300 and rotate: 90"){
            it("Without Transforms") {
                let actual = ImageKit.shared
                    .url(src: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg")
                    .height(height: 300)
                    .width(width: 300)
                    .chainTransformation()
                    .rotation(rotation: Rotation.VALUE_90)
                    .create()
                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?tr=h-300.00,w-300.00:rt-90&ik-sdk-version=ios-%@", apiVersion)))
            }
            it("With Path Transforms") {
                let actual = ImageKit.shared
                    .url(src: "https://ik.imagekit.io/demo/tr:h-300.00,w-300.00:rt-90/medium_cafe_B1iTdD0C.jpg")
                    .height(height: 300)
                    .width(width: 300)
                    .chainTransformation()
                    .rotation(rotation: Rotation.VALUE_90)
                    .create()
                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?tr=h-300.00,w-300.00:rt-90&ik-sdk-version=ios-%@", apiVersion)))
            }
            it("With Query Transforms") {
                let actual = ImageKit.shared
                    .url(src: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?tr=h-300.00,w-300.00:rt-90")
                    .height(height: 300)
                    .width(width: 300)
                    .chainTransformation()
                    .rotation(rotation: Rotation.VALUE_90)
                    .create()
                expect(actual).to(equal(String(format: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg?tr=h-300.00,w-300.00:rt-90&ik-sdk-version=ios-%@", apiVersion)))
            }
        }
    }
}

class InvalidCasesSpec: QuickSpec{
    override func spec(){
        describe("Invalid Initilization"){
            it("Empty Client Key") {
                expect { ImageKit.init(clientPublicKey: "", imageKitEndpoint: "https://ik.imagekit.io/demo", transformationPosition: "path") }.to(throwAssertion())
            }
            it("Empty ImageKit Endpoint") {
                expect { ImageKit.init(clientPublicKey: "Dummy public key", imageKitEndpoint: "", transformationPosition: "path") }.to(throwAssertion())
            }
            it("Invalid Transformation Position") {
                expect { ImageKit.init(clientPublicKey: "Dummy public key", imageKitEndpoint: "https://ik.imagekit.io/demo", transformationPosition: "pathx") }.to(throwAssertion())
            }
        }
    }
}
