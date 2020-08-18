//
//  page2.swift
//  iosapp
//
//  Created by 徐梓修 on 2020/6/30.
//  Copyright © 2020 徐梓修. All rights reserved.
//

import UIKit

class page2: UIViewController{
    @IBOutlet weak var username: UILabel!
    //@IBOutlet weak var position: UILabel!
    @IBOutlet weak var back_login_button: UIButton!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var change_password: UIButton!
    @IBOutlet weak var show_account: UILabel!
    //@IBOutlet weak var name_position: UIImageView!
    @IBOutlet var reason_buttons: [UIButton]!
    @IBOutlet weak var select_a_reason: UIButton!
    @IBOutlet weak var in_school: UIButton!
    @IBOutlet weak var vacation: UIButton!
    @IBOutlet weak var other_reason: UIButton!
    @IBOutlet weak var current_state: UILabel!
    @IBOutlet weak var weekofday: UILabel!
    @IBOutlet weak var reason_message: UITextField!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var inquire: UIButton!
    let date=Date()
    let dateformatter = DateFormatter()
    let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
    var whichday:String?
    var account_logined:String?
    var password_logined:String?
    var today_state:String?
    let state_array=["在校","休假","其他"]
    var new_password:String?
    var changePW:Bool=false

    @IBAction func button_event(_ sender: UIButton) {
        if sender==back_login_button{
            performSegue(withIdentifier: "back_to_login", sender: self)
        }
        if sender==change_password{
            setup_alert(2)
        }
        if sender==select_a_reason{
            reason_buttons.forEach{ (button) in
                UIView.animate(withDuration: 0.3 , animations: {
                    button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                })
            }
            submit.setTitle("提交", for: .normal)
            submit.titleLabel?.font=UIFont.boldSystemFont(ofSize: 32)
            submit.setTitleColor(UIColor.init(red: 0/255, green: 121/255, blue: 115/255, alpha: 1), for: .normal)
            submit.backgroundColor=UIColor.white
            submit.layer.borderWidth=3
            submit.layer.borderColor=UIColor.white.cgColor
            submit.isHidden=true
            //inquire.isHidden=true
            reason_message.isHidden=true
            current_state.isHidden=true
        }
        if sender==in_school{
            reason_buttons.forEach{ (button) in
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
                current_state.text=state_array[0]
                today_state=current_state.text
                current_state.textColor=UIColor.systemGreen
                reason_message.isHidden=true
                submit.isHidden=false
                current_state.isHidden=false
            }
        }
        if sender==vacation{
            reason_buttons.forEach{ (button) in
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
                current_state.text=state_array[1]
                today_state=current_state.text
                current_state.textColor=UIColor.systemYellow
                reason_message.isHidden=false
                submit.isHidden=false
                current_state.isHidden=false
            }
        }
        if sender==other_reason{
            reason_buttons.forEach{ (button) in
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
                current_state.text=state_array[2]
                today_state=current_state.text
                current_state.textColor=UIColor.init(red: 225/255, green: 110/255, blue: 121/255, alpha: 1)
                reason_message.isHidden=false
                submit.isHidden=false
                current_state.isHidden=false
            }
        }
        if sender==submit{
            if submit.titleLabel?.text=="提交"{
                if today_state=="在校"{
                    setup_alert(1)
                }
                if today_state=="其他" || today_state=="休假"{
                    if reason_message.text==""{
                        ok_alert("請輸入事由")
                    }else{
                        setup_alert(1)
                    }
                }
            }
        }
        if sender==inquire{
            performSegue(withIdentifier: "go_calldb", sender: self)
        }
    }
    func ok_alert(_ text: String){
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let controller_show_ok = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        controller_show_ok.addAction(okAction)
        present(controller_show_ok,animated: true,completion: nil)
    }
    func change_alert_color(_ controller: UIAlertController,_ string: String?){
    controller.setValue(NSAttributedString(
                      string: string!,attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15,weight: UIFont.Weight.medium),NSAttributedString.Key.foregroundColor : UIColor.systemPurple])
                      ,forKey: "attributedMessage")
    }
    func setup_alert(_ condiction: Int){
        if condiction==1{
            let submit_or_not = UIAlertController(title: "確定提交嗎?", message: nil, preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "確定", style: .default){
                action in
                self.todaySubmit()
                self.submit.setTitle("提交成功!", for: .normal)
                self.submit.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                self.submit.setTitleColor(UIColor.white, for: .normal)
                self.submit.backgroundColor = UIColor.init(red: 0/255, green: 121/255, blue: 115/255, alpha: 1)
                self.submit.layer.borderColor=UIColor.init(red: 106/255, green: 196/255, blue: 162/255, alpha: 1).cgColor
                //self.inquire.isHidden=false
            }
            let noAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            submit_or_not.addAction(yesAction)
            submit_or_not.addAction(noAction)
            present(submit_or_not,animated: true,completion: nil)
        }
        if condiction==2{
            let text="設定新密碼"
            var message_text:String?
            let change_password_alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
            change_password_alert.addTextField{
                (textField) in
                textField.placeholder="新密碼"
                self.secure_password(textField)
            }
            change_password_alert.addTextField{
                (textField) in
                textField.placeholder="請再次輸入一次"
                self.secure_password(textField)
            }
            let yesAction = UIAlertAction(title: "確定", style: .default){
                action in
                var changePw_ok:Bool = false
                if (change_password_alert.textFields?[0].text! == "" || change_password_alert.textFields?[1].text! == ""){
                    message_text="欄位不可留空"
                }else{
                    let whitespace = NSCharacterSet.whitespaces
                    if(change_password_alert.textFields?[0].text!.rangeOfCharacter(from: whitespace) != nil || change_password_alert.textFields?[1].text!.rangeOfCharacter(from: whitespace) != nil){
                        message_text="不可輸入空白字元"
                    }
                    else if(change_password_alert.textFields?[0].text! != change_password_alert.textFields?[1].text!){
                        message_text="密碼不一致"
                    }
                    else if((change_password_alert.textFields?[0].text!.count)!<8 || (change_password_alert.textFields?[0].text!.count)!>20){
                        message_text="密碼長度須介於8~20位之間"
                    }
                    else{
                        changePw_ok = true
                        self.new_password=change_password_alert.textFields?[0].text!
                        self.setup_alert(3)
                    }
                }
                if changePw_ok == false{
                    change_password_alert.message=message_text
                    self.change_alert_color(change_password_alert,message_text)
                    self.present(change_password_alert,animated: true,completion: nil)
                }
            }
            let noAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            change_password_alert.addAction(yesAction)
            change_password_alert.addAction(noAction)
            present(change_password_alert,animated: true,completion: nil)
        }
        if condiction==3{
            let message_text = new_password
            let changePW_or_not = UIAlertController(title: "是否將密碼變更為：", message: message_text, preferredStyle: .alert)
            let change_password_alert_ok = UIAlertController(title: "密碼變更成功！", message: nil, preferredStyle: .alert)
            self.change_alert_color(changePW_or_not,message_text)
            let yesAction = UIAlertAction(title: "確定", style: .default){
                action in
                self.present(change_password_alert_ok,animated: true,completion: nil)
            }
            let noAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "OK", style: .default){
                action in
                self.changePw()
            }
            changePW_or_not.addAction(yesAction)
            changePW_or_not.addAction(noAction)
            change_password_alert_ok.addAction(okAction)
            present(changePW_or_not,animated: true,completion: nil)
        }
        if condiction==4{
            let text="請輸入事由"
            let controller_reason = UIAlertController(title: text, message: nil, preferredStyle: .alert)
            controller_reason.addTextField{
                (textField) in
                //textField.placeholder="帳號格式：(例如)XX001"
                textField.text=self.reason_message.text
            }
            let okAction = UIAlertAction(title: "確定",style: .default){
                action in
                self.reason_message.text=controller_reason.textFields?[0].text!
            }
            let noAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            controller_reason.addAction(okAction)
            controller_reason.addAction(noAction)
            present(controller_reason, animated: true, completion: nil)
        }
    }
    func printTime()->(date: String, week: String){
        dateformatter.dateFormat="yyyy-MM-dd"+"\t"+" "+"HH:mm"
        let weekday = dateComponents.weekday
        let dateString = dateformatter.string(from: self.date)
        switch weekday {
            case 1:
                whichday="星期日"
            case 2:
                whichday="星期一"
            case 3:
                whichday="星期二"
            case 4:
                whichday="星期三"
            case 5:
                whichday="星期四"
            case 6:
                whichday="星期五"
            case 7:
                whichday="星期六"
            default:
                break
        }
        return (dateString,whichday!)
    }
    func secure_password(_ sender: UITextField){
        sender.isSecureTextEntry=true
        sender.textContentType=UITextContentType(rawValue: "")
    }
    func mod_button(){
        submit.setTitleColor(UIColor.init(red: 0/255, green: 121/255, blue: 115/255, alpha: 1), for: .normal)
        submit.backgroundColor=UIColor.white
        submit.layer.borderWidth=3
        submit.layer.borderColor=UIColor.white.cgColor
        //submit.layer.borderColor=UIColor.init(red: 106/255, green: 196/255, blue: 162/255, alpha: 1).cgColor
        
        inquire.setTitleColor(UIColor.white, for: .normal)
        inquire.backgroundColor=UIColor.init(red: 0/255, green: 121/255, blue: 115/255, alpha: 1)
        inquire.layer.borderWidth=3
        inquire.layer.borderColor=UIColor.init(red: 106/255, green: 196/255, blue: 162/255, alpha: 1).cgColor
        
        select_a_reason.backgroundColor=UIColor.systemTeal
        select_a_reason.setTitleColor(UIColor.init(red: 0/255, green: 121/255, blue: 115/255, alpha: 1), for: .normal)
        change_password.backgroundColor=UIColor.init(red: 106/255, green: 196/255, blue: 162/255, alpha: 1)
        change_password.layer.cornerRadius=15.0
    }
    func mod_label(){
        //name_position.alpha=0.2
        //currentTime.textColor=UIColor.init(red: 106/255, green: 196/255, blue: 162/255, alpha: 1)
        //weekofday.textColor=UIColor.init(red: 106/255, green: 196/255, blue: 162/255, alpha: 1)
        currentTime.textColor=UIColor.systemGreen
        weekofday.textColor=UIColor.systemGreen
        username.textColor=UIColor.systemYellow
        //position.textColor=UIColor.systemYellow
    }
    func circular_button(_ object1:AnyObject){
        object1.layer.cornerRadius=object1.frame.width/2
        object1.layer.masksToBounds=true
    }
    func todaySubmit(){
        let submit_time=self.printTime()
        //let request = NSMutableURLRequest(url: NSURL(string: "https://iosappdb.000webhostapp.com/usage/todaySubmit.php")! as URL)
        let request = NSMutableURLRequest(url: NSURL(string: "http://msmiosappdb.online/usage/todaySubmit.php")! as URL)
        request.httpMethod = "POST"
        let postString = "account_=\(account_logined!)&pw_=\(password_logined!)&status_=\(today_state!)&reason_=\(reason_message.text!)&submit_time_=\(submit_time.date)"
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
    func changePw(){
        //let request = NSMutableURLRequest(url: NSURL(string: "https://iosappdb.000webhostapp.com/usage/changePw.php")! as URL)
        let request = NSMutableURLRequest(url: NSURL(string: "http://msmiosappdb.online/usage/changePw.php")! as URL)
        request.httpMethod = "POST"
        let postString = "account_=\(account_logined!)&new_pw_=\(new_password!)&old_pw_=\(password_logined!)"
        request.httpBody=postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            (data, response, error) in
            if error != nil{
                print("error = \(String(describing: error))")
            }
            print("response = \(String(describing: response))")
            let responseString = NSString(data: data!, encoding:  String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
            
            DispatchQueue.main.async{
                self.performSegue(withIdentifier: "back_to_login", sender: self)
            }
        }
        task.resume()
    }
    func showProfile(){
        //let request = NSMutableURLRequest(url: NSURL(string: "https://iosappdb.000webhostapp.com/usage/profile.php")! as URL)
        let request = NSMutableURLRequest(url: NSURL(string: "http://msmiosappdb.online/usage/profile.php")! as URL)
        request.httpMethod = "POST"
        let postString = "account_=\(account_logined!)&pw_=\(password_logined!)"
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
        DispatchQueue.main.async {
            do{
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
                let jsonDict = jsonArray[0] as! [String:String]
                self.username.text=jsonDict["name"]!
                //self.position.text=jsonDict["position"]!
            }catch{
                print("There was an error")
            }
        }
    }
    @objc func ShowTextField(textField: UITextField){
        setup_alert(4)
    }
    override func touchesEnded(_ touch: Set<UITouch>,with event: UIEvent?){
        reason_message.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showProfile()
        current_state.text=""
        reason_message.isHidden=true
        submit.isHidden=true
        //inquire.isHidden=true
        circular_button(submit)
        circular_button(inquire)
        mod_label()
        mod_button()
        let time_result=self.printTime()
        currentTime.text=time_result.date
        weekofday.text=time_result.week
        show_account.text="id: "+account_logined!.uppercased()
        reason_message.addTarget(self, action: #selector(ShowTextField), for: .touchDown)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "back_to_login"{
            let vc = segue.destination as! page1
            vc.account_restore = account_logined!
            vc.password_restore = password_logined!
        }
        if segue.identifier == "go_calldb"{
            let vc = segue.destination as! page_calldb
            vc.account_logined_ = account_logined!
            vc.password_logined_ = password_logined!
            vc.today_state_ = today_state
            vc.reason_message_ = reason_message.text
        }
    }
}
