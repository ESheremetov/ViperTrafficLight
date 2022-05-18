//
//  LocalConnectionPresenter.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 16.05.2022.
//

import Foundation
import UIKit


protocol LocalConnectionPresenterProtocol: AnyObject {
    var router: LocalConnectionRouterProtocol! { get set }
    func configureView()
    func save()
    func changeTime(to value: Float)
    func changeType(to value: Int)
    func changeColor(_ color: UIColor, for light: String)
    func revertSettings()
}


class LocalConnectionPresenter: LocalConnectionPresenterProtocol {
    
    weak var view: LocalConnectionViewProtocol!
    var interactor: LocalConnectionInteractorProtocol!
    var router: LocalConnectionRouterProtocol!
    
    required init(view: LocalConnectionViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        self.view.settingsValue = self.interactor.getCurrentSettingsValues()
        self.view.settings = self.interactor.getSettings()
    }
    
    func save() {
        self.interactor.saveSettings()
    }
    
    func changeTime(to value: Float) {
        self.interactor.setSettings(value: value, to: "timeOn")
    }
    
    func changeType(to value: Int) {
        self.interactor.setSettings(value: value, to: "trafficLightType")
    }
    
    func changeColor(_ color: UIColor, for light: String) {
        self.interactor.setSettings(value: color.accessibilityName, to: light)
    }
    
    func revertSettings() {
        self.interactor.revertSettings()
    }
}
