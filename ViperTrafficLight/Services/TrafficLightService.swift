//
//  TrafficLightService.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 04.05.2022.
//

import Foundation

class TrafficLightService: TrafficLiteServiceProtocol {
    
    let serviceURL: URL?
    
    lazy var serviceStatus: () -> Bool = { [weak self] in
        return false
    }
    
    init(serviceURL: String) {
        self.serviceURL = URL(string: serviceURL)
    }
    
    func getCurrentState(setStateAction: @escaping (Result<TrafficLightState, Error>, @escaping () -> ()) -> (),
                         complition: @escaping () -> ()) {
        guard let url = self.serviceURL else {
            setStateAction(.failure(TrafficLightServiceError(description: "Invalid Traffic Light URL")), complition)
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                // HTTP REQUEST ERROR
                setStateAction(.failure(TrafficLightServiceError(description: "Can not get current state : \(error)")), complition)
            } else if let data = data {
                // FETCHING DATA
                let jsonDecoder = JSONDecoder()
                do {
                    let currentState = try jsonDecoder.decode(TrafficLightState.self, from: data)
                    setStateAction(.success(currentState), complition)
                } catch {
                    setStateAction(.failure(TrafficLightServiceError(description: "Can not parse current state response : \(error)")), complition)
                }
            } else {
                // UNKNOWN ERROR
                setStateAction(.failure(TrafficLightServiceError(description: "Can not get current state with <Unkown Error>")), complition)
            }
        }.resume()
    }
}
