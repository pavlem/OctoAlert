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
        if let vc = UIStoryboard(name: "OctoAlert", bundle: nil).instantiateViewController(withIdentifier: "OctoAlertVC_ID") as? OctoAlertVC {
            vc.set(title: "Channel icon guidelines", bulitedMessage: MocData.bulitedTxt, confirmBtnTitle: "OK", confirmIdentifier: "pajaC_ID", cancelIdentifier: "pajaCancel_ID")
            vc.delegate = self
            present(vc, animated: false, completion: nil)
        }
    }
}

extension ViewController: OctoAlertVCDelegate {
    func confirmAction(identifier: String?) {
        print(identifier ?? "")
        print("confirmAction")
    }
    
    func cancelAction(identifier: String?) {
        print(identifier ?? "")
        print("cancelAction")
    }
}
