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
            
            vc.set(title: nil, bulitedMessage: MocData.bulitedTxtLong)
            
//            vc.setBulitTxt("", arrayOfText: MocData.bulitedTxtLong)
//            vc.messageLblText = MocData.lblTxt
            vc.delegate = self
            vc.okBtnTitle = "OK_PAJA"
            vc.cancelBtnTitle = "CANCEL_PAJA"
            vc.alertTitleText = "PAKI TEST"
            
            present(vc, animated: false, completion: nil)
        }
    }
}

extension ViewController: OctoAlertVCDelegate {
    func cancelAction() {
        print("cancelAction")
    }
    
    func confirmAction() {
        print("confirmAction")
    }
}

