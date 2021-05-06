//
//  ColorLabel.swift
//  BankManagerUIApp
//
//  Created by 천수현 on 2021/05/06.
//

import Foundation
import UIKit
class CustomerLabel: UILabel {
    init(customer: Customer) {
        super.init(frame: CGRect())
        numberOfLines = 0
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        switch customer.priority {
        case .VVIP:
            text = "\(customer.ticketNumber)\nVVIP\n\(customer.task.name)"
            textColor = .red
        case .VIP:
            text = "\(customer.ticketNumber)\nVIP\n\(customer.task.name)"
            textColor = .blue
        case .normal:
            text = "\(customer.ticketNumber)\nVVIP\n\(customer.task.name)"
            textColor = .black
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
