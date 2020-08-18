//
//  ClipManager.swift
//  iosapp
//
//  Created by 徐梓修 on 2020/7/28.
//  Copyright © 2020 徐梓修. All rights reserved.
//

import UIKit

class ClipManager: NSObject {
    func ok_alert(_ text: String)->Void{
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let controller_show_ok = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        controller_show_ok.addAction(okAction)
        //UIApplication.sharedApplication.keyWindow?.rootViewController(controller_show_ok, animatd: true, completion: nil)
        controller_show_ok.present(controller_show_ok,animated: true,completion: nil)
    }
}
