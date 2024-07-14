//
//  LandscapeViewController.swift
//  LocationServices
//
//  Created by Nadav Avnon on 11/07/2024.
//

import Foundation

import UIKit

class LandscapeViewController : UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
 
    
    override var shouldAutorotate: Bool {
        return true
    }
}
