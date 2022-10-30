import csv

num_elems = []
residual_time = []
jacobian_time = []
solve_time = []

with open('lemhi/00/benchmark.csv') as f:
    reader = csv.DictReader(f)
    for row in reader:
        num_elems.append(float(row['num_elems']))
        jacobian_time.append(float(row['jac_time']))
        residual_time.append(float(row['res_time']))
        solve_time.append(float(row['solve_time']))

plt.title("Problem size vs time")
plt.scatter(num_elems, solve_time, marker='.', label='solve')
plt.scatter(num_elems, residual_time, marker='^', label='residual')
plt.scatter(num_elems, jacobian_time, marker='s', label='jacobian')
plt.legend()
plt.xlabel("Number of elements")
plt.ylabel("Time [s]")
plt.xscale('log')
plt.show()