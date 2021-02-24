//
//  TokenModel.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 22/2/21.
//

import UIKit
import RealmSwift

struct Token {
    
    var success: Bool?
    var expiresAt: String?
    var requestToken: String?
    var statusMessage: String?
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.expiresAt = attributes["expires_at"] as? String
        self.requestToken = attributes["request_token"] as? String
        self.statusMessage = attributes["status_message"] as? String
    }
}

class pToken:Object {
    @objc dynamic var token: String?
    @objc dynamic var expiresAt: String?
    
    override static func primaryKey() -> String? {
        return "token"
    }
}
