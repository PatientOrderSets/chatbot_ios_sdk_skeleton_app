//
//  ViewController.swift
//  NativeSdkTest
//
//  Created by Shiv Mohan Singh on 15/02/24.
//

import UIKit
import thinkresearch_messenger_ios_swift_sdk




class ViewController: UIViewController {
    
    // staging workflow
    var configuration = ChatBotConfiguration(
        appId: "yB9BJmrcH3bM4CShtMKB5qrw",
        baseUrl: "test.ca.digital-front-door.stg.gcp.trchq.com",
        originURL:  "test.ca.digital-front-door.stg.gcp.trchq.com",
        lang:"en"
    )
    
    // novoscatia
    //    let configuration = ChatBotConfiguration(
    //        appId: "XnA6d2mEejaov78UETAzM5uj",
    //        baseUrl: "test.ca.one-stop-talk.sbx.gcp.trchq.com",
    //        originURL: "app-digitalfrontdoor-dev.apps.ext.novascotia.ca",
    //        lang:"en"
    //    )
    
    
    var chatBotSdk:TRC_Chatbot_SDK?
    var language = "en"
    var appIID = "yB9BJmrcH3bM4CShtMKB5qrw"
    var originValue = "test.ca.digital-front-door.stg.gcp.trchq.com"
    var baseURL = "test.ca.digital-front-door.stg.gcp.trchq.com"
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        //        chatBotSdk = ChatBotSdk(configuration: configuration, viewController: self);
    }
    
    @IBAction func btnClicked(_ sender:  UIButton) {
        
        sender.isUserInteractionEnabled = false
        
        let defConfig=ConfigurationManager.shared.getDefaultConfiguration();
        
        
        configuration = ChatBotConfiguration(
            appId: defConfig!.appID,
            baseUrl: defConfig!.baseURL,
            originURL:  defConfig!.origin,
            lang:defConfig!.language
        )
        
        
        chatBotSdk = TRC_Chatbot_SDK(configuration: configuration, viewController: self);
        chatBotSdk?.openBot()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            sender.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func onSettingClicked(_ sender: Any) {
        if let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsController") as? SettingsController{
            secondViewController.onValueUpdate={(originValue:String,baseUrl:String,appId:String,language:String    )in
                
                guard !language.isEmpty && !appId.isEmpty && !baseUrl.isEmpty && !originValue.isEmpty else {
                    print("Some of the values are empty")
                    return
                }
                self.language = language
                print("Environment Value: \(language)")
                
                self.appIID = appId
                print("App ID: \(appId)")
                
                self.originValue = originValue
                print("Origin Value: \(originValue)")
                
                self.baseURL = baseUrl
                print("Base URL: \(baseUrl)")
                
                self.configuration = ChatBotConfiguration(
                    appId: appId,
                    baseUrl: baseUrl, 
                    originURL: originValue  ,
                    lang:language
                )
                
                
            }
            
            
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        
    }
}

