//
//  RungeKutta.swift
//  Predaprey
//
//  Created by Antonio De Luca on 31/03/23.
//

import Foundation

public func rungeKuttaMethod(r0: Double, p0: Double, a: Double, b: Double, c: Double, d: Double, k: Double, timeStep: Double, numSteps: Int) -> [(Double, Double)] {
    var rabbitPopulation = r0
    var predatorPopulation = p0
    var result: [(Double, Double)] = [(r0, p0)]

    for _ in 0..<numSteps {
        let r1 = timeStep * (a * rabbitPopulation * (1 - rabbitPopulation / k) - b * rabbitPopulation * predatorPopulation)
        let p1 = timeStep * (c * rabbitPopulation * predatorPopulation - d * predatorPopulation)

        let r2 = timeStep * (a * (rabbitPopulation + r1 / 2) * (1 - (rabbitPopulation + r1 / 2) / k) - b * (rabbitPopulation + r1 / 2) * (predatorPopulation + p1 / 2))
        let p2 = timeStep * (c * (rabbitPopulation + r1 / 2) * (predatorPopulation + p1 / 2) - d * (predatorPopulation + p1 / 2))

        let r3 = timeStep * (a * (rabbitPopulation + r2 / 2) * (1 - (rabbitPopulation + r2 / 2) / k) - b * (rabbitPopulation + r2 / 2) * (predatorPopulation + p2 / 2))
        let p3 = timeStep * (c * (rabbitPopulation + r2 / 2) * (predatorPopulation + p2 / 2) - d * (predatorPopulation + p2 / 2))

        let r4 = timeStep * (a * (rabbitPopulation + r3) * (1 - (rabbitPopulation + r3) / k) - b * (rabbitPopulation + r3) * (predatorPopulation + p3))
        let p4 = timeStep * (c * (rabbitPopulation + r3) * (predatorPopulation + p3) - d * (predatorPopulation + p3))

        rabbitPopulation += (r1 + 2 * r2 + 2 * r3 + r4) / 6
        predatorPopulation += (p1 + 2 * p2 + 2 * p3 + p4) / 6

        // Check for extinction and set the population to 0 if the threshold is reached
        if rabbitPopulation < 1 {
            rabbitPopulation = 0
        }
        if predatorPopulation < 1 {
            predatorPopulation = 0
        }

        result.append((rabbitPopulation, predatorPopulation))

        // Stop the simulation if both populations have reached extinction
        if rabbitPopulation == 0 && predatorPopulation == 0 {
            break
        }
    }


    return result
}

