press = 1e5

[GlobalParams]
  initial_p = ${press}
  initial_T = 300
  initial_vel = 0
[]

[Modules/FluidProperties]
  [fluid]
    type = IdealGasFluidProperties
    gamma = 1.4
  []
[]

[Closures]
  [simple]
    type = Closures1PhaseSimple
  []
[]

[Functions]
  [mfr_inlet_fn]
    type = ParsedFunction
    value = '0.5*sin(pi*t/100)+0.5'
  []
[]

[Components]
  [inlet]
    type = InletMassFlowRateTemperature1Phase
    input = 'channel:in'
    m_dot = 0.1
    T = 300
  []

  [channel]
    type = FlowChannel1Phase
    position = '0 0 0'
    orientation = '1 0 0'
    n_elems = 100
    A = 1
    length = 1
    f = 0.01
    closures = simple
    fp = fluid
  []

  [outlet]
    type = Outlet1Phase
    input = 'channel:out'
    p = ${press}
  []
[]

[ControlLogic]
  [mfr_ctrl]
    type = TimeFunctionComponentControl
    component = inlet
    parameter = m_dot
    function = mfr_inlet_fn
  []
[]

[Postprocessors]
  [total_mem]
    type = MemoryUsage
    execute_on = TIMESTEP_END
    mem_units = mebibytes
  []

  [total_mem_pg]
    type = PerfGraphData
    execute_on = TIMESTEP_END
    data_type = TOTAL_MEMORY
    section_name = 'Root'
  []
[]

[Executioner]
  type = Transient
  dt = 0.1
  start_time = 0
  num_steps = {{ num_steps }}

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
    execute_on = 'INITIAL TIMESTEP_END'
    interval = 10
  []
  print_linear_residuals = false

[]
