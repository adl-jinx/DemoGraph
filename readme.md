# Predaprey Simulation

Predaprey is a simulation program written in Swift that models the population dynamics between rabbits (prey) and predators. This program was developed with the aim of exploring the capabilities of the Swift Chart library and includes a feature to track the population changes with a pointer on the graph.

## Features

- The simulation can be customized with the following parameters:
  - Initial rabbit population
  - Initial predator population
  - Rabbit growth rate
  - Predator consumption rate
  - Predator increase rate
  - Predator death rate
  - Carrying capacity (maximum population size)
  - Time step size
  - Number of time steps

- The simulation results are processed and stored in the `SimResult` struct, which contains information about the rabbit population, predator population, and the corresponding time stamp.

- The simulation results can be visualized using the `CharterGraph` view, which displays line charts for the rabbit population and predator population over time. The view includes a slider to adjust the displayed time range of the simulation results.

- The `CharterGraph` view also incorporates a pointer that tracks the population values as you interact with the charts. This pointer allows for easy identification of the population values at specific time points.

## Usage

1. Set the desired simulation parameters in the `SimulationView` by providing values for the text fields.
2. Click the "Simulate" button to run the simulation using the Runge-Kutta method with the specified parameters.
3. The simulation results will be displayed in the `CharterGraph` view, showing the population changes over time for rabbits and predators.
4. Adjust the slider to change the time range displayed on the charts.
5. As you interact with the charts, the pointer will track the population values at specific time points, providing a visual representation of the population dynamics.

Feel free to explore and experiment with different parameter values to observe the population dynamics between rabbits and predators in the simulation. Additionally, take advantage of the pointer feature to easily track the population values at specific time points.

## Technologies Used

- The program is built using SwiftUI, a framework for building user interfaces in Swift.
- The Charts library is utilized for displaying the line charts in the `CharterGraph` view.

Please note that this description assumes the presence of additional code and files that may not have been included in the provided code snippets. The provided code snippets should be integrated into a larger project structure for proper execution.

This README provides a brief overview of the Predaprey simulation program, its usage, and the incorporation of the pointer feature for tracking the population values. For more detailed information and instructions, refer to the code comments and documentation within the program files.

Feel free to reach out if you have any questions or need further assistance!
