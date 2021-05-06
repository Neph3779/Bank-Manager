//
//  ColorLabel.swift
//  BankManagerUIApp
//
//  Created by 천수현 on 2021/05/06.
//

import Foundation
import UIKit
class ColorLabel: UILabel {
    init(backgroundColor: UIColor, text: String) {
        super.init(frame: CGRect())
        textColor = .white
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
