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
    
    /*
    // put this in an ib action
    var ref: DocumentReference? = nil
    ref = db.collection("users").addDocument(data: [
        "first": "Ada",
        "last": "Lovelace",
        "born": 1815
    ]) { err in
        if let err = err {
            print("Error adding document: \(err)")
        } else {
            print("Document added with ID: \(ref!.documentID)")
        }
    }
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseApp.configure()
        // Do any additional setup after loading the view.
    }


}

