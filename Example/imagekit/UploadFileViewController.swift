//
//  UploadFileViewController.swift
//  ImageKit_Example
//
//  Created by Abhinav Dhiman on 26/07/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UploadFileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func OnClickUpload(_ sender: UIButton) {
        let document = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .open)
        document.delegate = self
        document.modalPresentationStyle = .formSheet
        self.present(document, animated: true, completion: nil)
    }
}

extension UploadFileViewController: UINavigationControllerDelegate, UIDocumentPickerDelegate{
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true)
    }
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        dismiss(animated: true, completion: nil)
    }
}
