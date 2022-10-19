//
//  ViewModel.swift
//  BankManagerUIApp
//
//  Created by 천수현 on 2022/10/18.
//

import Foundation

final class ViewModel {
    var waiting = [Customer]()
    var working = [Customer]()
    var judging = [Customer]()

    var randomGenerator = RandomGenerator()
    let bankOperationQueue = OperationQueue()
    let bank = Bank(numberOfBankTeller: 3)

    init() {
        bankOperationQueue.maxConcurrentOperationCount = bank.numberOfBankTeller
    }
}
