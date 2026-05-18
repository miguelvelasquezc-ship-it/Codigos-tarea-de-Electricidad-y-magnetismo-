import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# constantes
#constante de coulomb
k = 8.99e9
#carga elemental del electron
e = 1.602e-19
#masa del electron
m = 9.11e-31

#datos del problema
#carga de las particulas fijas
q = 100 * e
#carga del electron oscilante
Q = e
#distancia entre las cargas fijas
d = 1e-10

#parametros de simulacion
#paso de tiempo
dt = 1e-18
#tiempo maximo de simulacion
t_max = 1e-13

#condiciones iniciales
#posicion inicial del electron
x = 2e-10
#velocidad inicial
v = 0

#lista para almacenar posiciones
#aqui se guardaran todas las posiciones del electron durante la simulacion
x_data = []
#tiempo inicial
t = 0

#simulacion del movimiento
#ciclo principal de simulacion
while t < t_max:

    #distancia desde el electron
    #hacia cada carga fija
    r = np.sqrt(x**2 + (d/2)**2)

    #fuerza electrica neta

    #fuerza electrica en el eje x
    #producida por ambas cargas
    Fx = -2 * k * q * Q * x / (r**3)

    #aceleracion

    #segunda ley de newton
    a = Fx / m

    #actualizacion de velocidad
    #metodo de euler
    v = v + a * dt

    #actualizacion de posicion
    #nueva posicion del electron
    x = x + v * dt

    #guardar posicion
    #almacenar posicion actual
    x_data.append(x)

    #avanzar tiempo
    t += dt

#crear figura y ejes

fig, ax = plt.subplots(figsize=(8,4))

#limites de la grafica

ax.set_xlim(-4e-10, 4e-10)
ax.set_ylim(-1e-10, 1e-10)

#titulo de la grafica
ax.set_title("Oscilacion del electron")

#dibujar cargas fijas

#carga superior
ax.plot(0, d/2, 'ro', markersize=12)

#carga inferior
ax.plot(0, -d/2, 'ro', markersize=12)

#crear electron animado
#punto azul que representa el electron
electron, = ax.plot([], [], 'bo', markersize=10)

#crear trayectoria
#linea que deja el movimiento del electron
trail, = ax.plot([], [], lw=1)

#listas para guardar trayectoria
trail_x = []
trail_y = []

#funcion de actualizacion
#esta funcion se ejecuta en cada frame
def update(frame):

    #obtener posicion actual
    xe = x_data[frame]

    #mover electron
    electron.set_data([xe], [0])

    #guardar trayectoria
    trail_x.append(xe)
    trail_y.append(0)

    #actualizar trayectoria
    trail.set_data(trail_x, trail_y)

    #retornar objetos
    return electron, trail

#crear animacion
ani = FuncAnimation(
    fig,                 #figura
    update,              #funcion de actualizacion
    frames=len(x_data),  #cantidad de frames
    interval=20,         #tiempo entre frames
    blit=True,           #optimiza animacion
    repeat=True          #repetir animacion
)

plt.grid()
plt.show()
