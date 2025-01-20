using Pkg

# Activate environment
Pkg.activate(".")
Pkg.instantiate()
Pkg.add("Plots")
Pkg.add("StaticArrays")
Pkg.add("LinearAlgebra")

# Load dependencies and include modules
using Plots
using StaticArrays
using LinearAlgebra

include("flocking.jl")
include("plot.jl")

# Simulation constants
const X_BOUNDARY = (-1.0, 1.0)
const Y_BOUNDARY = (-1.0, 1.0)
const Z_BOUNDARY = (-1.0, 1.0)
const TIME_STEP = 0.1
const FRAMES = 1500
const NUM_BOIDS = 100

# Initialize boids
boids = initialize_boids(NUM_BOIDS, (X_BOUNDARY, Y_BOUNDARY, Z_BOUNDARY))

# Run and visualize the simulation
run_simulation_with_plot(boids, FRAMES, (X_BOUNDARY, Y_BOUNDARY, Z_BOUNDARY), TIME_STEP)
