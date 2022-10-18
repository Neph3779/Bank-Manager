//
//  RandomGenerator.swift
//  BankManagerConsoleApp
//
//  Created by 천수현 on 2021/04/29.
//

import Foundation

struct RandomGenerator {
    private(set) var totalCustomer: Int = 0

    mutating func generateRandomCustomer(count: Int) -> [Customer] {
        var customers = [Customer]()

        for customerNumber in 1...count {
            let ticketNumber = customerNumber
            let priority = Customer.Priority.allCases.randomElement()!
            let task = Customer.Task.allCases.randomElement()!
            let randomCustomer  = Customer(ticketNumber: ticketNumber, priority: priority, task: task)
            customers.append(randomCustomer)
        }

        return customers
    }

    private func createRandomNumberInRange(_ start: Int, to end: Int) -> Int {
        guard start < end else {
            return Int.random(in: end...start)
        }
        return Int.random(in: start...end)
    }
}
