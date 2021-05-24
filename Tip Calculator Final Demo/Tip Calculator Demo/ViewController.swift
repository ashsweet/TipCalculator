//
//  ViewController.swift
//  Tip Calculator Demo
//
//  Created by Aishwarya Mukherjee on 16/05/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var billTotalTextField: UITextField!
    @IBOutlet var tipTextField: UITextField!
    @IBOutlet var minusSplitButton: UIButton!
    @IBOutlet var plusSplitButton: UIButton!
    @IBOutlet var splitCountLabel: UILabel!
    @IBOutlet var perPersonAmountLabel: UILabel!
    @IBOutlet var totalTipAmountLabel: UILabel!
    @IBOutlet var totalPayableAmountLabel: UILabel!
    @IBOutlet var cardView: UIView!
    
    private var splitCount: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        // Setting default values
        self.splitCountLabel.text = String(self.splitCount)
        self.setDefaultValues()
        
        // Setting UI
        self.cardView.layer.cornerRadius = 8.0
        self.minusSplitButton.layer.cornerRadius = self.minusSplitButton.bounds.height / 2
        self.plusSplitButton.layer.cornerRadius = self.plusSplitButton.bounds.height / 2
        
        // Adding target for textfield change
        self.billTotalTextField.addTarget(self, action: #selector(ViewController.billTotalTextFieldDidChange(_:)),
                                  for: .editingChanged)
        self.tipTextField.addTarget(self, action: #selector(ViewController.tipTextFieldDidChange(_:)),
                                  for: .editingChanged)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
         target: self,
         action: #selector(dismissMyKeyboard))
         //Add this tap gesture recognizer to the parent view
         view.addGestureRecognizer(tap)
    }


    // MARK: - IBActions
    
    @IBAction func minusSplitButtonTapped(_ sender: Any) {
        self.splitCount = max(1, self.splitCount - 1)
        self.splitCountLabel.text = String(self.splitCount)
        self.calculateTip()
    }
    
    @IBAction func plusSplitButtonTapped(_ sender: Any) {
        self.splitCount += 1
        self.splitCountLabel.text = String(self.splitCount)
        self.calculateTip()
    }
    
    // MARK: - Methods
    // Calculating tip, split amount and adding it to Labels
    private func calculateTip() {
        guard let billTotalText = self.billTotalTextField.text,
              let billTotal = Double(billTotalText) else {
            self.setDefaultValues()
            return
        }
        
        var tipTotal: Double = 0
        if let tipText = self.tipTextField.text,
           let tipPercent = Double(tipText) {
            
            tipTotal = billTotal * tipPercent / 100
        }
        
        let totalAmount = billTotal + tipTotal
        
        let amountPerPerson = totalAmount / Double(self.splitCount)
        
        
        self.totalTipAmountLabel.text = String(format:"$ %.2f", tipTotal)
        self.totalPayableAmountLabel.text = String(format:"$ %.2f", totalAmount)
        self.perPersonAmountLabel.text = String(format:"$ %.2f", amountPerPerson)
    }
    
    func setDefaultValues() {
        self.totalTipAmountLabel.text = String(format:"$ %.2f", 0)
        self.totalPayableAmountLabel.text = String(format:"$ %.2f", 0)
        self.perPersonAmountLabel.text = String(format:"$ %.2f", 0)
    }
    
    // MARK: - Target Methods
    
    @objc func billTotalTextFieldDidChange(_ textField: UITextField) {
        self.calculateTip()
    }
    
    @objc func tipTextFieldDidChange(_ textField: UITextField) {
        self.calculateTip()
    }
    
    @objc func dismissMyKeyboard(){
     //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
     //In short- Dismiss the active keyboard.
     view.endEditing(true)
     }
}

