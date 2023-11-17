//
//  ViewController.swift
//  Leson2.4
//
//  Created by Dmitry Parhomenko on 17.11.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var slider: UISlider!
    @IBOutlet var textField: UITextField!
    
    //MARK: - Method viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: false)
        setapSlider()
        setupMainLabel()
    }
    
    //MARK: - метод сегмента
    @IBAction func segmentedControlActions() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mainLabel.text = "The first segment"
            mainLabel.textColor = .red
            mainLabel.font = .systemFont(ofSize: 20)
        case 1:
            mainLabel.text = "The second segment"
            mainLabel.textColor = .green
            mainLabel.font = .systemFont(ofSize: 30)
        default:
            mainLabel.text = "The third segment"
            mainLabel.textColor = .yellow
            mainLabel.font = .systemFont(ofSize: 40)
        }
    }
    
    //MARK: - метод слайдера
    @IBAction func sliderActions() {
        mainLabel.text = String(format:"%.02f", slider.value)
        //mainLabel.text = slider.value.formatted()
        
        // метод изменения прозрачности экранв View
        view.backgroundColor = view.backgroundColor?.withAlphaComponent(CGFloat(slider.value))
    }
    
    //MARK: - метод кнопки
    @IBAction func buttonTap() {
        guard let text = textField.text, !text.isEmpty else {
            showAlert(withTitle: "Text field is empty", andMessage: "Plies enter your name")
            return
        }
//        // Заменили Регулярным выражением (стр.64 - 74)
//        if let _ = Double(text) {
//            showAlert(withTitle: "Wrong format", andMessage: "Plies enter your name")
//            return
//        }
    //MARK: - Регулярное выражение
        // (взамен 59 - 63) Регулярное выражение usernamePattern - проверяет условие a-zA-Z
        // пределах символов {3,20}
        let usernamePattern = "^[a-zA-Z ]{3,20}$"
        //Регулярное выражение сверяем text с условиями (стр.67)
        let isUsernameValid = NSPredicate(format: "SELF MATCHES %@", usernamePattern)
            .evaluate(with: text)
        
        if !isUsernameValid {
            showAlert(withTitle: "Wrong format", andMessage: "Plies enter your name")
            return
        }
        mainLabel.text = text
        textField.text = ""
    }
    
    //MARK: - Метод вызова alert меню при помощи UIAlertController
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // создаем кнопку ОК и замыкание, где создаем пустую строку для очистки данных
        // после нажатия кнопки ОК
        let okActions = UIAlertAction(title: "Ok", style: .default) { _ in
            self.textField.text = ""
        }
        alert.addAction(okActions)
        present(alert, animated: true)
    }
}

//MARK: - Setup UI
extension ViewController {
    private func setupMainLabel() {
        mainLabel.text = slider.value.formatted()
         mainLabel.font = .systemFont(ofSize: 30, weight: .bold)
         mainLabel.textAlignment = .center
         mainLabel.numberOfLines = 0
     }

    private func setapSlider() {
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 1
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.thumbTintColor = .purple
        print(String(format:"%.01f", slider.value))
    }
}
