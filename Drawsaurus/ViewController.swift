//
//  ViewController.swift
//  Drawsaurus
//
//  Created by Shark on 2015-08-09.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Parse

class ViewController: UIViewController {
    let permissions = ["public_profile", "email", "user_friends"]
    
    @IBAction func didTapFacebookConnect(sender: AnyObject) {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions,  block: {  (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    println("User signed up and logged in through Facebook!")
                } else {
                    println("User logged in through Facebook!")
                }
            } else {
                println("Uh oh. The user cancelled the Facebook login.")
            }
        })
    }
    
    @IBAction func didTapFacebookLogout(sender:AnyObject) {
        if PFUser.currentUser() != nil {
            PFUser.logOut()
            println("User logs out")
        }
    }
    
    @IBAction func showMainView(sender: UIButton) {
        if (PFUser.currentUser() != nil) {
            performSegueWithIdentifier("SegueToMain", sender: self)
        }
    }
    @IBAction func logoutUser(sender: UIButton) {
        if (PFUser.currentUser() != nil) {
            println("log out success")
            PFUser.logOut()
            showLoginSignup()
        }
    }
    
    func showLoginSignup() {
        var loginAlert: UIAlertController = UIAlertController(title: "Sign Up / Login", message: "Please sign up or login", preferredStyle: UIAlertControllerStyle.Alert)
        loginAlert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Your username"
        }
        loginAlert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Your password"
            textField.secureTextEntry = true
        }
        
        loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
            let textFields: NSArray = loginAlert.textFields!
            let usernameTextField: UITextField = textFields[0] as! UITextField
            let passwordTextField: UITextField = textFields[1] as! UITextField
            
            PFUser.logInWithUsernameInBackground(usernameTextField.text, password: passwordTextField.text, block: { (user, error) -> Void in
                if (user != nil) {
                    println("login success")
                    self.performSegueWithIdentifier("SegueToMain", sender: self)
                } else {
                    println("login failed")
                }
            })
        }))
        
        loginAlert.addAction(UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler: { (actionAlert) -> Void in
            let textFields: NSArray = loginAlert.textFields!
            let usernameTextField: UITextField = textFields[0] as! UITextField
            let passwordTextField: UITextField = textFields[1] as! UITextField
            
            let user: PFUser = PFUser()
            user.username = usernameTextField.text
            user.password = passwordTextField.text
            
            user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                if (error == nil) {
                    println("sign up success")
                    self.performSegueWithIdentifier("SegueToMain", sender: self)
                } else {
                    let errorString = error?.userInfo?["error"] as? String
                    println(errorString)
                }
            })
        }))
        
        self.presentViewController(loginAlert, animated: true, completion: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if (PFUser.currentUser() == nil) {
            self.showLoginSignup()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
        
        
// Add fb button
//        if (FBSDKAccessToken.currentAccessToken() == nil) {
//            println("Not logged in")
//        } else {
//            println("Logged in")
//        }
//        
//        var loginButton = FBSDKLoginButton()
//        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
//        loginButton.center = self.view.center
//        
//        loginButton.delegate = self
//        self.view.addSubview(loginButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
//add FB login and logout functions
//    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
//        if (error == nil) {
//            println("Login complete")
//        } else {
//            println("Login failed")
//        }
//    }
//    
//    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
//        println("User did log out")
//    }

}

