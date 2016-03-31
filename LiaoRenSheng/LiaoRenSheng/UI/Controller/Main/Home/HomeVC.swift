//
//  HomeVC.swift
//  LiaoRenSheng
//
//  Created by Wei on 3/29/16.
//  Copyright © 2016 Wei. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBAction func createBook(sender: AnyObject) {
//        let user:Client = BackendUtilities.sharedInstance.bookRepo.createUserWithEmail(EmailTextField.text!, password: PasswordTextField.text!) as! Client
        
        let newBook:Book?
        newBook = BackendUtilities.sharedInstance.bookRepo.modelWithDictionary(nil) as? Book
        newBook!.name = "somebook"
//        newBook?.saveWithSuccess({ () -> Void in
//            NSLog("Successfully created new Widget")
//            }, failure: { (error: NSError!) -> Void in
//                 NSLog(error.description)
//        })
        
        BackendUtilities.sharedInstance.bookRepo.allWithSuccess({ ( books : [AnyObject]!) -> Void in
            NSLog("Successfully created new Widget")
            }) { (error: NSError!) -> Void in
                NSLog(error.description)

        }
        
        
    
    }
}
