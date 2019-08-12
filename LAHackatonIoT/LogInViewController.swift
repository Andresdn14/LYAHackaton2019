//
//  LogInViewController.swift
//  LAHackatonIoT
//
//  Created by Andres Felipe De La Ossa Navarro on 8/10/19.
//  Copyright © 2019 Andres Felipe De La Ossa Navarro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LogInViewController: UIViewController {
    
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var password: UITextField!
    var token = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mail.text = "andresdelaossa@hotmail.com"
        password.text = "Andreso1!"
        
    }
    

    @IBAction func logInPressed(_ sender: Any) {
        let parameters = ["credenciales":["correo":mail.text!,"password":password.text!]]
        logIn(parameters: parameters)
    }
    

    
    func logIn(parameters:[String:Any]){
        
        
        
        let signUpURL = "http://3.224.227.74:3660/api/v1/usuarios/login"
        

        Alamofire.request(signUpURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString{
            response in

            if response.value != "Usuario Inexistente" && response.value != "Contraseña incorrecta" {

                if let resValue = response.value {
                    self.token = resValue
                    self.performSegue(withIdentifier: "toCatFact", sender: self)
                    print(resValue)
                    
                }
                }else {
                
                print("Error al loggear")
                print(response.value!)
                }
            }
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCatFact"{
            
            let destinationVC = segue.destination as! CatFactViewController
            
            destinationVC.token = token
        }
    }
    
    }
