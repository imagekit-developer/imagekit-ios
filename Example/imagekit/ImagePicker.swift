//
//  ImagePicker.swift
//  imagekit_Example
//
//  Created by Akshit New on 12/07/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

protocol ImagePickerDelegate {
    func onImagePicked(image: UIImage, imageURL: NSURL)
    func onImagePickerCancelled()
}

class ImagePicker: NSObject {
    
    weak var viewController: UIViewController?
    let imagePicker = UIImagePickerController()
    var delegate: ImagePickerDelegate?
    var imageURL: NSURL?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func show() {
        self.imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Select option", message: "Where would you like to capture your image from?", preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
            alertController.dismiss(animated: true, completion: nil)
            self.showImagePicker(type: .camera)
        })
        
        let gallery = UIAlertAction(title: "Gallery", style: .default, handler: { (action) -> Void in
            alertController.dismiss(animated: true, completion: nil)
            self.showImagePicker(type: .photoLibrary)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) -> Void in
            self.handleCancelledIntent()
        })
        
        alertController.addAction(camera)
        alertController.addAction(gallery)
        alertController.addAction(cancel)
        
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
    func showImagePicker(type: UIImagePickerControllerSourceType) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = type
        viewController?.present(imagePicker, animated: true, completion: nil)
    }
    
    func handleCancelledIntent() {
        if let delegate = self.delegate {
            delegate.onImagePickerCancelled()
        }
    }
    
}

// MARK: - UIImagePickerControllerDelegate Methods

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var localPath: String = ""
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
        if let uploadFileURL = info[UIImagePickerControllerReferenceURL] as? NSURL {
            let imageName = uploadFileURL.lastPathComponent
            localPath = (documentDirectory as NSString).appendingPathComponent(imageName!)
        } else {
            localPath = (documentDirectory as NSString).appendingPathComponent("\(DataStoreProvider.getUserDataStore().getUserData().userId)")
        }
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            let data = UIImagePNGRepresentation(resizeImage(image: pickedImage, newWidth: 600.0)!)
            do {
                try data!.write(to: URL(string: localPath)!, options: .atomic)
            } catch {
                print(error)
            }
            //let _ = Bool(data!.writeToFile(localPath, atomically: true))
            imageURL = NSURL(fileURLWithPath: localPath)
            if let delegate = self.delegate, let imageURL = imageURL {
                delegate.onImagePicked(image: pickedImage, imageURL: imageURL)
            }
        }
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        handleCancelledIntent()
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
