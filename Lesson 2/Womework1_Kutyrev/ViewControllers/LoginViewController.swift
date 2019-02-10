//
//  LoginViewController.swift
//  Womework1_Kutyrev
//
//  Created by Yuriy Kutyrev on 26.01.2019.
//  Copyright © 2019 Yuriy Kutyrev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView?
    
    @IBOutlet private weak var titleLabel: UILabel?
    
    @IBOutlet private weak var loginHintLabel: UILabel?
    @IBOutlet private weak var loginTextField: UITextField?
    
    @IBOutlet private weak var passHintLabel: UILabel?
    @IBOutlet private weak var passTextField: UITextField?
    
    @IBOutlet private weak var loginButton: UIButton?
    @IBOutlet private weak var buttonToGreen: UIButton?
    
//    @IBAction func myUnwindAction(segue: UIStoryboardSegue) {
//
//    }

    private let demoLogin = "1"
    private let demoPass = "1"
    
    //Mark: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.addNotifiactions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addNotifiactions()
    }
    
    deinit {
        self.removeNotifications()
    }
    
    
    // Mark - Notifiactions
    
    private func addNotifiactions() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHidde(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func removeNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWasShown(notification: Notification) {
        guard let userInfo = notification.userInfo as NSDictionary? else {
            return
        }
        guard let keyboardFrame = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {
            return
        }
        
        let keyboardHeight = keyboardFrame.cgRectValue.size.height
        let contentInsets = UIEdgeInsets(top: 0.0,
                                         left: 0.0,
                                         bottom: keyboardHeight,
                                         right: 0.0)
                                         
        self.scrollView?.contentInset = contentInsets
        self.scrollView?.scrollIndicatorInsets = contentInsets
        
    }
    
    @objc private func keyboardWillHidde(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        self.scrollView?.contentInset = contentInsets
        self.scrollView?.scrollIndicatorInsets = contentInsets
        
    }
    
        // MARK - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.green
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel?.text = "VK app"

        
        // Do any additional setup after loading the view.
    }

    // MARK - Actions
    
    @IBAction func loginButtonAction () {
        print("loginButtonAction")
        
        guard let loginText = self.loginTextField?.text else {
            print("Empty loginText")
            return
        }
        
        guard let passText = self.passTextField?.text else {
            print("Empty passText")
            return
        }
        
        if self.demoLogin == loginText && self.demoPass == passText {
            print("Success")
            self.performSegue(withIdentifier: "openApp", sender: nil)
            } else {
                self.showErrorAlert()
                print("Invalid")
        }
    }
    
    @IBAction func closeKeyboardAction () {
        self.view.endEditing(true)
    }
    
    @IBAction func logOutAction(segue: UIStoryboardSegue?) {
//        let dastinationVC = segue?.destination  // login
//        let sourse = segue?.source              //My profile
    }
    
    
    
    func showErrorAlert() {
        
        let alertController = UIAlertController(title: "Error", message: "Wrong login or pass", preferredStyle: .alert)
        
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action: UIAlertAction) in
            print("AlertOkAction")
        }
        
        alertController.addAction(alertCancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare \(String(describing: segue.identifier))")
        
        if let identifier = segue.identifier, identifier == "openApp" {
            if let destinationVC = segue.destination as? UITabBarController {
                destinationVC.selectedIndex = 1
            }
        }
        
    }
    
}
