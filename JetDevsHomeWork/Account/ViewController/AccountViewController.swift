//
//  AccountViewController.swift
//  JetDevsHomeWork
//
//  Created by Gary.yao on 2021/10/29.

import UIKit
import Kingfisher

typealias LoginResponseDelegate = (_ success: Bool) -> (Void)

class AccountViewController: UIViewController {

	@IBOutlet weak var nonLoginView: UIView!
	@IBOutlet weak var loginView: UIView!
	@IBOutlet weak var daysLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var headImageView: UIImageView!
    var user = UserDefaults.standard.getUserInfo()
    
	override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.navigationBar.isHidden = true
        nonLoginView.isHidden = false
        loginView.isHidden = true
    }
	
    @IBAction func loginButtonTap(_ sender: UIButton) {
        self.navigateToLoginView()
    }
    
    func navigateToLoginView() {
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        loginVC.handler = { response in
            if response {
                DispatchQueue.main.async {
                    if UserDefaults.standard.isUserLoggedIn() == true {
                        self.nonLoginView.isHidden = true
                        self.loginView.isHidden = false
                        if self.user != nil {
                            self.nameLabel.text = self.user?.userName ?? ""
                            let url = URL(string: self.user?.userProfileURL ?? "")
                            self.setDate(desireDate: self.user!.createdAt!)
                            self.headImageView.kf.setImage(with: url) } } else { self.nonLoginView.isHidden = false
                                self.loginView.isHidden = true }
                }
            }
        }
        let navigationController = UINavigationController(rootViewController: loginVC)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func setDate(desireDate: String) {
        let dateFromat = DateFormatter()
        dateFromat.timeZone = TimeZone(abbreviation: "UTC")
        dateFromat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFromat.date(from: desireDate)
        dateFromat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFromat.timeZone = TimeZone.current
        let strDate = dateFromat.string(from: date!)
        print(strDate)
        self.daysLabel.text = "Created \(dateFromat.date(from: strDate)?.getElapsedInterval() ?? "")"
    }
}
