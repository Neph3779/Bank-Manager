//
//  ConsoleViewController.swift
//  BankManagerConsoleApp
//
//  Created by 천수현 on 2021/04/27.
//

import Foundation

protocol ConsoleViewControllable {
    var userInput: String { get }
    mutating func getUserInput()
    func showStartMenu()
    func shouldContinue() -> Result<Bool, BankManagerError>
}

class ConsoleViewController: ConsoleViewControllable {
    private(set) var userInput = ""
    private let startMenu = "1 : 은행개점\n2 : 종료\n입력 :"
    
    func showStartMenu() {
        print(startMenu)
    }
    
    func getUserInput() {
        guard let input = readLine() else {
            return
        }
        userInput = input
    }
    
    func shouldContinue() -> Result<Bool, BankManagerError> {
        
        switch userInput {
        case "1":
            return .success(true)
        case "2":
            return .success(false)
        default:
            return .failure(.invalidUserInput)
        }
    }
}
