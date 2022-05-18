//
//  TrafficLightServiceProtocol.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 04.05.2022.
//

import Foundation

struct TrafficLightServiceError: Error {
    let description : String
    var localizedDesc: String {
        return NSLocalizedString(description, comment: "")
    }
}

protocol TrafficLiteServiceProtocol: AnyObject {
    
    var serviceURL: URL? { get }
    var serviceStatus: () -> Bool { get }
    
    func getCurrentState(setStateAction: @escaping (Result<TrafficLightState, Error>, @escaping () -> ()) -> (),
                         complition: @escaping () -> ())
}
