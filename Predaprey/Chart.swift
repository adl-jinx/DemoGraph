//
//  Chart.swift
//  Predaprey
//
//  Created by Antonio De Luca on 01/04/23.
//

import SwiftUI
import Charts

struct SimResult: Identifiable {
    let id = UUID()
    let rabbits: Double
    let predators: Double
    let timeStamp: Int
}



func createSimResults(from: simulationResult: [(Double, Double)]) -> [SimResult] 


let simulationData: [SimResult] = [
    // Paste the list of tuples you got from the simulation here
    // Convert each tuple to a Risultati object
    SimResult(rabbits: 50.0, predators: 20.0, timeStamp: 0),
    SimResult(rabbits: 50.42054587554474, predators: 19.121112457066666, timeStamp: 1),
    // ... and so on
]


