//
//  ViewController.swift
//  OPIAlert
//
//  Created by Pavle Mijatovic on 6/15/18.
//  Copyright © 2018 Pavle Mijatovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func testAction(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OctoAlertVC_ID") as? OctoAlertVC {
            vc.view.backgroundColor = UIColor.clear
            vc.modalPresentationStyle = .overFullScreen
            vc.bulit = "#"
            vc.arrayString = [
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
            ]
            present(vc, animated: false, completion: nil)
        }
    }
}


