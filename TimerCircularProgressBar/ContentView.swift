//
//  ContentView.swift
//  TimerCircularProgressBar
//
//  Created by Rangga Biner on 19/05/24.
//

import SwiftUI

let timer = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()

struct ContentView: View {
    
    @State var counter: Int = 0
    var countTo: Int = 120 // 4 minutes 120 - 2 minutes
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color(.clear))
                    .frame(width: 250, height: 250)
                    .overlay(
                        Circle().stroke(Color.green, lineWidth: 25)
                )
                
                Circle()
                    .fill(Color(.clear))
                    .frame(width: 250, height: 250)
                    .overlay(
                        Circle().trim(from: 0, to: progress())
                            .stroke(style: StrokeStyle(
                            lineWidth: 25,
                            lineCap: .square,
                            lineJoin: .round
                            )
                        )
                            .foregroundStyle(Color(completed() ? Color.orange : Color.gray))
                    ).animation(
                        .easeInOut(duration: 0.2)
                    )
                Clock(counter: counter, countTo: countTo)
            }
        } // end vstack
        .onReceive(timer) { time in
            if (self.counter < self.countTo) {
                self.counter += 1
            }
        }
    }
    
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return(CGFloat(counter) / CGFloat(countTo))
    }
}

struct Clock: View {
    
    var counter: Int
    var countTo: Int
    
    var body: some View {
        VStack {
            Text(counterToMinutes())
                .font(.system(size: 60))
                .fontWeight(.black)
        }
    }
    
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds  = currentTime % 60
        let minute = Int(currentTime / 60)
        
        return "\(minute):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}


#Preview {
    ContentView()
}
