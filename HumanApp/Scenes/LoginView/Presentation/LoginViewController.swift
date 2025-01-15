//
//  LoginViewController.swift
//  HumanApp
//
//  Created by Никита Коголенок on 14.01.25.
//

import UIKit

protocol LoginViewControllerCoordinator: AnyObject {
    func didFinish()
}

final class LoginViewController: UIViewController {
    
    // MARK: - Variables
    private weak var coordinator: LoginViewControllerCoordinator?
    private let viewModel: LoginViewModel
    
    // MARK: - GUI Variable
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Login"
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    init(coordinator: LoginViewControllerCoordinator?, viewModel: LoginViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configAction()
    }
    
    // MARK: - Methods create UI and action
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configAction() {
        
        let loginAction = UIAction { [weak self] _ in
            self?.viewModel.logIn()
            self?.coordinator?.didFinish()
        }
        loginButton.addAction(loginAction, for: .touchUpInside)
    }
}
