//
//  ContentView.swift
//  Calculator
//
//  Created by Skyler Thompson on 4/10/20.
//  Copyright © 2020 Skyler Thompson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let topRow = ["AC", "+/-", "%", "/"]
    let secondRow = ["7", "8", "9", "x"]
    let thirdRow = ["4", "5", "6", "-"]
    let fourthRow = ["1", "2", "3", "+"]
    let lastRow = ["0", ".", "="]
    let numRows = 5
    var body: some View {
        VStack {
            VStack {
                HStack(content: {
                    Text("0").font(.system(size:60))
                })
            }.frame(minWidth: 44, maxWidth: .infinity, minHeight: 250).background(Color(red: 64 / 255, green: 64 / 255, blue: 64 / 255)).foregroundColor(Color.white)
            VStack(spacing: 1, content: {
                HStack (spacing: 1, content:{
                    ForEach(0 ..< 4) { number in
                        Button(action: { buttonClick(buttonText: self.topRow[number])
                            
                        }) {
                            Text(self.topRow[number]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(Color.gray)
                        }
                    }
                })
                HStack (spacing: 1, content:{
                    ForEach(0 ..< 4) { number in
                        Button(action: {
                           buttonClick(buttonText: self.secondRow[number])
                        }) {
                            Text(self.secondRow[number]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(Color.gray)
                        }
                    }
                })
                HStack (spacing: 1, content:{
                    ForEach(0 ..< 4) { number in
                        Button(action: {
                           buttonClick(buttonText: self.thirdRow[number])
                        }) {
                            Text(self.thirdRow[number]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(Color.gray)
                        }
                    }
                })
                HStack (spacing: 1, content:{
                    ForEach(0 ..< 4) { number in
                        Button(action: {
                           buttonClick(buttonText: self.fourthRow[number])
                        }) {
                            Text(self.fourthRow[number]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(Color.gray)
                            }
                    }
                })
                HStack (spacing: 1, content:{
                    HStack (spacing: 1, content:{
                        ForEach(0 ..< 1) { number in
                            Button(action: {
                               buttonClick(buttonText: self.lastRow[number])
                            }) {
                                Text(self.lastRow[number]).frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity).background(Color.gray)
                                }
                        }
                    })
                    HStack (spacing: 1, content:{
                        ForEach(0 ..< 2) { number in
                            Button(action: {
                               buttonClick(buttonText: self.lastRow[number + 1])
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

func buttonClick(buttonText: String) {
    print(buttonText)
}
