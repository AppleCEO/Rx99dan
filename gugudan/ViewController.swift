//
//  ViewController.swift
//  gugudan
//
//  Created by joon-ho kil on 2020/03/03.
//  Copyright © 2020 joon-ho kil. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let viewModel = RxViewModel()
    var bag = DisposeBag()
    
    let introduceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .orange
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.text = "도미닉의 구구단"
        label.textAlignment = .center
        return label
    }()
    let danInputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "단을 입력해주세요."
        textField.backgroundColor = .white
        textField.borderStyle = .line
        return textField
    }()
    let resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50)
        label.textAlignment = .center
        label.backgroundColor = .lightGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        
        addSubviews()
        makeConstraints()
        binding()
        danInputTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }

    private func addSubviews() {
        self.view.addSubview(self.introduceLabel)
        self.view.addSubview(self.danInputTextField)
        self.view.addSubview(self.resultLabel)
    }
    
    private func makeConstraints() {
        self.introduceLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            make.bottom.equalTo(self.danInputTextField.snp.top).offset(-20)
            make.height.equalTo(50)
        }
        self.danInputTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.introduceLabel)
            make.bottom.equalTo(self.resultLabel.snp.top).offset(-20)
            make.height.equalTo(30)
        }
        self.resultLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.introduceLabel)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    private func binding() {
        _ = viewModel.currentDan.asObservable().subscribe({ (currentDan) in
        if let dan = currentDan.element {
            guard let inputDan = Int(self.danInputTextField.text ?? "0") else {
                return
            }
            guard dan != 0 else {
                self.resultLabel.text = nil
                return
            }
            let result = inputDan * dan
            self.resultLabel.text = "\(inputDan) * \(dan) = \(result)"
            if dan <= 3 {
                self.resultLabel.backgroundColor = UIColor.gray
            } else if dan <= 6 {
                self.resultLabel.backgroundColor = UIColor.green
            } else if dan <= 9 {
                self.resultLabel.backgroundColor = UIColor.yellow
            }
        }
        }).disposed(by: bag)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        self.viewModel.calculate99dan()
    }
}
