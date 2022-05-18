//
//  CustomAnimationCircle.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 11.05.2022.
//

import Foundation
import UIKit


class CustomAnimation {
    
    var executional: CABasicAnimation
    var next: CustomAnimation?
    
    init(animation: CABasicAnimation, next: CustomAnimation?) {
        self.executional = animation
        self.next = next
    }
}

class CustomAnimationCircle {
    
    var animation: CustomAnimation?
    var isActing: Bool = true
    var layer: CALayer?
    
    init(start animation: CustomAnimation?, for layer: CALayer?) {
        self.animation = animation
        self.layer = layer
    }
    
    convenience init() {
        self.init(start: nil, for: nil)
    }
    
    func run(for animation: CustomAnimation,
             complition: @escaping (@escaping () -> TrafficLightUnit) -> (),
             changeState: @escaping () -> TrafficLightUnit) {
        self.isActing = true
        self.animating(for: animation,
                          complition: complition,
                          changeState: changeState)
    }
    
    private func animating(for animation: CustomAnimation,
                           complition: @escaping (@escaping () -> TrafficLightUnit) -> (),
                           changeState: @escaping () -> TrafficLightUnit) {
        guard isActing else {
            self.layer!.removeAllAnimations()
            return
        }
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            if animation.next != nil {
                self.animating(for: animation.next!, complition: complition, changeState: changeState)
            } else {
                _ = complition(changeState)
            }
        }
        self.layer!.add(animation.executional, forKey: nil)
        CATransaction.commit()
    }
    
    func stop() {
        self.isActing = false
    }
}

