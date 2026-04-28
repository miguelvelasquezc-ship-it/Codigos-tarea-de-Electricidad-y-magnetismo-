import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

k = 8.99e9
e = 1.602e-19

q = 100 * e    
Q = -e          
m = 9.11e-31    
d = 1e-10      

dt = 1e-18
t_total = 5e-15
t = np.arange(0, t_total, dt)

x = np.zeros(len(t))
v = np.zeros(len(t))

x[0] = 1e-11
v[0] = 0

def fuerza(x):
    r = np.sqrt(x**2 + (d/2)**2)
    return 2 * k * q * Q * x / (r**3)

for i in range(len(t)-1):
    a = fuerza(x[i]) / m
    v[i+1] = v[i] + a * dt
    x[i+1] = x[i] + v[i] * dt

escala = 1e10
x_vis = x * escala
d_vis = d * escala

fig, ax = plt.subplots(figsize=(7,4))

ax.set_xlim(-2, 2)
ax.set_ylim(-2, 2)

ax.scatter(0, d_vis/2, color='red', s=200, label="+q")
ax.scatter(0, -d_vis/2, color='red', s=200)

electron, = ax.plot([], [], 'bo', markersize=10, label="electrón")

tray_x, tray_y = [], []
linea, = ax.plot([], [], 'b--', alpha=0.5)

frames = list(range(len(t))) + list(range(len(t)-1, 0, -1))

def update(frame):
    tray_x.append(x_vis[frame])
    tray_y.append(0)

    electron.set_data([x_vis[frame]], [0])
    linea.set_data(tray_x, tray_y)

    return electron, linea

ani = FuncAnimation(
    fig,
    update,
    frames=frames,
    interval=20,
    blit=True,
    repeat=True
)

ax.set_title("Oscilación del electrón")
ax.set_xlabel("x")
ax.set_ylabel("y")
ax.grid(alpha=0.3)
ax.legend()

plt.show()
