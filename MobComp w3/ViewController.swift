import UIKit

class CustomBorderButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    func setupButton() {
        layer.borderWidth = 2
        let superDarkGrayColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        let superDarkGrayCGColor = superDarkGrayColor.cgColor
        layer.borderColor = superDarkGrayCGColor
        layer.cornerRadius = 6
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var calResult: UILabel!
    
    var first: Double?
    var currentOperator: String?
    var previousOperator: String?
    var isTypingNumber: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
    }
    
    func clearAll() {
        calResult.text = "0"
        first = nil
        currentOperator = nil
        previousOperator = nil
        isTypingNumber = false
        digit = 0
    }
    
    @IBAction func acClicked(_ sender: UIButton) {
        clearAll()
    }
    
    @IBAction func cClicked(_ sender: UIButton) {
        calResult.text = "0"
        isTypingNumber = false
    }
    
    //BACKK
    @IBAction func backClicked(_ sender: UIButton) {
        if isTypingNumber {
            if let currentText = calResult.text, currentText.count > 1 {
                let truncatedText = String(currentText.dropLast())
                calResult.text = truncatedText
            } else {
                calResult.text = "0"
                isTypingNumber = false
            }
        }
    }
    
    @IBAction func plusMinusClicked(_ sender: Any) {
        if let posOrNeg = Double(calResult.text!), calResult.text != "0" {
            let newValue = -posOrNeg
            calResult.text = String(format: "%g", newValue)
        }
    }
    
    @IBAction func percentClicked(_ sender: UIButton) {
        if isTypingNumber {
            if let currentValue = Double(calResult.text ?? "0") {
                let percentValue = currentValue / 100.0
                calResult.text = String(format: "%g", percentValue)
            }
        }
    }
    
    // Operator Buttons
    @IBAction func addClicked() {
        handleOperator("+")
    }
    
    @IBAction func subtractClicked() {
        handleOperator("-")
    }
    
    @IBAction func multiplyClicked() {
        handleOperator("×")
    }
    
    @IBAction func divideClicked() {
        handleOperator("÷")
    }
    
    func handleOperator(_ operatorSymbol: String) {
        if isTypingNumber {
            if let value = Double(calResult.text!) {
                if let previous = previousOperator {
                    performCalculation(previous)
                } else {
                    first = value
                }
                
                currentOperator = operatorSymbol
                previousOperator = currentOperator
                isTypingNumber = false
            }
        }
    }
    
    @IBAction func equalsClicked(_ sender: UIButton) {
        if isTypingNumber, let operatorType = currentOperator {
            performCalculation(operatorType)
            currentOperator = nil
            previousOperator = nil
        }
    }
    
    func performCalculation(_ operatorType: String) {
        if let firstValue = first, let secondValue = Double(calResult.text!) {
            var result: Double = 0
            switch operatorType {
            case "×":
                result = firstValue * secondValue
            case "÷":
                if secondValue != 0 {
                    result = firstValue / secondValue
                } else {
                    calResult.text = "Error"
                    return
                }
            case "+":
                result = firstValue + secondValue
            case "-":
                result = firstValue - secondValue
            default:
                break
            }
            calResult.text = String(format: "%g", result)
            first = result
        }
    }
    
    @IBAction func decimalPointClicked(_ sender: UIButton) {
        if !isTypingNumber {
            calResult.text = "0."
            isTypingNumber = true
        } else if let currentText = calResult.text, !currentText.contains(".") {
            calResult.text! += "."
        }
    }
    
    var digit: Int?
    
    @IBAction func zeroClicked(_ sender: Any) {
        numberClicked(0)
    }
    
    @IBAction func oneClicked(_ sender: Any) {
        numberClicked(1)
    }
    
    @IBAction func twoClicked(_ sender: Any) {
        numberClicked(2)
    }
    
    @IBAction func threeClicked(_ sender: Any) {
        numberClicked(3)
    }
    
    @IBAction func fourClicked(_ sender: Any) {
        numberClicked(4)
    }
    
    @IBAction func fiveClicked(_ sender: Any) {
        numberClicked(5)
    }
    
    @IBAction func sixClicked(_ sender: Any) {
        numberClicked(6)
    }
    
    @IBAction func sevenClicked(_ sender: Any) {
        numberClicked(7)
    }
    
    @IBAction func eightClicked(_ sender: Any) {
        numberClicked(8)
    }
    
    @IBAction func nineClicked(_ sender: Any) {
        numberClicked(9)
    }
    
    func numberClicked(_ digit: Int) {
        let stringDigit = String(digit)
        
        if !isTypingNumber, digit == 0 {
            calResult.text = "0"
        } else {
            if isTypingNumber {
                calResult.text = (calResult.text ?? "") + stringDigit
            } else {
                calResult.text = stringDigit
                isTypingNumber = true
            }
        }
    }
}

