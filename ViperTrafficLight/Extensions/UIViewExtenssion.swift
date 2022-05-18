//
//  UIViewExtenssion.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 07.05.2022.
//

import Foundation
import UIKit


// NIB LOAD
extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}

// ANIMATIONS
extension UIView {
    func turnOn(changeState: @escaping () -> TrafficLightUnit) -> CABasicAnimation {
        _ = changeState()
        let onAnimation = CABasicAnimation(keyPath: "opacity")
        onAnimation.fillMode = .forwards
        onAnimation.isRemovedOnCompletion = false
        onAnimation.fromValue = 0
        onAnimation.toValue = 1
        onAnimation.duration = 0.01
        onAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        return onAnimation
    }
    
    func flash(count: Float, duration: Double, delay: Double, changeState: @escaping () -> TrafficLightUnit) -> CABasicAnimation {
        _ = changeState()
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.fillMode = .forwards
        flash.isRemovedOnCompletion = false
        flash.beginTime = CACurrentMediaTime() + delay
        flash.duration = duration
        flash.fromValue = 1
        flash.toValue = 0
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = count
        return flash
    }
    
    func wait(delay: Double, changeState: @escaping () -> TrafficLightUnit) -> CABasicAnimation {
        _ = changeState()
        let wait = CABasicAnimation(keyPath: "opacity")
        wait.fillMode = .forwards
        wait.isRemovedOnCompletion = false
        wait.beginTime = CACurrentMediaTime() + delay
        wait.duration = 0.001
        wait.fromValue = 0.999
        wait.toValue = 1
        wait.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        return wait
    }
    
    func turnOff(changeState: @escaping () -> TrafficLightUnit) -> CABasicAnimation {
        let offAnimation = CABasicAnimation(keyPath: "opacity")
        offAnimation.fillMode = .forwards
        offAnimation.isRemovedOnCompletion = false
        offAnimation.fromValue = 1
        offAnimation.toValue = 0
        offAnimation.duration = 0.01
        offAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        return offAnimation
    }
}
