import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

epsilon0 = 8.854e-12
k = 1 / (4 * np.pi * epsilon0)

#Definicion de las cargas
cargas = [
    (2e-6, 0, 0, 0),
    (-3e-6, 1, 0, 0),
    (1e-6, 0, 1, 1)
]
#Coordenadas donde se calculara el campo
x = 0.5
y = 0.5
z = 0.5
#Componentes del campo electrico
Ex = 0
Ey = 0
Ez = 0
#Calculo del campo electrico
for qi, xi, yi, zi in cargas:
    dx = x - xi      #distancia x entre carga y punto
    dy = y - yi      #distancia y entre carga y punto
    dz = z - zi      #distancia z entre carga y punto

    r = np.sqrt(dx**2 + dy**2 + dz**2)  #distancia total entre carga y punto

    if r == 0:
        continue

    Ex += k * qi * dx / r**3  #componente x del campo electrico
    Ey += k * qi * dy / r**3  #componente y del campo electrico
    Ez += k * qi * dz / r**3  #componente z del campo electrico

E = np.sqrt(Ex**2 + Ey**2 + Ez**2)   #Magnitud total del campo electrico

alpha = np.degrees(np.arccos(Ex / E))  #angulo con el eje x
beta  = np.degrees(np.arccos(Ey / E))  #angulo con el eje y
gamma = np.degrees(np.arccos(Ez / E))  #angulo con el eje z

#normalizar componentes del campo
ux, uy, uz = Ex/E, Ey/E, Ez/E

#crear figura
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')  #crear ejes tridimensionales
#recorrer las cargas
for qi, xi, yi, zi in cargas:
    if qi > 0:
        ax.scatter(xi, yi, zi, s=100)   #poner circulo para carga positiva
    else:
        ax.scatter(xi, yi, zi, s=100, marker='x')  #poner cruz para carga negativa

#dibujar punto donde se calcula el campo
ax.scatter(x, y, z, s=80, marker='s')

#longitud de la flecha
longitud = 1.0
#dibujar vector del campo
ax.quiver(x, y, z,
          ux*longitud, uy*longitud, uz*longitud)
#texto para magnitud y angulos
texto = (
    f"|E| = {E:.2e} N/C\n"
    f"α = {alpha:.1f}°\n"
    f"β = {beta:.1f}°\n"
    f"γ = {gamma:.1f}°"
)
#etiqueta para el punto
ax.text(x, y, z + 0.5, texto)

ax.set_xlabel("X")
ax.set_ylabel("Y")
ax.set_zlabel("Z")

plt.show()
