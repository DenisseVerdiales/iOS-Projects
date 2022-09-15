//
//  ViewController.swift
//  calculator
//
//  Created by C. Denisse Verdiales on 7/1/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numWorking: UILabel!
    @IBOutlet weak var result: UILabel!
    
    var workings:String = ""
    var cont: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clearAll()
    }

    func clearAll(){
        workings = ""
        numWorking.text = ""
        result.text = ""
        cont = 0
    }
    
    func addToWorkings(value: String){
        let operador = workings == "" ? value : String(workings.last!)
        
         if workings == "0"{
             clearAll()
             numWorking.text = value

         }else if(operador == "/" || operador == "-" || operador == "=" || operador == "+" || operador == "*" || operador == "%" || operador == ".") && (value == "/" || value == "-" || value == "=" || value == "+" || value == "*" || value == "%"){

                 let res = workings.dropLast(1)
                 workings = String(res)
                 if workings != "" {
                     workings = workings + value
                     numWorking.text = workings
                 }
         }
        
        
        if (value == "/" || value == "=" || value == "+" || value == "*" || value == "%" || value == "-" ){
            
            cont = 0
            
        }
        if value == "."{
            if cont == 0{
                if workings == ""{

                    workings =  workings + "0" + value
                    cont = 1
                 
                }else{
                    if (operador == "/" || operador == "=" || operador == "+" || operador == "*" || operador == "%" || operador == "-"){
                        workings = workings + "0" + value
                        cont = 1
                    }else{
                        workings =  workings + value
                        cont = 1
                    }
                }
                numWorking.text = workings
            }
        }else{
            workings = workings + value
            numWorking.text = workings
        }
    }
    
    
    @IBAction func AC(_ sender: Any) {
        clearAll()
    }
    
    @IBAction func negPos(_ sender: Any) {
        
        let op = numWorking.text?.prefix(1)
        
        if op != "0" {
            if op == "-"{
                let result = workings.dropFirst(1)
                numWorking.text = String(result)
                workings = String(result)
            }else{
                numWorking.text = "-"+workings
                workings = "-"+workings
            }
        }
    }
    
    @IBAction func porc(_ sender: Any) {
        addToWorkings(value:"%")
    }
    
    @IBAction func div(_ sender: Any) {
       
        addToWorkings(value:"/")
    }
    
    @IBAction func seven(_ sender: Any) {
        addToWorkings(value:"7")
    }
    
    @IBAction func eight(_ sender: Any) {
        addToWorkings(value:"8")
    }
    
    @IBAction func nine(_ sender: Any) {
        addToWorkings(value:"9")
    }
    
    @IBAction func mult(_ sender: Any) {
        addToWorkings(value:"*")
    }
    
    @IBAction func four(_ sender: Any) {
        addToWorkings(value:"4")
    }
    
    @IBAction func five(_ sender: Any) {
        addToWorkings(value:"5")
    }
    
    @IBAction func six(_ sender: Any) {
        addToWorkings(value:"6")
    }
    
    @IBAction func minus(_ sender: Any) {
        addToWorkings(value:"-")
    }
    
    @IBAction func one(_ sender: Any) {
        addToWorkings(value:"1")
    }
    
    @IBAction func two(_ sender: Any) {
        addToWorkings(value:"2")
    }
    
    @IBAction func three(_ sender: Any) {
        addToWorkings(value:"3")
    }
    
    @IBAction func plus(_ sender: Any) {
        addToWorkings(value:"+")
    }
    
    @IBAction func zero(_ sender: Any) {
        addToWorkings(value:"0")
    }
    
    @IBAction func point(_ sender: Any) {
        addToWorkings(value:".")
    }
    
    @IBAction func iconResult(_ sender: Any) {
        
        if workings != ""{
            if validInput(){
                
                let divContent = workings.contains(".") ? "/" : ".00/"
                let checkWorking = workings.replacingOccurrences(of: "%", with: "*0.01*")
                let checkWorking2 = checkWorking.replacingOccurrences(of: "/", with: divContent)
               
                let expression = NSExpression(format: checkWorking2)
                let resultExp = expression.expressionValue(with: nil, context: nil) as! Double
                let resultString = formatResult(result: resultExp)
                result.text = resultString
                
            }else{
                let alert = UIAlertController(
                    title: "Invalid Input",
                    message: "Calculator unable to do math base on input",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            clearAll()
        }
        
       
    }
    
    func validInput() -> Bool{
        var count = 0
        var funcCharIndexes = [Int]()
        
        for char in workings{
            if specialCharacter(char: char){
                funcCharIndexes.append(count)
            }
            count += 1
        }
        
        var previous: Int = -1
        
        for index in funcCharIndexes{
            if index == 0{
                return false
            }
            
            if index == workings.count-1{
                return false
            }
            
            if previous != -1{
                
                if (index - previous == 1) {
                    return false
                }
            }
            previous = index
        }
        
        
        return true
    }
    
    func specialCharacter(char: Character) -> Bool{
        if char == "*"{
            return true
        }
        if char == "/"{
            return true
        }
        if char == "+"{
            return true
        }
        if char == "."{
            return true
        }
        return false
    }
    
    func formatResult(result: Double)-> String{
        if result.truncatingRemainder(dividingBy: 1) == 0{
            return String(format: "%.0f", result)
        }else{
            return String(format: "%.8f", result)
        }
        
    }
}

