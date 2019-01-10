//
//  LoginController+handles.swift
//  projectDemo
//
//  Created by MAC on 1/8/19.
//  Copyright © 2019 Hai Vo L. All rights reserved.
//

import UIKit
import Firebase

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text,
            let name = nameTextField.text else {
                return
        }
        
        // chứng thực authentication
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            guard let this = self else { return }
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            
            guard let uid = user?.uid else { return }
            
            let imageName = NSUUID().uuidString
            
            // reference into storage
            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
            
            // upload image into storage firebase
            if let uploadData = this.profileImageView.image?.jpegData(compressionQuality: 0.1) {
            //if let uploadData = this.profileImageView.image!.pngData() {
                
                storageRef.putData(uploadData, metadata: nil ) { (_, err) in
                    if let err = error {
                        print(err.localizedDescription)
                        return
                    }
                    
                    //  get image from storage firebase
                    storageRef.downloadURL { (url, err) in
                        if let err = err {
                            print(err.localizedDescription)
                            return
                        }
                        
                        guard let url = url else { return }
                        let values = ["name": name, "email": email, "profileImageUrl": url.absoluteString]
                        this.registerUserIntoDatabaseWithUID(uid, values: values as [String : AnyObject])
                    }
                }
            }
        }
    }
    
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        
        // add user into firebase
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child(uid)
        usersReference.updateChildValues(values) { [weak self] (err, ref) in
            guard let this = self else { return }
            if let err = err {
                print(err.localizedDescription)
                return
            }
           // this.messageController?.fetchUserAndSetupNaviBarTitle()
            this.messageController?.navigationItem.title = values["name"] as? String
            this.dismiss(animated: true, completion: nil)
        }
    }
    
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
