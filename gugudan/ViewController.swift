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
    private var viewModel: ResultListViewModel = ResultListViewModel()

    let disposeBag = DisposeBag()
    
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
    let resultTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        
        addSubviews()
        makeConstraints()
        binding()
    }

    private func addSubviews() {
        self.view.addSubview(self.introduceLabel)
        self.view.addSubview(self.danInputTextField)
        self.view.addSubview(self.resultTableView)
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
            make.bottom.equalTo(self.resultTableView.snp.top).offset(-20)
            make.height.equalTo(30)
        }
        self.resultTableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.introduceLabel)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    private func binding() {
        self.danInputTextField.rx.text.orEmpty
            .map { $0 as String }
            .bind(to: self.viewModel.dan)
            .disposed(by: disposeBag)
        
        self.viewModel.result.bind(to: resultTableView.rx.items) { (tableView: UITableView, index: Int, element: String) -> UITableViewCell in
                let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
                cell.textLabel?.text = element
                return cell
            }
            .disposed(by: disposeBag)
        }
}
