//
//  Model.swift
//  LAHackatonIoT
//
//  Created by Andres Felipe De La Ossa Navarro on 8/10/19.
//  Copyright © 2019 Andres Felipe De La Ossa Navarro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Model: NSObject {
    func getData(parameters:[String:Any]){
        
          let signUpURL = "http://3.224.227.74:3660/api/v1/usuarios/registro"
//        let APP_ID = "2206f925-4275-4399-b592-58f0b531069f"
//        let APP_KEY = "Yvd2eK2LODfwVmkjQVNzFXwd3N0X7oUuwiMI3VDZ"
//        let headers : [String : String] = ["X-Parse-Application-Id" : APP_ID, "X-Parse-REST-API-Key":APP_KEY]
        
        
        let parameters: Parameters = [
            "foo": [1,2,3],
            "bar": [
                "baz": "qux"
            ]
        ]
        Alamofire.request(signUpURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).response{
            response in
            if response.response != nil {
                print(response)
            }else {
                
                print("Error getting data")
            }
        }
        
    }
}
