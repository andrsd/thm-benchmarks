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
    n_elems = {{ n_elems }}
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
