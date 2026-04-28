import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

q = -1.602e-19
m = 9.11e-31
E = 400
vx = 3e6

a = (q * E) / m

t_ns = np.arange(0, 3001, 100)
t = t_ns * 1e-9

x = vx * t
y = 0.5 * a * t**2

fig, ax = plt.subplots()
ax.set_xlim(min(x), max(x))
ax.set_ylim(min(y), max(y))
ax.set_xlabel("Posicion en x (m)")
ax.set_ylabel("Posicion en y (m)")
ax.set_title("Animacion del movimiento del electron")
ax.grid()

ax.plot(x, y, linestyle='--')

punto, = ax.plot([], [], 'o')

texto = ax.text(0.02, 0.95, '', transform=ax.transAxes)

def update(frame):
    punto.set_data([x[frame]], [y[frame]]) 
    texto.set_text(f"t = {t_ns[frame]} ns")
    return punto, texto

ani = FuncAnimation(fig, update, frames=len(t), interval=200, repeat=False)

plt.show()
