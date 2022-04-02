press = 1e5

[GlobalParams]
  initial_p = ${press}
  initial_T = 300
  initial_vel = 0
  initial_vel_x = 0
  initial_vel_y = 0
  initial_vel_z = 0

  gravity_vector = '9.81 0 0'
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
  {% set vol = 0.1 %}
  {% set n_chs = n_channels | int %}
  {% for j in range(n_loops | int) %}
    {% for i in range(n_chs) %}
    [channel-{{ j }}-{{ i }}]
      type = FlowChannel1Phase
      position = '{{ i }} {{ j }} 0'
      orientation = '1 0 0'
      n_elems = {{ n_elems }}
      A = 1
      length = 1
      f = 0.01
      closures = simple
      fp = fluid
    []
    {% if i < n_chs - 1 %}
    [jct-{{ j }}-{{ i }}]
      type = JunctionOneToOne1Phase
      connections = 'channel-{{j}}-{{i}}:out channel-{{j}}-{{i + 1}}:in'
    []
    {% endif %}
    {% endfor %}
    [jct-{{ j }}-{{ n_chs-1 }}]
      type = JunctionOneToOne1Phase
      connections = 'channel-{{j}}-{{n_chs-1}}:out channel-{{j}}-0:in'
    []
  {% endfor %}
[]
