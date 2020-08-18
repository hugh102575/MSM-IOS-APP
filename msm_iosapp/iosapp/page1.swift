//
//  ViewController.swift
//  iosapp
//
//  Created by 徐梓修 on 2020/6/22.
//  Copyright © 2020 徐梓修. All rights reserved.
//

import UIKit

class page1: UIViewController{
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login_button: UIButton!
    @IBOutlet weak var register_button: UIButton!
    @IBOutlet weak var forgot_password: UIButton!
    @IBOutlet weak var register_reminder: UILabel!
    @IBOutlet weak var register_reminder2: UILabel!
    var account_word:String?
    var account_check:String?
    var password_word:String?
    var account_restore:String?
    var password_restore:String?
    @IBAction func button_event(_ sender: UIButton) {
        account_word=account.text!
        password_word=password.text!
        let whitespace = NSCharacterSet.whitespaces
        if sender==login_button{
            if (account_word == ""||password_word == ""){
                ok_alert("請輸入帳號密碼")
            }
            else if account_word!.rangeOfCharacter(from: whitespace) != nil || password_word!.rangeOfCharacter(from: whitespace) != nil{
                ok_alert("不可輸入空白字元")
            }
            else{
                self.loginAccountandPw()
            }
        }
        if sender==register_button{
            setup_alert(1)
        }
        if sender==forgot_password{
            performSegue(withIdentifier: "go_forgot_password", sender: self)
        }
    }
    func change_alert_color(_ controller: UIAlertController,_ string: String?){
        controller.setValue(NSAttributedString(
                          string: string!,attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15,weight: UIFont.Weight.medium),NSAttributedString.Key.foregroundColor : UIColor.systemPurple])
                          ,forKey: "attributedMessage")
    }
    func ok_alert(_ text: String){
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let controller_show_ok = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        controller_show_ok.addAction(okAction)
        present(controller_show_ok,animated: true,completion: nil)
    }
    func setup_alert(_ condiction: Int){
        if condiction==1{
            var message_text:String?
            let text="請輸入帳號"
            let controller_check_account = UIAlertController(title: text, message: nil, preferredStyle: .alert)
            controller_check_account.addTextField{
                (textField) in
                //textField.placeholder="帳號格式：(例如)XX001"
                textField.placeholder=""
            }
            let ok_check_account = UIAlertAction(title: "送出",style: .default){
                action in
                let whitespace = NSCharacterSet.whitespaces
                if controller_check_account.textFields?[0].text! == ""{
                    message_text="欄位不可留空"
                    controller_check_account.message=message_text
                    self.change_alert_color(controller_check_account, message_text)
                    self.present(controller_check_account, animated: true, completion: nil)
                }else if controller_check_account.textFields?[0].text!.rangeOfCharacter(from: whitespace) != nil{
                    message_text="不可輸入空白字元"
                    controller_check_account.message=message_text
                    self.change_alert_color(controller_check_account, message_text)
                    self.present(controller_check_account, animated: true, completion: nil)
                }
                else{
                    self.account_check=controller_check_account.textFields?[0].text!
                    self.checkAccount()
                }
            }
            let noAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            controller_check_account.addAction(ok_check_account)
            controller_check_account.addAction(noAction)
            present(controller_check_account, animated: true, completion: nil)
        }
        if condiction == 2{
            let submit_or_not = UIAlertController(title: "此帳號已經註冊，是否再次註冊?", message: nil, preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "確定", style: .default){
                action in
                self.performSegue(withIdentifier: "go_register", sender: self)
            }
            let noAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            submit_or_not.addAction(yesAction)
            submit_or_not.addAction(noAction)
            present(submit_or_not,animated: true,completion: nil)
        }
    }
    
    func secure_password(_ sender: UITextField){
        sender.isSecureTextEntry=true
        sender.textContentType=UITextContentType(rawValue: "")
    }
    func mod_constraints(){
        register_reminder.centerXAnchor.constraint(equalTo: register_button.centerXAnchor).isActive=true
        register_reminder2.centerXAnchor.constraint(equalTo: register_button.centerXAnchor).isActive=true
    }
    func mod_button(){
        //106,196,162 藍綠色
        //0,175,210 淺藍色
        //0,121,115 深綠色
        //195,152,78 棕橘色
        register_button.backgroundColor=UIColor.init(red: 106/255, green: 196/255, blue: 162/255, alpha: 1)
        register_button.layer.cornerRadius=10.0
        login_button.backgroundColor=UIColor.systemBlue
        login_button.layer.cornerRadius=15.0
    }
    func loginAccountandPw(){
        let login_mode:String = "account_pw"
        //let request = NSMutableURLRequest(url: NSURL(string: "https://iosappdb.000webhostapp.com/usage/login.php")! as URL)
        let request = NSMutableURLRequest(url: NSURL(string: "http://msmiosappdb.online/usage/login.php")! as URL)
        request.httpMethod = "POST"
        let postString = "account_=\(account.text!)&login_mode_=\(login_mode)&pw_=\(password.text!)"
        request.httpBody=postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            (data, response, error) in
            if error != nil{
                print("error = \(String(describing: error))")
            }
            print("response = \(String(describing: response))")
            let responseString = NSString(data: data!, encoding:  String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
            self.parseJson(data!)
        }
        task.resume()
    }
    func checkAccount(){
        let login_mode:String = "account"
        //let request = NSMutableURLRequest(url: NSURL(string: "https://iosappdb.000webhostapp.com/usage/login.php")! as URL)
        let request = NSMutableURLRequest(url: NSURL(string: "http://msmiosappdb.online/usage/login.php")! as URL)
        request.httpMethod = "POST"
        let postString = "account_=\(account_check!)&login_mode_=\(login_mode)"
        request.httpBody=postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            (data, response, error) in
            if error != nil{
                print("error = \(String(describing: error))")
            }
            print("response = \(String(describing: response))")
            let responseString = NSString(data: data!, encoding:  String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
            self.parseJson(data!)
        }
        task.resume()
    }
    func parseJson(_ data:Data){
        DispatchQueue.main.async{
            let string = String(data: data,encoding: String.Encoding.utf8)
            
            if string == "new account"{
                self.performSegue(withIdentifier: "go_register", sender: self)
            }
            if string == "already registered"{
                self.setup_alert(2)
            }
            if (string == "account not exist" || string == "account not exist 2"){
                self.ok_alert("帳號錯誤")
            }
            
            
            if string == "new account 2"{
                self.ok_alert("此帳號尚未註冊")
            }
            if string == "login successed"{
                self.performSegue(withIdentifier: "after_login", sender: self)
            }
            if string == "password not exist"{
                self.ok_alert("密碼錯誤")
            }
        }
    }
    override func touchesEnded(_ touch: Set<UITouch>,with event: UIEvent?){
        account.resignFirstResponder()
        password.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mod_button()
        mod_constraints()
        secure_password(password)
        account.text=account_restore
        password.text=password_restore
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "after_login"{
            let vc = segue.destination as! page2
            vc.account_logined=account_word
            vc.password_logined=password_word
        }
        if segue.identifier == "go_register"{
            let vc = segue.destination as! page_register
            vc.account_checking=account_check
        }
    }
}
