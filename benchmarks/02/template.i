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
  {% for i in range(n_channels | int) %}
  [inlet-{{loop.index}}]
    type = InletMassFlowRateTemperature1Phase
    input = 'channel-{{loop.index}}:in'
    m_dot = 0.1
    T = 300
  []

  [channel-{{loop.index}}]
    type = FlowChannel1Phase
    position = '0 {{loop.index}} 0'
    orientation = '1 0 0'
    n_elems = {{ n_elems }}
    A = 1
    length = 1
    f = 0.01
    closures = simple
    fp = fluid
  []

  [outlet-{{loop.index}}]
    type = Outlet1Phase
    input = 'channel-{{loop.index}}:out'
    p = ${press}
  []
  {% endfor %}
[]
