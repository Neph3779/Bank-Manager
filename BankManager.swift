//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

struct BankManager {
    private var bank: Bank
    private var consoleViewController: ConsoleViewController
    private var randomGenerator: RandomGenerator
    private let bankOperationQueue = OperationQueue()
    private var randomCustomers: [Customer]?
    private var totalCustomerNumber: Int = 0

    init(bank: Bank, consoleViewer: ConsoleViewController, randomGenerator: RandomGenerator) {
        self.bank = bank
        self.consoleViewController = consoleViewer
        self.randomGenerator = randomGenerator
        bankOperationQueue.maxConcurrentOperationCount = bank.numberOfBankTeller
    }

    mutating func start() {
        while shouldContinue() {
            createRandomCustomer()
            bank.openBank()
            do {
                try handleCustomer()
                try bank.closeBank(totalCustomerNumber: totalCustomerNumber)
            } catch {
                print(error)
            }
        }
    }

    private mutating func createRandomCustomer() {
        randomCustomers = randomGenerator.generateRandomCustomer(count: 10)
        totalCustomerNumber = randomGenerator.totalCustomer
    }

    private mutating func handleCustomer() throws {
        guard var randomCustomers = randomCustomers else { throw BankManagerError.failToGenerateRandomCustomers }

        randomCustomers.sort { $0.priority > $1.priority }

        randomCustomers.forEach {
            let customerOperation = HandleCustomerOperation(customer: $0)
            bankOperationQueue.addOperation(customerOperation)
        }

        bankOperationQueue.waitUntilAllOperationsAreFinished()
    }

    private mutating func shouldContinue() -> Bool {
        var result: Result<Bool, BankManagerError> = .success(true)
        var shouldContinue = true

        repeat {
            consoleViewController.showStartMenu()
            if case let .failure(error) = result {
                print(error)
                shouldContinue = false
            }

            if case let .success(shouldContinueResult) = result {
                shouldContinue = shouldContinueResult
            }
        } while result == .failure(.invalidUserInput)

        return shouldContinue
    }
}
