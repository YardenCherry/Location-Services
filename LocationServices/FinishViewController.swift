//
//  FinishViewController.swift
//  LocationServices
//
//  Created by Nadav Avnon on 14/07/2024.
//

import UIKit

class FinishViewController: UIViewController {
    @IBOutlet weak var winnerLabel: UILabel!
    
    var winner: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let winner = winner {
            self.winnerLabel.text = "The winner is \(winner)"
        }
    }
    

    @IBAction func backToMenu(_ sender: Any) {
        UIApplication.shared.windows.first?.rootViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "StartScreen")
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
