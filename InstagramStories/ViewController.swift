//
//  ViewController.swift
//  InstagramStories
//
//  Created by Michael Miles on 5/22/19.
//  Copyright © 2019 Michael Miles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sharingImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func shareToInstaStories(_ sender: Any) {
        if let storiesUrl = URL(string: "instagram-stories://share") {
            if UIApplication.shared.canOpenURL(storiesUrl) {
                guard let image = sharingImageView.image else { return }
                guard let imageData = image.pngData() else { return }
                let pasteboardItems: [String: Any] = [
                    "com.instagram.sharedSticker.stickerImage": imageData,
                    "com.instagram.sharedSticker.backgroundTopColor": "#636e72",
                    "com.instagram.sharedSticker.backgroundBottomColor": "#b2bec3"
                ]
                let pasteboardOptions = [
                    UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)
                ]
                UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                UIApplication.shared.open(storiesUrl, options: [:], completionHandler: nil)
            } else {
                print("User doesn't have instagram on their device.")
            }
        }
    }
    
}

