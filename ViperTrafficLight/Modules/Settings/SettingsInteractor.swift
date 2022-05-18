//
//  SettingsInteractor.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 12.05.2022.
//

import Foundation


protocol SettingsInteractorProtocol: AnyObject {
    func getSettings() -> [Settings]
}

class SettingsInteractor: SettingsInteractorProtocol {
    
    weak var presenter: SettingsPresenterProtocol!
    
    private let settings: [Settings] = Bundle.main.decode("settings.json")
    
    init(presenter: SettingsPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getSettings() -> [Settings] {
        return self.settings
    }
}

