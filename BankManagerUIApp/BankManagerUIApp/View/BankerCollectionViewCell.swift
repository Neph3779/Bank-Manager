//
//  BankerCollectionViewCell.swift
//  BankManagerUIApp
//
//  Created by 천수현 on 2022/10/18.
//

import UIKit

final class BankerCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "bankerCollectionViewCell"

    private let label: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setContents(customer: Customer) {
        label.text = "\(customer.ticketNumber) \n \(customer.priority.name) \n \(customer.task.name)"
        label.textColor = customer.priority.labelColor
    }

    private func setLabel() {
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
