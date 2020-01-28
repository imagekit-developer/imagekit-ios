//
//  ViewController.swift
//  imagekit
//
//  Created by rungtaakki on 07/03/2019.
//  Copyright (c) 2019 rungtaakki. All rights reserved.
//

import UIKit
import imagekit
//import Alamofire
//import ObjectMapper

class ViewController: UIViewController {
    
    var selectedImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectImage()
        
//        i.uploadImage(<#T##image: Data##Data#>, fileName: <#T##String#>, signature: <#T##String#>, timestamp: <#T##Date#>, tags: <#T##Array<String>?#>, folder: <#T##String?#>)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func selectImage() {
        let imagePicker = ImagePicker(viewController: self)
        imagePicker.delegate = self
        imagePicker.show()
    }
    
    func uploadImageToImageKit() {
        let ik = ImageKit(clientPublicKey: "publicKey", imageKitId: "KitID")
        
    }
}

extension ViewController : ImagePickerDelegate {
    func onImagePicked(image: UIImage, imageURL: NSURL) {
        print("ImagePicked")
        DispatchQueue.main.async {
            
            self.selectedImage = image
            self.uploadImageToImageKit()
        }
    }
    
    func onImagePickerCancelled() {
        print("ImagePicker cancelled")
    }
}

