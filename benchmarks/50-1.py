import csv

time = []
total_mem = []
total_mem_pg = []

with open('macos/50/benchmark.csv') as f:
    reader = csv.DictReader(f)
    for row in reader:
        time.append(float(row['time']))
        total_mem.append(float(row['total_mem']))
        total_mem_pg.append(float(row['total_mem_pg']))

plt.title("Memory consumption")
plt.plot(time, total_mem, marker='.', label='OS')
plt.plot([1, 100], [total_mem[1], total_mem[1]], '--', label='ideal OS')
plt.plot(time, total_mem_pg, marker='^', label='PerfGraph')
plt.plot([1, 100], [total_mem_pg[1], total_mem_pg[1]], '--', label='ideal PerfGraph')

plt.legend()
plt.xlabel("Simulation time [s]")
plt.ylabel("Memory [MB]")
plt.show()