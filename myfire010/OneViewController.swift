//
//  OneViewController.swift
//  myfire010
//
//  Created by sarahwu on 2/5/18.
//  Copyright © 2018 sarahwu. All rights reserved.


import UIKit

protocol OneViewControllerDelegate {
    
    func bringValueBack(controller:OneViewController,value:Any?);
}

class OneViewController: UIViewController {

    
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var numberTxt: UITextField!
    
    
    @IBOutlet weak var deptTxt: UITextField!
    
    @IBOutlet weak var contentTxt: UITextField!
    
    var delegate:OneViewControllerDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTxt.text = "";
        deptTxt.text = "";
        numberTxt.text = "";
        contentTxt.text = "";

    }
    

    @IBAction func cancelBtn(_ sender: UIBarButtonItem) {
        
        self.delegate?.bringValueBack(controller: self, value: nil);
    }
    
    @IBAction func doneBtn(_ sender: UIBarButtonItem) {
        
        guard nameTxt.text?.isEmpty == false else {
            
            print("empty data");
            return;
            
        }
        guard numberTxt.text?.isEmpty == false else {
            
            print("empty data");
            return;
            
        }
        guard deptTxt.text?.isEmpty == false else {
            
            print("empty data");
            return;
            
        }
        guard contentTxt.text?.isEmpty == false else {
            
            print("empty data");
            return;
            
        }
        
        let dic =
            ["name":nameTxt.text!,
        "number":numberTxt.text!,
            "dept":deptTxt.text!,
        "content":contentTxt.text!];
        
        self.delegate?.bringValueBack(controller: self, value: dic);
        
    }

}
