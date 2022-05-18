//
//  SecondTypeViewController.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 08.05.2022.
//

import UIKit

class SecondTypeViewController: TFTypeViewControllerDelegate {

    @IBOutlet var secondTypeView: SecondTypeTrafficLightView!
    
    private var customAnimationCircle: CustomAnimationCircle = CustomAnimationCircle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.secondTypeView.topLightImage.backgroundColor = UIColor(named: "Red")
        self.secondTypeView.bottomLightImage.backgroundColor = UIColor(named: "Green")
        
        self.secondTypeView.topLightImage.layer.opacity = 0.0
        self.secondTypeView.bottomLightImage.layer.opacity = 0.0
        
        self.setupTrafficLightView()
    }
    
    private func setupTrafficLightView() {
        self.view.layer.shadowRadius = 100.0
        self.view.layer.shadowOpacity = 0.7
        self.view.layer.shadowColor = UIColor(red: 1, green: 0.342, blue: 0, alpha: 0.5).cgColor
    }
    
    
    override func animate(for unit: @escaping () -> TrafficLightUnit) {
        let unitObject = unit()
        unowned let _self = self
        switch unitObject.name {
        case "top":
            _self.animateLight(_self.secondTypeView.topLightImage, with: unitObject, complition: unit)
        case "bottom":
            _self.animateLight(_self.secondTypeView.bottomLightImage, with: unitObject, complition: unit)
        default:
            print("Unkown element: \(unitObject.name)")
        }
    }
    
    override func changeColors(to colors: [String]) {
        guard colors.count == 2 else { print("Incorrect number of colors: \(colors.count)"); return }
        self.secondTypeView.topLightImage.backgroundColor = UIColor(named: colors[0])
        self.secondTypeView.bottomLightImage.backgroundColor = UIColor(named: colors[1])
    }
}

