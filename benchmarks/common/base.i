{{ comps }}

[Postprocessors]
  [num_elems]
    type = NumElems
  []

  [res_time]
    type = PerfGraphData
    data_type = TOTAL
    section_name = THMProblem::computeResidualInternal
    execute_on = TIMESTEP_END
  []

  [jac_time]
    type = PerfGraphData
    data_type = TOTAL
    section_name = THMProblem::computeJacobianInternal
    execute_on = TIMESTEP_END
  []

  [solve_time]
    type = PerfGraphData
    data_type = TOTAL
    section_name = THMProblem::solve
    execute_on = TIMESTEP_END
  []
[]

[Executioner]
  type = Transient
  dt = 0.1
  start_time = 0
  num_steps = 1

  solve_type = NEWTON
  line_search = basic
  petsc_options_iname = {{ petsc_options_iname }}
  petsc_options_value = {{ petsc_options_value }}

  nl_rel_tol = 1e-6
  nl_abs_tol = {{ nl_abs_tol }}
[]


[Outputs]
  perf_graph = true
  [console]
    type = Console
    max_rows = 1
  []
  [out]
    type = CSV
    execute_on = final
    show = 'jac_time res_time solve_time'
  []
[]
