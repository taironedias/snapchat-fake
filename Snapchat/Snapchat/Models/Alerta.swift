//
//  Alerta.swift
//  Snapchat
//
//  Created by Tairone Dias on 20/05/19.
//  Copyright © 2019 DiasDevelopers. All rights reserved.
//

import UIKit

class Alerta {
    var titulo: String
    var mensagem: String
    var nameBtn: String
    
    init(titulo: String, mensagem: String, nameBtn: String) {
        self.titulo = titulo
        self.mensagem = mensagem
        self.nameBtn = nameBtn
    }
    
    func getAlerta() -> UIAlertController {
        let alerta = UIAlertController(title: self.titulo, message: self.mensagem, preferredStyle: .alert)
        let action = UIAlertAction(title: self.nameBtn, style: .default, handler: nil)
        alerta.addAction(action)
        
        return alerta
    }
    
    func setAlerta(titulo: String, mensagem: String, nameBtn: String) {
        self.titulo = titulo
        self.mensagem = mensagem
        self.nameBtn = nameBtn
    }
}
