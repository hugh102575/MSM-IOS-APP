//
//  page_forgot.swift
//  iosapp
//
//  Created by 徐梓修 on 2020/7/13.
//  Copyright © 2020 徐梓修. All rights reserved.
//

import UIKit

class page_forgot: UIViewController {
    @IBOutlet weak var last_4_id: UITextField!
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var back_to_login: UIButton!
    @IBOutlet weak var submit: UIButton!
    
    @IBAction func button_event(_ sender: UIButton){
        if sender==submit{
            if last_4_id.text==""{
                ok_alert("欄位不可留空")
            }else{
                if(!isStringAnInt(last_4_id.text!)){
                    ok_alert("後四碼格式錯誤")
                }else if howlongint(last_4_id.text!) != 4{
                    ok_alert("後四碼格式錯誤")
                }else{
                    //setup_alert(1)
                    self.forgotPw()
                }
            }
        }
        if sender==back_to_login{
            performSegue(withIdentifier: "forgot_password_to_login", sender: self)
        }
    }
    func mod_button(){
        submit.backgroundColor=UIColor.init(red: 0/255, green: 121/255, blue: 115/255, alpha: 1)
        submit.layer.borderWidth=3
        submit.layer.borderColor=UIColor.init(red: 106/255, green: 196/255, blue: 162/255, alpha: 1).cgColor
    }
    func circular_button(_ object1:AnyObject){
        object1.layer.cornerRadius=object1.frame.width/2
        object1.layer.masksToBounds=true
    }
    func howlongint(_ string: String) -> Int{
        var a = Int(string)
        var count:Int = 0
        while a! > 0{
            a = a!/10
            count+=1
        }
        return count
    }
    func isStringAnInt(_ string: String)->Bool{
        return Int(string) != nil
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
    func ok_alert_showPw(_ text: String,_ message:String){
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let controller_show_ok = UIAlertController(title: text, message: message, preferredStyle: .alert)
        controller_show_ok.addAction(okAction)
        self.change_alert_color(controller_show_ok,message)
        present(controller_show_ok,animated: true,completion: nil)
    }
    func setup_alert(_ condiction: Int){
        if condiction==1{
            let submit_or_not = UIAlertController(title: "確定提交嗎?", message: nil, preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "確定", style: .default){
                action in
                self.forgotPw()
            }
            let noAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            submit_or_not.addAction(yesAction)
            submit_or_not.addAction(noAction)
            present(submit_or_not,animated: true,completion: nil)
        }
    }
    func forgotPw(){
        //let request = NSMutableURLRequest(url: NSURL(string: "https://iosappdb.000webhostapp.com/usage/forgotPw.php")! as URL)
        let request = NSMutableURLRequest(url: NSURL(string: "http://msmiosappdb.online/usage/forgotPw.php")! as URL)
        request.httpMethod = "POST"
        let postString = "account_=\(account.text!)&last_4_id_=\(last_4_id.text!)"
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
            
            if string == "account not exist"{
                self.ok_alert("帳號錯誤")
            }
            else if string == "not registered yet"{
                self.ok_alert("此帳號尚未註冊")
            }
            else if string == "last_4_id wrong"{
                self.ok_alert("後四碼錯誤")
            }else{
                self.ok_alert_showPw("您的密碼為:",string!)
            }
        }
    }
    override func touchesEnded(_ touch: Set<UITouch>,with event: UIEvent?){
        last_4_id.resignFirstResponder()
        account.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mod_button()
        circular_button(submit)
        last_4_id.keyboardType = .numberPad
    }
}
