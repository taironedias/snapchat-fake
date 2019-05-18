//
//  FotoViewController.swift
//  Snapchat
//
//  Created by Tairone Dias on 18/05/19.
//  Copyright © 2019 DiasDevelopers. All rights reserved.
//

import UIKit

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var campoDescricao: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }

    @IBAction func btnSelecionarFoto(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imgRecuperada = info[.originalImage] as? UIImage {
            self.imageView.image = imgRecuperada
        } else {
            print("Not able to get an image")
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
