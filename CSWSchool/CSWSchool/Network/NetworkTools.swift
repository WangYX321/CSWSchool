//
//  File.swift
//  CSWSchool
//
//  Created by wyx on 2018/1/20.
//  Copyright © 2018年 com.cswSchool. All rights reserved.
//

import Foundation
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        
        if type == .post {
            Alamofire.request(URLString, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
                
                // 3.获取结果
                guard let result = response.result.value else {
                    print(response.result.error!)
                    return
                }
                
                // 4.将结果回调出去
                finishedCallback(result)
            }
        } else {
            Alamofire.request(URLString, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
                
                // 3.获取结果
                guard let result = response.result.value else {
                    print(response.result.error!)
                    return
                }
                
                // 4.将结果回调出去
                finishedCallback(result)
            }
        }
    }
}
