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
    
    func set(title: String?, message: String) {
        alertTitleText = title
        alertMessageText = message
    }
    
    func set(title: String?, bulitedMessage: [String], bulit: String? = "•") {
        self.bulit = bulit
        self.arrayString = bulitedMessage
        self.title = title
    }

    var alertTitleText: String?
    var alertMessageText: String?
    var okBtnTitle: String?
    var cancelBtnTitle: String?
    
    var okBtnTint = UIColor.white
    var okBtnBackgroundColor = UIColor(red:0.25, green:0.3, blue:0.72, alpha:1)
    var cancelBtnTint = UIColor(red:0.25, green:0.3, blue:0.72, alpha:1)
    var cancelBtnBackgroundColor = UIColor.clear
    var contentContanierBackgroundColor = UIColor.white
    

    var bulitedTextFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    var bulitedTextFontColor = UIColor.gray
    var bulitedTextLinespacing: CGFloat = 6
    
    
    var textFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    var textFontColor = UIColor(red:0.13, green:0.15, blue:0.19, alpha:0.9)
    
    var titleFont = UIFont.systemFont(ofSize: 22, weight: .semibold)
    var titleFontColor = UIColor(red:0.13, green:0.15, blue:0.19, alpha:0.9)
    
    var okBtnTitleFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
    var cancelBtnTitleFont = UIFont.systemFont(ofSize: 17, weight: .semibold)


    // MARK: - Properties
    // MARK: Vars
    private var arrayString: [String]?
    private var bulit: String?
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    // Outlet - constraints
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var cstrTitleUp: NSLayoutConstraint!
    @IBOutlet weak var cstrTitleDown: NSLayoutConstraint!
    @IBOutlet weak var cstrTVDown: NSLayoutConstraint!
    @IBOutlet weak var okBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var csrtOkBtnDown: NSLayoutConstraint!
    @IBOutlet weak var cancelBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var csrtCancelBtnDown: NSLayoutConstraint!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapGestureOnMainView()
    }
    
    func setBtnsUI() {
        okBtn.backgroundColor = okBtnBackgroundColor
        okBtn.tintColor = okBtnTint
        cancelBtn.backgroundColor = cancelBtnBackgroundColor
        cancelBtn.tintColor = cancelBtnTint
    }
    
    
    func setUI() {
        contentContainerView.backgroundColor = contentContanierBackgroundColor
        setBtnsUI()
        setContentContainerAndBtnsCornerRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        setTableView()
        setContentContainerLimits()
        
        // BTNS
        if okBtnTitle == nil {
            okBtnHeight.constant = 0
            okBtn.isHidden = true
            okBtn.setTitle("", for: .normal)
        } else {
            okBtn.setTitle(okBtnTitle!, for: .normal)
            okBtn.titleLabel?.font = okBtnTitleFont
        }
        
        if cancelBtnTitle == nil {
            cancelBtnHeight.constant = 0
            cancelBtn.isHidden = true
            cancelBtn.setTitle("", for: .normal)
        } else {
            cancelBtn.setTitle(cancelBtnTitle!, for: .normal)
            cancelBtn.titleLabel?.font = cancelBtnTitleFont
        }

        if alertTitleText == nil {
            cstrTitleDown.constant = 0
            alertTitle.frame.size.height = 0
            alertTitle.text = ""
            alertTitle.isHidden = true
        } else {
            alertTitle.text = alertTitleText
            alertTitle.font = titleFont
            alertTitle.textColor = titleFontColor
        }
        
        setUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
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
    func setContentContainerAndBtnsCornerRadius() {
        okBtn.layer.cornerRadius = 4
        cancelBtn.layer.cornerRadius = 4
        contentContainerView.layer.cornerRadius = 6
    }
    
    private func setContentContainerLimits() {
        let limitHeight = (UIApplication.shared.keyWindow?.frame.height)! - 2*20
        let expandableHeight = cstrTitleUp.constant + alertTitle.frame.size.height + cstrTitleDown.constant + tableView.contentSize.height + cstrTVDown.constant + okBtnHeight.constant + csrtOkBtnDown.constant + cancelBtnHeight.constant + csrtCancelBtnDown.constant
        if expandableHeight > limitHeight {
            tvHeight.constant = limitHeight - (cstrTitleUp.constant + alertTitle.frame.size.height + cstrTitleDown.constant + cstrTVDown.constant + okBtnHeight.constant + csrtOkBtnDown.constant + cancelBtnHeight.constant + csrtCancelBtnDown.constant)
        } else {
            tvHeight.constant = tableView.contentSize.height
            tableView.bounces = false
        }
    }

    private func addTapGestureOnMainView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.layoutSubviews()
    }
    
    func dismissOctoAlert() {
        alertTitle.isHidden = true
        okBtn.isHidden = true
        cancelBtn.isHidden = true
        tableView.isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = self.view.backgroundColor?.withAlphaComponent(0.0)
            self.contentContainerView.backgroundColor = self.contentContainerView.backgroundColor?.withAlphaComponent(0.0)
            
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func add(stringList: [String],
             font: UIFont,
             bullet: String = "\u{2022}",
             indentation: CGFloat = 20,
             lineSpacing: CGFloat = 1.6,
             paragraphSpacing: CGFloat = 12,
             textColor: UIColor = .gray,
             bulletColor: UIColor = .gray) -> NSAttributedString {
        
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
            
            let string = NSString(string: formattedString)
            let rangeForBullet: NSRange = string.range(of: bullet)
            attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
            bulletList.append(attributedString)
        }
        
        return bulletList
    }
}

// MARK: - UIGestureRecognizerDelegate
extension OctoAlertVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if contentContainerView.bounds.contains(touch.location(in: contentContainerView)) {
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
        
        if alertMessageText != nil {
            cell.textLabel?.text = alertMessageText
        } else if arrayString != nil {
//            cell.textLabel?.attributedText = add(stringList: arrayString!, font: (cell.textLabel?.font)!, bullet: bulit ?? "")
            
            cell.textLabel?.attributedText = add(stringList: arrayString!, font: bulitedTextFont, bullet: bulit ?? "", lineSpacing: bulitedTextLinespacing, textColor: bulitedTextFontColor, bulletColor: bulitedTextFontColor)
            
        }
        return cell
    }
}















