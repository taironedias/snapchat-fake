//
//  FotoViewController.swift
//  Snapchat
//
//  Created by Tairone Dias on 18/05/19.
//  Copyright © 2019 DiasDevelopers. All rights reserved.
//

import UIKit
import FirebaseStorage

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    var idImagem = NSUUID().uuidString              // Gera um id randomico toda vez que eh utilizado
    
    @IBOutlet weak var campoDescricao: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var botaoProximo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        botaoProximo.isEnabled = false
        botaoProximo.backgroundColor = UIColor.gray
    }

    @IBAction func btnSelecionarFoto(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnProximo(_ sender: Any) {
        self.botaoProximo.isEnabled = false
        self.botaoProximo.setTitle("Carregando...", for: .normal)
        
        let storage = Storage.storage().reference()
        let imagesFolder = storage.child("imagens")
        let imagesFile = imagesFolder.child("\(idImagem).jpg")
        
        // Recover image
        if let imgRecovered = imageView.image {
            
            if let imgData = imgRecovered.jpegData(compressionQuality: 0.1) {
                imagesFile.putData(imgData, metadata: nil) { (metaData, error) in
                    if error == nil {
                        // START Download URL
                        imagesFile.downloadURL(completion: { (url, error) in
                            print(String(describing: url?.absoluteString))
                        })
                        // END Download URL
                        print("Sucesso ao salvar!")
                        
                    } else {
                        print("Erro ao fazer upload do arquivo")
                    }
                    self.botaoProximo.isEnabled = true
                    self.botaoProximo.setTitle("Próximo", for: .normal)
                }
            
            }
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imgRecuperada = info[.originalImage] as? UIImage {
            self.imageView.image = imgRecuperada
        } else {
            print("Not able to get an image")
        }
        self.botaoProximo.isEnabled = true
        self.botaoProximo.backgroundColor = UIColor(red: 0.552, green: 0.368, blue: 0.748, alpha: 1)
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
