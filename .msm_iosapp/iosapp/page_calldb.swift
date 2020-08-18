//
//  page_calldb.swift
//  iosapp
//
//  Created by 徐梓修 on 2020/7/13.
//  Copyright © 2020 徐梓修. All rights reserved.
//

import UIKit
let tableViewCell_inst = tableViewCell()
class page_calldb: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var account_logined_:String?
    var password_logined_:String?
    var today_state_:String?
    var reason_message_:String?=""
    var db_struct_data = [db_struct]()
    let date=Date()
       let dateformatter = DateFormatter()
       let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
       var whichday:String?
    
    
    @IBOutlet weak var date_stackview: UIStackView!
    @IBOutlet weak var tableViewData: UITableView!
    @IBOutlet weak var back_page2_button: UIButton!
    @IBOutlet weak var show_account: UILabel!
    @IBAction func button_event(_ sender: UIButton){
        if sender==back_page2_button{
            performSegue(withIdentifier: "back_calldb", sender: self)
        }
    }
    @IBOutlet weak var current_time: UILabel!
    @IBOutlet weak var weekofday: UILabel!
    func getItems(){
        //let request = NSMutableURLRequest(url: NSURL(string: "https://iosappdb.000webhostapp.com/usage/service.php")! as URL)
        let request = NSMutableURLRequest(url: NSURL(string: "http://msmiosappdb.online/usage/service.php")! as URL)
        request.httpMethod = "POST"
        let postString = "account_=\(account_logined_!)&authority_=\(getCharcter(account_logined_,1))&location_=\(getCharcter(account_logined_,0))&alter_=\(getCharcter(account_logined_,2))"
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
        var locArray = [db_struct]()
            do{
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
                for jsonResult in jsonArray{
                    let jsonDict = jsonResult as! [String:String]
                    let loc = db_struct(account: jsonDict["account"]!,
                                        //position: jsonDict["position"]!,
                                        name: jsonDict["name"]!,
                                        password: jsonDict["password"]!,
                                        status: jsonDict["status"]!,
                                        reason: jsonDict["reason"]!,
                                        last_4_id: jsonDict["last_4_id"]!,
                                        submit_time: jsonDict["submit_time"]!)
                    locArray.append(loc)
                }
            }catch{
                print("There was an error")
            }
            self.db_struct_data=locArray
            self.tableViewData.reloadData()
        }
    }
    func mod_constraints(){
        let g = UILayoutGuide()
        self.view.addLayoutGuide(g)
        g.topAnchor.constraint(equalTo: tableViewData.bottomAnchor).isActive=true
        g.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive=true
        
        let f = UILayoutGuide()
        self.view.addLayoutGuide(f)
        f.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive=true
        f.bottomAnchor.constraint(equalTo: tableViewData.topAnchor).isActive=true
        
        date_stackview.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(date_stackview)
        date_stackview.topAnchor.constraint(equalTo: g.topAnchor).isActive=true
        date_stackview.bottomAnchor.constraint(equalTo: g.bottomAnchor).isActive=true
        
        show_account.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(show_account)
        show_account.topAnchor.constraint(equalTo: f.topAnchor).isActive=true
        show_account.bottomAnchor.constraint(equalTo: f.bottomAnchor).isActive=true
       }
    func printTime()->(date: String, week: String){
        dateformatter.dateFormat="yyyy-MM-dd"+"\t"+"HH:mm"
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
    
    func ok_alert(_ text: String){
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let controller_show_ok = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        controller_show_ok.addAction(okAction)
        present(controller_show_ok,animated: true,completion: nil)
    }
    func getCharcter(_ string: String?,_ index: Int)->String{
        return String(string![string!.index(string!.startIndex, offsetBy: index)])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db_struct_data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! tableViewCell
        //cell.textLabel?.text = dataformat(cellForRowAt: indexPath)
        cell.reason_button.isHidden=true
        cell.submit_date.isHidden=true
        cell.submit_time.isHidden=true
        
        cell.reason_button.setTitle("事由", for: .normal)
        cell.reason_button.setTitleColor(UIColor.systemTeal, for: .normal)
        cell.reason_button.layer.borderWidth=1
        cell.reason_button.layer.cornerRadius=10.0
        cell.reason_button.layer.borderColor=UIColor.systemTeal.cgColor
        
        cell.backgroundColor=UIColor.init(red: 0/255, green: 121/255, blue: 115/255, alpha: 1)
        let selectColor = UIView()
        selectColor.backgroundColor = UIColor.systemBlue
        cell.selectedBackgroundView = selectColor
        
        cell.submit_time.widthAnchor.constraint(equalToConstant: cell.submit_date.frame.width).isActive=true
        cell.submit_time.centerXAnchor.constraint(equalTo: cell.submit_date.centerXAnchor).isActive=true
        
        //cell.id_label.text=db_struct_data[indexPath.row].account
        cell.id_label.attributedText=NSAttributedString(string: db_struct_data[indexPath.row].account, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        cell.id_label.textColor=UIColor.init(red: 106/255, green: 196/255, blue: 162/255, alpha: 1)
        //cell.id_label.layer.borderWidth=1
        //cell.id_label.layer.borderColor=UIColor.init(red: 106/255, green: 196/255, blue: 162/255, alpha: 1).cgColor
    
        
        //cell.position_label.text=db_struct_data[indexPath.row].position
        //cell.position_label.textColor=UIColor.systemYellow
        
        cell.name_label.text=db_struct_data[indexPath.row].name
        cell.name_label.textColor=UIColor.white
        
        
        cell.status_label.text=db_struct_data[indexPath.row].status
        if(db_struct_data[indexPath.row].status == "在校"){
            cell.status_label.textColor=UIColor.systemGreen
        }
        if(db_struct_data[indexPath.row].status == "休假"){
            cell.status_label.textColor=UIColor.systemYellow
        }
        if(db_struct_data[indexPath.row].status == "其他"){
            cell.status_label.textColor=UIColor.init(red: 225/255, green: 110/255, blue: 121/255, alpha: 1)
        }
        
        if(db_struct_data[indexPath.row].reason != ""){
            cell.reason_button.isHidden=false
            cell.actionBlock = {
                self.ok_alert(self.db_struct_data[indexPath.row].reason)
            }
        }
        
        
        if(db_struct_data[indexPath.row].submit_time != ""){
            let post_time = db_struct_data[indexPath.row].submit_time
            cell.submit_date.isHidden=false
            cell.submit_time.isHidden=false
            cell.submit_date.text = String(post_time.prefix(10))
            cell.submit_time.text = String(post_time.suffix(5))
            cell.submit_date.textColor = UIColor.white
            cell.submit_time.textColor = UIColor.white
        }
        
        
       
        
        return cell
    }
    func mod_label(){
        current_time.textColor=UIColor.init(red: 0/255, green: 121/255, blue: 115/255, alpha: 1)
        weekofday.textColor=UIColor.init(red: 0/255, green: 121/255, blue: 115/255, alpha: 1)
        show_account.text="id: "+account_logined_!.uppercased()
        show_account.textColor=UIColor.init(red: 0/255, green: 121/255, blue: 115/255, alpha: 1)
    }
    func mod_button(){
        
    }
    /*
    func dataformat(cellForRowAt indexPath: IndexPath)->String{
        return db_struct_data[indexPath.row].account + " " + db_struct_data[indexPath.row].position + " " + db_struct_data[indexPath.row].name + " " + db_struct_data[indexPath.row].status + " " + db_struct_data[indexPath.row].reason
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewData.delegate = self
        tableViewData.dataSource = self
        tableViewData.backgroundColor = UIColor.init(red: 0/255, green: 121/255, blue: 115/255, alpha: 1)
        getItems()
        mod_constraints()
        let time_result=self.printTime()
        current_time.text=time_result.date
        weekofday.text=time_result.week
        mod_label()
        
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "back_calldb"{
            let vc = segue.destination as! page2
            vc.account_logined = account_logined_!
            vc.password_logined = password_logined_!
        }
    }
}


