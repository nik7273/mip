using JuMP
using Gurobi

include("../sim/grocery_packing_env.jl")

domain_path = "pddl_graph/pddl/groceryworld/domain.pddl"
problem_path = "pddl_graph/pddl/groceryworld/problem1.pddl"

function volume(object)
    return 1 # figure out how to get volume from object. Cube for now.
end

function bin_packing_constraints(model, objects, n, bin_capacity)
    m = size(objects)
    @variable(model, y[1:n])
    @variable(model, z[1:m, 1:n])
    @constraint(model, [i=1:m, j=1:n], sum(volume(objects[i]) * z[i,j]) <= bin_capacity*y[j])
    @constraint(model, [i=1:m, j=1:n], sum(z[i,j])==1)
    problem_objective = y->sum(y) # function 
    return problem_objective
end

load_and_run_sim(domain_path, problem_path, bin_packing_constraints)