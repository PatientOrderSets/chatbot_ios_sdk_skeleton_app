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
    @IBOutlet weak var tableView: UITableView!
    
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
    
    var configurations: [Configuration] = []
    
    
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
        
        tableView.delegate=self
        tableView.dataSource=self
        tableView.rowHeight = 84

        
        self.hideKeyboardOnTapAround()
        refreshConfiguration()
        
    }
    func refreshConfiguration(){
        configurations = ConfigurationManager.shared.getConfigurations()
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
                
                let csomd = Configuration(appID: appIID, origin: originValue, baseURL: baseURL, language: language, isDefault: false)
                ConfigurationManager.shared.saveConfiguration(config: csomd)
                
                configurations.append(csomd)
                tableView.reloadData()
                
            }
        }
        
        
    }
    
}
extension SettingsController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You taped index path")
    }
}
extension SettingsController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConfigurationCell
        
        let config = configurations[indexPath.row]
        // Configure cell with configuration data
        
        cell.name.lineBreakMode = .byTruncatingTail
        cell.name.numberOfLines=2
        cell.name.text = "\(config.appID)\n\(config.baseURL)"
        cell.defaultButton.setOn(config.isDefault, animated: true)
        
        // Set indexPath for the cell
        cell.indexPath = indexPath
        // Set delegate to handle actions
        cell.delegate = self
        
        
        return cell
    }
}

extension SettingsController: ConfigurationTableViewCellDelegate {
    func didSelectDefaultConfiguration(at indexPath: IndexPath) {
        
        ConfigurationManager.shared.setDefaultConfiguration(at: indexPath.row)
        self.refreshConfiguration()
        tableView.reloadData()
    }
    
    func didTapDeleteConfiguration(at indexPath: IndexPath) {
        
        
        configurations.remove(at: indexPath.row)
        ConfigurationManager.shared.deleteConfiguration(at: indexPath.row)
        tableView.reloadData()
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
