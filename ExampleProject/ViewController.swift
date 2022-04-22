//
//  ViewController.swift
//  ExampleProject
//
//  Created by John on 4/16/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var userTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    
    @IBOutlet var responseTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LoginVC"
        
        // Do any additional setup after loading the view.
    }


    @IBAction func btnLogin_touchup(_ sender: UIButton) {
        
        let targetVC = SecondViewController()
        let username = "darky", pass = "dk2022@"
        
        if (userTextField.text == username
            && passTextField.text == pass)
        {
            navigationController?.pushViewController(targetVC, animated: true)
        }else {
            print("Credentials are invalid")
        }
    }
    
    
    @IBAction func btnGet_touchup(_ sender: Any) {
        makeSomeNetworkCall()
    }
    
    func makeSomeNetworkCall() {
        let urlString = "https://httpbin.org/get?param1=val1&param2=val2"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            DispatchQueue.main.async {
                let dataString = data?.base64EncodedString() ?? ""
                if let encodedData = Data(base64Encoded: dataString) {
                    if let decodedData = String(data: encodedData, encoding: .utf8) {
                        self.responseTextView.text = decodedData
                        self.responseTextView.accessibilityLabel = "RequestDone"
                    }
                }
            }
        }.resume()
    }
    
    class SecondViewController : UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .red
            title = "Welcome to your dashboard"
        }
    }
}

