import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

k = 8.99e9
Q = 100e-6
q = 1e-15
d = 1
m = 1e-6

omega = np.sqrt((2 * k * Q * q) / (m * (d/2)**3))

t = np.linspace(0, 10, 300)

A = 0.01
x_real = A * np.cos(omega * t)

escala = 20
x = x_real * escala

fig, ax = plt.subplots(figsize=(8, 3))
ax.set_xlim(-d/2, d/2)
ax.set_ylim(-0.2, 0.2)

ax.scatter([-d/2, d/2], [0, 0], color='red', s=150, label="+Q")

linea, = ax.plot([], [], 'b--', alpha=0.5)

particle, = ax.plot([], [], 'bo', markersize=10, label="+q")

ax.set_title("Movimiento armónico")
ax.set_xlabel("Posición x")
ax.get_yaxis().set_visible(False)
ax.legend()

x_tray = []
y_tray = []

def update(frame):
    x_tray.append(x[frame])
    y_tray.append(0)

    particle.set_data([x[frame]], [0])
    linea.set_data(x_tray, y_tray)

    return particle, linea

ani = FuncAnimation(fig, update, frames=len(t), interval=30, blit=True)

plt.grid(alpha=0.3)
plt.show()
