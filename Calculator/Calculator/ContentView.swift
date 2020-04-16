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

var number1 : String = ""
var number2 : String = ""
var num2 : Bool = false
var reset : Bool = false
var operation = ""

func buttonClick(buttonText: String, viewModel : ViewModel) {
    switch(buttonText) {
    case "AC":
        print("AC was pressed")
        viewModel.calculationText = "0"
        number1 = ""
        number2 = ""
        num2 = false
    case "+/-":
        print("+/- was pressed")
        if (num2) {
            number2 = "-" + number2
            viewModel.calculationText = number2
        } else {
            number1 = "-" + number1
            viewModel.calculationText = number1
        }
    case "%":
        print("% was pressed")
        var result:Double = 0.0
        if (num2) {
            let numb:Int = Int(number2)!
            result = Double(numb) / Double(100)
        } else {
            let numb:Int = Int(number1)!
            result = Double(numb) / Double(100)
        }
        let resultString = String(result)
        print(resultString)
        if (num2) {
            number2 = resultString
        } else {
            number1 = resultString
        }
        viewModel.calculationText = resultString
    case "/":
        print("/ was pressed")
        if (!number1.isEmpty) {
            viewModel.calculationText = "0"
            number2 = "0"
            num2 = true
            operation = "/"
        }
    case "x":
        print("x was pressed")
         if (!number1.isEmpty) {
            viewModel.calculationText = "0"
            number2 = "0"
            num2 = true
            operation = "*"
        }
    case "-":
        print("- was pressed")
         if (!number1.isEmpty) {
            viewModel.calculationText = "0"
            number2 = "0"
            num2 = true
            operation = "-"
        }
    case "+":
         if (!number1.isEmpty) {
            print("+ was pressed")
            viewModel.calculationText = "0"
            number2 = "0"
            num2 = true
            operation = "+"
        }
    case "=":
        print("= was pressed")
        if (!number1.isEmpty || !number2.isEmpty) {
            let numb1:Double = Double(number1)!
            let numb2:Double = Double(number2)!
            var result:Double = 0.0
            switch(operation) {
            case "/":
                result = numb1 / numb2
            case "*":
                result = numb1 * numb2
            case "+":
                result = numb1 + numb2
            case "-":
                result = numb1 - numb2
            default:
                print("Something went horribly wrong")
            }
            viewModel.calculationText = String(result)
        } else if (number2.isEmpty && !number1.isEmpty) {
            viewModel.calculationText = String("0")
        }
        
        //reset everything
        number1 = ""
        number2 = ""
        num2 = false
        reset = true
    default:
        print(buttonText + " was pressed")
        if (reset) {
            viewModel.calculationText = ""
        }
        if (viewModel.calculationText == "0") {
            viewModel.calculationText = ""
        }
        if (num2) {
            number2 = viewModel.calculationText + buttonText
            viewModel.calculationText = number2;
            print(number2)
        } else {
            number1 = viewModel.calculationText + buttonText
            viewModel.calculationText = number1
            print(number1)
        }
    }
}
