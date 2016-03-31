//
//  BookRepository.swift
//  LiaoRenSheng
//
//  Created by Wei on 3/29/16.
//  Copyright © 2016 Wei. All rights reserved.
//

import Foundation

class BookRepository: LBPersistedModelRepository {
    
    override init() {
        super.init(className: "Books")
    }
    
    class func repository() -> BookRepository {
        return BookRepository()
    }

}
class Book : LBPersistedModel {
    
    var name: String!
}