//
//  AddViewController.swift
//  BMIRegister
//
//  Created by junsoo on 12/12/24.
//

import UIKit

protocol AddViewControllerDelegate: AnyObject {
    func didUpdateBMI(tuple: (String, String, String, String, String))
}

class AddViewController: UIViewController {

    @IBOutlet weak var textFieldHeight: UITextField!
    @IBOutlet weak var textFieldWeight: UITextField!
    
    var tuple: (String, String, String, String, String) = ("", "", "", "", "")
    
    weak var delegate: AddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func buttonOK(_ sender: UIBarButtonItem) {
        // 사용자에게 입력 받은 키와 몸모게로 BMI 지수를 계산한다.
        guard let heightText = textFieldHeight.text, let height = Double(heightText), let weightText = textFieldWeight.text, let weight = Double(weightText)  else {
            showAlert(message: "키와 몸무게를 바르게 입력해주세요.")
            return
        }
        let bmi = calculateBMI(height: height, weight: weight)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDateString = dateFormatter.string(from: Date())
        
        tuple.0 = currentDateString
        tuple.1 = heightText
        tuple.2 = weightText
        tuple.3 = String(format: "%.2f", bmi)
        
        let status: String
        switch bmi {
        case ..<18.5:
            status = "저체중"
        case 18.5..<24.9:
            status = "정상"
        case 25..<29.9:
            status = "과체중"
        default:
            status = "비만"
        }
        tuple.4 = status
        print("tuple: \(tuple)")
        
        // 델리것 패턴을 이용해 첫 번째 페이지로 데이터 전달
        delegate?.didUpdateBMI(tuple: tuple)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func calculateBMI(height: Double, weight: Double) -> Double {
        let heightInMeter = height / 100
        return weight / (heightInMeter * heightInMeter)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
