//
//  LoginController+handles.swift
//  projectDemo
//
//  Created by MAC on 1/8/19.
//  Copyright © 2019 Hai Vo L. All rights reserved.
//

import UIKit

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectImageFromPicker: UIImage?
        
        if let editImage = info[.editedImage] as? UIImage {
            selectImageFromPicker = editImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectImageFromPicker = originalImage
        }
        
        if let selectedImage = selectImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
