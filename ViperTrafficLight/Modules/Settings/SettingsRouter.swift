//
//  SettingsRouter.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 12.05.2022.
//

import Foundation


protocol SettingsRouterProtocol: AnyObject {
    func showViewFor(segue: String)
    func closeView()
}


class SettingsRouter: SettingsRouterProtocol {
    
    var viewController: SettingsViewController!
    
    init(viewController: SettingsViewController) {
        self.viewController = viewController
    }
    
    func showViewFor(segue: String) {
        self.viewController.performSegue(withIdentifier: segue, sender: nil)
    }
    
    func closeView() {
        self.viewController.dismiss(animated: true, completion: nil)
    }
}
