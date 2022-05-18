//
//  LocalConnectionConfigurator.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 16.05.2022.
//

import Foundation

protocol LocalConnectionConfiguratorProtocol: AnyObject {
    
    func configure(with viewController: LocalConnectionViewController)
    
}

class LocalConnectionConfigurator: LocalConnectionConfiguratorProtocol {
    
    func configure(with viewController: LocalConnectionViewController) {
        let presenter = LocalConnectionPresenter(view: viewController)
        let interactor = LocalConnectionInteractor(presenter: presenter)
        let router = LocalConnectionRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
