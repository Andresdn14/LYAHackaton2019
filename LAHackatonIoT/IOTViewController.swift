//
//  IOTViewController.swift
//  LAHackatonIoT
//
//  Created by Andres Felipe De La Ossa Navarro on 8/10/19.
//  Copyright © 2019 Andres Felipe De La Ossa Navarro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class IOTViewController: UIViewController {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var mqttButton: UIButton!
    
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    

    @IBAction func lyaDevice0(_ sender: Any) {
            mqttButton.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            })
            let idURL = "http://192.168.4.1/info"
            
            Alamofire.request(idURL, method: .get).responseJSON{
                response in
                if response.result.isSuccess {
                    if let resValue = response.result.value {
                        let idJSON: JSON = JSON(resValue)
                        print(idJSON)
                        self.idLabel.text = idJSON["info"]["ID"].stringValue
                        
                        
                    }
                }else {
                    
                    print("Error getting data")
                }
            }
        
    }
    
    @IBAction func lyaDevice3(_ sender: Any) {
            mqttButton.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            })
            let idURL = "http://192.168.4.1/info"
            
            Alamofire.request(idURL, method: .get).responseJSON{
                response in
                if response.result.isSuccess {
                    if let resValue = response.result.value {
                        let idJSON: JSON = JSON(resValue)
                        print(idJSON)
                        self.idLabel.text = idJSON["info"]["ID"].stringValue
                        
                        
                    }
                }else {
                    
                    print("Error getting data")
                }
            }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tiotToMQTT"{
            
            let destinationVC = segue.destination as! MQTTClientViewController
            
           
        }
    }
    @IBAction func mqttPressed(_ sender: Any) {
        let thingURL = "http://3.224.227.74:3660/api/v1/thing"
        let credentialsURL = "http://3.224.227.74:3660/api/v1/credentials"
        let getCredentialsURL = "http://3.224.227.74:3660/api/v1/credentials"
        let thingHeaders : [String : String] = ["authorization" :  "LYA " + token!]
        let credentialsHeaders : [String : String] = ["authorization" : "LYA " + token!]
        let getCredentialsHeaders : [String : String] = ["authorization" : "LYA " + token!]
        Alamofire.request(thingURL, method: .post, headers: thingHeaders).responseJSON{
            response in
            if response.result.isSuccess {
                if let resValue = response.result.value {
                    let gamesJSON: JSON = JSON(resValue)
                }
            }else {
                
                print("Error getting data")
            }
        }
        
        Alamofire.request(credentialsURL, method: .post, headers: credentialsHeaders).responseJSON{
            response in
            if response.result.isSuccess {
                if let resValue = response.result.value {
                    let gamesJSON: JSON = JSON(resValue)
                }
            }else {
                
                print("Error getting data")
            }
        }
        
        Alamofire.request(getCredentialsURL, method: .get, headers: getCredentialsHeaders).responseJSON{
            response in
            if response.result.isSuccess {
                if let resValue = response.result.value {
                    let credentialsJSON: JSON = JSON(resValue)
                    print(credentialsJSON)
                }
            }else {
                
                print("Error getting data")
            }
        }


    }
    
}
