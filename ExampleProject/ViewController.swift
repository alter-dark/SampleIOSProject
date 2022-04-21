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
        let request = NetworkRequests()
        
        let result = request.dataTaskNetwork(urlString: "https://httpbin.org/get?param1=val1&param2=val2")
        responseTextView.text = result["data"] as? String ?? ""
    }
    
    class SecondViewController : UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .red
            title = "Welcome to your dashboard"
        }
    }
}

