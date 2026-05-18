import numpy as np
import matplotlib.pyplot as plt

k = 1    #se pone 1 para simplificar
#definicion de cargas
charges = [
    (+1, -1, -1),
    (+1,  1,  1),
    (-1,  1, -1),
    (-1, -1,  1)
]
#creacion de malla de puntos
x = np.linspace(-5, 5, 40)    #valores del eje x desde -5 hasta 5 usando 40 puntos
y = np.linspace(-5, 5, 40)    #valores del eje y desde -5 hasta 5 usando 40 puntos
X, Y = np.meshgrid(x, y)    #malla bidimensional

#matrices para el campo total
Ex_total = np.zeros_like(X)   #inicializar componente x del campo
Ey_total = np.zeros_like(Y)   #inicializar componente y del campo

#Calculo del campo electrico
#recorrer cada carga
for q, xq, yq in charges:
    Rx = X - xq       #Distancia horizontal desde la carga
    Ry = Y - yq       #Distancia vertical desde la carga
    R = np.sqrt(Rx**2 + Ry**2)    #Distancia total
    R[R == 0] = 1e-9
#superposicion de campos
    Ex_total += k * q * Rx / R**3    #Sumar componente x del campo
    Ey_total += k * q * Ry / R**3    #Sumar componente y del campo

#magnitud total del campo
E = np.sqrt(Ex_total**2 + Ey_total**2)

#normalizar vectores
#para representar solo direccion
Ex_n = Ex_total / E
Ey_n = Ey_total / E
#crear figura
plt.figure(figsize=(6,6))
#dibujar lineas de flujo siguiendo la direccion del campo
plt.streamplot(X, Y, Ex_total, Ey_total, color=E, cmap='plasma', density=1.4)
#dibujar vectores
plt.quiver(X[::3,::3], Y[::3,::3], Ex_n[::3,::3], Ey_n[::3,::3], scale=30)
#dibujar cargas
plt.scatter([-1, 1, 1, -1], [-1, 1, -1, 1],
            c=['red','red','blue','blue'], s=100)

plt.title("Campo eléctrico (4 cargas)")
plt.xlabel("x")
plt.ylabel("y")
plt.grid()
plt.show()
