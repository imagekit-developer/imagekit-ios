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
        
        let tokenResponse = UploadAuthService.getUploadToken(payload: [
            "fileName" : imageName,
            "useUniqueFileName" : "true",
            "tags" : ["demo","image"].joined(separator: ","),
            "folder" : "/",
        ])
        if let token = tokenResponse?["token"] {
            ImageKit.shared.uploader().upload(
                file: image,
                token: token,
                fileName: imageName,
                useUniqueFilename: true,
                tags: ["demo","image"],
                folder: "/",
                progress: { progress in
                    let progressBar: UIProgressView? = progressAlert.view.subviews.filter{$0 is UIProgressView}.first as? UIProgressView
                    if (progressBar != nil){
                        progressBar!.setProgress(Float(progress.fractionCompleted), animated: true)
                    }
                },
//                policy: UploadPolicy.Builder()
//                    .requireNetworkType(.UNMETERED)
//                    .requiresBatteryCharging(true)
//                    .maxRetries(4)
//                    .backoffCriteria(backoffMillis: 500, backoffPolicy: .EXPONENTIAL)
//                    .build(),
                preprocessor: ImageUploadPreprocessor<UIImage>.Builder()
                    .limit(width: 400, height: 300)
//                    .rotate(degrees: 45)
                    .build(),
                completion: { result in
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: {
                                switch result {
                                case .success(( _, let uploadAPIResponse)):
                                    self.showToast(title: "Upload Complete", message: "The uploaded image can be accessed using url: " + (uploadAPIResponse?.url!)!)
                                case .failure(let error as UploadAPIError):
                                    self.showToast(title: "Upload Failed", message: "Error: " + error.message)
                                case .failure(let error):
                                    self.showToast(title: "Upload Failed", message: "Error: " + error.localizedDescription)
                                }
                            }
                        )
                    }
                }
            )
        } else {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: {
                    self.showToast(title: "Upload Failed", message: "Failed to fetch upload token")
                })
            }
        }
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
