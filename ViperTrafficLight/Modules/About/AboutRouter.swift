//
//  AboutRouter.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 06.05.2022.
//

import Foundation


protocol AboutRouterProtocol: AnyObject {
    func closeCurrentViewController()
}


class AboutRouter: AboutRouterProtocol {
    
    var viewController: AboutViewController!
    
    init(viewController: AboutViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
