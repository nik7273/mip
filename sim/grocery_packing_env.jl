include("../solver/mip_solver.jl")
include("action_model.jl")

function execute_plan!(plan, vis, poses, anim, ts)
    for action in plan
        act = process_action(action)
        if act[1] == "pickup"
            pickup!(act[2], vis, poses, anim, ts)
        elseif act[1] == "putdown"
            putdown!(act[2], vis, poses, anim, ts)
        elseif act[1] == "stack"
            stack!(act[2], act[3], vis, poses, anim, ts)
        elseif act[1] == "unstack"
            unstack!(act[2], act[3], vis, poses, anim, ts)
        elseif act[1] == "putleft"
            putleft!(act[2], vis, poses, anim, ts)
        elseif act[1] == "putright"
            putright!(act[2], vis, poses, anim, ts)
        end
    end
end

function load_and_run_sim(domain_path, problem_path, problem_constraint_fn)
    vis = Visualizer()
    load_table("sim/models/table/desk.obj", [0.0, 0.0, 0.0], vis)
    gripper_path = "sim/models/ee/endeffector.obj"
    poses = Dict()
    domain = load_domain(domain_path)
    problem = load_problem(problem_path)
    load_objects!(problem, vis, poses)
    load_ee!(vis, gripper_path, poses)
    initialize_objects!(problem, vis, poses)
    anim = Animation()
    ts = [0]
    @time plan = mip_planner(domain_path, problem_path, problem_constraint_fn)
    execute_plan!(plan, vis, poses, anim, ts)
    render(vis)
end