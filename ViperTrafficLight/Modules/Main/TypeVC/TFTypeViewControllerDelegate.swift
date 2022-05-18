//
//  TFTypeViewControllerDelegate.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 11.05.2022.
//

import Foundation
import UIKit


class TFTypeViewControllerDelegate: UIViewController {
    
    private var customAnimationCircle: CustomAnimationCircle = CustomAnimationCircle()
    private var customTiming: Double = 2.0
    
    func animate(for unit: @escaping () -> TrafficLightUnit) {}
    
    func animateLight(_ imageView: UIImageView,
                              with unit: TrafficLightUnit,
                              complition: @escaping () -> TrafficLightUnit, autoreverse: Bool = true) {
        let flashCount: Float = 5.0
        let duration = 0.2
        let delay = self.customTiming
        
        let onAnimation = imageView.turnOn(changeState: complition)
        let offAnimation = imageView.turnOff(changeState: complition)
        let prepareAnimation = autoreverse ? imageView.flash(count: flashCount,
                                                             duration: duration,
                                                             delay: delay,
                                                             changeState: complition) : imageView.wait(delay: delay * 2, changeState: complition)
        
        let customOffAnimation = CustomAnimation(animation: offAnimation, next: nil)
        let customPrepareAnimation = CustomAnimation(animation: prepareAnimation, next: customOffAnimation)
        let customOnAnimation = CustomAnimation(animation: onAnimation, next: customPrepareAnimation)
        
        self.customAnimationCircle.animation = customOnAnimation
        self.customAnimationCircle.layer = imageView.layer
        self.customAnimationCircle.run(for: self.customAnimationCircle.animation!, complition: self.animate, changeState: complition)
    }
    
    func cancelAnimations() {
        self.customAnimationCircle.stop()
    }
    
    func changeTiming(to time: Double) {
        self.customTiming = time
    }
    
    func changeColors(to colors: [String]) {}
}
