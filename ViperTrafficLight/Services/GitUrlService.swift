//
//  GitUrlService.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 06.05.2022.
//

import Foundation
import UIKit


protocol GitUrlServiceProtocol: AnyObject {
    
    var urlString: String { get }
    
    func openUrl(with urlString: String)
    
}

class GitUrlService: GitUrlServiceProtocol {
    
    var urlString: String {
        return "https://github.com/ESheremetov"
    }
    
    func openUrl(with urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
