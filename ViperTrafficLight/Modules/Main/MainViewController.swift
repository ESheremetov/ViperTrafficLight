//
//  MainViewController.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 06.05.2022.
//

import UIKit


protocol MainViewProtocol: AnyObject {
    func showLoadingIndicator()
    func cancelLoadingIndicator()
    func toggleBulb()
    func setBulbState(isOn: Bool)
    func disableTrafficLight()
    func enableTrafficLight()
}


class MainViewController: UIViewController, MainViewProtocol {
    
    
    // MARK: -- OUTLETS
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    // MARK: -- ACTIONS
    @IBAction func reloadButtonAction(_ sender: UIButton) {
        self.presenter.reloadButtonClicked()
    }
    @IBAction func settingsButtonAction(_ sender: UIButton) {
        self.presenter.settingsButtonClicked()
    }
    @IBAction func startButtonAction(_ sender: UIButton) {
        self.presenter.startButtonClicked()
    }
    @IBOutlet weak var firstTypeView: UIView!
    @IBOutlet weak var secondTypeView: UIView!
    
    weak var loadSpinner: UIView?
    
    // MARK: -- PROPERTIES
    var presenter: MainPresenterProtocol!
    let configurator: MainConfiguratorProtocol! = MainConfigurator()
    
    var firstTypeController: FirstTypeViewController!
    var secondTypeController: SecondTypeViewController!

    // MARK: -- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView(self.firstTypeController, self.secondTypeController)
        
        self.reloadButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        self.reloadButton.tintColor = .white
        self.reloadButton.clipsToBounds = true
        self.reloadButton.setTitle("", for: .normal)
        self.reloadButton.layer.cornerRadius = 15.0
        self.reloadButton.layer.backgroundColor = UIColor(red: 1, green: 0.342, blue: 0, alpha: 0.5).cgColor
        
        self.settingsButton.setImage(UIImage(systemName: "gear"), for: .normal)
        self.settingsButton.tintColor = .white
        self.settingsButton.clipsToBounds = true
        self.settingsButton.setTitle("", for: .normal)
        self.settingsButton.layer.cornerRadius = 15.0
        self.settingsButton.layer.backgroundColor = UIColor(red: 1, green: 0.342, blue: 0, alpha: 0.5).cgColor
        
        self.startButton.setImage(UIImage(systemName: "lightbulb.fill"), for: .normal)
        self.startButton.tintColor = .white
        self.startButton.clipsToBounds = true
        self.startButton.setTitle("", for: .normal)
        self.startButton.layer.cornerRadius = 15.0
        self.startButton.layer.backgroundColor = UIColor(red: 1, green: 0.342, blue: 0, alpha: 0.5).cgColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier {
            if segueId == "toFirstType" {
                self.firstTypeController = (segue.destination as! FirstTypeViewController)
            } else if segueId == "toSecondType" {
                self.secondTypeController = (segue.destination as! SecondTypeViewController)
            }
        }
    }
    
    func toggleBulb() {
        self.startButton.tintColor = self.startButton.tintColor == .white ? UIColor(named: "Gold") : .white
    }
    
    func setBulbState(isOn: Bool) {
        self.startButton.tintColor = isOn ? UIColor(named: "Gold") : .white
    }
    
    func disableTrafficLight() {
        self.startButton.isEnabled = false
    }
    
    func enableTrafficLight() {
        self.startButton.isEnabled = true
    }
    
    func showLoadingIndicator() {
        let spinnerView = UIView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        spinnerView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 5)
        spinnerView.backgroundColor = UIColor(red: 1, green: 0.342, blue: 0, alpha: 0.5)
        spinnerView.clipsToBounds = true
        
        spinnerView.layer.cornerRadius = 20.0
        
        let indicator = UIActivityIndicatorView.init(style: .large)
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.center = CGPoint(x: (spinnerView.frame.width) / 2, y: (spinnerView.frame.height) / 2)
        indicator.color = .white
        
        indicator.startAnimating()
        DispatchQueue.main.async { [ unowned self ] in
            spinnerView.addSubview(indicator)
            self.view.addSubview(spinnerView)
        }
        
        self.loadSpinner = spinnerView
    }
    
    func cancelLoadingIndicator() {
        DispatchQueue.main.async { [ unowned self ] in
            self.loadSpinner?.removeFromSuperview()
            self.loadSpinner = nil
        }
    }
}
