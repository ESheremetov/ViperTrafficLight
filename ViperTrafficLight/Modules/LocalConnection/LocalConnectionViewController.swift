//
//  LocalConnectionViewController.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 16.05.2022.
//

import UIKit


protocol LocalConnectionViewProtocol: AnyObject {
    var settings: Array<LocalSettings> { get set }
    var settingsValue: Dictionary<String,Any> { get set }
}

// MARK: - CELLS
class SliderTimeCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!

    @IBAction func timeValueChanged(_ sender: UISlider) {
        let selectedValue = round(sender.value * 100) / 100.0
        self.timeLabel.text = "\(selectedValue) sec."
        self.changeTimeAction(selectedValue)
    }
    
    var changeTimeAction: (Float) -> () = {_ in }
}

class TrafficLightTypeCell: UITableViewCell {
    @IBOutlet weak var typeControl: UISegmentedControl!
    @IBAction func changeTypeAction(_ sender: UISegmentedControl) {
        self.changeType(typeControl.selectedSegmentIndex + 1)
    }
    
    var changeType: (Int) -> () = {_ in }
}

class ColorsCell: UITableViewCell {
    
    @IBOutlet weak var topLightButton: UIButton!
    @IBOutlet weak var middleLightButton: UIButton!
    @IBOutlet weak var bottomLightButton: UIButton!
    
    
    @IBAction func topLightButtonAction(_ sender: UIButton) {
        self.showColorPicker(sender, "top")
    }
    
    @IBAction func middleLightButtonAction(_ sender: UIButton) {
        self.showColorPicker(sender, "middle")
    }
    
    @IBAction func bottomLightButtonAction(_ sender: UIButton) {
        self.showColorPicker(sender, "bottom")
    }
    
    var showColorPicker: (UIButton, String) -> () = {_,_ in }
    
}

class ButtonsCell: UITableViewCell {
    
    @IBAction func revertButton(_ sender: UIButton) {
        revertAction()
    }
    
    @IBAction func acceptButton(_ sender: UIButton) {
        saveAction()
    }
    
    var saveAction: () -> () = {}
    var revertAction: () -> () = {}
}

// MARK: - VIEW
class LocalConnectionViewController: UIViewController,
                                     UITableViewDelegate, UITableViewDataSource,
                                     LocalConnectionViewProtocol, UIColorPickerViewControllerDelegate {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    var settings: Array<LocalSettings> = []
    var settingsValue: Dictionary<String,Any> = [:]
    
    var presenter: LocalConnectionPresenterProtocol!
    let configurator: LocalConnectionConfiguratorProtocol = LocalConnectionConfigurator()
    
    var pickerView: UIColorPickerViewController!
    
    var selectedLightButton: UIButton = UIButton()
    var selectedLightName: String = "top"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingsTableView.delegate = self
        self.settingsTableView.dataSource = self
        
        self.pickerView = UIColorPickerViewController()
        self.pickerView.delegate = self
        
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.settings[section].name
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.settings.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selection = self.settings[indexPath.section]
        let cellIdentifier = selection.cell
        
        let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        return self.addAction(for: cell)
    }
    
    func addAction(for cell: UITableViewCell) -> UITableViewCell {
        switch type(of: cell) {
        case is ButtonsCell.Type:
            let buttonsCell = cell as! ButtonsCell
            buttonsCell.saveAction = self.presenter.save
            buttonsCell.revertAction = self.presenter.revertSettings
            return buttonsCell
            
        case is SliderTimeCell.Type:
            let timeCell = cell as! SliderTimeCell
            timeCell.changeTimeAction = self.presenter.changeTime
            timeCell.timeSlider.value = self.settingsValue["timeOn"] as! Float
            timeCell.timeLabel.text = "\(self.settingsValue["timeOn"]!) sec."
            return timeCell
            
        case is TrafficLightTypeCell.Type:
            let typeCell = cell as! TrafficLightTypeCell
            typeCell.changeType = self.presenter.changeType
            typeCell.typeControl.selectedSegmentIndex = self.settingsValue["trafficLightType"] as! Int - 1
            return typeCell
            
        case is ColorsCell.Type:
            let colorCell = cell as! ColorsCell
            colorCell.showColorPicker = self.showPickerView
            colorCell.topLightButton.tintColor = UIColor(named: self.settingsValue["top"] as! String)
            colorCell.middleLightButton.tintColor = UIColor(named: self.settingsValue["middle"] as! String)
            colorCell.bottomLightButton.tintColor = UIColor(named: self.settingsValue["bottom"] as! String)
            return colorCell
        default:
            return cell
        }
    }
    
    func showPickerView(_ sender: UIButton, name: String) {
        self.selectedLightButton = sender
        self.selectedLightName = name
        self.present(self.pickerView, animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        self.presenter.changeColor(color, for: self.selectedLightName)
        self.selectedLightButton.tintColor = color
    }
    
    func setSettings(values: Dictionary<String,Any>) {
        self.settingsValue = values
    }
}

// TRAFFIC LIGHT UPDATE AFTER APPLY SETTINGS
// REVERTING UPDATE SETTINGS VIEW
// CHECK COLORS SAVING
// ADD LOADING COLORS BY NAME
