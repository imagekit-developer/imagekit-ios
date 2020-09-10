//
//  UploadImageViewController.swift
//  ImageKit_Example
//
//  Created by Abhinav Dhiman on 26/07/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import ImageKitIO
import Photos

class UploadImageViewController: UIViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectImage: UIButton!
    @IBOutlet weak var uploadImage: UIButton!
    
    var progressToastView: UIProgressView!
    var alertView: UIAlertController!
    
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
        let progressAlert = showProgressToast(title: "Uploading", message: "Please Wait")
        ImageKit.shared.uploader().upload(
            file: image,
            fileName: imageName,
            useUniqueFilename: true,
            tags: ["demo","image"],
            folder: "/",
            signatureHeaders: ["x-test-header":"Test"],
            progress: { progress in
                let progressBar: UIProgressView? = progressAlert.view.subviews.filter{$0 is UIProgressView}.first as? UIProgressView
                if (progressBar != nil){
                    progressBar!.setProgress(Float(progress.fractionCompleted), animated: true)
                }
            },
            completion: { result in
                self.dismiss(animated: true)
                switch result{
                    case .success(let uploadAPIResponse):
                        self.showToast(title: "Upload Complete", message: "The uploaded image can be accessed using url: " + uploadAPIResponse.url!)
                    case .failure(let error as UploadAPIError):
                        self.showToast(title: "Upload Failed", message: "Error: " + error.message)
                    case .failure(let error):
                        self.showToast(title: "Upload Failed", message: "Error: " + error.localizedDescription)
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
