//
//  MainController.swift
//  AutoTutorial
//
//  Created by Tula Ram Subba on 5/3/17.
//  Copyright © 2017 Tula Ram Subba. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MainController: UIViewController {
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var myShadowView: UIView!
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    var menuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myScrollView.contentSize.height = 1000
        myShadowView.layer.shadowOpacity = 1
        myShadowView.layer.shadowRadius = 6
        let url=URL(string: "http://mentor-mentee-app.herokuapp.com/")
        myWebView.loadRequest(URLRequest(url: url!))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutTapped(_ sender: UIButton) {
        
        do {
            try FIRAuth.auth()?.signOut()
            dismiss(animated: true, completion: nil)
            
        } catch {
            print("There was a problem logging out")
        }
    }
  
 // It can hide and show the menu 
    @IBAction func openMenu(_ sender: Any) {
        if (menuShowing) {
            leadingConstraint.constant = -250
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else {
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })

        }
        menuShowing = !menuShowing
    }
    
//It allows to load the page by showing indicator
    func webViewDidStartLoad(_ : UIWebView) {
        
        myActivityIndicator.startAnimating()
        
    }
    
    func webViewDidFinishLoad(_ : UIWebView) {
        
        myActivityIndicator.stopAnimating()
        
    }

}
