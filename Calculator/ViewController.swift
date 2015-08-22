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
    
    //the current instruction field
    @IBOutlet weak var display: UILabel!
    
    //the current history of calculation
    @IBOutlet weak var history: UILabel!
    
    //internal calculation class
    var brain = CalcBrain()
    
    //checks if value is float or integer
    var isFloat = false
    
    //checks if user is in the middle of a calculation
    var userIsTyping = false
    
    //pulls value from display field
    var displayVal: Double? {
        get {
            //sets displayVal = display.text
            if let entry = display.text {
                if let entryNum = NSNumberFormatter().numberFromString(entry) {
                    return entryNum.doubleValue
                }
            }
            return nil
        }
        set {
            userIsTyping = false
            if newValue == nil {
                history.text = ""
                brain.clear()
                display.text = "0"
                isFloat = false
            } else {
                display.text = "\(newValue!)"
                isFloat = true
            }
        }
    }
    
    //on clear: wipes history, calc stack, display text, and bools
    @IBAction func clearHistory() {
        displayVal = nil
    }
    
    //adds digit to display
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        //appends digit if user has been typing
        if userIsTyping {
            display.text = display.text! + digit
        }
        //replaces default value with digit otherwise
        else {
            display.text = digit
            userIsTyping = true
            isFloat = false
        }
    }
    
    //adds decimal and sets bools, preventing additional "."
    @IBAction func decAction(sender: UIButton) {
        if !isFloat {
            display.text = display.text! + "."
            isFloat = true
            userIsTyping = true
        }
    }
    
    //pushes value on to stack
    @IBAction func returnAction() {
        isFloat = true
        userIsTyping = false
        if let inDouble = displayVal {
            if let result = brain.pushOperand(inDouble) {
                displayVal = result
                history.text = brain.getStack()
            }
        } else {
            displayVal = 0
            history.text = ""
        }
    }
    
    //display symbols
    @IBAction func displayNum(sender: UIButton) {
        let digit = sender.currentTitle!
        //switch statement to easily add new values
        switch digit {
        case "π":
            display.text = "\(M_PI)"; isFloat = true
        default:
            break
        }
        userIsTyping = true
    }
    
    //push operation on to stack
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