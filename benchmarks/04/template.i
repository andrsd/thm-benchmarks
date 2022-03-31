press = 1e5
len = 1

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

[Materials]
  [mat]
    type = ADGenericConstantMaterial
    prop_names = 'density specific_heat thermal_conductivity'
    prop_values = '1 1 1'
  []
[]

[Closures]
  [simple]
    type = Closures1PhaseSimple
  []
[]


[Components]
  [inlet-pri]
    type = InletMassFlowRateTemperature1Phase
    input = 'channel-pri:in'
    m_dot = 0.1
    T = 300
  []

  [channel-pri]
    type = FlowChannel1Phase
    position = '0 0 0'
    orientation = '0 0 1'
    n_elems = {{ n_elems }}
    A = 1
    length = ${len}
    f = 0.01
    closures = simple
    fp = fluid
  []

  [outlet-pri]
    type = Outlet1Phase
    input = 'channel-pri:out'
    p = ${press}
  []

  [ht-pri]
    type = HeatTransferFromHeatStructure1Phase
    flow_channel = 'channel-pri'
    hs = wall
    hs_side = INNER
    Hw = 1000
  []

  [wall]
    type = HeatStructureCylindrical
    position = '0 0 0'
    orientation = '0 0 1'
    length = ${len}
    n_elems = {{ n_elems }}
    inner_radius = 0.05
    names = 'wall'
    widths = '0.1'
    n_part_elems = 10
  []

  [ht-sec]
    type = HeatTransferFromHeatStructure1Phase
    flow_channel = 'channel-sec'
    hs = wall
    hs_side = OUTER
    Hw = 1000
  []

  [inlet-sec]
    type = InletMassFlowRateTemperature1Phase
    input = 'channel-sec:in'
    m_dot = 0.1
    T = 300
  []

  [channel-sec]
    type = FlowChannel1Phase
    position = '0.1 0 ${len}'
    orientation = '0 0 -1'
    n_elems = {{ n_elems }}
    A = 1
    length = ${len}
    f = 0.01
    closures = simple
    fp = fluid
  []

  [outlet-sec]
    type = Outlet1Phase
    input = 'channel-sec:out'
    p = ${press}
  []
[]
