//
//  CharterGraph.swift
//  Predaprey
//
//  Created by Antonio De Luca on 01/04/23.
//

import SwiftUI
import Charts

// this init is only for the preview.

var data: [SimResult] = [
    .init(rabbits: 45, predator: 25, timeStamp: 0),
    .init(rabbits: 50, predator: 20, timeStamp: 1),
    .init(rabbits: 54, predator: 19, timeStamp: 2),
    .init(rabbits: 60, predator: 18, timeStamp: 3),
    .init(rabbits: 65, predator: 17, timeStamp: 4),
]



struct CharterGraph: View {
    
    var simResults: [SimResult] = []
    @State private var selectedDataPoint: SimResult?
    
    @State var rabbitPopulation : Int = 0
    @State var cyclesRabbit: Int = 0
    
    @State var cyclesPred: Int = 0
    @State var predatorPopulation: Int = 0
    
    // these var are for the - carryCapacity RuleMark
    @State var carryCap: String
    @State var endCycle: String
    
    @State var chartWidth: CGFloat = 0 // Track the width of the chart
    @State var sliderValue: Double = 1.0 // Default value for slider
    
    @State var sliderValuePred: Double = 1.0
    
    
    var body: some View {
        
        VStack{
            
            Text("Rabbit")
                .bold()
            Text(String("Prey pop: \(rabbitPopulation)"))
            Text(String("Cycles: \(cyclesRabbit)"))
            // Text("Rabbit Population: \(point)")
            
            Chart{
                
                if let carryCapInt = Int(carryCap), let endCycleInt = Int(endCycle) {
                    RuleMark(
                        xStart: .value("", 0),
                        xEnd: .value("", endCycleInt),
                        y: .value("CarryCap", carryCapInt)
                        
                    )
                    .foregroundStyle(Color.green)
                    .annotation(position: .top, alignment: .trailing) {
                        Text("Environment Capacity")
                    }
                    
                    let endIndex = Int(Double(simResults.count) * sliderValue) // Calculate the end index based on slider value
                    
                    let filteredSimResults = Array(simResults[0..<endIndex])
                    
                    ForEach(filteredSimResults) { dataPoint in
                        LineMark(
                            x: .value("Time Stamp", Double(dataPoint.timeStamp)),
                            y: .value("Rabbits", dataPoint.rabbits)
                        )
                        .annotation{
                            Text("\(dataPoint.rabbits)")
                        }
                    }
                
                    PointMark(
                        x: .value("Prey", cyclesRabbit),
                        y: .value("Time", rabbitPopulation)
                    ).foregroundStyle(Color.yellow)
                }
            }
            
            
            
            .frame(height: 200)
            
           
            
            .background(
                GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            chartWidth = geo.size.width
                        }
                }
            )
            
            
            .chartOverlay{ proxy in
                GeometryReader { geometry in
                    Rectangle().fill(.clear).contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    // Convert the gesture location to the coordiante space of the plot area.
                                    let origin = geometry[proxy.plotAreaFrame].origin
                                    let location = CGPoint(
                                        x: value.location.x - origin.x,
                                        y: value.location.y - origin.y
                                    )
                                    // Get the x () and y () value from the location.
                                    
                                    let (timeStamp, _) = proxy.value(at: location, as: (Double, Int).self)!
                                    
                                    let closestTimestamp = simResults.min { a, b in
                                        let aDistance = abs(Double(a.timeStamp) - timeStamp)
                                        let bDistance = abs(Double(b.timeStamp) - timeStamp)
                                        return aDistance < bDistance
                                    }?.timeStamp
                                    
                                    if let closestTimestamp = closestTimestamp {
                                        cyclesRabbit = closestTimestamp
                                        rabbitPopulation = simResults.first(where: { $0.timeStamp == closestTimestamp })?.rabbits ?? 0
                                    }
                                    
                                })
                } // Geometry Reader
            } // Overlay End
            
            Slider(value: $sliderValue, in: 0...1, step: 0.01)
                .padding(.horizontal, 20)
                .frame(height: 30)
                .background(Color.white.opacity(0.5))
            Text("\(Int(sliderValue * Double(simResults.count - 1))) / \(simResults.count - 1)")

            
            
            
            
            
            
            
            
            
            
            
            
            
            // PREDATOR CHART
            Group{
                Text("Predator")
                    .bold()
                Text(String("Pred pop: \(predatorPopulation)"))
                Text(String("Cycles: \(cyclesPred)"))
            }
            
            Chart {
                
                
                let endIndexPred = Int(Double(simResults.count) * sliderValuePred) // Calculate the end index based on slider value
                
                let filteredSimResultsPred = Array(simResults[0..<endIndexPred])
                
                ForEach(filteredSimResultsPred) { dataPoint in
                    LineMark(
                        x: .value("Time", Int(dataPoint.timeStamp)),
                        y: .value("Predator", dataPoint.predator))
                    .foregroundStyle(Color.red)
                    .annotation{
                        Text("\(dataPoint.predator)")
                        
                    }
                }
                PointMark(
                    x: .value("Prey", cyclesPred),
                    y: .value("Time", predatorPopulation)
                ).foregroundStyle(Color.yellow)
            }
            .chartOverlay { proxy in
                GeometryReader { geometry in
                    Rectangle().fill(.clear).contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    // Convert the gesture location to the coordiante space of the plot area.
                                    let origin = geometry[proxy.plotAreaFrame].origin
                                    let location = CGPoint(
                                        x: value.location.x - origin.x,
                                        y: value.location.y - origin.y
                                    )
                                    // Get the x (date) and y (price) value from the location.
                                    let (timeStamp, _) = proxy.value(at: location, as: (Double, Int).self)!
                                    
                                    let closestTimestamp = simResults.min { a, b in
                                        let aDistance = abs(Double(a.timeStamp) - timeStamp)
                                        let bDistance = abs(Double(b.timeStamp) - timeStamp)
                                        return aDistance < bDistance
                                    }?.timeStamp
                                    
                                    if let closestTimestamp = closestTimestamp {
                                        cyclesPred = closestTimestamp
                                        predatorPopulation = simResults.first(where: { $0.timeStamp == closestTimestamp })?.predator ?? 0
                                    }
                                }
                        )
                    
                }
                
                
            } // Overlay End.
            
            Slider(value: $sliderValuePred, in: 0...1, step: 0.01)
                .padding(.horizontal, 20)
                .frame(height: 30)
                .background(Color.white.opacity(0.5))
            
            
        } // - END OF THE VIEW -
        
    } //  - END OF THE CharterGraph Struct -
    
}

struct CharterGraph_Previews: PreviewProvider {
    static var previews: some View{
        CharterGraph(simResults: data, carryCap: "1000", endCycle: "100")
    }
}

