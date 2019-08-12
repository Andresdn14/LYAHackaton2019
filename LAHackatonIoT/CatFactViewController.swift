//
//  CatFactViewController.swift
//  LAHackatonIoT
//
//  Created by Andres Felipe De La Ossa Navarro on 8/10/19.
//  Copyright © 2019 Andres Felipe De La Ossa Navarro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CatFactViewController: UIViewController {
    @IBOutlet weak var labelFact: UILabel!
    @IBOutlet weak var qrView: UIImageView!
    @IBOutlet weak var iotButton: UIButton!
    
    let login = LogInViewController()
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func meowPressed(_ sender: Any) {
        getFact()
    }
    
    
    
    
    
    
    func getFact(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
        })
        let catURL = "https://catfact.ninja/fact?max_length=140"
        let headers : [String : String] = ["Accept": "application/json"]
        
        Alamofire.request(catURL, method: .get, headers: headers).responseJSON{
            response in
            if response.result.isSuccess {
                if let resValue = response.result.value {
                    let catJSON: JSON = JSON(resValue)
                    print(catJSON)

                    

                    let myString = catJSON["fact"].stringValue

                    let data = myString.data(using: String.Encoding.ascii)

                    guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return }

                    qrFilter.setValue(data, forKey: "inputMessage")

                    guard let qrImage = qrFilter.outputImage else { return }
                    let transform = CGAffineTransform(scaleX: 10, y: 10)
                    let scaledQrImage = qrImage.transformed(by: transform)
                    
                    // Get a CIContext
                    let context = CIContext()
                    // Create a CGImage *from the extent of the outputCIImage*
                    guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return }
                    // Finally, get a usable UIImage from the CGImage
                    let processedImage = UIImage(cgImage: cgImage)
                    
                    self.qrView.image = processedImage
                    
                    let detector:CIDetector=CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])!
                    let ciImage = CIImage(cgImage: cgImage)
                    var qrCodeString=""
                    
                    let features=detector.features(in: ciImage)
                    for feature in features as! [CIQRCodeFeature] {
                        qrCodeString += feature.messageString!
                    }
                    
                    if qrCodeString=="" {
                        print("nothing")
                    }else{
                        print("message: \(qrCodeString)")
                        self.labelFact.text = qrCodeString
                    }    
                    
                    self.iotButton.isHidden = false
                }
            }else {
                
                print("Error getting data")
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "catToIOT"{
            
            let destinationVC = segue.destination as! IOTViewController
            
            destinationVC.token = token
        }
    }

}
