//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Tairone Dias on 18/05/19.
//  Copyright © 2019 DiasDevelopers. All rights reserved.
//

import UIKit
import FirebaseAuth

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSair(_ sender: Any) {
        let autenticacao = Auth.auth()
        
        do {
            try autenticacao.signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            print("Erro ao deslogar do usuário")
        }
    }

}
