import csv

num_cpus = []
residual_time = []
jacobian_time = []
solve_time = []

with open('macos/01/benchmark-weak.csv') as f:
    reader = csv.DictReader(f)
    for row in reader:
        num_cpus.append(float(row['n_cpus']))
        jacobian_time.append(float(row['jac_time']))
        residual_time.append(float(row['res_time']))
        solve_time.append(float(row['solve_time']))
max_cpu = num_cpus[-1]

plt.title("Weak scaling")
plt.scatter(num_cpus, solve_time, marker='.', label='solve')
plt.plot([1, max_cpu], [solve_time[0], solve_time[0]], '--', label='ideal solve')

plt.scatter(num_cpus, residual_time, marker='^', label='residual')
plt.plot([1, max_cpu], [residual_time[0], residual_time[0]], '--', label='ideal residual')

plt.scatter(num_cpus, jacobian_time, marker='s', label='jacobian')
plt.plot([1, max_cpu], [jacobian_time[0], jacobian_time[0]], '--', label='ideal jacobian')

plt.legend()
plt.xlabel("Number of CPUs")
plt.ylabel("Time [s]")
plt.xscale('log')
plt.show()