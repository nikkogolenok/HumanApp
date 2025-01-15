//
//  MainViewController.swift
//  HumanApp
//
//  Created by Никита Коголенок on 13.01.25.
//

import UIKit

class MainViewControllerTest: UIViewController {
    
    // MARK: - GUI Variables
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(plusButtonTaped), for: .touchUpInside)
        return button
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Original", "Black & White"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.isHidden = true
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var saveBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBarButtonTaped))
    }()
    
    var imageView: UIImageView?
    
    // MARK: - View LifeCycel
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton()
        setupNavigationBar()
        setupSegmentedControl()
    }
    
    private func setupButton() {
        view.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        title = "Main View"
        navigationItem.rightBarButtonItems = [saveBarButtonItem]
    }
    
    private func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
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
    
    // MARK: - Actions
    @objc private func plusButtonTaped() {
        let imagePicker = UIImagePickerController()
        //imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func saveBarButtonTaped() {
        guard let image = imageView?.image else {
            print("No image to save")
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeMutableRawPointer) {
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
        } else {
            print("Image saved successfully")
        }
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
