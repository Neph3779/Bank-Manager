//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

struct BankManager {
    private var bank: Bankable
    private var consoleViewController: ConsoleViewControllable
    private var randomGenerator: RandomGeneratable
    private let bankOperationQueue = OperationQueue()
    private var randomCustomers: [Customer]?
    private var totalCustomerNumber: Int = 0
    
    init(bank: Bankable, consoleViewer: ConsoleViewControllable, randomGenerator: RandomGeneratable) {
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
        randomCustomers = randomGenerator.generateRandomCustomer()
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
            consoleViewController.getUserInput()
            result = consoleViewController.shouldContinue()
            do {
                shouldContinue = try result.get()
            } catch {
                print(error)
            }
        } while result == .failure(.invalidUserInput)
        
        return shouldContinue
    }
}
