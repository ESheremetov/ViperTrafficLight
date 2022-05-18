//
//  TrafficLightState.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 04.05.2022.
//

import Foundation

class TrafficLightState: Decodable {
    
    let timeOn: Double // time of "on" state
    let currentState: Bool // current state of the traffic light
    let trafficLightType: Int // type of the traffic light (can be 1 - for triple, 2 - double)
    let colors: String // colors of the traffic light elements
    
    init(timeOn: Double,  currentState: Bool, trafficLightType: Int, colors: String) {
        self.timeOn = timeOn
        self.currentState = currentState
        self.trafficLightType = trafficLightType
        self.colors = colors
    }
}
