//
//  MainInteractor.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 06.05.2022.
//

import Foundation


protocol MainInteractorProtocol: AnyObject {
    var firstTypeTFObject: FirstTypeTrafficLightObject { get }
    var secondTypeTFObject: SecondTypeTrafficLightObject { get }
    var currentState: TrafficLightState? { get set }
    func updateState(complition: @escaping () -> ())
}


class MainInteractor: MainInteractorProtocol {
    
    
    // TODO: change service type
    let service: TrafficLiteServiceProtocol = TrafficLightLocalService()
    let firstTypeTFObject = FirstTypeTrafficLightObject(colors: ["Red", "Yellow", "Green"])
    let secondTypeTFObject = SecondTypeTrafficLightObject(colors: ["Red", "Green"])
    
    weak var presenter: MainPresenterProtocol!
    
    var currentState: TrafficLightState?
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    private func reloadState(new state: Result<TrafficLightState, Error>, complition: @escaping () -> ()) {
        switch state {
        case .success(let newState):
            self.currentState = newState
            complition()
        case .failure(let error):
            print("Traffic Light state request failed with error: \(error)")
        }
    }
    
    func updateState(complition: @escaping () -> ()) {
        unowned let _self = self
        self.service.getCurrentState(setStateAction: _self.reloadState, complition: complition)
    }
}
