//
//  ProfileViewController.swift
//  SeSAC_DrinkWater
//
//  Created by ChanhoHwang on 2021/10/09.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var line: UIView!
    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var secondTextField: UITextField!
    
    @IBOutlet weak var thirdStackView: UIStackView!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var thirdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setView()
    }
    
    func setView() {
        self.line.backgroundColor = .gray
        
        self.view.backgroundColor = UIColor(red: 1/255, green: 151/255, blue: 112/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        imageView.image = UIImage(named: UserManager.shared.user.currentImage)
        imageView.backgroundColor = UIColor(red: 1/255, green: 151/255, blue: 112/255, alpha: 1)
        
        firstLabel.text = "닉네임을 설정해주세요"
        firstLabel.textColor = .white
        firstLabel.font = UIFont.systemFont(ofSize: 15)
        firstLabel.numberOfLines = 1
        firstLabel.sizeToFit()
        
        firstTextField.text = UserManager.shared.user.userName
        firstTextField.textColor = .white
        firstTextField.font = UIFont.systemFont(ofSize: 20)
        firstTextField.backgroundColor = UIColor(red: 1/255, green: 151/255, blue: 112/255, alpha: 1)
        firstTextField.sizeToFit()
        firstTextField.borderStyle = .none
        self.firstTextField.delegate = self
        
        secondLabel.text = "키(cm)를 설정해주세요"
        secondLabel.textColor = .white
        secondLabel.font = UIFont.systemFont(ofSize: 15)
        secondLabel.numberOfLines = 1
        secondLabel.sizeToFit()
        
        secondTextField.text = String(Int(UserManager.shared.user.height))
        secondTextField.textColor = .white
        secondTextField.font = UIFont.systemFont(ofSize: 20)
        secondTextField.backgroundColor = UIColor(red: 1/255, green: 151/255, blue: 112/255, alpha: 1)
        secondTextField.sizeToFit()
        secondTextField.borderStyle = .none
        self.secondTextField.delegate = self
        
        thirdLabel.text = "몸무게(kg)를 설정해주세요"
        thirdLabel.textColor = .white
        thirdLabel.font = UIFont.systemFont(ofSize: 15)
        thirdLabel.numberOfLines = 1
        thirdLabel.sizeToFit()
        
        thirdTextField.text = String(Int(UserManager.shared.user.weight))
        thirdTextField.textColor = .white
        thirdTextField.font = UIFont.systemFont(ofSize: 20)
        thirdTextField.backgroundColor = UIColor(red: 1/255, green: 151/255, blue: 112/255, alpha: 1)
        thirdTextField.sizeToFit()
        thirdTextField.borderStyle = .none
        self.thirdTextField.delegate = self
        
        setBoarder(firstTextField)
        setBoarder(secondTextField)
        setBoarder(thirdTextField)
    }
    
    func setBoarder(_ textField: UITextField) {
        let border = CALayer()
        
        border.frame = CGRect(x: 0, y: textField.frame.size.height-1, width: stackView.frame.width, height: 2)
        border.backgroundColor = UIColor.white.cgColor
        textField.layer.addSublayer(border)
    }
    
    @objc func saveButtonPressed(_: Any) {
        if firstTextField.text != UserManager.shared.user.userName {
            UserManager.shared.user.userName = firstTextField.text ?? "default"
            UserManager.shared.user.height = Double(secondTextField.text ?? "0")!
            UserManager.shared.user.weight = Double(thirdTextField.text ?? "0")!
            UserManager.shared.user.drunkenTotal = 0
            UserManager.shared.user.currentImage = "1-1"
            UserManager.shared.user.totalPercent = 0
        } else {
            UserManager.shared.user.height = Double(secondTextField.text ?? "0")!
            UserManager.shared.user.weight = Double(thirdTextField.text ?? "0")!
        }
        
        UserManager.shared.save()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    // return 키에 내려감 textfield를 사용하는 경우 UITextFieldDelegate 프로토콜을 적용할 클래스 상속 선언을 하면 TextField의 Outlet 변수를 delegate로 지정하여 원하는 함수들을 사용할 수 있다. ex) self.이름.delegate = self -> UITextFieldDelegate 추가
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 텍스트필드 비활성화
        return true
    }
    
    
}
