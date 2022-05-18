//
//  AboutConfigurator.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 06.05.2022.
//

import Foundation
import UIKit

protocol AboutConfiguratorProtocol: AnyObject {
    
    func configure(with viewController: AboutViewController)
    
}

class AboutConfigurator: AboutConfiguratorProtocol {
    
    func configure(with viewController: AboutViewController) {
        let presenter = AboutPresenter(view: viewController)
        let interactor = AboutInteractor(presenter: presenter)
        let router = AboutRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
