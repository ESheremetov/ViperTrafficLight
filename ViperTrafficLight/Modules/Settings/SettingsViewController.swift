//
//  SettingsViewController.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 15.05.2022.
//

import UIKit

protocol SettingsViewControllerProtocol: AnyObject {
    var settings: [Settings] { get set }
}

class SettingsViewController: UIViewController,
                              UITableViewDelegate, UITableViewDataSource,
                              SettingsViewControllerProtocol {
    
    var presenter: SettingsPresenterProtocol!
    var configurator: SettingsConfiguratorProtocol! = SettingsConfigurator()
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    @IBAction func connectionChanged(_ sender: UISwitch) {
        self.presenter.connectionChanged(to: sender.isOn)
    }
    
    var settings: Array<Settings> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingsTableView.delegate = self
        self.settingsTableView.dataSource = self
        
        configurator.configure(with: self)
        self.presenter.configureView()
        
        self.navigationItem.title = "Settings"
        
        self.settingsTableView.layer.cornerRadius = 10
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sideTap(_:)))
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func sideTap(_ sender: UITapGestureRecognizer) {
        let tappedView = self.view.hitTest(sender.location(in: self.view), with: nil)
        if tappedView == self.view {
            self.presenter.outsideTap()
        } else {
            let touch = sender.location(in: self.settingsTableView)
            if let indexPath = self.settingsTableView.indexPathForRow(at: touch) {
                self.tableView(self.settingsTableView, didSelectRowAt: indexPath)
            }
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.settings[section].name
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.settings.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settings[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selection = self.settings[indexPath.section]
        let data = selection.rows[indexPath.row]
        
        if data == "Remote Connection" {
            return self.settingsTableView.dequeueReusableCell(withIdentifier: "connectionCell", for: indexPath)
        }
        
        let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = data
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = self.settings[indexPath.section].rows[indexPath.row]
        if cellData != "Remote Connection" {
            self.presenter.selectCellAt(section: indexPath.section, row: indexPath.row)
        }
    }
}
