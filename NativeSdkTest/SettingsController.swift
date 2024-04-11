//
//  ViewController.swift
//  Single Screen
//
//  Created by netcom on 06/04/24.
//

import UIKit
import SwiftUI



class SettingsController: UIViewController {
    
    
    @IBOutlet weak var environmentTextField: UITextField!
    @IBOutlet weak var appIDTextField: FloatingLabelInput!
    @IBOutlet weak var baseUrlTextField: FloatingLabelInput!
    @IBOutlet weak var originTextField: FloatingLabelInput!
    let valuePicker: UIPickerView! = UIPickerView()
    @IBOutlet weak var languageTextField: UITextField!
    
    let gradePickerValues = ["Other", "Staging", "Production"]
    let languagePickerValues = ["en", "fr"]
    var activeTextField:UITextField?
    var languageValue = ""
    var originValue = ""
    var baseURL = ""
    var appIID = ""
    var language = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        valuePicker.dataSource = self
        valuePicker.delegate = self
        valuePicker.isHidden = true
        appIDTextField.floatingLabelColor = .blue
        originTextField.floatingLabelColor = .blue
        baseUrlTextField.floatingLabelColor = .blue
        environmentTextField.inputView = valuePicker
        languageTextField.inputView = valuePicker
        environmentTextField.delegate = self
        languageTextField.delegate = self
        self.hideKeyboardOnTapAround()
    }
    var onValueUpdate: ((_ originValue: String, _ baseURL: String, _ appIID: String, _ language: String)-> Void)?
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        appIID = appIDTextField.text ?? ""
        baseURL = baseUrlTextField.text ?? ""
        language = languageTextField.text ?? ""
        originValue = originTextField.text ?? ""
        
        // Instantiate the storyboard containing the ViewController
        if let storyboard = self.navigationController?.storyboard {
            // Navigate back to the ViewController
            if let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                
                onValueUpdate?(originValue,baseURL,appIID,language)
                // Navigate back to the FirstViewController
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        //        if let savedViewController = self.storyboard?.instantiateViewController(withIdentifier: "SavedDataViewController") as? SavedDataViewController{
        //            savedViewController.baseURL = self.baseURL
        //            savedViewController.appIID = self.appIID
        //            savedViewController.environmentValue = self.environmentValue
        //            savedViewController.languageValue = self.languageValue
        //            savedViewController.originValue = self.originValue
        //            self.navigationController?.pushViewController(savedViewController, animated: true)
        //        }
    }
    
}

extension SettingsController :UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if activeTextField == environmentTextField {
            return gradePickerValues.count
        } else if activeTextField  == languageTextField{
            return languagePickerValues.count
        } else {
            return 0
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if activeTextField == environmentTextField{
            return gradePickerValues[row]
        } else if activeTextField == languageTextField {
            return languagePickerValues[row]
        }
        return ""
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if activeTextField == environmentTextField {
            environmentTextField.text = gradePickerValues[row]
            if row == 1{
                
                
                
                appIDTextField.text = "yB9BJmrcH3bM4CShtMKB5qrw"
                appIDTextField.isUserInteractionEnabled = false
                originTextField.text = "test.ca.digital-front-door.stg.gcp.trchq.com"
                originTextField.isUserInteractionEnabled = false
                baseUrlTextField.text = "test.ca.digital-front-door.stg.gcp.trchq.com"
                baseUrlTextField.isUserInteractionEnabled = false
                languageTextField.text = languagePickerValues[0]
                
                
            }else if row == 2{
                
                
                
                appIDTextField.text = "XnA6d2mEejaov78UETAzM5uj"
                appIDTextField.isUserInteractionEnabled = false
                originTextField.text = "app-digitalfrontdoor-dev.apps.ext.novascotia.ca"
                originTextField.isUserInteractionEnabled = false
                baseUrlTextField.text = "test.ca.one-stop-talk.sbx.gcp.trchq.com"
                baseUrlTextField.isUserInteractionEnabled = false
                languageTextField.text = languagePickerValues[0]
 
                
            }
            
            else{
                originTextField.isUserInteractionEnabled = true
                originTextField.text = ""
                appIDTextField.isUserInteractionEnabled = true
                appIDTextField.text = ""
                baseUrlTextField.isUserInteractionEnabled = true
                baseUrlTextField.text = ""
            }
        } else  if activeTextField == languageTextField {
            languageTextField.text = languagePickerValues[row]
        }
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == environmentTextField{
            activeTextField = environmentTextField
            valuePicker.isHidden = false
            valuePicker.reloadAllComponents()
            return true
        } else if textField == languageTextField{
            activeTextField = languageTextField
            valuePicker.isHidden = false
            valuePicker.reloadAllComponents()
            return true
        }
        return true
    }
    func hideKeyboardOnTapAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
}
