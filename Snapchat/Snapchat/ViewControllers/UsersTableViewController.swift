//
//  UsersTableViewController.swift
//  Snapchat
//
//  Created by Tairone Dias on 20/05/19.
//  Copyright © 2019 DiasDevelopers. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UsersTableViewController: UITableViewController {
    
    var users: [Usuario] = []
    var descricao = ""
    var urlImagem = ""
    var idImagem = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Abrindo acesso ao Database do Firebase
        let database = Database.database().reference()
        let usuarios = database.child("usuarios")
        
        // Abrindo acesso ao Authenticate do Firebase
        let auth = Auth.auth()
        
        /* Adiciona evento novo usuario adicionado */
        usuarios.observe(DataEventType.childAdded) { (snapshot) in
            let dados = snapshot.value as! NSDictionary
            
            // Recuperando os dados
            let emailUser = dados["email"] as! String
            let nomeUser = dados["nome"] as! String
            let uidUser = snapshot.key
            
            let user = Usuario(email: emailUser, nome: nomeUser, uid: uidUser)
            
            if let emailUserLog = auth.currentUser?.email {
                if emailUserLog != emailUser {
                 self.users.append(user)
                }
            }
            
            self.tableView.reloadData()
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)

        // Configure the cell...
        let usuario = self.users[indexPath.row]
        cell.textLabel?.text = usuario.nome
        cell.detailTextLabel?.text = usuario.email

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userSelected = self.users[indexPath.row]
        let uidUserSelected = userSelected.uid
        
        let database = Database.database().reference()
        let usuarios = database.child("usuarios")
        
        let snapsUser = usuarios.child(uidUserSelected).child("snaps").childByAutoId()
        
        // Recuperar os dados do user logado
        let auth = Auth.auth()
        let emailFrom = auth.currentUser!.email
        let uidFrom = auth.currentUser!.uid
        // Para recuperar o nome do usuário precisamos fazer uma nova e unica consulta no banco de dados, por isso utilizamos a referencia "usuarios" passando o uid do user logado para consultarmos uma única vez (observeSingleEvent) os dados do user logado
        let usuarioFrom = usuarios.child(uidFrom)
        usuarioFrom.observeSingleEvent(of: DataEventType.value) { (snapshot) in
            let dados = snapshot.value as! NSDictionary
            // Conseguindo recuperar, basta criar um Dictionary com as informacoes obtidas. Lembrando que, os valores presentes em self.descricao, self.urlImagem e self.idImagem foram setados no prepare for segue na classe FotoViewController
            let snap = [
                "de": emailFrom,
                "nome": dados["nome"] as! String,
                "descricao": self.descricao,
                "urlImagem": self.urlImagem,
                "idImagem": self.idImagem
            ]
            
            // Por fim, setamos como new value essas informações
            snapsUser.setValue(snap)
            
            self.navigationController?.popToRootViewController(animated: true)
        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
