import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

epsilon0 = 8.854e-12
k = 1 / (4 * np.pi * epsilon0)

cargas = [
    (2e-6, 0, 0, 0),
    (-3e-6, 1, 0, 0),
    (1e-6, 0, 1, 1)
]

x, y, z = 0.5, 0.5, 0.5

Ex, Ey, Ez = 0, 0, 0

for qi, xi, yi, zi in cargas:
    dx = x - xi
    dy = y - yi
    dz = z - zi
   
    r = np.sqrt(dx**2 + dy**2 + dz**2)
   
    if r == 0:
        continue
   
    Ex += k * qi * dx / r**3
    Ey += k * qi * dy / r**3
    Ez += k * qi * dz / r**3

E = np.sqrt(Ex**2 + Ey**2 + Ez**2)

alpha = np.degrees(np.arccos(Ex / E))
beta  = np.degrees(np.arccos(Ey / E))
gamma = np.degrees(np.arccos(Ez / E))

ux, uy, uz = Ex/E, Ey/E, Ez/E

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

for qi, xi, yi, zi in cargas:
    if qi > 0:
        ax.scatter(xi, yi, zi, s=100)
    else:
        ax.scatter(xi, yi, zi, s=100, marker='x')

ax.scatter(x, y, z, s=80, marker='s')

longitud = 1.0
ax.quiver(x, y, z,
          ux*longitud, uy*longitud, uz*longitud)

texto = (
    f"|E| = {E:.2e} N/C\n"
    f"α = {alpha:.1f}°\n"
    f"β = {beta:.1f}°\n"
    f"γ = {gamma:.1f}°"
)

ax.text(x, y, z + 0.5, texto)

ax.set_xlabel("X")
ax.set_ylabel("Y")
ax.set_zlabel("Z")

plt.show()
