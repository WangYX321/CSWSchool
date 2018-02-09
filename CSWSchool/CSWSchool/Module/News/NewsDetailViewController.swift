//
//  NewsDetailViewController.swift
//  CSWSchool
//
//  Created by wyx on 2018/1/21.
//  Copyright © 2018年 com.cswSchool. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController {
    var Id = String()
    
//    convenience init(Id: String) {
//        self.Id = Id
//        super.init()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
        
        let wkWebConfig = WKWebViewConfiguration()
        let jSString = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        // 自适应屏幕宽度js
        let wkUserScript = WKUserScript(source: jSString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        // 添加自适应屏幕宽度js调用的方法
        wkWebConfig.userContentController.addUserScript(wkUserScript)
        let webView = WKWebView(frame: self.view.bounds, configuration: wkWebConfig)
        self.view.addSubview(webView)
        
//        Id = "1156165"
        let prefix_url = "https://csw.myschoolapp.com/api/news/detail/"+Id+"/?format=json"
        NetworkTools.requestData(.get, URLString: prefix_url) { (result) in
            print(result)
            if let dictionary = result as? [String:Any] {
                if let Description = dictionary["Description"] as? String {
                    let html = "<html><body>" + Description + "</body></html>"
                    webView.loadHTMLString(html, baseURL: nil)
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
