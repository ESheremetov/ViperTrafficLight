//
//  NibView.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 06.05.2022.
//

import UIKit


class NibTrafficLightView: UIView {
    
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func setupLights() {}
}

private extension NibTrafficLightView {
    
    func xibSetup() {
        backgroundColor = UIColor.clear
        view = loadNib()

        view.frame = bounds

        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view!]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view!]))
    }
}

