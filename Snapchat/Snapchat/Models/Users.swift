//
//  Users.swift
//  Snapchat
//
//  Created by Tairone Dias on 20/05/19.
//  Copyright © 2019 DiasDevelopers. All rights reserved.
//

import Foundation

class User {
    
    var email: String
    var nome: String
    var uid: String
    
    init(email: String, nome: String, uid: String) {
        self.email = email
        self.nome = nome
        self.uid = uid
    }
}
