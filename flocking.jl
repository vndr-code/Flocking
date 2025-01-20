# Boid structure and initialization
struct Boid
    position::SVector{3, Float64}
    velocity::SVector{3, Float64}
    acceleration::SVector{3, Float64}
end

# Initialize boids with random positions and velocities
function initialize_boids(num_boids::Int, boundaries::Tuple{Tuple{Float64, Float64}, Tuple{Float64, Float64}, Tuple{Float64, Float64}})
    x_limits, y_limits, z_limits = boundaries
    boids = Boid[]
    for _ in 1:num_boids
        position = SVector(
            rand(x_limits[1]:0.01:x_limits[2]),
            rand(y_limits[1]:0.01:y_limits[2]),
            rand(z_limits[1]:0.01:z_limits[2])
        )
        velocity = SVector(
            rand([-1.0, 1.0]) * rand(0.01:0.01:0.05),
            rand([-1.0, 1.0]) * rand(0.01:0.01:0.05),
            rand([-1.0, 1.0]) * rand(0.01:0.01:0.05)
        )
        push!(boids, Boid(position, velocity, SVector(0.0, 0.0, 0.0)))
    end
    return boids
end

# Update boids positions and velocities
function update_boids!(boids, time_step::Float64)
    for i in eachindex(boids)
        boid = boids[i]
        
        # Reset acceleration
        acceleration = SVector(0.0, 0.0, 0.0)

        # Flocking rules
        separation = compute_separation(boid, boids)
        alignment = compute_alignment(boid, boids)
        cohesion = compute_cohesion(boid, boids)

        # Aggregate forces
        acceleration += separation
        acceleration += alignment
        acceleration += cohesion

        # Update velocity
        velocity = boid.velocity + acceleration * time_step
        velocity = clamp_velocity(velocity, 0.05)

        # Update position
        position = boid.position + velocity * time_step
        position = reflect_boundaries(position, (X_BOUNDARY, Y_BOUNDARY, Z_BOUNDARY))

        # Update boid
        boids[i] = Boid(position, velocity, acceleration)
    end
end

# Flocking rules
function compute_separation(boid::Boid, boids::Vector{Boid})
    force = SVector(0.0, 0.0, 0.0)
    for other in boids
        if other !== boid
            distance = norm(boid.position - other.position)
            if distance < 0.1
                force -= (other.position - boid.position) / distance
            end
        end
    end
    return force
end

function compute_alignment(boid::Boid, boids::Vector{Boid})
    avg_velocity = SVector(0.0, 0.0, 0.0)
    count = 0
    for other in boids
        if other !== boid && norm(boid.position - other.position) < 0.5
            avg_velocity += other.velocity
            count += 1
        end
    end
    return count > 0 ? (avg_velocity / count - boid.velocity) * 0.05 : SVector(0.0, 0.0, 0.0)
end

function compute_cohesion(boid::Boid, boids::Vector{Boid})
    center_of_mass = SVector(0.0, 0.0, 0.0)
    count = 0
    for other in boids
        if other !== boid && norm(boid.position - other.position) < 0.5
            center_of_mass += other.position
            count += 1
        end
    end
    return count > 0 ? (center_of_mass / count - boid.position) * 0.05 : SVector(0.0, 0.0, 0.0)
end

# Utility functions
function clamp_velocity(velocity, max_speed)
    speed = norm(velocity)
    return speed > max_speed ? velocity * (max_speed / speed) : velocity
end

function reflect_boundaries(position, boundaries)
    x_limits, y_limits, z_limits = boundaries
    position = SVector(
        clamp(position[1], x_limits[1], x_limits[2]),
        clamp(position[2], y_limits[1], y_limits[2]),
        clamp(position[3], z_limits[1], z_limits[2])
    )
    return position
end
