press = 1e5
sm_len = 0.01
volume = 0.1

[GlobalParams]
  initial_p = ${press}
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
    input = 'inlet-chan:in'
    m_dot = 0.1
    T = 300
  []

  [inlet-chan]
    type = FlowChannel1Phase
    position = '0 0 -${fparse 2*sm_len}'
    orientation = '0 0 1'
    n_elems = {{ n_sm_elems }}
    length = ${sm_len}
    A = {{ area }}
    f = 0
    closures = simple
    fp = fluid
  []

  [jct-in]
    type = VolumeJunction1Phase
    position = '0 0 -${fparse sm_len}'
    connections = 'inlet-chan:out {% for pos in pos_y %}jct-chan-in-{{ loop.index }}:in {% endfor %}'
    volume = ${volume}
  []

  {% for py in pos_y %}
    {% set i = loop.index %}
    [jct-chan-in-{{ i }}]
      type = FlowChannel1Phase
      position = '0 {{ py }} -${fparse sm_len}'
      orientation = '0 0 1'
      n_elems = {{ n_sm_elems }}
      length = ${sm_len}
      A = {{ area }}
      f = 0
      closures = simple
      fp = fluid
    []
    [jct-{{ i }}-in]
      type = VolumeJunction1Phase
      position = '0 {{ py }} 0'
      connections = 'jct-chan-in-{{ i }}:out {% for px in pos_x %}chan-{{ i }}-{{ loop.index }}:in {% endfor %}'
      volume = ${volume}
    []
  {% endfor %}

  {% for py in pos_y %}
    {% set j = loop.index %}
    {% for px in pos_x %}
      {% set i = loop.index %}
      [chan-{{ j }}-{{ i }}]
        type = FlowChannel1Phase
        position = '{{ px }} {{ py }} 0'
        orientation = '0 0 1'
        n_elems = {{ n_axial_elems }}
        A = {{ area }}
        length = {{ length }}
        f = 0.01
        closures = simple
        fp = fluid
      []
    {% endfor %}
  {% endfor %}

  {% for py in pos_y %}
    {% set i = loop.index %}
    [jct-{{ i }}-out]
      type = VolumeJunction1Phase
      position = '0 {{ py }} {{ length }}'
      connections = '{% for px in pos_x %}chan-{{ i }}-{{ loop.index }}:out {% endfor %} jct-chan-out-{{ i }}:in'
      volume = ${volume}
    []
    [jct-chan-out-{{ i }}]
      type = FlowChannel1Phase
      position = '0 {{ py }} {{ length }}'
      orientation = '0 0 1'
      n_elems = {{ n_sm_elems }}
      length = ${sm_len}
      A = {{ area }}
      f = 0
      closures = simple
      fp = fluid
    []
  {% endfor %}

  [jct-out]
    type = VolumeJunction1Phase
    position = '0 0 ${fparse {{ length }} + sm_len}'
    connections = '{% for py in pos_y %}jct-chan-out-{{ loop.index }}:out {% endfor %} outlet-chan:in'
    volume = ${volume}
  []

  [outlet-chan]
    type = FlowChannel1Phase
    position = '0 0 ${fparse {{ length }} + sm_len}'
    orientation = '0 0 1'
    n_elems = {{ n_sm_elems }}
    length = ${sm_len}
    A = {{ area }}
    f = 0
    closures = simple
    fp = fluid
  []

  [outlet]
    type = Outlet1Phase
    input = 'outlet-chan:out'
    p = ${press}
  []

  [block]
    type = HeatStructureFromFile3D
    file = '{{ mesh_file }}'
    position = '0 0 0'
  []

  [ht]
    type = HeatTransferFromHeatStructure3D1Phase
    hs = block
    flow_channels = '
    {% for py in pos_y %}
      {% set j = loop.index %}
      {% for px in pos_x %}
        {% set i = loop.index %}
        chan-{{ i }}-{{j}}
      {% endfor %}
    {% endfor %}'
    boundary = 'block:holes'
    Hw = 1000
    P_hf = {{ P_hf }}
  []
[]
