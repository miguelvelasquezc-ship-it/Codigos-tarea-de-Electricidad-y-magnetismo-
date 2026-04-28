import numpy as np
import matplotlib.pyplot as plt

epsilon0 = 8.854e-12
k = 1 / (4 * np.pi * epsilon0)

cargas = [
    (2e-6, 5, 1),
    (-3e-6, -3, 4)
]

x, y = 2, 6

Ex, Ey = 0, 0

for qi, xi, yi in cargas:
    dx = x - xi
    dy = y - yi
    r = np.sqrt(dx**2 + dy**2)
   
    Ex += k * qi * dx / r**3
    Ey += k * qi * dy / r**3

E = np.sqrt(Ex**2 + Ey**2)
theta = np.degrees(np.arctan2(Ey, Ex))

ux = Ex / E
uy = Ey / E

plt.figure(figsize=(6,6))

for qi, xi, yi in cargas:
    if qi > 0:
        plt.scatter(xi, yi, s=120)
    else:
        plt.scatter(xi, yi, s=120, marker='x')

plt.scatter(x, y, s=100, marker='s')

longitud = 1.5
plt.quiver(x, y, ux*longitud, uy*longitud,
           angles='xy', scale_units='xy', scale=1)

plt.text(x, y + 1.2,
         f"|E|={E:.2e} N/C\nθ={theta:.1f}°",
         ha='center',
         bbox=dict(boxstyle="round", facecolor="white"))

plt.axhline(0)
plt.axvline(0)
plt.grid()
plt.xlabel("x (m)")
plt.ylabel("y (m)")

plt.axis('equal')
plt.show()
