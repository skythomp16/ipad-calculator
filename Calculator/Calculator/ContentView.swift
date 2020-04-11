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
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Hello").font(.title)
                }
            }.frame(minWidth: 44, maxWidth: .infinity, minHeight: 250)
            VStack {
                HStack {
                    ForEach(0 ..< 4) { number in
                        Button(action: {
                           // flag was tapped
                        }) {
                            Text(self.topRow[number])
                        }.frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity)
                    }
                }
                HStack {
                    ForEach(0 ..< 4) { number in
                        Button(action: {
                           // flag was tapped
                        }) {
                            Text(self.secondRow[number])
                        }.frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity)
                    }
                }
                HStack {
                    ForEach(0 ..< 4) { number in
                        Button(action: {
                           // flag was tapped
                        }) {
                            Text(self.thirdRow[number])
                        }.frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity)
                    }
                }
                HStack {
                    ForEach(0 ..< 4) { number in
                        Button(action: {
                           // flag was tapped
                        }) {
                            Text(self.fourthRow[number])
                        }.frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity)
                    }
                }
                HStack {
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                           // flag was tapped
                        }) {
                            Text(self.lastRow[number])
                        }.frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: .infinity)
                    }
                }
            }.buttonStyle(PlainButtonStyle())
        }
    }
    func addNumber() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
