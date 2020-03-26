//
//  RxViewModel.swift
//  gugudan
//
//  Created by joon-ho kil on 2020/03/26.
//  Copyright © 2020 joon-ho kil. All rights reserved.
//

import Foundation
import RxSwift

class RxViewModel {
    var currentDan = Variable<Int>(1)
    var model = Model()
    
    func calculate99dan() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        let currentDan = self.currentDan.value
            if currentDan < 9 {
                self.currentDan.value = self.model.AddCount(value: currentDan)
                self.calculate99dan()
             } else {
                self.currentDan.value = 0
             }
        }
    }
}

