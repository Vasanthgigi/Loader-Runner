//
//  RunnerViewController.swift
//  Loader-Runner
//
//  Created by Vasanth Rathnakumar on 2020-03-26.
//  Copyright © 2020 Vasanth Rathnakumar. All rights reserved.
//

import UIKit

class RunnerViewController: UIViewController {
    
    @IBOutlet weak private var searchTextField: UITextField!
    @IBOutlet weak private var runningLoaderIndicatorLeadingConstraints: NSLayoutConstraint!
    @IBOutlet weak private var runningLoaderIndicatorView: UIView!
    
    private let loaderWidth: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        stopRunnerLoading()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
    }
}

//MARK: Private Methods

private extension RunnerViewController {
    
    func setupSearchBar() {
        self.searchTextField.delegate = self
        self.searchTextField.becomeFirstResponder()
        self.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 128 / 255.0, green: 128 / 255.0, blue: 128 / 255.0, alpha: 1.0)])
    }
    
    func stopRunnerLoading() {
        self.runningLoaderIndicatorView.layer.removeAllAnimations()
        self.runningLoaderIndicatorLeadingConstraints.constant = 0
        self.runningLoaderIndicatorView.isHidden = true
    }
    
    @IBAction func editingChanged(_ sender: Any) {
        
        guard let textField = sender as? UITextField else {
            return
        }
        
        if (textField.text?.count)! < 3 {
            stopRunnerLoading()
        } else {
            startRunningLoader()
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func startRunningLoader() {
        let animationDuration: TimeInterval = 1.0
        self.runningLoaderIndicatorView.isHidden = false
        UIView.animate(withDuration: animationDuration, delay: 0, options: [.repeat, .autoreverse, .curveEaseInOut], animations: {
            self.runningLoaderIndicatorLeadingConstraints.constant = UIScreen.main.bounds.width - self.loaderWidth
            self.view.layoutIfNeeded()
        })
    }
}

//MARK: UITextFieldDelegate Delegate

extension RunnerViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
