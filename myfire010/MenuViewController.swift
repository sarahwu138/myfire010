//
//  MenuViewController.swift
//  myfire010
//
//  Created by sarahwu on 2/5/18.
//  Copyright © 2018 sarahwu. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UITableViewController,OneViewControllerDelegate {
   
    var menuList = ["One","Two"];
    var user:User? = nil;
    var ref = Database.database().reference();
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goOne"{
            let oneController = segue.destination as! OneViewController;
            oneController.delegate = self;
            
        
        }
        
        if segue.identifier == "goChat"{
            
            let chatController = segue.destination as! ChatViewController;
            
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.user != nil {
            if let email = self.user?.email{
                self.title = String(email);
                
            }
            if let currentUser = Auth.auth().currentUser{
                let email = currentUser.email;
                print("email:\(email!)");
            }
        }

    }

   
    @IBAction func cancelBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil);
    }
    
    
    
    //MARK:-OneViewControllerDelegate
    
     func bringValueBack(controller: OneViewController, value: Any?) {
        
        if let value2 = value{
            
            //self.ref.child("users").child(user.uid).setValue(["username": username])
         /*
 
             let key = ref.child("posts").childByAutoId().key
             let post = ["uid": userID,
             "author": username,
             "title": title,
             "body": body]
             let childUpdates = ["/posts/\(key)": post,
             "/user-posts/\(userID)/\(key)/": post]
             ref.updateChildValues(childUpdates)
        */
            
            if let writingDic = value2 as? [String:Any]{
                
               
                
                let autoID = ref.child("posts").childByAutoId()

                
                if let numberNSNumber = writingDic["number"] as? NSNumber{
                    
                    autoID.child("number").setValue(numberNSNumber);
                    
                }
                
                if let nameString = writingDic["name"] as? String{
                    
                    autoID.child("name").setValue(nameString);
                    
                }
                
                if let deptString = writingDic["dept"] as? String{
                    
                    autoID.child("dept").setValue(deptString);
                }
                
                if let contentString = writingDic["content"] as? String{
                    
                    autoID.child("content").setValue(contentString);
                }
                
            }
            
        }
        
        self.navigationController?.popViewController(animated: true);
        
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = menuList[indexPath.row];

        return cell
    }
    //MARK:table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "goOne", sender: self);
        }else if indexPath.row == 1 {
            self.performSegue(withIdentifier: "goChat", sender: self);

        }
    }
    

}
