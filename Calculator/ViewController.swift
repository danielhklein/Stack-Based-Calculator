//
//  ViewController.swift
//  Calculator
//
//  Created by Daniel Klein on 6/20/15.
//  Copyright (c) 2015 Daniel H Klein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsTyping: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsTyping = true
        }
    }
    
    var opStack = Array<Double>()
    
    @IBAction func returnAction() {
        userIsTyping = false
        opStack.append(displayVal)
    }
    
    var displayVal: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
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

