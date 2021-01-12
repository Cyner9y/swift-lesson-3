//
//  ViewController.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 01.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    var timerSeconds = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.alpha = 0.5
        let progressStatusIndicator = ProgressStatusIndicator(frame: CGRect(x: 0, y:0, width: view.bounds.width, height: view.bounds.height))
        view.addSubview(progressStatusIndicator)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.timerSeconds -= 1
            if self.timerSeconds == 0 {
                timer.invalidate()
                progressStatusIndicator.removeFromSuperview()
                self.view.alpha = 1
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let checkResult = checkUserData()
        
        if !checkResult {
            showLoginError()
        }
        return checkResult
    }
    
    
    
    func checkUserData() -> Bool{
        guard let login = loginInput.text, let password = passwordInput.text else { return false }
        
        if login == "" && password == "" {
            return true
        } else {
            return false
        }
    }
    
    func showLoginError() {
        let alert = UIAlertController(title: "Ошибка", message: "Неправильный логин или пароль", preferredStyle: .alert)
        let  action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

