//
//  ViewController.swift
//  ChallengeAccepted
//
//  Created by Clare Casey on 12/7/20.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController {
    var score = 0
    var password = "Password"
    var email = "123@gmail.com"

    
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
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
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
}

