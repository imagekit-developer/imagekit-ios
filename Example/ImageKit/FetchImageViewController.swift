//
//  FetchImageViewController.swift
//  ImageKit_Example
//
//  Created by Abhinav Dhiman on 25/07/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import ImageKit

class FetchImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var transformationName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func OnClickTransformation1(_ sender: Any) {
        let url = ImageKit.shared.url(urlEndpoint: "https://ik.imagekit.io/demo/img", path: "plant.jpeg")
            .width(width: 300)
            .height(height: 200)
            .cropMode(cropMode: CropMode.PAD_RESIZE)
            .background(backgroundColor: "F3F3F3")
            .create()
        self.showImage(url: url)
    }
    
    @IBAction func OnClickTransformation2(_ sender: Any) {
        let url = ImageKit.shared.url(path: "default-image.jpg", transformationPosition: TransformationPosition.QUERY)
            .height(height: 400)
            .aspectRatio(width: 3, height: 2)
            .create()
        self.showImage(url: url)
    }
    
    @IBAction func OnClickTransformation3(_ sender: Any) {
        let url = ImageKit.shared.url(src: "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg", transformationPosition: TransformationPosition.PATH)
            .overlayImage(overlayImage: "logo-white_SJwqB4Nfe.png")
            .overlayX(overlayX: 10)
            .overlayY(overlayY: 20)
            .create()
        self.showImage(url: url)
    }
    
    @IBAction func OnClickTransformation4(_ sender: Any) {
        let url = ImageKit.shared.url(src: "https://ik.imagekit.io/demo/tr:oi-logo-white_SJwqB4Nfe.png,ox-N10,oy-20/medium_cafe_B1iTdD0C.jpg")
            .create()
        self.showImage(url: url)
    }
    
    @IBAction func OnClickTransformation5(_ sender: Any) {
        let url = ImageKit.shared.url(src: "https://ik.imagekit.io/demo/img/plant.jpeg?tr=oi-logo-white_SJwqB4Nfe.png,ox-10,oy-20")
            .addCustomTransformation(key: "w", value: "400")
            .overlayText(overlayText: "Hand with a green plant")
            .overlayTextColor(overlayTextColor: "264120")
            .overlayTextFontSize(overlayTextSize: 30)
            .overlayX(overlayX: 10)
            .overlayY(overlayY: 20)
            .create()
        self.showImage(url: url)
    }
    
    @IBAction func OnClickTransformation6(_ sender: Any) {
        let url = ImageKit.shared.url(src: "https://ik.imagekit.io/demo/img/tr:ot-Hand%20with%20a%20green%20plant,otc-264120,ots-30,ox-10,oy-10/default-image.jpg")
            .height(height: 400)
            .width(width: 300)
            .chainTransformation()
            .rotation(rotation: Rotation.VALUE_90)
            .create()
        self.showImage(url: url)
    }
    
    private func showImage(url: String) {
        self.transformationName.text = String(format: "Image Url: %@", url)
        self.imageView.load(url: URL(string: url)!)
    }

}
