//
//  Operations.swift
//  BankManagerConsoleApp
//
//  Created by 천수현 on 2021/04/29.
//

import Foundation

protocol ViewControllerDelegate {
    func depositStarted(customer: Customer)
    func depositEnded(customer: Customer)
    func loanStarted(customer: Customer)
    func loanEnded(customer: Customer)
    func loanJudgeStarted(customer: Customer)
    func loanJudgeEnded(customer: Customer)
}

class HandleCustomerOperation: Operation {
    let customer: Customer
    let viewControllerDelegate: ViewControllerDelegate
    init(customer: Customer, delegate: ViewControllerDelegate) {
        self.customer = customer
        self.viewControllerDelegate = delegate
        super.init()
    }

    override func main() {
        switch customer.task {
        case .deposit:
            handleDeposit()
        case .loan:
            handleLoan()
        }
    }

    private func handleDeposit() {
        viewControllerDelegate.depositStarted(customer: customer)
        usleep(Bank.Task.deposit.time)
        viewControllerDelegate.depositEnded(customer: customer)
    }

    private func handleLoan() {
        viewControllerDelegate.loanStarted(customer: customer)
        usleep(Bank.Task.examineLoanDocument.time)
        BankHeadOffice.loanJudgement() {
            self.viewControllerDelegate.loanJudgeStarted(customer: self.customer)
            usleep(Bank.Task.judgementLoan.time)
            self.viewControllerDelegate.loanJudgeEnded(customer: self.customer)
        }
        usleep(Bank.Task.loan.time)
        viewControllerDelegate.loanEnded(customer: customer)
    }
}

struct BankHeadOffice {
    static var semaphoreValue = 0

    static func loanJudgement(task: @escaping () -> Void) {
        while BankHeadOffice.semaphoreValue < 0 {} // wait until semaphoreValue is 0
        semaphoreValue -= 1
        task()
        semaphoreValue += 1
    }
}

