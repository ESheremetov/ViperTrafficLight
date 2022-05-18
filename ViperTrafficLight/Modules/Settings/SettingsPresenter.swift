//
//  SettingsPresenter.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 12.05.2022.
//

import Foundation


protocol SettingsPresenterProtocol: AnyObject {
    var router: SettingsRouterProtocol! { get set }
    
    func selectCellAt(section: Int, row: Int)
    func configureView()
    func outsideTap()
    func connectionChanged(to state: Bool)
}


class SettingsPresenter: SettingsPresenterProtocol {
    
    weak var view: SettingsViewControllerProtocol!
    
    var router: SettingsRouterProtocol!
    var interactor: SettingsInteractorProtocol!
    
    init(view: SettingsViewControllerProtocol) {
        self.view = view
    }
    
    func configureView() {
        self.view.settings = self.getSettings()
    }
    
    func getSettings() -> [Settings] {
        return self.interactor.getSettings()
    }
    
    func selectCellAt(section: Int, row: Int) {
        let settings = self.getSettings()
        let seguePrefix = "\(settings[section].rows[row])".lowercased().replacingOccurrences(of: " ", with: "")
        let segueName = "\(seguePrefix)Segue"
        self.router.showViewFor(segue: segueName)
    }
    
    func outsideTap() {
        self.router.closeView()
    }
    
    func connectionChanged(to state: Bool) {
        print("Change connection")
    }
}
