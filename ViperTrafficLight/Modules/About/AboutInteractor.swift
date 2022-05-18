//
//  AboutInteractor.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 06.05.2022.
//

import Foundation


protocol AboutInteractorProtocol: AnyObject {
    var urlSource: String { get }
    
    func openUrl(with urlString: String)
}

class AboutInteractor: AboutInteractorProtocol {
    
    let service: GitUrlServiceProtocol = GitUrlService()
    weak var presenter: AboutPresenterProtocol!
    var urlSource: String {
        return self.service.urlString
    }
    
    init(presenter: AboutPresenterProtocol) {
        self.presenter = presenter
    }
    
    func openUrl(with urlString: String) {
        self.service.openUrl(with: urlString)
    }
}
