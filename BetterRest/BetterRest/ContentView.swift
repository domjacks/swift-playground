//
//  ContentView.swift
//  BetterRest
//
//  Created by Dom Jackson on 27/09/2025.
//

import SwiftUI
import CoreML

struct ContentView: View {
    // Inputs
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var wakeUpTime: String {
        return calculateBedtime()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    HStack {
                        Spacer()
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                        Spacer()
                    }
                }
                Section(header: Text("Desired amount of sleep")) {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                Section(header: Text("Daily coffee intake")) {
                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)

                }
            }
            Text("Sleep time: \(wakeUpTime)")
                .font(.largeTitle)
            .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            // Get at the minutes and hours and convert to seconds
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let totalSeconds = Double(hour + minute)
            
            let prediction = try model.prediction(wake: totalSeconds, estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
}

#Preview {
    ContentView()
}
