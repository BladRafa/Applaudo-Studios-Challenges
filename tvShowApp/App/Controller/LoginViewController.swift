//
//  LoginViewController.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 23/2/21.
//

import UIKit
import Combine

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private let notificationcenter = NotificationCenter.default
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private var subscribirse = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false
        guard AppData.sharedData.getToken() == "" else {
              let controller = self.storyboard?.instantiateViewController(withIdentifier: Constants.App.home) as! HomeViewController
              pushToViewController(controller: controller, animated: false)
              return
          }
          guard Utilities.hasInternet() else {
            self.alert(message: Constants.App.NoInternetText, title:Constants.App.msgInfo)
              return
          }
        self.userTextField.delegate = self
        self.passWordTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        navigationController?.navigationBar.isHidden = true
        self.observeTextField()
        // Do any additional setup after loading the view.
    }

    
    private func observeTextField(){
        
        notificationcenter.publisher(for: UITextField.textDidChangeNotification, object: userTextField).sink(receiveValue:{
            guard let texfield = $0.object as? UITextField else {return}
            let text = texfield.text
            print(text ?? "")
            self.enableButton()
        }).store(in: &subscribirse)
        
        
        notificationcenter.publisher(for: UITextField.textDidChangeNotification, object: passWordTextField).sink(receiveValue:{
            guard let texfield = $0.object as? UITextField else {return}
            
            let text = texfield.text
            print(text ?? "")
            self.enableButton()
        }).store(in: &subscribirse)
    }
    
    func enableButton(){
        if passWordTextField.text != "" && passWordTextField.text != "" {
            loginButton.isEnabled = true
        }else{
            loginButton.isEnabled = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet(charactersIn: " ")) == nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        var keyboardFrame:CGRect = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        guard view.frame.origin.y == 0 else { return }
        view.frame.origin.y = -keyboardFrame.height * 0.5
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        view.frame.origin.y = 0
    }
    
    private func validations() -> Bool {
        guard userTextField.text == "" || passWordTextField.text == "" || passWordTextField.text!.count < 6  else {return true }
        self.alert(message: Constants.Login.msgCredentials, title:Constants.App.msgWarning)
        return false
    }
    
    @IBAction func login(_ sender: Any) {
        guard !validations() else {
            requestToken(user: userTextField.text ?? "", pass: passWordTextField.text ?? "")
            return
        }
    }
    
    
    // MARK: Requests
    private func requestToken(user:String, pass:String) {
        guard Utilities.hasInternet() else {
            self.alert(message: Constants.App.NoInternetText, title:Constants.App.msgInfo)
            return
        }
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        TokenWS().getToken(completion: { (token,error) in
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            guard error == nil else {
                self.alert(message: Constants.App.GeneralErrorText, title:Constants.App.msgError)
                return
            }
            if let success = token?.success {
                if success {
                    self.requestAuth(user: user, pass: pass, tkn: token?.requestToken ?? "")
                } else {
                    self.alert(message: token?.statusMessage ?? "", title:Constants.App.msgError)

                }
            }
        })
    }

    private func requestAuth(user:String, pass:String, tkn:String) {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: self.view)
            AuthWS().postLogin(user: user, pass: pass, token: tkn, completion: { (token,error) in
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
                DispatchQueue.main.async {
                    guard error == nil else {
                        self.alert(message: Constants.App.GeneralErrorText, title:Constants.App.msgError)
                        return
                    }
                    guard token?.statusMessage == nil else {
                        self.alert(message: token?.statusMessage ?? "", title:Constants.App.msgError)
                        return
                    }
                    DispatchQueue.main.async {
                        AppData.sharedData.saveToken(requestToken: token?.requestToken ?? "", expiresAt: String(token?.expiresAt ?? ""))
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: Constants.App.home) as! HomeViewController//CollectionViewController
                        self.pushToViewController(controller: controller, animated: true)
                    }
                  }
             })
            }
        }
    }



//extension UIViewController {
//    func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        for (index, title) in actionTitles.enumerated() {
//            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
//            alert.addAction(action)
//        }
//        self.present(alert, animated: true, completion: nil)
//    }
//}

