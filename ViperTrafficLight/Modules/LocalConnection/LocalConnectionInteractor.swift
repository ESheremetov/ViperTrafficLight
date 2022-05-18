//
//  LocalConnectionInteractor.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 16.05.2022.
//

import Foundation


protocol LocalConnectionInteractorProtocol: AnyObject {
    func getSettings() -> [LocalSettings]
    func saveSettings()
    func setSettings(value: Any, to settingsName: String)
    func revertSettings()
    func getCurrentSettingsValues() -> Dictionary<String, Any>
}

class LocalConnectionInteractor: LocalConnectionInteractorProtocol {
    
    weak var presenter: LocalConnectionPresenterProtocol!
    
    var currentSettings: Dictionary<String, Any> = [:]
    
    init(presenter: LocalConnectionPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getSettings() -> [LocalSettings] {
        return Bundle.main.decode("local_settings.json")
    }
    
    func getCurrentSettingsValues() -> Dictionary<String, Any> {
        let defaults = UserDefaults.standard
        let colors = defaults.string(forKey: "colors") ?? "Red,Yellow,Green"
        let colorsArray = colors.components(separatedBy: ",")
        let settings: Dictionary<String, Any> = [
            "timeOn": defaults.float(forKey: "timeOn"),
            "trafficLightType": defaults.integer(forKey: "trafficLightType"),
            "top": colorsArray[0],
            "middle": colorsArray[1],
            "bottom": colorsArray.count == 2 ? "grey" : colorsArray[2]
        ]
        self.currentSettings = settings
        return settings
    }
    
    func saveSettings() {
        let colorsString = [
            self.currentSettings["top"]! as! String,
            self.currentSettings["middle"]! as! String,
            self.currentSettings["bottom"]! as! String
        ].joined(separator: ",")
        let defaults = UserDefaults.standard
        defaults.set(self.currentSettings["timeOn"]!, forKey: "timeOn")
        defaults.set(self.currentSettings["trafficLightType"]!, forKey: "trafficLightType")
        defaults.set(colorsString, forKey: "colors")
    }
    
    func setSettings(value: Any, to settingsName: String) {
        self.currentSettings[settingsName] = value
    }
    
    func revertSettings() {
        let defaults = UserDefaults.standard
        defaults.set(2.0, forKey: "timeOn")
        defaults.set(1, forKey: "trafficLightType")
        defaults.set("Red,Yellow,Green", forKey: "colors")
    }
}
