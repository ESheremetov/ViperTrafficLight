//
//  AboutPresenter.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 06.05.2022.
//

import Foundation


protocol AboutPresenterProtocol: AnyObject {
    var router: AboutRouterProtocol! { get set }
    func configureView()
    func closeButtonClicked()
    func urlButtonClicked(with stringURL: String?)
}


class AboutPresenter: AboutPresenterProtocol {
    
    weak var view: AboutViewProtocol!
    var interactor: AboutInteractorProtocol!
    var router: AboutRouterProtocol!
    
    required init(view: AboutViewProtocol) {
        self.view = view
    }
    
    func closeButtonClicked() {
        self.router.closeCurrentViewController()
    }

    func configureView() {
        self.view.setUrlButtonTitle(with: self.interactor.urlSource)
    }
    
    func urlButtonClicked(with stringURL: String?) {
        if let url = stringURL {
            interactor.openUrl(with: url)
        }
    }
}
