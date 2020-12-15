//
//  PasswordlessViewController.swift
//  ChallengeAccepted
//
//  Created by Clare Casey on 12/14/20.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController {
    var score = 0
    var password = "Password"
    var email = "123@gmail.com"
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        // Do any additional setup after loading the view.
        let db = Firestore.firestore()
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        let emailText = unwrapVars(inputString: emailField.text)
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://challengeaccepted-84b01.firebaseapp.com")
        // The sign-in operation has to always be completed in the app.
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        let passwordText = unwrapVars(inputString: passwordField.text)
        Auth.auth().createUser(withEmail: emailText, password: passwordText) { authResult, error in
            if let authResult = authResult {
                print("auth result \(authResult)")
            }
            if let error = error {
                print("error \(error)")
            }
        }
    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        print("login button pressed")
    }
    
    func unwrapVars(inputString: String?) -> String {
        if let input = inputString {
            return input
        }
        return "password"
    }
}

