include("../pddl_graph/create_graph.jl")
domain = load_domain("pddl_graph/pddl/blocksworld/domain.pddl")
problem =  load_problem("pddl_graph/pddl/blocksworld/problem3.pddl")

tree =  create_causal_graph(domain, problem; max_depth=1000000)
id_dict = get_state_int_id_dict(tree)
pais, actions, pair_action_dict = get_edge_action_pairs(tree)
print_id_to_state(tree, id_dict)
println(pair_action_dict)
matrix = create_adjacency_matrix(tree, pais)
# get_goal_id(domain, problem, id_dict, tree)
