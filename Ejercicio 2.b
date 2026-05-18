import numpy as np
import matplotlib.pyplot as plt

#Constantes
epsilon0 = 8.854e-12
k = 1 / (4 * np.pi * epsilon0)   #Constante electrica

#Definicion de las cargas
cargas = [
    (2e-6, 5, 1),
    (-3e-6, -3, 4)
]
#Coordenadas donde se calculara el campo
x = 2
y = 6
#Componentes del campo electrico
Ex = 0
Ey = 0

#Calculo del campo electrico
for qi, xi, yi in cargas:
    dx = x - xi     #distancia horizontal entre carga y punto
    dy = y - yi     #distancia vertical entre carga y punto
    r = np.sqrt(dx**2 + dy**2)    #distancia total entre carga y punto

    Ex += k * qi * dx / r**3     #componente x del campo electrico
    Ey += k * qi * dy / r**3     #componente y del campo electrico

E = np.sqrt(Ex**2 + Ey**2)      #Magnitud total del campo electrico
theta = np.degrees(np.arctan2(Ey, Ex))   #angulo con respecto al eje x

#para normalizar el vector campo electrico
ux = Ex / E
uy = Ey / E

#crear ventana para grafica
plt.figure(figsize=(6,6))
#recorrer las cargas
for qi, xi, yi in cargas:
    if qi > 0:
        plt.scatter(xi, yi, s=120)    #poner circulo para carga positiva
    else:
        plt.scatter(xi, yi, s=120, marker='x')  #poner cruz para carga negativa

#dibujar punto donde se calcula el campo
plt.scatter(x, y, s=100, marker='s')

#longitud de la flecha
longitud = 1.5
#dibujar flecha del campo electrico
plt.quiver(x, y, ux*longitud, uy*longitud,
           angles='xy', scale_units='xy', scale=1)
#Mostrar en texto magnitud y angulo
plt.text(x, y + 1.2,
         f"|E|={E:.2e} N/C\nθ={theta:.1f}°",
         ha='center',
         bbox=dict(boxstyle="round", facecolor="white"))

plt.axhline(0)   #eje horizontal
plt.axvline(0)   #eje vertical
plt.grid()
plt.xlabel("x (m)")
plt.ylabel("y (m)")

plt.axis('equal')
plt.show()
