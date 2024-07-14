//
//  ViewController.swift
//  LocationServices
//
//

import UIKit
    
class StartScreen: UIViewController, LocationManagerDelegate,UITextFieldDelegate {
 
    @IBOutlet weak var westSideImage: UIImageView!
    
    @IBOutlet weak var eastSideImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var inputNameButton: UIButton!
    
    @IBOutlet weak var startButton: UIButton!
    let locationManager = LocationManager()
    var currentLocation: Location?
    let center = 34.817549168324334

    override func viewDidLoad() {
         super.viewDidLoad()
         locationManager.delegate  = self
         locationManager.requestLocation()
         initUI()
         
         inputNameButton.addAction(UIAction { [weak self] act in

             self?.showNameDialog()
         }, for: .touchUpInside)
        
        if let name = UserManager.instance.getUserName() {
            self.nameLabel.text = "Hi \(name)"
            self.inputNameButton.isHidden = true
            if currentLocation != nil  {
                self.startButton.isEnabled = true
            }
        }
        
        self.startButton.isEnabled = false
        self.startButton.addAction(UIAction { [weak self] act in
            if let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "GameViewController")
                as? GameViewController, 
                let location = self?.currentLocation,
                let strongSelf = self {
                vc.userName = UserManager.instance.getUserName()
                if location.lng < strongSelf.center {
                    vc.side = .West
                }
                else {
                    vc.side = .East
                }
                strongSelf.present(vc, animated: true)
            }
         
        }, for: .touchUpInside)
     }
     
    func didUpdateLocation(location: Location) {
        self.currentLocation = location
        if UserManager.instance.getUserName() != nil {
            self.startButton.isEnabled = true
        }
    }
    
    func didFailWithError(err: any Error) {
        let aController = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
        aController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { act in
            aController.dismiss(animated: true)
        }))
        present(aController, animated: true)
    }
    

    func showNameDialog() {
        let vc = UIAlertController(title: "Input Name", message: "Enter your name", preferredStyle: .alert)
        var textFieldOpt: UITextField?
        vc.addTextField { textField in
            textField.placeholder = "Enter your name"
            textFieldOpt = textField
        }
        vc.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [weak self] act in
            vc.dismiss(animated: true)
            if let text = textFieldOpt?.text {
                UserManager.instance.setUserName(userName: text)
                self?.nameLabel.text = "Hi \(text)"
                self?.inputNameButton.isHidden = true
                if self?.currentLocation != nil {
                    self?.startButton.isEnabled = true
                }
            }
        }))
        vc.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { act in
            vc.dismiss(animated: true)
        }))
        present(vc, animated: true)

    }
    
    func initUI() {
        
        westSideImage.image = UIImage(named: "west")
        eastSideImage.image = UIImage(named: "east")
    }
    

    

}

