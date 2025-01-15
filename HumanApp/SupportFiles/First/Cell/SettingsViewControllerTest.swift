//
//  SettingsViewController.swift
//  HumanApp
//
//  Created by Никита Коголенок on 13.01.25.
//

import UIKit

class SettingsViewControllerTest: UIViewController {
    
    // MARK: - GUI Variable
    let tableView = UITableView()
    
    // MARK: - View LifeCycel
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Setup TableView
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "Settings View"
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
    }
}
