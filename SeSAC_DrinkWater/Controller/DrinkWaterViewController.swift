//
//  ViewController.swift
//  SeSAC_DrinkWater
//
//  Created by ChanhoHwang on 2021/10/09.
//

import UIKit

class DrinkWaterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var line: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalDrunkenLabel: UILabel!
    @IBOutlet weak var percentageToGoalLabel: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var waterInputTextField: UITextField!
    
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    // var total: Double = 0

    var totalPer: Double = 0 {
        didSet {
            var assetName = ""
            
            switch self.totalPer {
            case 0 ..< 15:
                assetName = "1-1"
            case 15 ..< 35:
                assetName = "1-3"
            case 35 ..< 55:
                assetName = "1-4"
            case 55 ..< 65:
                assetName = "1-5"
            case 65 ..< 75:
                assetName = "1-6"
            case 75 ..< 85:
                assetName = "1-7"
            case 85 ..< 99:
                assetName = "1-8"
            case 100:
                assetName = "1-9"
            default:
                assetName = "1-9"
            }
            UserManager.shared.user.currentImage = assetName
            image.image = UIImage(named: assetName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        setView()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let input = waterInputTextField.viewWithTag(1) as! UITextField
        let text = input.text?.trimmingCharacters(in: ["m","l"])
        
        if Int(text!) != nil {
            UserManager.shared.user.drunkenTotal += Double(text!)!
        }
        else {
            print("Wrong input")
        }
        
        totalDrunkenLabel.text = "\(Int(UserManager.shared.user.drunkenTotal))ml"
        if UserManager.shared.user.drunkenTotal > UserManager.shared.waterRecomend() * 1000.0 {
            totalDrunkenLabel.textColor = .red
        }
 
        UserManager.shared.save()
        
        totalPer = round(UserManager.shared.user.drunkenTotal) * 100 / (UserManager.shared.waterRecomend() * 1000)
        percentageToGoalLabel.text = "목표의 \(String(format: "%.0f", totalPer))%"
        UserManager.shared.user.totalPercent = Int(totalPer)
        
        UserManager.shared.save()
    }
    
    func setView() {
        self.line.backgroundColor = .gray
        self.view.backgroundColor = UIColor(red: 1/255, green: 151/255, blue: 112/255, alpha: 1)
        
        self.navigationItem.title = "물 마시기"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: .none)
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(moveToUserPage(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        titleLabel.text = "잘하셨어요! \n오늘 마신 양은"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        titleLabel.numberOfLines = 2
        titleLabel.sizeToFit()
        
        
        totalDrunkenLabel.text = "\(Int(UserManager.shared.user.drunkenTotal))ml"
        if UserManager.shared.user.drunkenTotal > UserManager.shared.waterRecomend() * 1000.0 {
            totalDrunkenLabel.textColor = .red
        } else {
            totalDrunkenLabel.textColor = .white
        }
        totalDrunkenLabel.font = UIFont.boldSystemFont(ofSize: 35)
        totalDrunkenLabel.numberOfLines = 1
        totalDrunkenLabel.sizeToFit()
        
        image.image = UIImage(named: UserManager.shared.user.currentImage)
        
        percentageToGoalLabel.text = "목표의 \(UserManager.shared.user.totalPercent)%"
        percentageToGoalLabel.textColor = .white
        percentageToGoalLabel.font = UIFont.systemFont(ofSize: 15)
        percentageToGoalLabel.numberOfLines = 1
        percentageToGoalLabel.sizeToFit()

        waterInputTextField.text = "0ml"
        waterInputTextField.textColor = .white
        waterInputTextField.font = UIFont.systemFont(ofSize: 30)
        waterInputTextField.backgroundColor = UIColor(red: 1/255, green: 151/255, blue: 112/255, alpha: 1)
        waterInputTextField.textAlignment = .center
        waterInputTextField.sizeToFit()
        waterInputTextField.borderStyle = .none
        waterInputTextField.tag = 1
        self.waterInputTextField.delegate = self
        
        let reco = String(format: "%.1f", UserManager.shared.waterRecomend())
        guideLabel.text = "\(UserManager.shared.user.userName)님의 하루 물 권장 섭취량은 \(reco)L 입니다."
        guideLabel.textColor = .white
        guideLabel.font = UIFont.systemFont(ofSize: 15)
        guideLabel.numberOfLines = 1
        guideLabel.textAlignment = .center
        
        button.setTitle("물마시기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .white
        button.layer.borderColor = CGColor(red: 1/255, green: 151/255, blue: 112/255, alpha: 1)
    }
    
    @objc func moveToUserPage(_: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileView") else {
            return
        }
        self.navigationController?.pushViewController(uvc, animated: true)
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

