//
//  ResultProcessing.swift
//  Predaprey
//
//  Created by Antonio De Luca on 01/04/23.
//

import Foundation

struct SimResult: Identifiable {
    let id = UUID()
    let rabbits: Int
    let predator: Int
    let timeStamp: Int
}


func processSimulationResults(_ results: [(Double, Double)]) -> [SimResult] {
    var processedResults: [SimResult] = []
    
    for (index, result) in results.enumerated() {
           let simResult = SimResult(rabbits: Int(round(result.0)), predator: Int(round(result.1)), timeStamp: index)
           processedResults.append(simResult)
       }
        print("------ Sta Result Processing -----")
        print(processedResults)
        print("------ End Result Processing -----")
        return processedResults
        
}


 
