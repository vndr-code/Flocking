# Flocking Simulation in Julia

This repository contains a 3D flocking simulation implemented in Julia. The simulation models the collective behavior of particles (or "boids") that follow simple rules of separation, alignment, and cohesion, inspired by natural systems like bird flocks or fish schools.

---

## Features

- **Separation**: Ensures boids maintain a minimum distance to avoid collisions.
- **Alignment**: Boids align their velocity with nearby neighbors.
- **Cohesion**: Encourages boids to move towards the center of mass of nearby neighbors.
- **Boundary Reflection**: Keeps boids within the defined simulation space by reflecting their positions.

---

## File Structure

- **`main.jl`**: The main entry point for the simulation. Configures parameters and initializes the simulation.
- **`plot.jl`**: Handles visualization of the boids' movement.
- **`flocking.jl`**: Contains the core logic for the flocking behavior, including the boid structure, force calculations, and boundary handling.

---
