import numpy as np
import matplotlib.pyplot as plt

k = 1

charges = [
    (+1, -1, 0),
    (-1,  1, 0)
]

x = np.linspace(-5, 5, 40)
y = np.linspace(-5, 5, 40)
X, Y = np.meshgrid(x, y)

Ex_total = np.zeros_like(X)
Ey_total = np.zeros_like(Y)

for q, xq, yq in charges:
    Rx = X - xq
    Ry = Y - yq
    R = np.sqrt(Rx**2 + Ry**2)
    R[R == 0] = 1e-9

    Ex_total += k * q * Rx / R**3
    Ey_total += k * q * Ry / R**3

E = np.sqrt(Ex_total**2 + Ey_total**2)

Ex_n = Ex_total / E
Ey_n = Ey_total / E

plt.figure(figsize=(6,6))

plt.streamplot(X, Y, Ex_total, Ey_total, color=E, cmap='plasma', density=1.3)
plt.quiver(X[::3,::3], Y[::3,::3], Ex_n[::3,::3], Ey_n[::3,::3], scale=30)

plt.scatter([-1, 1], [0, 0], c=['red', 'blue'], s=100)

plt.title("Campo eléctrico (2 cargas)")
plt.xlabel("x")
plt.ylabel("y")
plt.grid()
plt.show()
