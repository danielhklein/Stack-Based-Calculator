//
//  ViewController.swift
//  Calculator
//
//  Created by Daniel Klein on 6/20/15.
//  Copyright (c) 2015 Daniel H Klein. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsTyping = false
    var isFloat = false
    var opStack = Array<Double>()
    
    @IBAction func clearHistory() {
        history.text = ""
        opStack = []
        display.text = ""
        userIsTyping = false
        isFloat = false
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsTyping = true
            isFloat = false
        }
    }
    
    @IBAction func displayHistory(sender: UIButton) {
        history.text = history.text! + sender.currentTitle!
    }
    
    @IBAction func decAction(sender: UIButton) {
        if !isFloat {
            display.text = display.text! + "."
            isFloat = true
            userIsTyping = true
        }
    }
    
    @IBAction func returnAction() {
        isFloat = true
        userIsTyping = false
        opStack.append(displayVal)
    }
    
    @IBAction func displayPi(sender: UIButton) {
        let digit = sender.currentTitle!
        display.text = "\(M_PI)"
        history.text = history.text! + "∏"
        userIsTyping = true
        isFloat = true
    }
    
    var displayVal: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            isFloat = true
            userIsTyping = false
        }
    }
    
    @IBAction func op(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsTyping {
            returnAction()
        }
        switch operation {
        case "+": performOp {$0 + $1}
        case "-": performOp {$1 - $0}
        case "×": performOp {$0 * $1}
        case "÷": performOp {$1 / $0}
        case "√": performOp {sqrt($0)}
        case "sin": performOp {sin($0)}
        case "cos": performOp {cos($0)}
        default: break
        }
    }
    
    private func performOp(operation: (Double, Double) -> Double) {
        if opStack.count >= 2 {
            displayVal = operation(opStack.removeLast(), opStack.removeLast())
            returnAction()
        }
    }
    
    private func performOp(operation: Double -> Double) {
        if opStack.count >= 1 {
            displayVal = operation(opStack.removeLast())
            returnAction()
        }
    }
}

