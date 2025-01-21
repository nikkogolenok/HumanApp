//
//  MainViewController.swift
//  HumanApp
//
//  Created by Никита Коголенок on 15.01.25.
//

import UIKit
import Photos

final class MainViewController: UIViewController {
    
    // MARK: - Variables
    
    // MARK: - GUI Variables
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
        button.addTarget(self, action: #selector(plusButtonTaped), for: .touchUpInside)
        return button
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Original", "Black & White"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    var imageView: UIImageView?

    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBarButtonTaped))
        navigationItem.rightBarButtonItem = saveBarButtonItem
        
        view.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func applyBlackAndWhiteFilter(to image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(0.0, forKey: kCIInputSaturationKey)
        
        guard let outputImage = filter?.outputImage else { return nil }
        
        let context = CIContext()
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
    
    func showErrorSave() {
        let alertController = UIAlertController(title: "You shold tapped button '+'", message: "Your picture save", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    // MARK: - Actions
    @objc private func plusButtonTaped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            if let originalImage = imageView?.image {
                imageView?.image = originalImage
            }
        case 1:
            if let originalImage = imageView?.image {
                imageView?.image = applyBlackAndWhiteFilter(to: originalImage)
            }
        default:
            break
        }
    }

    @objc private func saveBarButtonTaped() {
        guard let image = imageView?.image else {
            showErrorSave()
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeMutableRawPointer) {
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
        } else {
            print("Image saved successfully")
//            imageView?.image = nil
//            DispatchQueue.main.async {
//                self.dismiss(animated: true)
//            }
        }
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let viewToMove = gesture.view else { return }
        
        let translation = gesture.translation(in: self.view)
        viewToMove.center = CGPoint(x: viewToMove.center.x + translation.x, y: viewToMove.center.y + translation.y)
        gesture.setTranslation(.zero, in: self.view)
    }
    
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let viewToTransform = gesture.view else { return }
        
        if gesture.state == .began || gesture.state == .changed {
            viewToTransform.transform = viewToTransform.transform.scaledBy(x: gesture.scale, y: gesture.scale)
            gesture.scale = 1
        }
    }

    @objc func handleRotation(_ gesture: UIRotationGestureRecognizer) {
        guard let viewToTransform = gesture.view else { return }
        
        if gesture.state == .began || gesture.state == .changed {
            viewToTransform.transform = viewToTransform.transform.rotated(by: gesture.rotation)
            gesture.rotation = 0
        }
    }
    
}

extension MainViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {

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
                borderView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
                borderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                borderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                borderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
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
