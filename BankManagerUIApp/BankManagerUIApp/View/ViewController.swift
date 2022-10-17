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
    private let judgingStackView = BankStackView(axis: .horizontal, distribution: .fill)
    private let workingOnStackView = BankStackView(axis: .horizontal, distribution: .fill)
    private let waitingStackView = BankStackView(axis: .horizontal, distribution: .fill)
    private let outerStackView = BankStackView(axis: .vertical, distribution: .fillEqually)
    private let judgingScrollView = UIScrollView()
    private let workingOnScrollView = UIScrollView()
    private let waitingScrollView = UIScrollView()
    private let judgingScrollStackView = BankStackView(axis: .horizontal, distribution: .equalSpacing)
    private let workingOnScrollStackView = BankStackView(axis: .horizontal, distribution: .equalSpacing)
    private let waitingScrollStackView = BankStackView(axis: .horizontal, distribution: .equalSpacing)
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
        setOuterStackView()
        setBottomButtonsStackView()
    }
    
    private func setTopTimerLabel() {
        view.addSubview(topTimerLabel)
        NSLayoutConstraint.activate([
            topTimerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topTimerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setOuterStackView() {
        view.addSubview(outerStackView)
        addOuterStackViewConstraints()
        setJudgingStackView()
        setWorkingOnStackView()
        setWaitingStackView()
        outerStackView.addArrangedSubview(judgingStackView)
        outerStackView.addArrangedSubview(workingOnStackView)
        outerStackView.addArrangedSubview(waitingStackView)
    }
    
    private func addOuterStackViewConstraints() {
        NSLayoutConstraint.activate([
            outerStackView.topAnchor.constraint(equalTo: topTimerLabel.bottomAnchor),
            outerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setJudgingStackView() {
        judgingStackView.addArrangedSubview(judgingLabel)
        judgingStackView.addArrangedSubview(judgingScrollView)
        NSLayoutConstraint.activate([
            judgingLabel.widthAnchor.constraint(equalTo: judgingScrollView.widthAnchor, multiplier: 0.4)
        ])
        
        judgingScrollView.addSubview(judgingScrollStackView)
        NSLayoutConstraint.activate([
            judgingScrollStackView.leadingAnchor.constraint(equalTo: judgingScrollView.leadingAnchor),
            judgingScrollStackView.topAnchor.constraint(equalTo: judgingScrollView.topAnchor),
            judgingScrollStackView.trailingAnchor.constraint(equalTo: judgingScrollView.trailingAnchor),
            judgingScrollStackView.bottomAnchor.constraint(equalTo: judgingScrollView.bottomAnchor)
        ])
    }
    
    private func setWorkingOnStackView() {
        workingOnStackView.addArrangedSubview(workingOnLabel)
        workingOnStackView.addArrangedSubview(workingOnScrollView)
        NSLayoutConstraint.activate([
            workingOnLabel.widthAnchor.constraint(equalTo: workingOnScrollView.widthAnchor, multiplier: 0.4)
        ])
        
        workingOnScrollView.addSubview(workingOnScrollStackView)
        NSLayoutConstraint.activate([
            workingOnScrollStackView.leadingAnchor.constraint(equalTo: workingOnScrollView.leadingAnchor),
            workingOnScrollStackView.topAnchor.constraint(equalTo: workingOnScrollView.topAnchor),
            workingOnScrollStackView.trailingAnchor.constraint(equalTo: workingOnScrollView.trailingAnchor),
            workingOnScrollStackView.bottomAnchor.constraint(equalTo: workingOnScrollView.bottomAnchor)
        ])
    }
    
    private func setWaitingStackView() {
        waitingStackView.addArrangedSubview(waitngLabel)
        waitingStackView.addArrangedSubview(waitingScrollView)
        NSLayoutConstraint.activate([
            waitngLabel.widthAnchor.constraint(equalTo: waitingScrollView.widthAnchor, multiplier: 0.4)
        ])
        waitingScrollView.addSubview(waitingScrollStackView)
        NSLayoutConstraint.activate([
            waitingScrollStackView.leadingAnchor.constraint(equalTo: waitingScrollView.leadingAnchor),
            waitingScrollStackView.topAnchor.constraint(equalTo: waitingScrollView.topAnchor),
            waitingScrollStackView.trailingAnchor.constraint(equalTo: waitingScrollView.trailingAnchor),
            waitingScrollStackView.bottomAnchor.constraint(equalTo: waitingScrollView.bottomAnchor)
        ])
    }

    private func setBottomButtonsStackView() {
        view.addSubview(bottomButtonsStackView)
        NSLayoutConstraint.activate([
            bottomButtonsStackView.topAnchor.constraint(equalTo: outerStackView.bottomAnchor),
            bottomButtonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomButtonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomButtonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        bottomButtonsStackView.addArrangedSubview(addCustomerButton)
        bottomButtonsStackView.addArrangedSubview(resetButton)
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
