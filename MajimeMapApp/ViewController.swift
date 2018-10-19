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
        ////////////////////////////////////////////////////
//        // インスタンス初期化
//        let textFieldStart = UITextField()
//        let textFieldEnd = UITextField()
//
//        // サイズ設定
//        textFieldStart.frame.size.width = self.view.frame.width * 2/5
//        textFieldStart.frame.size.height = 50
//
//        textFieldEnd.frame.size.width = self.view.frame.width * 2/5
//        textFieldEnd.frame.size.height = 50
//
//        // 位置設定
//        textFieldStart.center.x = 215
//        textFieldStart.center.y = 270
//
//        textFieldEnd.center.x = 155
//        textFieldEnd.center.y = 400
//
//        // Delegate を設定
//        textFieldStart.delegate = self
//        textFieldEnd.delegate = self
//
//        // プレースホルダー
//        textFieldStart.placeholder = "テキストを入力"
//        textFieldEnd.placeholder = "テキストを入力"
//
//        // 背景色
//        textFieldStart.backgroundColor = UIColor(white: 0.9, alpha: 1)
//        textFieldEnd.backgroundColor = UIColor(white: 0.9, alpha: 1)
//
//        // 左の余白
//        textFieldStart.leftViewMode = .always
//        textFieldStart.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
//
//        textFieldEnd.leftViewMode = .always
//        textFieldEnd.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
//
//        // テキストを全消去するボタンを表示
//        textFieldStart.clearButtonMode = .always
//        textFieldEnd.clearButtonMode = .always
//
//        // 改行ボタンの種類を変更
//        textFieldStart.returnKeyType = .done
//        textFieldEnd.returnKeyType = .done
//        // 画面に追加
//        self.view.addSubview(textFieldStart)
//        self.view.addSubview(textFieldEnd)
        /////////////////////////////////////////////////////////////
        
//        let Label = UILabel()
//        
//        Label.frame.size.width = self.view.frame.width * 2/5
//        Label.frame.size.height = 48
     //////////////////////////////////////////////////////////////////
        
        
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

