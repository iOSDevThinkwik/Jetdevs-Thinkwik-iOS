//
//  viewController+Extensions.swift
//  JetDevsHomeWork
//
//  Created by Hemang Solanki on 14/12/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showToast(message : String, font: UIFont = UIFont.latoRegularFont(size: 16),isMenu:Bool = false) {
        let viewToast = UIView.init()
        viewToast.tag = -1904
        viewToast.backgroundColor = UIColor.black.withAlphaComponent(1)
        viewToast.translatesAutoresizingMaskIntoConstraints = false
        viewToast.layer.cornerRadius = 10;
        viewToast.clipsToBounds  =  true
        viewToast.alpha = 1.0
        if let taglist = self.view.viewWithTag(-1904){
            taglist.isHidden = true
            taglist.removeFromSuperview()
        }
        self.view.addSubview(viewToast)
        var bottomValue = -50

        if isMenu {
            bottomValue = -140
        }else{
            bottomValue = -80
        }

        let bottomConst = NSLayoutConstraint.init(item: viewToast as Any, attribute: .bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: .bottom, multiplier: 1, constant: CGFloat(bottomValue))
        let leadingConst = NSLayoutConstraint.init(item: viewToast as Any, attribute: .leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: .leading, multiplier: 1, constant: 60)
        let trailingConst = NSLayoutConstraint.init(item: viewToast as Any, attribute: .trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -60)
        self.view.addConstraint(leadingConst)
        self.view.addConstraint(trailingConst)
        self.view.addConstraint(bottomConst)
        self.view.layoutSubviews()

        let toastLabel = UILabel()
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.numberOfLines = 0
        //        toastLabel.sizeToFit()
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        viewToast.addSubview(toastLabel)

        let labelTopConst = NSLayoutConstraint.init(item: toastLabel as Any, attribute: .top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewToast, attribute: .top, multiplier: 1, constant: 10)
        let labelBottomConst = NSLayoutConstraint.init(item: toastLabel as Any, attribute: .bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewToast, attribute: .bottom, multiplier: 1, constant: -10)
        let labelLeadingConst = NSLayoutConstraint.init(item: toastLabel as Any, attribute: .leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewToast, attribute: .leading, multiplier: 1, constant: 20)
        let labelTrailingConst = NSLayoutConstraint.init(item: toastLabel as Any, attribute: .trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewToast, attribute: .trailing, multiplier: 1, constant: -20)

        viewToast.addConstraints([labelTopConst, labelBottomConst, labelLeadingConst, labelTrailingConst])
        viewToast.layoutSubviews()
        self.view.layoutSubviews()
        UIView.animate(withDuration: 1.0, delay: 2, options: .curveEaseOut, animations: {
            viewToast.alpha = 0.0
        }, completion: {
            (isCompleted) in
            viewToast.removeFromSuperview()
        })
    }
    
    func makePullToRefreshToCollectionView(collectionView: UICollectionView, triggerMethod: Selector){
        let collectionRefreshControl:UIRefreshControl = UIRefreshControl()
        collectionRefreshControl.backgroundColor = UIColor.clear
        collectionRefreshControl.addTarget(self, action: triggerMethod, for: UIControl.Event.valueChanged)
        collectionView.refreshControl = collectionRefreshControl
    }
    
    func endRefreshing(collectionView: UICollectionView){
        collectionView.refreshControl?.endRefreshing()
    }
    
    func makePullToRefreshToTableView(tableView: UITableView, triggerMethod: Selector){
        let tableRefreshControl:UIRefreshControl = UIRefreshControl()
        tableRefreshControl.backgroundColor = UIColor.clear
        tableRefreshControl.addTarget(self, action: triggerMethod, for: UIControl.Event.valueChanged)
        tableView.refreshControl = tableRefreshControl
    }
    
    func endRefreshing(tableView: UITableView){
        tableView.refreshControl?.endRefreshing()
    }
    
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor = .red
        let someAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(someAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func bindKeyboard(to constraint: NSLayoutConstraint) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main) { [weak self, weak constraint] notification in
            guard let info = notification.userInfo else { return }
            guard let height = (info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size.height else { return }
            guard constraint?.constant != height else { return }
            constraint?.constant = height + 5
            self?.view.layoutIfNeeded()
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main) { [weak self, weak constraint] notification in
            guard constraint?.constant != 0 else { return }
            guard let info = notification.userInfo else { return }
            guard ((info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size.height) != nil else { return }
            constraint?.constant = 20
            self?.view.layoutIfNeeded()
        }
    }
    
    func hideNavigationBar(){
        self.navigationController?.navigationBar.isHidden = true
    }
    
}
