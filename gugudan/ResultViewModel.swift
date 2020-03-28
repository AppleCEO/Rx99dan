//
//  ResultViewModel.swift
//  gugudan
//
//  Created by joon-ho kil on 2020/03/28.
//  Copyright © 2020 joon-ho kil. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ResultListViewModel {
    private var model = BehaviorRelay(value: 0)
    let dan = BehaviorRelay(value: "")
    var result = BehaviorRelay(value: [String]())
    let disposeBag = DisposeBag()
    
    init() {
        self.dan
            .map({ (text) -> Int in
                (Int(text) ?? 0)
            })
            .bind(to: self.model)
            .disposed(by: disposeBag)
        
        model
            .filter({ (number) -> Bool in
                number != 0
            })
            .map({ (dan) -> [String] in
                [1,2,3,4,5,7,8,9].map({ (index) -> String in
                    return "\(dan) X \(index) = "+String(dan*index)
                })
            })
            .bind(to: self.result)
            .disposed(by: disposeBag)
    }
}
