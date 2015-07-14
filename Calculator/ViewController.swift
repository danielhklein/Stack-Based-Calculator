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
    
    var brain = CalcBrain()
    
    var isFloat = false
    var userIsTyping = false
    
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
    
    @IBAction func clearHistory() {
        history.text = ""
        brain.clear()
        display.text = "0"
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
        if let result = brain.pushOperand(displayVal) {
            displayVal = result
            history.text = brain.getStack()
        } else {
            displayVal = 0
            history.text = ""
        }
    }
    
    @IBAction func displayNum(sender: UIButton) {
        let digit = sender.currentTitle!
        switch digit {
        case "π":
            display.text = "\(M_PI)"; isFloat = true
        default:
            break
        }
        userIsTyping = true
    }
    
    @IBAction func op(sender: UIButton) {
        if userIsTyping {
            returnAction()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOp(operation) {
                displayVal = result
                history.text = brain.getStack()
            } else {
                displayVal = 0
                history.text = ""
            }
        }
    }
}

