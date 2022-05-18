//
//  LocalConnectionRouter.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 16.05.2022.
//

import Foundation


protocol LocalConnectionRouterProtocol: AnyObject {
    func closeCurrentViewController()
}


class LocalConnectionRouter: LocalConnectionRouterProtocol {
    
    var viewController: LocalConnectionViewController!
    
    init(viewController: LocalConnectionViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
