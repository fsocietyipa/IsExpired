//
//  ViewController.swift
//  IsExpired?
//
//  Created by fsociety.1 on 8/14/18.
//  Copyright © 2018 fsociety.1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var docTypeTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.minimumDate = Date()
    }

    @IBAction func sendData(_ sender: Any) {
        //print(formatDate(now: picker.date))
        postData()
    }
    
    
    func postData() {
        
        let url = ""
        let parameters = [
            "docType": docTypeTF.text,
            "date": formatDate(now: picker.date),
            "deviceToken": UserDefaults.standard.string(forKey: "deviceToken") ?? ""
            ] as [String : Any] as [String : Any]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            do {
                let json = JSON(response.value)
                print(json)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }
    }
    
    
    func formatDate(now: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: now)
    }
}

