//
//  BackendUtilities.swift
//  LiaoRenSheng
//
//  Created by Wei on 3/28/16.
//  Copyright © 2016 Wei. All rights reserved.
//

import Foundation

class BackendUtilities  {
    let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate!)
    let DEFAULTS_CURRENT_USER_ID_KEY: String = "LBUserRepositoryCurrentUserId"
    var adapter: LBRESTAdapter
    var clientRepo: ClientRepository
    var bookRepo: BookRepository
    
    static let sharedInstance = BackendUtilities()
    
    init() {
        adapter = appDelegate.adapter as LBRESTAdapter!
        clientRepo = adapter.repositoryWithClass(ClientRepository) as! ClientRepository
        bookRepo = adapter.repositoryWithClass(BookRepository) as! BookRepository
    }
}
