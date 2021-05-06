//
//  BankStackView.swift
//  BankManagerUIApp
//
//  Created by 천수현 on 2021/05/06.
//

import Foundation
import UIKit
class BankStackView: UIStackView {
    init(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) {
        super.init(frame: CGRect())
        self.axis = axis
        self.distribution = distribution
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
