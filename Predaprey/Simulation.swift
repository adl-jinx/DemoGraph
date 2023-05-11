//
//  Simulation.swift
//  Predaprey
//
//  Created by Antonio De Luca on 31/03/23.
//

import SwiftUI
import Charts

struct SimulationView: View {
    
    
    
    @State private var initialRabbits = "50"
    @State private var initialPredators = "20"
    @State private var growthRate = "0.50"
    @State private var consumptionRate = "0.02"
    @State private var predatorIncreaseRate = "0.003"
    @State private var predatorDeathRate = "0.85"
    @State private var carryingCapacity = "1000"
    @State private var timeStep = "0.1"
    @State private var numTimeSteps = "100"
    
    @State private var result: (Double, Double) = (0,0)
    
    @State private var ObjSim: [SimResult] = [
        SimResult(rabbits: 0, predator: 0, timeStamp: 1),
        SimResult(rabbits: 0, predator: 0, timeStamp: 1)
    ]
    
    
    var body: some View {
        
        
        NavigationView{
            
            
            ScrollView{
                VStack(spacing: 20) {
                    Group{
                        TextField("Initial rabbit population", text: $initialRabbits)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Initial predator population", text: $initialPredators)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Rabbit growth rate (a)", text: $growthRate)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Predator consumption rate (b)", text: $consumptionRate)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Predator increase rate (c)", text: $predatorIncreaseRate)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Predator death rate (d)", text: $predatorDeathRate)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Carrying capacity (K)", text: $carryingCapacity)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Time step (Δt)", text: $timeStep)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Number of time steps", text: $numTimeSteps)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    // BUTTON BEGINNING -> CREATE RESULT VARIABLE -
                    
                    Button(action: {
                        
                        // Convert input values to appropriate data types
                        let r0 = Double(initialRabbits) ?? 0
                        let p0 = Double(initialPredators) ?? 0
                        let a = Double(growthRate) ?? 0
                        let b = Double(consumptionRate) ?? 0
                        let c = Double(predatorIncreaseRate) ?? 0
                        let d = Double(predatorDeathRate) ?? 0
                        let k = Double(carryingCapacity) ?? 0
                        let dt = Double(timeStep) ?? 0
                        let steps = Int(numTimeSteps) ?? 0
                        
                        
                        // Call the rungeKuttaMethod function with the input values
                        print("Sim started")
                        let result = rungeKuttaMethod(r0: r0, p0: p0, a: a, b: b, c: c, d: d, k: k, timeStep: dt, numSteps: steps)
                        
                        // _ = processSimulationResults(result)
                        print("Simulation finished")
                        ObjSim = processSimulationResults(result)
                        
                        // Process the result (e.g., display it on a graph or in a table)
                    })
                    {
                        Text("Simulate")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    //Button End
                    .navigationTitle("Simulation")
                    .padding()
                    CharterGraph(simResults: ObjSim, carryCap: carryingCapacity, endCycle: numTimeSteps)
                    NavigationLink(destination: CharterGraph(simResults: ObjSim, carryCap: (carryingCapacity), endCycle: numTimeSteps)) {
                        Text("Simulation Graph View")
                    }                }
            }
        }.padding()
    }
}



struct SimulationView_Previews: PreviewProvider {
    static var previews: some View {
        SimulationView()
    }
}

