//
//  TrafficLightLocalService.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 04.05.2022.
//

import Foundation

class TrafficLightLocalService: TrafficLiteServiceProtocol {
    
    var serviceURL: URL?
    
    lazy var serviceStatus: () -> Bool = {
        // Generating some random value with a small possibility of false state
        return (Double.random(in: 0...100) / 100.0) > 0.1
    }
    
    func getCurrentState(setStateAction: @escaping (Result<TrafficLightState, Error>, @escaping () -> ()) -> (),
                         complition: @escaping () -> ()) {
        DispatchQueue.global(qos: .background).async {
            let currentState = self.getDummy()
            setStateAction(.success(currentState), complition)
        }
    }
    
    // Return dummy traffic light data
    private func getDummy() -> TrafficLightState {
        let defaults = UserDefaults.standard
        sleep(UInt32.random(in: 0...2))
        let tfType = defaults.integer(forKey: "trafficLightType")
        let dummyData: [String: Any] = [
            "timeOn": defaults.float(forKey: "timeOn"),
            "currentState": (Double.random(in: 0...100) / 100.0) > 0.33,
            "trafficLightType": tfType,
            "colors": defaults.string(forKey: "colors") ?? (tfType == 1 ? "Red,Yellow,Green" : "Red,Green")
        ]
        let jsonDecoder = JSONDecoder()
        let jsonData = try! JSONSerialization.data(withJSONObject: dummyData, options: [])
        let currentState = try! jsonDecoder.decode(TrafficLightState.self, from: jsonData)
        return currentState
    }
}

//
