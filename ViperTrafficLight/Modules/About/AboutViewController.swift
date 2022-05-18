//
//  AboutViewController.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 06.05.2022.
//

import UIKit


protocol AboutViewProtocol: AnyObject {
    func setUrlButtonTitle(with title: String)
}

class AboutViewController: UIViewController, AboutViewProtocol {
    
    // MARK: -- OUTLETS
    
    @IBOutlet weak var urlButton: UIButton!
    
    // MARK: -- ACTIONS
    
    @IBAction func urlButtonAction(_ sender: UIButton) {
        self.presenter.urlButtonClicked(with: sender.currentTitle)
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.presenter.closeButtonClicked()
    }
    
    // MARK: -- PROPERTIES
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    var presenter: AboutPresenterProtocol!
    let configurator: AboutConfiguratorProtocol = AboutConfigurator()

    // MARK: -- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    // MARK: -- PROTOCOL IMPLEMENTATION
    func setUrlButtonTitle(with title: String) {
        self.urlButton.setTitle(title, for: .normal)
    }
}
