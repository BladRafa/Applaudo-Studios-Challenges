//
//  AppData.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 22/2/21.
//

import UIKit
import RealmSwift

class AppData {

    static let sharedData = AppData()
    var allShows = [Show]() {
        didSet {
            // Persist Data
            saveShows()
        }
    }
    var showTypeSelected:ShowType = ShowType.allShowType().first!
    
    func saveToken(requestToken:String, expiresAt:String, in realm: Realm = try! Realm(configuration: Utilities.bundleRealmConfig)) {
        let tkn = pToken()
        tkn.token = requestToken
        tkn.expiresAt = expiresAt
        do {
            try realm.write {
                realm.add(tkn, update: .all)
            }
        } catch let e as NSError {
            print(e.description)
        }
    }
    
    func getToken(in realm: Realm = try! Realm(configuration: Utilities.bundleRealmConfig)) -> String {
        let tkn = realm.objects(pToken.self)
        return tkn.first?.token ?? ""
    }
    
    func removeToken(in realm: Realm = try! Realm(configuration: Utilities.bundleRealmConfig)) {
        do {
            let token = realm.objects(pToken.self)
            try realm.write {
                realm.delete(token)
            }
        } catch let e as NSError {
            print(e.description)
        }
    }
    
    func getExpiresAt(in realm: Realm = try! Realm(configuration: Utilities.bundleRealmConfig)) -> String {
        let tkn = realm.objects(pToken.self)
        return tkn.first?.expiresAt ?? ""
    }
    
    func saveShows() {
        if let encoded = try? JSONEncoder().encode(allShows) {
            UserDefaults.standard.set(encoded, forKey: Constants.App.shows)
        }
    }
    
    func getShows() {
        if let data = UserDefaults.standard.object(forKey: Constants.App.shows) as? Data {
            if let loadedSHows = try? JSONDecoder().decode([Show].self, from: data) {
                allShows = loadedSHows
            }
        }
    }
    
    func resetData() {
        allShows.removeAll()
        UserDefaults.standard.removeObject(forKey: Constants.App.shows)
    }
}

