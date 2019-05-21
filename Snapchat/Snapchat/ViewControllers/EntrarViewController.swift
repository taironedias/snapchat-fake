//
//  EntrarViewController.swift
//  Snapchat
//
//  Created by Tairone Dias on 21/04/19.
//  Copyright © 2019 DiasDevelopers. All rights reserved.
//

import UIKit
import FirebaseAuth

class EntrarViewController: UIViewController {

    @IBOutlet weak var campoEmail: UITextField!
    @IBOutlet weak var campoPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.campoEmail.becomeFirstResponder()
    }
    
    @IBAction func bntEntrar(_ sender: Any) {
        // Recuperar dados digitados
        if let email = self.campoEmail.text {
            if let password = self.campoPassword.text {
                
                let autenticacao = Auth.auth()
                autenticacao.signIn(withEmail: email, password: password) { (resultUsuario, error) in
                    
                    if error == nil {
                        if resultUsuario != nil {
                            self.campoEmail.text = ""
                            self.campoPassword.text = ""
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        } else {
                            self.alertaMessage(titulo: "Erro ao autenticar", msg: "Problema ao realizar autenticação, tente novamente mais tarde!", nameBtn: "Cancelar")
                        }
                        
                    } else {
                        self.alertaMessage(titulo: "Dados incorretos", msg: "Verifique os dados digitados e tente novamente!", nameBtn: "OK")
                    }
                    
                }
                
            }
        }
        
    }
    
    func alertaMessage(titulo: String, msg: String, nameBtn: String) {
        let alerta = Alerta(titulo: titulo, mensagem: msg, nameBtn: nameBtn)
        present(alerta.getAlerta(), animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

}
