//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Tairone Dias on 18/05/19.
//  Copyright © 2019 DiasDevelopers. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var snaps: [Snap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let autenticacao = Auth.auth()
        
        if let uidUserLoagado = autenticacao.currentUser?.uid {
            
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            
            let snaps = usuarios.child(uidUserLoagado).child("snaps")
            
            // Criando ouvinte para Snaps adicionados
            snaps.observe(DataEventType.childAdded) { (snapshot) in
                let dados = snapshot.value as? NSDictionary
                
                let snap = Snap()
                snap.idSnap = snapshot.key
                snap.de = dados?["de"] as! String
                snap.nome = dados?["nome"] as! String
                snap.descricao = dados?["descricao"] as! String
                snap.urlImagem = dados?["urlImagem"] as! String
                snap.idImagem = dados?["idImagem"] as! String
                
                self.snaps.append(snap)
                print(self.snaps)
                self.tableView.reloadData()
            }
            
            // Criando ouvinte para Snaps removidos
            snaps.observe(DataEventType.childRemoved) { (snapshot) in
                var indice = 0
                for snap in self.snaps {
                    if snap.idSnap == snapshot.key {
                        self.snaps.remove(at: indice)
                        break
                    }
                    indice = indice + 1
                }
                self.tableView.reloadData()
            }
        }
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let totalSnaps = snaps.count
        if totalSnaps == 0 {
            return 1
        }
        return totalSnaps
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaSnaps", for: indexPath)
        
        let totalSnaps = snaps.count
        if totalSnaps == 0 {
            cell.textLabel?.text = "Nenhum snap para você!"
        } else {
            cell.textLabel?.text = self.snaps[indexPath.row].nome
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let totalSnaps = snaps.count
        if totalSnaps > 0 {
            let snap = self.snaps[indexPath.row]
            self.performSegue(withIdentifier: "detalhesSnapSegue", sender: snap)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalhesSnapSegue" {
            let detalhesSnapViewController = segue.destination as! DetalhesSnapViewController
            
            detalhesSnapViewController.snap = sender as! Snap
        }
    }

}
