//
//  FirstTypeViewController.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 08.05.2022.
//

import UIKit


class FirstTypeViewController: TFTypeViewControllerDelegate {
    
    //TODO: add stop animation
    
    @IBOutlet var firstTypeView: FirstTypeTrafficLightView!
                
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstTypeView.topLightImage.backgroundColor = UIColor(named: "Red")
        self.firstTypeView.middleLightImage.backgroundColor = UIColor(named: "Yellow")
        self.firstTypeView.bottomLightImage.backgroundColor = UIColor(named: "Green")
        
        self.firstTypeView.topLightImage.layer.opacity = 0.0
        self.firstTypeView.middleLightImage.layer.opacity = 0.0
        self.firstTypeView.bottomLightImage.layer.opacity = 0.0
        
        self.setupTrafficLightView()
    }
    
    private func setupTrafficLightView() {
        self.view.layer.shadowRadius = self.view.frame.width * 100 / self.view.frame.height
        self.view.layer.shadowOpacity = 0.7
        self.view.layer.shadowColor = UIColor(red: 1, green: 0.342, blue: 0, alpha: 0.5).cgColor
    }
    
    override func animate(for unit: @escaping () -> TrafficLightUnit) {
        let unitObject = unit()
        unowned let _self = self
        switch unitObject.name {
        case "top":
            _self.animateLight(_self.firstTypeView.topLightImage, with: unitObject, complition: unit)
        case "middle":
            _self.animateLight(_self.firstTypeView.middleLightImage, with: unitObject, complition: unit, autoreverse: false)
        case "bottom":
            _self.animateLight(_self.firstTypeView.bottomLightImage, with: unitObject, complition: unit)
        default:
            print("Unkown element: \(unitObject.name)")
        }
    }
    
    override func changeColors(to colors: [String]) {
        guard colors.count == 3 else { print("Incorrect number of colors: \(colors.count)"); return }
        self.firstTypeView.topLightImage.backgroundColor = UIColor(named: colors[0])
        self.firstTypeView.middleLightImage.backgroundColor = UIColor(named: colors[1])
        self.firstTypeView.bottomLightImage.backgroundColor = UIColor(named: colors[2])
    }
}
