//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by Tairone Dias on 21/04/19.
//  Copyright © 2019 DiasDevelopers. All rights reserved.
//
//  PARA IDENTAR O CÓDIGO UTILIZAR CTRL + I

import UIKit
import Firebase

class CadastroViewController: UIViewController {
    
    @IBOutlet weak var campoEmail: UITextField!
    @IBOutlet weak var campoNome: UITextField!
    @IBOutlet weak var campoPassword: UITextField!
    @IBOutlet weak var campoConfirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.campoEmail.becomeFirstResponder()
    }
    
    @IBAction func btnCriarConta(_ sender: Any) {
        
        if let email = self.campoEmail.text {
            if let nomeCompleto = self.campoNome.text {
                if let password = self.campoPassword.text {
                    if let confirmPassword = self.campoConfirmPassword.text {
                        
                        if email.contains("@") {
                            if nomeCompleto != "" {
                                if password == confirmPassword {
                                    
                                    Auth.auth().createUser(withEmail: email, password: password) { (resultUser, error) in
                                        if error == nil {
                                            if resultUser == nil {
                                                self.alertMessage(titulo: "Erro autenticação", msg: "Problema ao realizar a autenticação, tente novamente!", nameBtn: "Cancelar")
                                            } else {
                                                
                                                let database = Database.database().reference()
                                                let usuarios = database.child("usuarios")
                                                
                                                let userDic = ["nome": nomeCompleto, "email": email]
                                                usuarios.child(resultUser!.user.uid).setValue(userDic)
                                                
                                                // REALMENTE CRIOU A CONTA E VAI REDIRECIONAR PARA A TELA PRINCIPAL
                                                self.performSegue(withIdentifier: "cadastroLoginSegue", sender: nil)
                                            }
                                            
                                        } else {
                                            // ERRO DIVERSOS
                                            let erroRec = error! as NSError
                                            if let nameError = erroRec.userInfo["error_name"] {
                                                
                                                let erroTexto = nameError as! String
                                                var msgErro: String = ""
                                                
                                                switch erroTexto {
                                                case "ERROR_INVALID_EMAIL":
                                                    msgErro = "E-mail inválido, digite um e-mail válido!"
                                                    break
                                                case "ERROR_EMAIL_ALREADY_IN_USE":
                                                    msgErro = "Esse e-mail já está sendo utilizado, crie a conta com outro endereço de  e-mail!"
                                                    break
                                                case "ERROR_WEAK_PASSWORD":
                                                    msgErro = "Senha fraca, digite uma senha com no mínimo 6 caracteres!"
                                                    break
                                                default:
                                                    msgErro = "Erro desconhecido! Contate o desenvolvedor..."
                                                }
                                                
                                                self.alertMessage(titulo: "Dados inválidos", msg: msgErro, nameBtn: "OK")
                                            }
                                            
                                        }
                                    }
                                    
                                } else {
                                    resetCampos(option: 2)
                                    self.alertMessage(titulo: "Cadastro", msg: "Senhas não conferem! Por favor, insira novamente!", nameBtn: "OK")
                                }
                            } else {
                                self.alertMessage(titulo: "Erro", msg: "Digite seu nome para prosseguir!", nameBtn: "OK")
                            }
                            
                        } else {
                            resetCampos(option: 1)
                            self.alertMessage(titulo: "Cadastro", msg: "Não é um e-mail válido!", nameBtn: "OK")
                        }
                        
                    }
                }
            }
        }
        
    }
    
    func alertMessage(titulo: String, msg: String, nameBtn: String) {
        let alerta = Alerta(titulo: titulo, mensagem: msg, nameBtn: nameBtn)
        present(alerta.getAlerta(), animated: true, completion: nil)
    }
    
    func resetCampos(option: Int) {
        if option == 1 {
            self.campoEmail.text = ""
            self.campoEmail.becomeFirstResponder()
        } else if option == 2 {
            self.campoPassword.text = ""
            self.campoConfirmPassword.text = ""
            self.campoPassword.becomeFirstResponder()
        } else if option == 3 {
            self.campoEmail.text = ""
            self.campoPassword.text = ""
            self.campoConfirmPassword.text = ""
            self.campoEmail.becomeFirstResponder()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
