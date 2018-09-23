//
//  LoginVC.swift
//  FideliCash-Cliente
//
//  Created by Carlos Doki on 09/06/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet var loginView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        loginView.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 50, width: loginView.frame.width - 32, height: 50)
        loginButton.delegate = self
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        print("Sucessfully logged in with Facebook...")
        let credentials = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signIn(with: credentials, completion: { (user, error) in
            if let err = error {
                print("Failed to create a Firebase User", err)
                return
            }
            
            guard let uid = user?.uid else { return }
            userUUID = uid
            let ref = Database.database().reference()
            let users = ref.child("users").child(uid)
            users.child("cpf").setValue("")
            users.child("IDFacebook").setValue(user?.uid)
            users.child("nome").setValue(user?.displayName)
            users.child("fcmTokennotification").setValue(fcmTokennotification)
            
            let keychainResult = KeychainWrapper.standard.set((user?.uid)!, forKey: KEY_UID)
            print("DOKI: Data saved to keychain \(keychainResult)")
            
            print("Firebase user created", uid)
            self.performSegue(withIdentifier: "menuinicial", sender: nil)

        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did logout Facebook")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //let defaults = UserDefaults.standard
        //defaults.set("54FjYF8UwBS5IVbeitX9Pq6IbfF3", forKey: "authVID")
        //let keychainResult = KeychainWrapper.standard.set(("54FjYF8UwBS5IVbeitX9Pq6IbfF3"), forKey: KEY_UID)

        
        if let user = KeychainWrapper.standard.string(forKey: KEY_UID) {
            userUUID = user
            print("DOKI: ID found in keychain")
            performSegue(withIdentifier: "menuinicial", sender: nil)
        } else {
        }
    }
}

