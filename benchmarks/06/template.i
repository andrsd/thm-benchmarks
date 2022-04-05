{% set press = 1e5 %}
{% set length = 1 %}

[GlobalParams]
  initial_p = {{ press }}
  initial_T = 300
  initial_vel = 0
  initial_vel_x = 0
  initial_vel_y = 0
  initial_vel_z = 0
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
  [inlet]
    type = InletMassFlowRateTemperature1Phase
    input = 'inlet-channel:in'
    m_dot = 0.1
    T = 300
  []

  [inlet-channel]
    type = FlowChannel1Phase
    position = '0 0 0'
    orientation = '0 0 1'
    n_elems = {{ n_elems }}
    A = 1
    length = {{ length }}
    f = 0.01
    closures = simple
    fp = fluid
  []

  [in-jct]
    type = VolumeJunction1Phase
    position = '0 0 {{ length }}'
    volume = 0.1
    connections = 'inlet-channel:out
      {% for i in range(n_loops | int) %}
      channel-{{ i }}-0:in
      {% endfor %}'
  []

  {% for i in range(n_loops | int) %}
    {% for j in range(n_channels | int) %}
      [channel-{{ i }}-{{ j }}]
        type = FlowChannel1Phase
        position = '0 {{ i }} {{ (j + 1) * length }}'
        orientation = '0 0 1'
        n_elems = {{ n_elems }}
        A = 1
        length = {{ length }}
        f = 0.01
        closures = simple
        fp = fluid
      []
      [hs-{{ i }}-{{ j }}]
        type = HeatStructureCylindrical
        position = '0 {{ i }} {{ (j + 1) * length }}'
        orientation = '0 0 1'
        n_elems = {{ n_elems }}
        length = {{ length }}
        names = '0'
        widths = '0.1'
        inner_radius = 0.56419
        n_part_elems = 10
      []
      [ht-{{ i }}-{{ j }}]
        type = HeatTransferFromHeatStructure1Phase
        flow_channel = channel-{{ i }}-{{ j }}
        hs = hs-{{ i }}-{{ j }}
        hs_side = INNER
        Hw = 1000
      []
      [hs-bnd-{{ i }}-{{ j }}]
        type = HSBoundarySpecifiedTemperature
        hs = hs-{{ i }}-{{ j }}
        boundary = hs-{{ i }}-{{ j }}:outer
        T = 300
      []

      {% if j < n_channels | int - 1 %}
      [jct-{{ i }}-{{ j }}]
        type = JunctionOneToOne1Phase
        connections = 'channel-{{ i }}-{{ j }}:out channel-{{ i }}-{{ j + 1 }}:in'
      []
      {% endif %}
    {% endfor %}
  {% endfor %}

  [out-jct]
    type = VolumeJunction1Phase
    position = '0 0 {{ length }}'
    volume = 0.1
    connections = 'outlet-channel:in
      {% for i in range(n_loops | int) %}
      channel-{{ i }}-{{ n_channels | int - 1 }}:out
      {% endfor %}'
  []

  [outlet-channel]
    type = FlowChannel1Phase
    position = '0 0 {{ length * (1 + n_channels | int )}}'
    orientation = '0 0 1'
    n_elems = {{ n_elems }}
    A = 1
    length = {{ length }}
    f = 0.01
    closures = simple
    fp = fluid
  []

  [outlet]
    type = Outlet1Phase
    input = 'outlet-channel:out'
    p = {{ press }}
  []
[]
