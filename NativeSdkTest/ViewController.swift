//
//  ViewController.swift
//  NativeSdkTest
//
//  Created by Shiv Mohan Singh on 15/02/24.
//

import UIKit
import Think_research_messenger_SDK_Suhail




class ViewController: UIViewController {
    
    
    let configuration = ChatBotConfiguration(
        appId: "yB9BJmrcH3bM4CShtMKB5qrw",
        baseUrl: "test.ca.digital-front-door.stg.gcp.trchq.com",
        originURL: "test.ca.digital-front-door.stg.gcp.trchq.com"
    )
    
    var chatBotSdk:ChatBotSdk?
    
    override func viewDidLoad()  {
        super.viewDidLoad()
//        chatBotSdk = ChatBotSdk(configuration: configuration, viewController: self);
    }
    
    @IBAction func btnClicked(_ sender: Any) {
        chatBotSdk = ChatBotSdk(configuration: configuration, viewController: self);
        chatBotSdk?.openBot()
    }
    

    //
    

    
    
}


