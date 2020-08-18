//
//  page_register.swift
//  iosapp
//
//  Created by 徐梓修 on 2020/7/8.
//  Copyright © 2020 徐梓修. All rights reserved.
//

import UIKit
class page_register: UIViewController {
    @IBOutlet weak var fin_register: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var re_password: UITextField!
    @IBOutlet weak var last_4_id: UITextField!
    @IBOutlet weak var register_success: UILabel!
    @IBOutlet weak var back_to_login: UIButton!
    @IBOutlet weak var show_account: UILabel!
    var account_checking:String?
    @IBAction func button_event(_ sender: UIButton){
        if sender == back_to_login{
            performSegue(withIdentifier: "register_to_login", sender: self)
        }
        if sender == fin_register{
            if register_success.isHidden==true{
                let whitespace = NSCharacterSet.whitespaces
                if (name.text == "" || password.text == "" || re_password.text == "" || last_4_id.text == ""){
                    ok_alert("欄位不可留空")
                }else if(password.text!.rangeOfCharacter(from: whitespace) != nil || re_password.text!.rangeOfCharacter(from: whitespace) != nil){
                    ok_alert("不可輸入空白字元")
                }
                else{
                    if password.text != re_password.text{
                        ok_alert("密碼不一致")
                    }
                    else if password.text!.count<8 || password.text!.count>20{
                        ok_alert("密碼長度須介於8~20位之間")
                    }
                    else if(!isStringAnInt(last_4_id.text!)){
                        ok_alert("後四碼格式錯誤")
                    }
                    else if howlongint(last_4_id.text!) != 4{
                        ok_alert("後四碼格式錯誤")
                    }
                    else{
                        setup_alert(1)
                    }
                }
            }
        }
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
    func ok_alert(_ text: String){
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           let controller_show_ok = UIAlertController(title: text, message: nil, preferredStyle: .alert)
           controller_show_ok.addAction(okAction)
           present(controller_show_ok,animated: true,completion: nil)
       }
    func setup_alert(_ condiction: Int){
        if condiction==1{
            let submit_or_not = UIAlertController(title: "確定提交嗎?", message: nil, preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "確定", style: .default){
                action in
                self.postItem()
                self.register_success.isHidden=false
                self.fin_register.isHidden=true
            }
            let noAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            submit_or_not.addAction(yesAction)
            submit_or_not.addAction(noAction)
            present(submit_or_not,animated: true,completion: nil)
        }
    }
    func mod_constraints(){
        register_success.centerYAnchor.constraint(equalTo: fin_register.centerYAnchor).isActive=true
    }
    func mod_button(){
        fin_register.backgroundColor=UIColor.init(red: 0/255, green: 121/255, blue: 115/255, alpha: 1)
        fin_register.layer.borderWidth=3
        fin_register.layer.borderColor=UIColor.init(red: 106/255, green: 196/255, blue: 162/255, alpha: 1).cgColor
    }
    func secure_password(_ sender: UITextField){
           sender.isSecureTextEntry=true
           sender.textContentType=UITextContentType(rawValue: "")
       }
    func circular_button(_ object1:AnyObject){
        object1.layer.cornerRadius=object1.frame.width/2
        object1.layer.masksToBounds=true
    }
    func postItem(){
        //let request = NSMutableURLRequest(url: NSURL(string: "https://iosappdb.000webhostapp.com/usage/register.php")! as URL)
        let request = NSMutableURLRequest(url: NSURL(string: "http://msmiosappdb.online/usage/register.php")! as URL)
        request.httpMethod = "POST"
        let postString = "account_=\(account_checking!)&name_=\(name.text!)&pw_=\(password.text!)&last_4_id_=\(last_4_id.text!)"
        request.httpBody=postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            (data, response, error) in
            if error != nil{
                print("error = \(String(describing: error))")
            }
            print("response = \(String(describing: response))")
            let responseString = NSString(data: data!, encoding:  String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    override func touchesEnded(_ touch: Set<UITouch>,with event: UIEvent?){
        name.resignFirstResponder()
        password.resignFirstResponder()
        re_password.resignFirstResponder()
        last_4_id.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        circular_button(fin_register)
        mod_constraints()
        mod_button()
        show_account.text="id: "+account_checking!.uppercased()
        secure_password(password)
        secure_password(re_password)
        register_success.isHidden=true
        last_4_id.keyboardType = .numberPad
    }
}
