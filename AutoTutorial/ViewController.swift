//
//  ViewController.swift
//  AutoTutorial
//
//  Created by Tula Ram Subba on 5/3/17.
//  Copyright © 2017 Tula Ram Subba. All rights reserved.
//

import UIKit
import Firebase //to access firebase to app
import FirebaseAuth //to autorise from firebase
import FBSDKLoginKit // to access facebook login
import GoogleSignIn  // to access google login
import LocalAuthentication

class ViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFacebookButtons()
        setupGoogleButtons()
    }
    
    //it helps to place google button on the login screen.
    fileprivate func setupGoogleButtons() {
                let googleButton = GIDSignInButton()
                googleButton.frame = CGRect(x: 16, y: 500, width: view.frame.width - 32, height: 40)
                view.addSubview(googleButton)
        
                GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    //it helps to place google button on the login screen.
    fileprivate func setupFacebookButtons() {
                let loginButton = FBSDKLoginButton()
                view.addSubview(loginButton)
                loginButton.frame = CGRect(x: 16, y: 450, width: view.frame.width - 32, height: 40)
        
                loginButton.delegate = self
        
                loginButton.readPermissions = ["email", "user_friends", "public_profile"]
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("DId log out of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        showEmailAddress()
    }
    
    func showEmailAddress() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else
        { return }
        
        let credentials = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
        FIRAuth.auth()?.signIn(with: credentials, completion: {(user, error) in
            if error != nil {
                print("Something went wrong in FB user: ", error ?? "")
                return
            }
            print("Successfully logged in with user: ", user ?? "")
            self.viewDidAppear(true)
            
        })
    
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start {
            (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:", err ?? "")
                return
            }
            print(result ?? "")
        }
    }
   //after authenticating from facebook and google login it directly goes to homepage
    override func viewDidAppear(_ animated: Bool) {
        
        if FIRAuth.auth()?.currentUser != nil {
            self.performSegue(withIdentifier: "goToHome", sender: self)

        }
    }
    

    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        isSignIn = !isSignIn
        
        if isSignIn {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        }
        else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
    }
   
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            if isSignIn {
                FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                    if let u = user {
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                        
                    }
                    else {
                        //Error: check error and show message
                        print("Password is wrong")
                    }
                })
            }
            else {
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                    if let u = user {
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                        
                    }
                })
            }
            
        }
        
        let myContext = LAContext()
        var authError: NSError? = nil
        if myContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            myContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate to log into your MinedMinds account") { (success, evaluateError) in
                if (success) {
                    //User authenticated successfully.
                    print ("TouchID is authenticated successfully.")
                } else {
                    //User did not authenticated successfully.
                    print ("TouchID Do not Authenticate")
                }
            }
        } else {
            //Could not evaluate policy; look at authError and present an appropriate message to user
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
   }
