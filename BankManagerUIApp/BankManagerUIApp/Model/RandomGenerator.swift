//
//  RandomGenerator.swift
//  BankManagerConsoleApp
//
//  Created by 천수현 on 2021/04/29.
//

import Foundation

class RandomGenerator {
    private(set) var totalCustomer: Int = 0

   func generateRandomCustomer(count: Int) -> [Customer] {
        var customers = [Customer]()

        for _ in 1...count {
            totalCustomer += 1
            let ticketNumber = totalCustomer
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
