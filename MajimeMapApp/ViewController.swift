//
//  ViewController.swift
//  MajimeMapApp
//
//  Created by CaoQian on 2018/09/21.
//  Copyright © 2018 CaoQian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var tapBtn: UIButton!
    
    var testText : String = " default "
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField1.delegate = self
        
        textField2.delegate = self
        
        tapBtn?.isUserInteractionEnabled = false
        
        tapBtn?.alpha = 0.5
        
        userDefaults.register(defaults: ["DataStore": "default"])
    }
    
    
    @IBAction func textField1(_ sender: UITextField) {
        print("textField1")
        let text1 = textField1.text! as String
        let text2 = textField2.text! as String
        
        if !text1.isEmpty && !text2.isEmpty {
            tapBtn?.isUserInteractionEnabled = true
            tapBtn?.alpha = 1.0
        } else {
            tapBtn?.isUserInteractionEnabled = false
            tapBtn?.alpha = 0.5
        }
    }
    
    @IBAction func textField2(_ sender: UITextField) {
        print("textField2")
        let text1 = textField1.text! as String
        let text2 = textField2.text! as String
        
        if !text1.isEmpty && !text2.isEmpty {
            tapBtn?.isUserInteractionEnabled = true
            tapBtn?.alpha = 1.0
        } else {
            tapBtn?.isUserInteractionEnabled = false
            tapBtn?.alpha = 0.5
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//        let text1 = (textField1.text! as NSString).replacingCharacters(in: range, with: string)
//        let text2 = (textField2.text! as NSString).replacingCharacters(in: range, with: string)

//        if !text1.isEmpty && !text2.isEmpty {
//            tapBtn?.isUserInteractionEnabled = true
//            tapBtn?.alpha = 1.0
//        } else {
//            tapBtn?.isUserInteractionEnabled = false
//            tapBtn?.alpha = 0.5
//        }
        return true
    }
    // textFieldに入力しユーザーがキーボードのエンターをおした瞬間に発動するメソッド
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
//
//        testText = textField.text!
//        textField.resignFirstResponder()
//
//        // if文でtextFieldの1か2かでuserDefaultの保存先を変える
//        if () {
//            userDefaults.set(testText, forKey: "DataStore1")
//        } else {
//            userDefaults.set(testText, forKey: "DataStore2")
//        }
////        userDefaults.synchronize()
//
//        return true
//    }
    
//    func saveData(str: String){
//
//
//        userDefaults.set(str, forKey: "DataStore")
//        userDefaults.synchronize()
//    }
    
    func readData() -> String {

        let str: String = userDefaults.object(forKey: "DataStore") as! String
        
        return str
}
    @IBAction func tapBtn(_ sender: UIButton) {

        
//        func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//            if (textField == self.textField1) { /* do Something */ }
//            else if (textField == self.textField2) { /* do Something */ }
//return true
        
        // userDefaultへの保存処理
        
        userDefaults.set(textField1.text!, forKey: "DataStore1")
        userDefaults.set(textField2.text!, forKey: "DataStore2")
        
//        userDefaults.removeObject(forKey: "DataStore")
        //debugeに表示するcode
        //userdefaultは分けて保存する、仕組みをキーである
        let str1: String = userDefaults.object(forKey: "DataStore1") as! String
        NSLog("userdefault: %@", str1)
        
        let str2: String = userDefaults.object(forKey: "DataStore2") as! String
        NSLog("userdefault: %@", str2)
        
        
            }
        }

