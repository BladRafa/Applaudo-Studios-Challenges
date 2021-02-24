//
//  Extras.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 23/2/21.
//

import UIKit

extension UIApplication {

    static func topViewController() -> UIViewController? {
        return UIApplication.shared.windows.first!.rootViewController
    }
}

extension UINavigationBar {
    
    func renderlogo() {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: frame.height))
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: Constants.App.logoHeader)
        img.center.x = center.x
        addSubview(img)
    }
}

extension UserDefaults {
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }

    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key)
    }
}

