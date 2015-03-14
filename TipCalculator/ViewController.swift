//
//  ViewController.swift
//  TipCalculator
//
//  Created by Richard Goldberg on 2/14/15.
//  Copyright (c) 2015 Richard Goldberg. All rights reserved.
//

import UIKit

class UIViewController {
    
}
    
class ViewController: UIKit.UIViewController, UITableViewDataSource {

    @IBOutlet var totalTextField : UITextField!
    @IBOutlet var taxPctSlider : UISlider!
    @IBOutlet var taxPctLabel : UILabel!
    //@IBOutlet var resultsTextView : UITextView!
    
    @IBOutlet weak var tipTableView: UITableView!

    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    var possibleTips = Dictionary<Int, (tipAmt:Double, tipTotal:Double)>()
    var sortedKeys:[Int] = []

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
        tipCalc.total = Double((totalTextField.text as NSString).doubleValue)
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = sorted(Array(possibleTips.keys))
        tipTableView.reloadData()
    
    }
    
    @IBAction func taxPercentageChanged(sender: AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }
    
   /* @IBAction func viewTapped(sender: AnyObject) {
        totalTextField.resignFirstResponder()
    }*/

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        let tipPct = sortedKeys[indexPath.row]
        let tipAmt = possibleTips[tipPct]!.tipAmt
        let total = possibleTips[tipPct]!.tipTotal
        
        cell.textLabel?.text = "\(tipPct)%:"
        cell.detailTextLabel?.text = String(format:"Tip:$%0.2f, Total: $%0.2f", tipAmt,total)
        return cell
    }

    
    func refreshUI() {
        // 1
        totalTextField.text = String(format: "%0.2f", tipCalc.total)
        // 2
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        // 3
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        // 4
        //resultsTextView.text = ""
    }
    
}

