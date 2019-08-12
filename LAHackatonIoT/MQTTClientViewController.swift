//
//  MQTTClientViewController.swift
//  LAHackatonIoT
//
//  Created by Andres Felipe De La Ossa Navarro on 8/10/19.
//  Copyright © 2019 Andres Felipe De La Ossa Navarro. All rights reserved.
//

import UIKit
import MQTTClient

class MQTTClientViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let MQTT_HOST = "a1cf0ig3498foo-ats.iot.us-east-1.amazonaws.com" // or IP address e.g. "192.168.0.194"
    let MQTT_PORT: UInt32 = 8883
    
    private var transport = MQTTCFSocketTransport()
    fileprivate var session = MQTTSession()
    fileprivate var completion: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.session?.delegate = self
        self.transport.host = MQTT_HOST
        self.transport.port = MQTT_PORT
        session?.transport = transport
        
        updateUI(for: self.session?.status ?? .created)
        session?.connect() { error in
            print("connection completed with status \(String(describing: error))")
            if error != nil {
                self.updateUI(for: self.session?.status ?? .created)
            } else {
                self.updateUI(for: self.session?.status ?? .error)
            }
        }
    }
    
    private func updateUI(for clientStatus: MQTTSessionStatus) {
        DispatchQueue.main.async {
            switch clientStatus {
            case .connected:
                self.statusLabel.text = "Conectado"

            case .connecting,
                 .created:
                self.statusLabel.text = "Conectando..."

            default:
                self.statusLabel.text = "No hay conexión"

            }
        }
    }
    
    private func subscribe() {
        self.session?.subscribe(toTopic: "elDeiOS", at: .exactlyOnce) { error, result in
            print("subscribe result error \(String(describing: error)) result \(result!)")
        }
    }
    
    private func publishMessage(_ message: String, onTopic topic: String) {
        session?.publishData(message.data(using: .utf8, allowLossyConversion: false), onTopic: topic, retain: false, qos: .exactlyOnce)
    }
    
    
    @IBAction func publishPressed(_ sender: Any) {

        if let text = textField.text{
           
            publishMessage(text, onTopic: "elDeiOS")
        }
    }
    


}

extension MQTTClientViewController: MQTTSessionManagerDelegate, MQTTSessionDelegate {
    
    func newMessage(_ session: MQTTSession!, data: Data!, onTopic topic: String!, qos: MQTTQosLevel, retained: Bool, mid: UInt32) {
        if let msg = String(data: data, encoding: .utf8) {
            print("topic \(topic!), msg \(msg)")
        }
    }
    
    func messageDelivered(_ session: MQTTSession, msgID msgId: UInt16) {
        print("delivered")
        DispatchQueue.main.async {
            self.completion?()
        }
    }
}
