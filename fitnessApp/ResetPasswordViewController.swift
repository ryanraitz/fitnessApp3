//
//  ResetPasswordViewController.swift
//  fitnessApp
//
//  Created by Ryan Raitz on 11/24/19.
//  Copyright © 2019 Ryan Raitz. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class ResetPasswordViewController : UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var resetPasswordTextField: UITextField!
    
    @IBOutlet weak var confirmationLabel: UILabel!
    
    //Function to send a password reset link to user
    @IBAction func resetPasswordButton(_ sender: Any)
    {
        //Check to see if there is an account under the given email
        Auth.auth().fetchSignInMethods(forEmail: resetPasswordTextField.text!, completion: { (stringArray, error) in
            if error != nil
            {
                self.confirmationLabel.text = error!.localizedDescription
            }
            else
            {
                if stringArray == nil
                {
                    self.confirmationLabel.text = "No active account under this email"
                }
                else
                {
                    Auth.auth().sendPasswordReset(withEmail: self.resetPasswordTextField.text!)
                    { error in
                        
                          if (error == nil)
                          {
                            self.confirmationLabel.text = "Password reset link sent to " + self.resetPasswordTextField.text!
                          }
                          else
                          {
                            self.confirmationLabel.text = "Error sending link to " + self.resetPasswordTextField.text!
                          }
                    }
                }
            }
        })
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Navigation bar styling
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemBlue]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        //Title label styling
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 10, height: 10)
        titleLabel.layer.shadowRadius = 10
        titleLabel.layer.shadowOpacity = 1.0
        
        //Reset password text field styling
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 0, y: resetPasswordTextField.frame.height-2, width: resetPasswordTextField.frame.width, height: 2)
        bottomLine1.backgroundColor = UIColor.white.cgColor
        resetPasswordTextField.borderStyle = .none
        resetPasswordTextField.layer.addSublayer(bottomLine1)
        self.resetPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Enter Email to Receive Password Reset Link", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }

}
