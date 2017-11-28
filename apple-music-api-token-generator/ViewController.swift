//
//  ViewController.swift
//  apple-music-api-token-generator
//
//  Created by wajiwaji moff on 2017/11/27.
//  Copyright © 2017年 wajiwaji. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController {

    @IBOutlet weak var Token: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func GetToken(_ sender: UIButton) {
        let controller = SKCloudServiceController()
        
        SKCloudServiceController.requestAuthorization { status in
            guard status == .authorized else { return }
        }
        
        controller.requestCapabilities { capabilities, error in 
            print(capabilities.contains(.musicCatalogPlayback))
            print(capabilities.contains(.musicCatalogSubscriptionEligible))
            print(capabilities.contains(.addToCloudMusicLibrary))
            guard capabilities.contains(.musicCatalogPlayback) else { return }
            
        }
        let developerToken = ""
        
        controller.requestUserToken(forDeveloperToken: developerToken, completionHandler: { token, error in
            guard let token = token else { return }
                    
            print("Music User Token:", token)
            self.Token.text = token
        })
        
    }
    
}

