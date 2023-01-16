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
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack (spacing: 0, content: {
            VStack {
                HStack(content: {
                    Text(viewModel.calculationText).font(.system(size:60))
                })
            }.frame(minWidth: 44, maxWidth: .infinity, minHeight: 250).background(colorScheme == .dark ? Color(red: 64 / 255, green: 64 / 255, blue: 64 / 255) : Color(UIColor.lightGray)).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            VStack(spacing: 1, content: {
                HStack (spacing: 1, content:{
                    ForEach(0 ..< 4) { number in
                        Button(action: { buttonClick(buttonText: self.topRow[number], viewModel: self.viewModel)
                            
                        }) {
                            Text(self.topRow[number]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(colorScheme == .dark ? Color.gray : Color.white).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        }
                    }
                })
                HStack (spacing: 1, content:{
                    ForEach(0 ..< 4) { number in
                        Button(action: {
                            buttonClick(buttonText: self.secondRow[number], viewModel: self.viewModel)
                        }) {
                            Text(self.secondRow[number]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(colorScheme == .dark ? Color.gray : Color.white).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        }
                    }
                })
                HStack (spacing: 1, content:{
                    ForEach(0 ..< 4) { number in
                        Button(action: {
                            buttonClick(buttonText: self.thirdRow[number], viewModel: self.viewModel)
                        }) {
                            Text(self.thirdRow[number]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(colorScheme == .dark ? Color.gray : Color.white).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        }
                    }
                })
                HStack (spacing: 1, content:{
                    ForEach(0 ..< 4) { number in
                        Button(action: {
                            buttonClick(buttonText: self.fourthRow[number], viewModel: self.viewModel)
                        }) {
                            Text(self.fourthRow[number]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(colorScheme == .dark ? Color.gray : Color.white).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            }
                    }
                })
                HStack (spacing: 1, content:{
                    HStack (spacing: 1, content:{
                        ForEach(0 ..< 1) { number in
                            Button(action: {
                                buttonClick(buttonText: self.lastRow[number], viewModel: self.viewModel)
                            }) {
                                Text(self.lastRow[number]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(colorScheme == .dark ? Color.gray : Color.white).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                }
                        }
                    })
                    HStack (spacing: 1, content:{
                        ForEach(0 ..< 2) { number in
                            Button(action: {
                                buttonClick(buttonText: self.lastRow[number + 1], viewModel: self.viewModel)
                            }) {
                                Text(self.lastRow[number + 1]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(colorScheme == .dark ? Color.gray : Color.white).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                }
                        }
                    })
                })
            }).buttonStyle(PlainButtonStyle()).font(.system(size: 24)).background(Color(red: 64 / 255, green: 64 / 255, blue: 64 / 255))
        }).edgesIgnoringSafeArea(.all)
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
var equalPressed:Bool = false

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
        equalPressed = false
        currentOperation = ""
    case "+/-":
        if (currentNumber != 0.0 && !equalPressed) {
            currentNumber = -currentNumber
            currentNumberText = "-" + currentNumberText
            viewModel.calculationText = String(format: "%g", currentNumberText)
        }
        if (equalPressed && previousNumber != 0) {
            previousNumber = -previousNumber
            let previousNumberText = String(previousNumber)
            viewModel.calculationText = String(format: "%g", previousNumberText)
        }
    case "%":
        print("% was pressed")
        if (currentNumber != 0 && !equalPressed) {
            currentNumber = currentNumber / 100
            currentNumberText = String(currentNumber)
            viewModel.calculationText = currentNumberText
        }
        if (equalPressed && previousNumber != 0) {
            previousNumber = previousNumber / 100
            let previousNumberText = String(previousNumber)
            viewModel.calculationText = previousNumberText
        }
    case "/", "x", "-", "+":
        print("current number " + String(currentNumber))
        if (equalPressed == false) {
            if (previousNumber == 0.0) {
                previousNumber = currentNumber
            } else {
                currentNumber = Double(currentNumber)
                previousNumber = Double(previousNumber)
                let result = evaluate(currentOperation: currentOperation, num1: previousNumber, num2: currentNumber)
                viewModel.calculationText = String(format: "%g", result)
                previousNumber = result
            }
        }
        currentOperation = buttonText
        currentNumber = 0.0
        currentNumberText = ""
        equalPressed = false
    case "=":
        currentNumber = Double(currentNumber)
        previousNumber = Double(previousNumber)
        print(currentNumber)
        print(previousNumber)
        if (currentOperation == "") {
            return;
        }
        //Evaluate operations on numbers
        let result = evaluate(currentOperation: currentOperation, num1: previousNumber, num2: currentNumber)
        viewModel.calculationText = String(format: "%g", result)
        previousNumber = result
        currentNumber = 0.0
        currentNumberText = ""
        equalPressed = true
    default:
        if (viewModel.calculationText.contains(".") && buttonText == ".") {
            return;
        }
        if (equalPressed && viewModel.calculationText.contains(".") == false && viewModel.calculationText != "") {
            currentNumberText = viewModel.calculationText + buttonText
            viewModel.calculationText = currentNumberText
            previousNumber = Double(currentNumberText)!
            print("previous number " + String(previousNumber))
        } else if (equalPressed) {
            currentNumberText = currentNumberText + buttonText
            previousNumber = Double(currentNumberText)!
            viewModel.calculationText = currentNumberText
        } else {
            currentNumberText = currentNumberText + buttonText
            if (currentNumberText == ".") {
                viewModel.calculationText = "0."
                currentNumberText = "0."
            } else {
                currentNumber = Double(currentNumberText)!
                viewModel.calculationText = currentNumberText
            }
        }
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
