//
//  ViewController.swift
//  CSWSchool
//
//  Created by wyx on 2018/1/18.
//  Copyright © 2018年 com.cswSchool. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTf: UITextField!
    
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loading.isHidden = true
    }

    @IBAction func loginAction(_ sender: UIButton) {
        loading.isHidden = false
        loading.startAnimating()
        loginBtn.isHidden = true
        let dic = ["From" : "",
                   "InterfaceSource" : "WebApp",
                   "Password" : "159632",
                   "Username" : "jzhang2019",
                   "remember" : false] as [String : Any]
        NetworkTools.requestData(.post, URLString: "https://csw.myschoolapp.com/api/SignIn", parameters: dic) { (result) in
//            print(result)
            if let dictionary = result as? Dictionary<String,AnyObject> {
                if let s = dictionary["LoginSuccessful"] {
                    if s.int8Value == 1 {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarcontroller") as! UITabBarController
                        UIApplication.shared.keyWindow?.rootViewController = viewController
                    } else {
                        self.loading.stopAnimating()
                        self.loading.isHidden = true
                        self.loginBtn.isHidden = false
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

