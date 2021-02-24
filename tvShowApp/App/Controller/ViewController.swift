//
//  ViewController.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 22/2/21.
//

import UIKit

extension UIViewController {
    
    func pushToViewController <T: UIViewController>(controller:T,animated:Bool) {
        navigationController?.pushViewController(controller, animated: animated)
    }
}

