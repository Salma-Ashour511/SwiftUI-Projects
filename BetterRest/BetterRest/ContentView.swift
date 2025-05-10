//
//  ContentView.swift
//  BetterRest
//
//  Created by V17SAshour1 on 08/05/2025.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWatkeTime
    @State private var coffeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWatkeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
        
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // Showing current date and time
                Text(Date.now.formatted(date: .long, time: .shortened))
                Spacer()
                
                Form {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        // Date Picker
                        DatePicker("Please pick a time:", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Desired amount of sleep?")
                            .font(.headline)
                        // Stepper
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                    
                   
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Daily coffee intake?")
                            .font(.headline)
                        // Stepper
                        Stepper("^[\(coffeeAmount.formatted()) cup](inflect: true)", value: $coffeeAmount, in: 0...10)
                        
                    }
                }
                Spacer()
            }
            .navigationTitle("BetterRest")
            .toolbar(content: {
                Button("Calculate") {
                    calculateBedTime()
                }
            })
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    // 86400 is the number of seconds from now to tomorrow
    
    func calculateBedTime() {
        let config = MLModelConfiguration()
        do {
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
