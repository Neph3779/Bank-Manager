//
//  ConsoleViewController.swift
//  BankManagerConsoleApp
//
//  Created by 천수현 on 2021/04/27.
//

import Foundation

struct ConsoleViewController {
    private(set) var userInput = ""
    
    func showStartMenu() {
        print(
 """
 1 : 은행개점
 2 : 종료
 입력 : 
 """, terminator: "")
    }
    
    mutating func getUserInput() {
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
