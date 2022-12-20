//
//  Utils.swift
//  Test
//
//  Created by Minh on 22/11/2022.
//

import Foundation
import UIKit
//import StoreKit
//import LocalAuthentication
//import CryptoSwift

open class Utils: NSObject {
   
    static func customSwitch(isOn:Bool,sender: CustomSwitch){
        if isOn {
            sender.thumbImage = UIImage(named: "switch_checked")
            sender.layer.borderColor = UIColor.blue.cgColor
            sender.setOn(on: true, animated: false)
        }else{
            sender.thumbImage = UIImage(named: "switch_unchecked")
            sender.layer.borderColor = UIColor.red.cgColor
            sender.setOn(on: false, animated: false)
        }
    }
}
