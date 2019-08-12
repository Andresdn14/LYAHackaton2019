//
//  SignUpViewController.swift
//  LAHackatonIoT
//
//  Created by Andres Felipe De La Ossa Navarro on 8/10/19.
//  Copyright © 2019 Andres Felipe De La Ossa Navarro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpViewController: UIViewController {

    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = "Andres"
        lastName.text = "Martinez"
        mail.text = "andresdelaossa3@hotmail.com"
        password.text = "Andreso1!"
        
    }
    
    
    @IBAction func signUpPressed(_ sender: Any) {
         let parameters = ["usuario":["nombre":name.text!,"apellidos":lastName.text!,"correo":mail.text!,"password":password.text!]]
        signUp(parameters: parameters)
        

    }
    
    
    func signUp(parameters:[String:Any]){
        
       
        
        let signUpURL = "http://3.224.227.74:3660/api/v1/usuarios/registro"
        
        
        Alamofire.request(signUpURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{
            response in
            if let res = response.value {
                let resJSON: JSON = JSON(res)
                if resJSON["success"] != "0" {
                self.performSegue(withIdentifier: "signUpToLogIn", sender: self)
                }
                print(response.value!)
                
            }else {
                
                print("Error al registrar")
                
                
                
            }
        }
        
    }


}
