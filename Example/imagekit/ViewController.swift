//
//  ViewController.swift
//  imagekit
//
//  Created by rungtaakki on 07/03/2019.
//  Copyright (c) 2019 rungtaakki. All rights reserved.
//

import UIKit
import imagekit
import Alamofire
import ObjectMapper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let i = ImageKit(clientPublicKey: "publicKey", imageKitId: "KitID")
//        i.uploadImage(<#T##image: Data##Data#>, fileName: <#T##String#>, signature: <#T##String#>, timestamp: <#T##Date#>, tags: <#T##Array<String>?#>, folder: <#T##String?#>)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

