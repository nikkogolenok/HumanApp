//
//  MainViewController + Ext.swift
//  HumanApp
//
//  Created by Никита Коголенок on 13.01.25.
//

import UIKit
import Photos

extension MainViewControllerTest: UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[.originalImage] as? UIImage {
            displayImage(selectedImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func displayImage(_ image: UIImage) {
        imageView?.removeFromSuperview()
        
        let borderView = UIView()
        borderView.layer.borderWidth = 2
        borderView.layer.borderColor = UIColor.yellow.cgColor
        borderView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView = UIImageView(image: image)
        imageView?.contentMode = .scaleAspectFit
        imageView?.isUserInteractionEnabled = true
        
        if let imageView = imageView {
            borderView.addSubview(imageView)
            view.addSubview(borderView)
            
            NSLayoutConstraint.activate([
                borderView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
                borderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                borderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                borderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            ])
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: borderView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor)
            ])
            
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            borderView.addGestureRecognizer(panGesture)
            
            let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
            borderView.addGestureRecognizer(pinchGesture)
    
            let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
            borderView.addGestureRecognizer(rotationGesture)
        }
    }
}
