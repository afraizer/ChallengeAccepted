//
//  PasswordlessViewController.swift
//  ChallengeAccepted
//
//  Created by Clare Casey on 12/14/20.
//

import UIKit
import FirebaseAuth
import Firebase

class PasswordlessViewController: UIViewController {
    var score = 0
    var password = "Password"
    var email = "123@gmail.com"
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet var showMessagePrompt: UILabel!
    @IBOutlet var LoginButton: UIButton!
    @IBOutlet var RegisterButton: UIButton!
    var link: String!
    
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
        /*
        Auth.auth().sendSignInLink(toEmail:email, actionCodeSettings: actionCodeSettings) { error in
            if let error = error {
                self.showMessagePrompt.text = "\(error.localizedDescription)"
              return
            }
            // The link was successfully sent. Inform the user.
            // Save the email locally so you don't need to ask the user for it again
            // if they open the link on the same device.
            UserDefaults.standard.set(self.email, forKey: "Email")
            self.showMessagePrompt.text = "Check your email for link"
            // ...
            Auth.auth().signIn(withEmail: email, link: self.link) { (user, error) in
                if let error = error {
                    self.showMessagePrompt.text = error.localizedDescription
                    return
                }
                self.navigationController!.popViewController(animated: true)
            }
        }
 */
        Auth.auth().createUser(withEmail: emailText, password: passwordText) { authResult, error in
            if let authResult = authResult {
                print("auth result \(authResult)")
            }
            if let error = error {
                print("error \(error)")
            }
        }
    }
    /*
    // passes the place through the UIStoryboardSegue
    // takes in sender of type any and a segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "ShowTableView" {
                if let tableVC = segue.destination as? ViewController {
                    print("logging in without email")
                    tableVC.email = "123@gmail.com"
                }
            }
        }
    }
    */
    func unwrapVars(inputString: String?) -> String {
        if let input = inputString {
            return input
        }
        return "password"
    }
 
}

