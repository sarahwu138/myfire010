//
//  ViewController.swift
//  myfire010
//
//  Created by sarahwu on 2/5/18.
//  Copyright © 2018 sarahwu. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    //try a source control
    var persons:[String] = [];;
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    var handle:AuthStateDidChangeListenerHandle?;
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goMenu"{
            
            let navi = segue.destination as! UINavigationController;
            let menuController = navi.viewControllers.first as! MenuViewController;
            menuController.user = sender as? User;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        handle = Auth.auth().addStateDidChangeListener {
            (auth:Auth, user:User?) in
            if let user = user{
                print("new the state listener user is:\(user.email!)");
            }
        }
        
        print("add is the handle of \(handle)");
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        prepare();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        
            Auth.auth().removeStateDidChangeListener(handle!)
        
        print("remove user :\(handle)")
        
    }
    
    func prepare(){
        emailTxt.placeholder = "Email";
        passwordTxt.placeholder = "Password";
    
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
        guard emailTxt.text?.isEmpty == false &&
              passwordTxt.text?.isEmpty == false else {
            print("empty data");
            return;
        }
        
        Auth.auth().signIn(withEmail: emailTxt.text!, password: passwordTxt.text!) {
            (user:User?, error:Error?) in
            guard error == nil else{
                print("error:\(error?.localizedDescription)");
                return;
            }
            if let user = user{
                
                print("the user:\(user.email!) log in");
                self.performSegue(withIdentifier: "goMenu", sender: user);

            }
            
        }
        self.resignFirstResponderFunc();
        prepare();
        
        
        
    }
    
    @IBAction func registerBtn(_ sender: UIButton) {
        
        guard emailTxt.text?.isEmpty == false &&
              passwordTxt.text?.isEmpty == false else {
            print("empty data");
            return;
        }
        
        Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!) { (user:User?, error:Error?) in
            
            guard error == nil else{
                print("error:\(error?.localizedDescription)");
                return;
            }
            if let currentUser  = Auth.auth().currentUser{
                if let currentUserEmail = currentUser.email{
                    
                     print("\(currentUserEmail) register successfully");
                }
            }
            
            
        }
        
        self.resignFirstResponderFunc();
        self.prepare();
        
       
        
    }
    func resignFirstResponderFunc(){
        
        emailTxt.resignFirstResponder();
        passwordTxt.resignFirstResponder();
    }

}

