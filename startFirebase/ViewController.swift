//
//  ViewController.swift
//  startFirebase
//
//  Created by 阪上葵 on 2018/08/25.
//  Copyright © 2018年 ueao. All rights reserved.
//

import UIKit
// Firebase導入
import Firebase

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var messageTextField:UITextField!
    
    var databaseRef: FIRDatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
        //インスタンスを作成
        databaseRef = FIRDatabase.database().reference()
        
        databaseRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            if let name = snapshot.value!.objectForKey("name") as? String,
                let message = snapshot.value!.objectForKey("message") as? String {
                self.textView.text = "\(self.textView.text)\n\(name) : \(message)"
            }
        })
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool { //Returnキー
       
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        
        let messageData = ["name": nameTextField.text!, "message": messageTextField.text!]
        databaseRef.childByAutoId().setValue(messageData)
        
        textField.resignFirstResponder()
        messageTextField.text = ""
        
        return true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

