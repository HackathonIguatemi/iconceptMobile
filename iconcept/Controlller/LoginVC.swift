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
    
    @IBOutlet weak var fbButtonLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // fbButtonLoginButton.delegate = self
        //fbButtonLoginButton.readPermissions = [ "email" ]
        
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        print("Sucessfully logged in with Facebook...")
//        let credentials = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//        Auth.auth().signInAndRetrieveData(with: credentials, completion: { (user, error) in
//            if let err = error {
//                print("Failed to create a Firebase User", err)
//                return
//            }
//        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did logout Facebook")
    }
}

