//
//  ViewController.swift
//  Snapchat
//
//  Created by Tairone Dias on 21/04/19.
//  Copyright © 2019 DiasDevelopers. All rights reserved.
//
//  PARA IDENTAR O CÓDIGO UTILIZAR CTRL + I

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.areLogged()
        
    }
    
    func areLogged() {
        let autenticacao = Auth.auth()
        autenticacao.addStateDidChangeListener { (auth, usuario) in
            if let user = usuario {
                
                var usuarioLogado = user.email as! String
                usuarioLogado = String(usuarioLogado.split(separator: "@")[0])
                print("Bem vindo " + usuarioLogado + "!")
                
                self.performSegue(withIdentifier: "loginAutoSegue", sender: nil)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
}

