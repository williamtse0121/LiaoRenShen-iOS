//
//  ClientRepository.swift
//  LiaoRenSheng
//
//  Created by Wei on 3/28/16.
//  Copyright © 2016 Wei. All rights reserved.
//

import Foundation

class ClientRepository: LBUserRepository {
    override init!(className name: String!) {
        super.init(className: "Clients")
    }
    override init() {
        super.init(className: "Clients")
    }
}

class Client: LBUser {
    
}