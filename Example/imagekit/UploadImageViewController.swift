//
//  UploadImageViewController.swift
//  ImageKit_Example
//
//  Created by Abhinav Dhiman on 26/07/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import ImageKit
import Photos

class UploadImageViewController: UIViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectImage: UIButton!
    @IBOutlet weak var uploadImage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func OnClickSelect(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = .photoLibrary
            image.mediaTypes = ["public.image"]
            image.allowsEditing = false
            self.present(image, animated: true, completion: nil)
        }
    }

    @IBAction func OnClickUpload(_ sender: UIButton) {
        let image: UIImage = self.imageView.image!
        let imageName = image.accessibilityIdentifier!
        ImageKit.shared.uploader().upload(
            file: image,
            fileName: imageName,
            useUniqueFilename: true,
            tags: ["demo","image"],
            folder: "/",
            signatureHeaders: ["x-test-header":"Test", "x-passphrase": "1DE62D7FE8E56B2C0A00014701BB5F2EFB061F1006F"],
            completion: { result in
                switch result{
                    case .success(let uploadAPIResponse):
                        print(uploadAPIResponse)
                    case .failure(let error):
                        print(error)
                }
        })
    }
}

extension UploadImageViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]){
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let imageUrl = info[UIImagePickerControllerImageURL] as! URL
            let imageName = String(imageUrl.absoluteString.split(separator: "/").last!)
            image.accessibilityIdentifier = imageName
            self.imageView.image = image
            self.uploadImage.isHidden = false
        }
        dismiss(animated: true)
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
