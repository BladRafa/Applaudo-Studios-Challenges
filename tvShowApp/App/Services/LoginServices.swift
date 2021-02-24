//
//  LoginServices.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 22/2/21.
//

import UIKit

struct TokenWS {
    
    func getToken(completion: @escaping (Token?, _ error: Error?)->()) {
        
        let url = Constants.WS.baseURL.rawValue + Constants.WS.version.rawValue + Constants.WS.token.rawValue + Constants.WS.apiKey.rawValue
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            completion(Token(attributes: data), nil)
        }
    }
}

struct AuthWS {
    
    func postLogin(user:String,pass:String,token:String,completion: @escaping (Token?, _ error: Error?)->()) {
        let login: [String: Any] = [
            "username": user,
            "password": pass,
            "request_token": token
        ]
        let url = Constants.WS.baseURL.rawValue + Constants.WS.version.rawValue + Constants.WS.auth.rawValue + Constants.WS.apiKey.rawValue
        RequestManager.sharedService.requestAPI(url: url, parameter: login as [String : Any], httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            completion(Token(attributes: data), nil)
        }
    }
}
