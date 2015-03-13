//
//  ViewController.swift
//  TipCalculator
//
//  Created by Richard Goldberg on 2/14/15.
//  Copyright (c) 2015 Richard Goldberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var totalTextField : UITextField!
    @IBOutlet var taxPctSlider : UISlider!
    @IBOutlet var taxPctLabel : UILabel!
    @IBOutlet var resultsTextView : UITextView!
    
    @IBOutlet weak var tipTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func calculateTapped(sender: AnyObject) {
        // 1
        tipCalc.total = Double((totalTextField.text as NSString).doubleValue)
        // 2
        var possibleTips = Dictionary <Int, (tipAmt:Double, tipTotal:Double)>()

        possibleTips = tipCalc.returnPossibleTips()
        var results = ""
        // 3
        for (tipPct, (tipAmt, tipTotal)) in possibleTips {
            // 4
            //results += "\(tipPct)%: \(tipValue)\n"
            results += String(format: "%d%%: $%5.2f\n", tipPct, tipValue)
        }
        // 5
        resultsTextView.text = results

    }
    
    @IBAction func taxPercentageChanged(sender: AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        totalTextField.resignFirstResponder()
    }
    
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    
    func refreshUI() {
        // 1
        totalTextField.text = String(format: "%0.2f", tipCalc.total)
        // 2
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        // 3
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        // 4
        resultsTextView.text = ""
    }
    
}

