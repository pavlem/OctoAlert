//
//  OctoAlertVC.swift
//  OPIAlert
//
//  Created by Pavle Mijatovic on 6/15/18.
//  Copyright © 2018 Pavle Mijatovic. All rights reserved.
//

import UIKit

protocol OctoAlertVCDelegate: class {
    func cancelAction(identifier: String?)
    func confirmAction(identifier: String?)
}

extension OctoAlertVCDelegate {
    func cancelAction(identifier: String?) {}
    func confirmAction(identifier: String?) {}
}

class OctoAlertVC: UIViewController {
    
    // MARK: - API
    weak var delegate: OctoAlertVCDelegate?
    
    func set(title: String?, message: String, confirmBtnTitle: String? = nil, cancelBtnTitle: String? = nil, confirmIdentifier: String? = nil, cancelIdentifier: String? = nil) {
        self.alertTitleText = title
        self.alertMessageText = message
        self.confirmIdentifier = confirmIdentifier
        self.cancelIdentifier = cancelIdentifier
        self.okBtnTitle = confirmBtnTitle
        self.cancelBtnTitle = cancelBtnTitle
        view.backgroundColor = UIColor.clear
        modalPresentationStyle = .overFullScreen
    }
    
    func set(title: String?, bulitedMessage: [String], bulit: String? = "•", confirmBtnTitle: String? = nil, cancelBtnTitle: String? = nil, confirmIdentifier: String? = nil, cancelIdentifier: String? = nil) {
        self.bulit = bulit
        self.alertMessageBulitText = bulitedMessage
        self.alertTitleText = title
        self.confirmIdentifier = confirmIdentifier
        self.cancelIdentifier = cancelIdentifier
        self.okBtnTitle = confirmBtnTitle
        self.cancelBtnTitle = cancelBtnTitle
        view.backgroundColor = UIColor.clear
        modalPresentationStyle = .overFullScreen
    }
    
    // Buttons
    var okBtnTint = UIColor.white
    var okBtnBackgroundColor = lightPurple
    var cancelBtnTint = lightPurple
    var cancelBtnBackgroundColor = UIColor.clear
    var contentContanierBackgroundColor = UIColor.white
    // Fonts
    var bulitedTextFont = systemFontRegular15
    var bulitedTextFontColor = UIColor.gray
    var bulitedTextLinespacing: CGFloat = 6
    var textFont = systemFontRegular15
    var textFontColor = lightBlack
    var titleFont = systemFontSemibold22
    var titleFontColor = lightBlack
    var okBtnTitleFont = systemFontSemibold17
    var cancelBtnTitleFont = systemFontSemibold17
    
    // MARK: - Properties
    // MARK: Constants
    static let lightBlack = UIColor(red: 0.13, green:0.15, blue:0.19, alpha:0.9)
    static let lightPurple = UIColor(red: 0.25, green:0.3, blue:0.72, alpha:1)
    static let systemFontSemibold17 = UIFont.systemFont(ofSize: 17, weight: .semibold)
    static let systemFontSemibold22 = UIFont.systemFont(ofSize: 22, weight: .semibold)
    static let systemFontRegular15 = UIFont.systemFont(ofSize: 15, weight: .regular)
    // MARK: Vars
    private var alertMessageBulitText: [String]?
    private var bulit: String?
    private var alertTitleText: String?
    private var alertMessageText: String?
    private var confirmIdentifier: String?
    private var cancelIdentifier: String?
    private var okBtnTitle: String?
    private var cancelBtnTitle: String?
    // MARK: Constants
    let btnCornerRadius: CGFloat = 4
    let contentContainerCornerRadius: CGFloat = 6
    let containerTopPadding: CGFloat = 20
    let containerBottomPadding: CGFloat = 20
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setTableView()
        setUIComponents()
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateBachgroundFadeIn()
    }
    
    // MARK: - Actions
    @IBAction func cancelAction(_ sender: UIButton) {
        delegate?.cancelAction(identifier: cancelIdentifier)
        dismissOctoAlert()
    }
    
    @IBAction func okAction(_ sender: UIButton) {
        delegate?.confirmAction(identifier: confirmIdentifier)
        dismissOctoAlert()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        dismissOctoAlert()
    }
    
    // MARK: - Helper
    private func animateBachgroundFadeIn() {
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
    private func setUIComponents() {
        setContentContainerLimits()
        
        set(button: okBtn, title: okBtnTitle, btnHeightCsrt: okBtnHeight, font: okBtnTitleFont)
        set(button: cancelBtn, title: cancelBtnTitle, btnHeightCsrt: cancelBtnHeight, font: cancelBtnTitleFont)
        
        if cancelBtnTitle == nil {
            csrtOkBtnDown.constant = 0
        }
        
        guard alertTitleText != nil else {
            cstrTitleDown.constant = 0
            alertTitle.frame.size.height = 0
            alertTitle.text = ""
            alertTitle.isHidden = true
            
            return
        }
        
        alertTitle.text = alertTitleText
        alertTitle.font = titleFont
        alertTitle.textColor = titleFontColor
    }
    
    private func setBtnsUI() {
        okBtn.backgroundColor = okBtnBackgroundColor
        okBtn.tintColor = okBtnTint
        cancelBtn.backgroundColor = cancelBtnBackgroundColor
        cancelBtn.tintColor = cancelBtnTint
    }
    
    private func setUI() {
        contentContainerView.backgroundColor = contentContanierBackgroundColor
        setBtnsUI()
        setContentContainerAndBtnsCornerRadius()
    }
    
    private func setContentContainerAndBtnsCornerRadius() {
        okBtn.layer.cornerRadius = btnCornerRadius
        cancelBtn.layer.cornerRadius = btnCornerRadius
        contentContainerView.layer.cornerRadius = contentContainerCornerRadius
    }
    
    private func setContentContainerLimits() {
        let limitHeight = (UIApplication.shared.keyWindow?.frame.height)! - (containerTopPadding + containerBottomPadding)
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
    
    private func set(button: UIButton, title: String?, btnHeightCsrt: NSLayoutConstraint, font: UIFont) {
        guard title != nil else {
            btnHeightCsrt.constant = 0
            button.isHidden = true
            button.setTitle("", for: .normal)
            return
        }
        
        button.setTitle(title!, for: .normal)
        button.titleLabel?.font = font
    }
    
    private func dismissOctoAlert() {
        contentContainerView.isHidden = true
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.view.backgroundColor = self.view.backgroundColor?.withAlphaComponent(0.0)
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    private func add(stringList: [String], font: UIFont, bullet: String = "\u{2022}", indentation: CGFloat = 20, lineSpacing: CGFloat = 1.6, paragraphSpacing: CGFloat = 12, textColor: UIColor = .gray, bulletColor: UIColor = .gray) -> NSAttributedString {
        
        let textAttributes = [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: textColor]
        let bulletAttributes = [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: bulletColor]
        
        let paragraphStyle = NSMutableParagraphStyle()
        let nonOptions = [NSTextTab.OptionKey: Any]()
        paragraphStyle.tabStops = [
            NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
        paragraphStyle.defaultTabInterval = indentation
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.headIndent = indentation
        
        let bulletList = NSMutableAttributedString()
        for string in stringList {
            let formattedString = "\(bullet)\t\(string)\n"
            let attributedString = NSMutableAttributedString(string: formattedString)
            
            attributedString.addAttributes( [NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            
            attributedString.addAttributes( textAttributes, range: NSMakeRange(0, attributedString.length))
            
            let string = NSString(string: formattedString)
            let rangeForBullet = string.range(of: bullet)
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
        cell.textLabel?.textColor = (alertMessageText != nil) ? OctoAlertVC.lightBlack : UIColor.gray
        cell.textLabel?.numberOfLines = 0
        if alertMessageText != nil {
            cell.textLabel?.text = alertMessageText
            cell.textLabel?.font = OctoAlertVC.systemFontRegular15
        } else if alertMessageBulitText != nil {
            cell.textLabel?.attributedText = add(stringList: alertMessageBulitText!, font: bulitedTextFont, bullet: bulit ?? "", lineSpacing: bulitedTextLinespacing, textColor: bulitedTextFontColor, bulletColor: bulitedTextFontColor)
        }
        return cell
    }
}
