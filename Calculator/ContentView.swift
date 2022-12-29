//
//  ContentView.swift
//  Calculator
//
//  Created by Skyler Thompson on 4/10/20.
//  Copyright © 2020 Skyler Thompson. All rights reserved.
//

import SwiftUI

class ViewModel: ObservableObject {
  @Published var calculationText = "0"
}

struct ContentView: View {
    let topRow = ["AC", "+/-", "%", "/"]
    let secondRow = ["7", "8", "9", "x"]
    let thirdRow = ["4", "5", "6", "-"]
    let fourthRow = ["1", "2", "3", "+"]
    let lastRow = ["0", ".", "="]
    let numRows = 5
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            VStack {
                HStack(content: {
                    Text(viewModel.calculationText).font(.system(size:60))
                })
            }.frame(minWidth: 44, maxWidth: .infinity, minHeight: 250).background(Color(red: 64 / 255, green: 64 / 255, blue: 64 / 255)).foregroundColor(Color.white)
            VStack(spacing: 1, content: {
                HStack (spacing: 1, content:{
                    ForEach(0 ..< 4) { number in
                        Button(action: { buttonClick(buttonText: self.topRow[number], viewModel: self.viewModel)
                            
                        }) {
                            Text(self.topRow[number]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(Color.gray)
                        }
                    }
                })
                HStack (spacing: 1, content:{
                    ForEach(0 ..< 4) { number in
                        Button(action: {
                            buttonClick(buttonText: self.secondRow[number], viewModel: self.viewModel)
                        }) {
                            Text(self.secondRow[number]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(Color.gray)
                        }
                    }
                })
                HStack (spacing: 1, content:{
                    ForEach(0 ..< 4) { number in
                        Button(action: {
                            buttonClick(buttonText: self.thirdRow[number], viewModel: self.viewModel)
                        }) {
                            Text(self.thirdRow[number]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(Color.gray)
                        }
                    }
                })
                HStack (spacing: 1, content:{
                    ForEach(0 ..< 4) { number in
                        Button(action: {
                            buttonClick(buttonText: self.fourthRow[number], viewModel: self.viewModel)
                        }) {
                            Text(self.fourthRow[number]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(Color.gray)
                            }
                    }
                })
                HStack (spacing: 1, content:{
                    HStack (spacing: 1, content:{
                        ForEach(0 ..< 1) { number in
                            Button(action: {
                                buttonClick(buttonText: self.lastRow[number], viewModel: self.viewModel)
                            }) {
                                Text(self.lastRow[number]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(Color.gray)
                                }
                        }
                    })
                    HStack (spacing: 1, content:{
                        ForEach(0 ..< 2) { number in
                            Button(action: {
                                buttonClick(buttonText: self.lastRow[number + 1], viewModel: self.viewModel)
                            }) {
                                Text(self.lastRow[number + 1]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(Color.gray)
                                }
                        }
                    })
                })
            }).buttonStyle(PlainButtonStyle()).font(.system(size: 24)).background(Color(red: 64 / 255, green: 64 / 255, blue: 64 / 255))
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

var currentNumber:Double = 0.0
var previousNumber:Double = 0.0
var currentNumberText:String = ""
var currentOperation:String = ""

func buttonClick(buttonText: String, viewModel : ViewModel) {
    switch(buttonText) {
    case "AC":
        print("AC was pressed")
        var clearAll:Bool = false
        if (viewModel.calculationText != "0") {
            clearAll = true
        }
        if (clearAll) {
            // Also zero out the previous number
            previousNumber = 0.0
        }
        // Otherwise just clear the current number being worked on
        viewModel.calculationText = "0"
        currentNumber = 0.0
        currentNumberText = ""
        currentOperation = ""
    case "+/-":
        print("+/- was pressed")
    case "%":
        print("% was pressed")
    case "/", "x", "-", "+":
        if (previousNumber == 0.0) {
            previousNumber = currentNumber
            viewModel.calculationText = "0"
        } else {
            let result = evaluate(currentOperation: currentOperation, num1: previousNumber, num2: currentNumber)
            viewModel.calculationText = String(result)
            previousNumber = result
        }
        currentOperation = buttonText
        currentNumber = 0.0
        currentNumberText = ""
    case "=":
        print("= was pressed")
        //Evaluate operations on numbers
        let result = evaluate(currentOperation: currentOperation, num1: previousNumber, num2: currentNumber)
        viewModel.calculationText = String(result)
        previousNumber = result
        currentNumber = 0.0
        currentNumberText = ""
    default:
        currentNumberText = currentNumberText + buttonText
        currentNumber = Double(currentNumberText)!
        viewModel.calculationText = currentNumberText
    }
}

func evaluate(currentOperation: String, num1: Double, num2: Double) -> Double {
    var result:Double = 0.0
    switch(currentOperation) {
    case "/":
        result = previousNumber / currentNumber
    case "x":
        result = previousNumber * currentNumber
    case "-":
        result = previousNumber - currentNumber
    case "+":
        result = previousNumber + currentNumber
    default:
        print("Should never make it here")
    }
    return result
}
