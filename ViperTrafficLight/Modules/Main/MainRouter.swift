//
//  MainRouter.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 06.05.2022.
//

import Foundation
import UIKit


protocol MainRouterProtocol: AnyObject {
    func showSettingsViewController()
}


class MainRouter: MainRouterProtocol {
    
    var viewController: MainViewController!
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func showSettingsViewController() {
        self.viewController.performSegue(withIdentifier: "settingsSegue", sender: nil)
    }
}
