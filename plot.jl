using Plots

# Run simulation and plot results
function run_simulation_with_plot(boids, frames, boundaries, time_step)
    x_limits, y_limits, z_limits = boundaries

    # Animate frames
    anim = @animate for frame in 1:frames
        update_boids!(boids, time_step)
        scatter(
            [b.position[1] for b in boids],
            [b.position[2] for b in boids],
            [b.position[3] for b in boids],
            markersize=5,
            markercolor=:blue,
            alpha=0.4,  # Set transparency to 40%
            xlims=(x_limits[1], x_limits[2]),
            ylims=(y_limits[1], y_limits[2]),
            zlims=(z_limits[1], z_limits[2]),
            xlabel="X", ylabel="Y", zlabel="Z",
            title="Flocking Simulation",
            label=false
        )
    end

    gif(anim, "flocking_simulation.gif", fps=20)
end

