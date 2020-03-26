//
//  ViewController.swift
//  gugudan
//
//  Created by joon-ho kil on 2020/03/03.
//  Copyright © 2020 joon-ho kil. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
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
        label.backgroundColor = .lightGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        
        addSubviews()
        makeConstraints()
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
}

