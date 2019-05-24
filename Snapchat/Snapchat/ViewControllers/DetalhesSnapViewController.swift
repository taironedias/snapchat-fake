//
//  DetalhesSnapViewController.swift
//  Snapchat
//
//  Created by Tairone Dias on 21/05/19.
//  Copyright © 2019 DiasDevelopers. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class DetalhesSnapViewController: UIViewController {

    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var labelContador: UILabel!
    @IBOutlet weak var labelDetalhes: UILabel!
    
    var snap = Snap()
    var tempo = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelDetalhes.text = "Carregando..."
        
        let url = URL(string: self.snap.urlImagem)
        self.imagem.sd_setImage(with: url) { (imagem, error, cache, url) in
            if error != nil {
                print("Erro: \(String(describing: error))")
            } else {
                self.labelDetalhes.text = self.snap.descricao
                // Começando o contador
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                    self.tempo = self.tempo - 1
                    self.labelContador.text = String(describing: self.tempo)
                    
                    if self.tempo == 0 {
                        timer.invalidate()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        let auth = Auth.auth()
        if let idUserLogado = auth.currentUser?.uid {
            
            // Removendo o nó no banco de dados
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            let snaps = usuarios.child(idUserLogado).child("snaps")
            snaps.child(snap.idSnap).removeValue()
            
            // Removendo a imagem do snap
            let storage = Storage.storage().reference()
            let imagens = storage.child("imagens")
            imagens.child("\(snap.idImagem).jpg").delete { (error) in
                if error != nil {
                    print("Erro ao excluir imagem: "+String(describing: error))
                    return
                }
                print("Sucesso ao excluir imagem")
            }
            
        }
    }

}
