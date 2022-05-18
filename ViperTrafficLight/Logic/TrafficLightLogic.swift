enum TrafficLightUnitState {
    case on
    case off
    case prepare
}

class TrafficLightNode {
    
    var next: TrafficLightNode?
    var value: TrafficLightUnitState
    
    init(next: TrafficLightNode?, state: TrafficLightUnitState?) {
        self.next = next
        self.value = state ?? .off
    }
    
    convenience init(next: TrafficLightNode?) {
        self.init(next: next, state: nil)
    }
    
    convenience init() {
        self.init(next: nil, state: nil)
    }
    
    convenience init(state: TrafficLightUnitState?) {
        self.init(next: nil, state: state)
    }
}


class TrafficLightUnit {
    
    var color: String
    var state: TrafficLightNode
    var nextUnit: TrafficLightUnit?
    let name: String
    
    init(name: String, color: String, nextUnit: TrafficLightUnit?, startState: TrafficLightUnitState) {
        self.color = color
        self.name = name
        
        let onState = TrafficLightNode(state: .on)
        let offState = TrafficLightNode(next: onState, state: .off)
        let prepareState = TrafficLightNode(next: offState, state: .prepare)
        onState.next = prepareState
        
        switch startState {
        case .off: self.state = offState
        case .prepare: self.state = prepareState
        case .on: self.state = onState
        }
        
        self.nextUnit = nextUnit
    }
    
    convenience init(name: String, color: String) {
        self.init(name: name, color: color, nextUnit: nil, startState: .off)
    }
    
    convenience init(name: String, color: String, nextUnit: TrafficLightUnit?) {
        self.init(name: name, color: color, nextUnit: nextUnit, startState: .off)
    }
    
    func nextState() {
        self.state = self.state.next!
    }
}


protocol TrafficLightObjectProtocol: AnyObject {
    
    var currentUnit: TrafficLightUnit { get set }
    func getState() -> TrafficLightUnit
    
}


class FirstTypeTrafficLightObject {
    
    let topUnit: TrafficLightUnit
    let middleUnit: TrafficLightUnit
    let bottomUnit: TrafficLightUnit
    
    var currentUnit: TrafficLightUnit
    
    init(colors: [String]) {
        self.topUnit = TrafficLightUnit(name: "top", color: colors[0])
        self.middleUnit = TrafficLightUnit(name: "middle", color: colors[1], nextUnit: topUnit)
        self.bottomUnit = TrafficLightUnit(name: "bottom", color: colors[2], nextUnit: middleUnit)
        
        self.topUnit.nextUnit = self.bottomUnit
        
        self.currentUnit = topUnit
    }
    
    func getState() -> TrafficLightUnit {
        if self.currentUnit.state.value == .off {
            self.currentUnit = self.currentUnit.nextUnit!
        }
        self.currentUnit.nextState()
        return self.currentUnit
    }
}


class SecondTypeTrafficLightObject {
    
    let topUnit: TrafficLightUnit
    let bottomUnit: TrafficLightUnit
    
    var currentUnit: TrafficLightUnit
    
    init(colors: [String]) {
        self.topUnit = TrafficLightUnit(name: "top", color: colors[0])
        self.bottomUnit = TrafficLightUnit(name: "bottom", color: colors[1], nextUnit: topUnit)
        
        self.topUnit.nextUnit = self.bottomUnit
        
        self.currentUnit = topUnit
    }
    
    func getState() -> TrafficLightUnit {
        if self.currentUnit.state.value == .off {
            self.currentUnit = self.currentUnit.nextUnit!
        }
        self.currentUnit.nextState()
        return self.currentUnit
    }
}
