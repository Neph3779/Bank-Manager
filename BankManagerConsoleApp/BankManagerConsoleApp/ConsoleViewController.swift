//
//  ConsoleViewController.swift
//  BankManagerConsoleApp
//
//  Created by 천수현 on 2021/04/27.
//

import Foundation

class ConsoleViewController {
    var userInput = ""
    private let startMenu = "1 : 은행개점\n2 : 종료\n입력 : "
    
    func showStartMenu() {
        print(startMenu, terminator: "")
    }
    
    func getUserInput() -> String {
        guard let input = readLine() else { return "" }
        return input
    }
    
    func shouldContinue(input: String) -> Result<Bool, BankManagerError> {
        switch input {
        case "1":
            return .success(true)
        case "2":
            return .success(false)
        default:
            return .failure(.invalidUserInput)
        }
    }
}
