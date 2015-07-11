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
    
    var userIsInTheMIddleOfTypingANumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMIddleOfTypingANumber {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsInTheMIddleOfTypingANumber = true
        }
    }
}

