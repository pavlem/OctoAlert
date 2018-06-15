//
//  OctoAlertVC.swift
//  OPIAlert
//
//  Created by Pavle Mijatovic on 6/15/18.
//  Copyright © 2018 Pavle Mijatovic. All rights reserved.
//

import UIKit

protocol OctoAlertVCDelegate: class {
    func cancelAction()
    func confirmAction()
}

extension OctoAlertVCDelegate {
    func cancelAction() {}
    func confirmAction() {}
}

class OctoAlertVC: UIViewController {
    
    // MARK: - API
    weak var delegate: OctoAlertVCDelegate?
    
    var arrayString = [
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    ]
    
    var bulit: String?
    
    // MARK: - Outlets
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var opiLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        alertTitle.text = "Paja TITLE"
        
        //        tableView.layoutIfNeeded()
        tableView.layoutSubviews()
        
        
//        tvHeight.constant = tableView.contentSize.height > 300 ? 300 : tableView.contentSize.height
        
        tvHeight.constant = tableView.contentSize.height

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        }
    }
    
    
    // MARK: - Actions
    @IBAction func cancelAction(_ sender: UIButton) {
        delegate?.cancelAction()
        dismissOctoAlert()
    }
    
    @IBAction func okAction(_ sender: UIButton) {
        delegate?.confirmAction()
        dismissOctoAlert()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        dismissOctoAlert()
    }
    
    // MARK: - Helper
    func dismissOctoAlert() {
        alertTitle.isHidden = true
        okBtn.isHidden = true
        cancelBtn.isHidden = true
        tableView.isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = self.view.backgroundColor?.withAlphaComponent(0.0)
            self.containerView.backgroundColor = self.containerView.backgroundColor?.withAlphaComponent(0.0)
            
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func add(stringList: [String],
             font: UIFont,
             bullet: String = "\u{2022}",
             indentation: CGFloat = 20,
             lineSpacing: CGFloat = 2,
             paragraphSpacing: CGFloat = 12,
             textColor: UIColor = .gray,
             bulletColor: UIColor = .red) -> NSAttributedString {
        
        let textAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: textColor]
        let bulletAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: bulletColor]
        
        let paragraphStyle = NSMutableParagraphStyle()
        let nonOptions = [NSTextTab.OptionKey: Any]()
        paragraphStyle.tabStops = [
            NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
        paragraphStyle.defaultTabInterval = indentation
        //paragraphStyle.firstLineHeadIndent = 0
        //paragraphStyle.headIndent = 20
        //paragraphStyle.tailIndent = 1
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.headIndent = indentation
        
        let bulletList = NSMutableAttributedString()
        for string in stringList {
            let formattedString = "\(bullet)\t\(string)\n"
            let attributedString = NSMutableAttributedString(string: formattedString)
            
            attributedString.addAttributes(
                [NSAttributedStringKey.paragraphStyle : paragraphStyle],
                range: NSMakeRange(0, attributedString.length))
            
            attributedString.addAttributes(
                textAttributes,
                range: NSMakeRange(0, attributedString.length))
            
            let string:NSString = NSString(string: formattedString)
            let rangeForBullet:NSRange = string.range(of: bullet)
            attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
            bulletList.append(attributedString)
        }
        
        return bulletList
    }
}

// MARK: - UIGestureRecognizerDelegate
extension OctoAlertVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if containerView.bounds.contains(touch.location(in: containerView)) {
            return false
        }
        return true
    }
}

extension OctoAlertVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlertCell", for: indexPath)
        cell.textLabel?.textColor = UIColor.lightGray
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.attributedText = add(stringList: arrayString, font: (cell.textLabel?.font)!, bullet: bulit ?? "")
        return cell
    }
}















