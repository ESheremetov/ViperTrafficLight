//
//  SettingsConfigurator.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 12.05.2022.
//

import Foundation

protocol SettingsConfiguratorProtocol: AnyObject {
    func configure(with viewController: SettingsViewController)
}

class SettingsConfigurator: SettingsConfiguratorProtocol {
    
    func configure(with viewController: SettingsViewController) {
        let presenter = SettingsPresenter(view: viewController)
        let interactor = SettingsInteractor(presenter: presenter)
        let router = SettingsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
