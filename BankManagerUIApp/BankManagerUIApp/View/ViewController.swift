//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    private let topTimerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "업무시간"
        return label
    }()
    private let judgingLabel = ColorLabel(backgroundColor: .orange, text: "심사중")
    private let workingOnLabel = ColorLabel(backgroundColor: .systemGreen, text: "업무중")
    private let waitngLabel = ColorLabel(backgroundColor: .systemBlue, text: "대기중")
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let addCustomerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("고객 10명 추가", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    private let resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    
    private let bottomButtonsStackView = BankStackView(axis: .horizontal, distribution: .fillEqually)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopTimerLabel()
        setBottomButtonsStackView()
        setLabelStackView()
    }
    
    private func setTopTimerLabel() {
        view.addSubview(topTimerLabel)
        NSLayoutConstraint.activate([
            topTimerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topTimerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }

    private func setBottomButtonsStackView() {
        view.addSubview(bottomButtonsStackView)
        NSLayoutConstraint.activate([
            bottomButtonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomButtonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomButtonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        bottomButtonsStackView.addArrangedSubview(addCustomerButton)
        bottomButtonsStackView.addArrangedSubview(resetButton)
    }

    private func setLabelStackView() {
        view.addSubview(labelStackView)
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            labelStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: bottomButtonsStackView.topAnchor),
            labelStackView.widthAnchor.constraint(equalToConstant: 100)
        ])

        [judgingLabel, workingOnLabel, waitngLabel].forEach { labelStackView.addArrangedSubview($0) }
    }

    private func setAddCustomerButtonTarget() {
        addCustomerButton.addTarget(self, action: #selector(addCustomerButtonTouched(_:)), for: .touchUpInside)
    }

    @objc private func addCustomerButtonTouched(_ sender: UIButton) {
        
    }

    private func setResetButtonTarget() {
        resetButton.addTarget(self, action: #selector(resetButtonTouched(_:)), for: .touchUpInside)
    }

    @objc private func resetButtonTouched(_ sender: UIButton) {

    }
}
