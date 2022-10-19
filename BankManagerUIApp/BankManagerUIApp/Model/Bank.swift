//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 천수현 on 2021/04/27.
//

import Foundation

struct Bank {
    let numberOfBankTeller: Int
}

extension Bank {
    enum Task {
        case deposit
        case examineLoanDocument
        case judgementLoan
        case loan

        var time: useconds_t {
            switch self {
            case .deposit:
                return 3_100_000
            case .examineLoanDocument, .loan:
                return 900_000
            case .judgementLoan:
                return 1500_000
            }
        }
    }
}
