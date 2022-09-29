//
//  Customer.swift
//  BankManagerConsoleApp
//
//  Created by 천수현 on 2021/04/29.
//

import Foundation

struct Customer {
    let ticketNumber: Int
    let priority: Priority
    let task: Task
}

extension Customer {
    enum Priority: CaseIterable, Comparable {
        case normal
        case VIP
        case VVIP
        
        var name: String {
            switch self {
            case .VVIP:
                return "VVIP"
            case .VIP:
                return "VIP"
            case .normal:
                return "일반"
            }
        }
    }
    
    enum Task: CaseIterable {
        case loan
        case deposit
        
        var name: String {
            switch self {
            case .loan:
                return "대출"
            case .deposit:
                return "예금"
            }
        }
    }
}
