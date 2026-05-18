import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

#constante de coulomb
k = 8.99e9
#carga fija positiva
Q = 100e-6
#carga que oscila
q = 1e-15
#distancia entre las cargas fijas
d = 1
#masa de la particula
m = 1e-6

#calcular frecuencia angular del movimiento armonico
omega = np.sqrt((2 * k * Q * q) / (m * (d/2)**3))

#crear vector de tiempo
#desde 0 hasta 10 segundos
#usando 300 puntos
t = np.linspace(0, 10, 300)

#amplitud real de oscilacion
A = 0.01

#ecuacion del movimiento armonico simple
#x(t) = A cos(wt)
x_real = A * np.cos(omega * t)

#factor de escala visual
#se usa para que el movimiento se vea mas grande en pantalla
escala = 20

#posicion escalada
x = x_real * escala

#crear figura y ejes
fig, ax = plt.subplots(figsize=(8, 3))

#definir limites de la grafica
ax.set_xlim(-d/2, d/2)
ax.set_ylim(-0.2, 0.2)

#dibujar cargas fijas positivas
ax.scatter(
    [-d/2, d/2],
    [0, 0],
    color='red',
    s=150,
    label="+Q"
)

#crear linea de trayectoria
#inicialmente vacia
linea, = ax.plot([], [], 'b--', alpha=0.5)

#crear particula animada
particle, = ax.plot(
    [],
    [],
    'bo',
    markersize=10,
    label="+q"
)

#titulo de la grafica
ax.set_title("Movimiento armónico")

#etiqueta del eje x
ax.set_xlabel("Posición x")

#ocultar eje y
ax.get_yaxis().set_visible(False)

#mostrar leyenda
ax.legend()

#listas para guardar trayectoria
x_tray = []
y_tray = []

#funcion que actualiza la animacion
def update(frame):

    #guardar posicion actual
    x_tray.append(x[frame])
    y_tray.append(0)

    #mover particula
    particle.set_data([x[frame]], [0])

    #actualizar trayectoria
    linea.set_data(x_tray, y_tray)

    #retornar objetos
    return particle, linea

#crear animacion
ani = FuncAnimation(
    fig,                  #figura principal
    update,               #funcion de actualizacion
    frames=len(t),        #numero de frames
    interval=30,          #tiempo entre frames
    blit=True             #optimizacion grafica
)

plt.grid(alpha=0.3)
plt.show()
