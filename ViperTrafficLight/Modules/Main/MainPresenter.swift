//
//  MainPresenter.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 06.05.2022.
//

import Foundation


protocol MainPresenterProtocol: AnyObject {
    var router: MainRouterProtocol! { get set }
    func configureView(_ firstTypeSubview: FirstTypeViewController, _ secondTypeSubview: SecondTypeViewController)
    func reloadButtonClicked()
    func settingsButtonClicked()
    func startButtonClicked()
}


class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol!
    weak var firstTypeSubview: FirstTypeViewController!
    weak var secondTypeSubview: SecondTypeViewController!
    
    var router: MainRouterProtocol!
    var interactor: MainInteractorProtocol!
    
    var isAnimating: Bool = false
    
    private var currentType: Int = 1
        
    init(view: MainViewProtocol) {
        self.view = view
    }
    
    func configureView(_ firstTypeSubview: FirstTypeViewController, _ secondTypeSubview: SecondTypeViewController) {
        self.firstTypeSubview = firstTypeSubview
        self.secondTypeSubview = secondTypeSubview
        self.secondTypeSubview.view.isHidden = true
    }
    
    // MARK: - BUTTONS ACTIONS
    func reloadButtonClicked() {
        let activeView = self.getActiveView()
        activeView.cancelAnimations()
        self.view.setBulbState(isOn: false)
        self.view.showLoadingIndicator()
        self.isAnimating = self.isAnimating ? false : self.isAnimating
        self.interactor.updateState(complition: self.updateTfView)
    }
    
    func settingsButtonClicked() {
        self.router.showSettingsViewController()
    }
    
    func startButtonClicked() {
        self.isAnimating.toggle()
        self.view.toggleBulb()
        let activeView = self.getActiveView()
        if self.isAnimating {
            activeView.animate(for: self.currentType == 1 ? self.interactor.firstTypeTFObject.getState : self.interactor.secondTypeTFObject.getState)
        } else {
            activeView.cancelAnimations()
        }
    }
    
    // MARK: - HELP ACTIONS
    private func getActiveView() -> TFTypeViewControllerDelegate {
        return self.firstTypeSubview.view.isHidden ? self.secondTypeSubview : self.firstTypeSubview
    }
    
    private func updateTfView() {
        let currentState = self.interactor.currentState!
        DispatchQueue.main.async {
            if currentState.currentState {
                self.view.enableTrafficLight()
            } else {
                self.view.disableTrafficLight()
            }
            self.changeType(currentState.trafficLightType)
            self.changeColors(for: currentState.colors.components(separatedBy: ","))
            self.changeTiming(to: currentState.timeOn)
            self.view.cancelLoadingIndicator()
        }
    }
    
    private func changeType(_ viewType: Int) {
        if viewType == 1 {
            self.currentType = 1
            self.firstTypeSubview.view.isHidden = false
            self.secondTypeSubview.view.isHidden = true
        } else if viewType == 2 {
            self.currentType = 2
            self.firstTypeSubview.view.isHidden = true
            self.secondTypeSubview.view.isHidden = false
        }
    }
    
    private func changeTiming(to time: Double) {
        let activeView = self.getActiveView()
        activeView.changeTiming(to: time)
    }
    
    private func changeColors(for colors: [String]) {
        if self.currentType == 1 {
            self.firstTypeSubview.changeColors(to: colors)
        } else {
            self.secondTypeSubview.changeColors(to: colors)
        }
    }
}
