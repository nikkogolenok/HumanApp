//
//  SettingsViewController.swift
//  HumanApp
//
//  Created by Никита Коголенок on 14.01.25.
//

import UIKit

protocol SettingsViewControllerCoordinator: AnyObject {
    func didSelecedCell(settingsViewNavigation: SettingsViewNavigation)
}

final class SettingsViewController: UITableViewController {
    
    // MARK: - Viriables
    private let viewModel: SettingsViewModel
    private weak var coordinator: SettingsViewControllerCoordinator?
    
    // MARK: - Inits
    init(viewModel: SettingsViewModel, coordinator: SettingsViewControllerCoordinator?) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configmTableView()
    }
    
    private func configmTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .systemGroupedBackground
    }
}

// MARK: - TableView Delegate
extension SettingsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.settingsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModel.getItemSettingViewModel(row: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.image = UIImage(systemName: viewModel.icon)
        contentConfiguration.text = viewModel.title
        cell.contentConfiguration = contentConfiguration
        
        if viewModel.isNavigable {
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navigation = viewModel.cellSeleced(row: indexPath.row)
        coordinator?.didSelecedCell(settingsViewNavigation: navigation)
    }
}
