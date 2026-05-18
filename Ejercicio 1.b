import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

#Datos del problema
q = -1.602e-19  #C
m = 9.11e-31    #kg
E = 400         #N/C
vx = 3e6        #m/s

#Calculo de la aceleracion
a = (q * E) / m

#Vector de tiempo en nanosegundos de 0 a 3000, en intervalos de 100
t_ns = np.arange(0, 3001, 100)
t = t_ns * 1e-9

#Calculo de las posiciones
x = vx * t
y = 0.5 * a * t**2

#Creacion de figura y ejes
fig, ax = plt.subplots()            #Crear ventana de grafica
ax.set_xlim(min(x), max(x))         #Limites horizontales
ax.set_ylim(min(y), max(y))         #Limites verticales
ax.set_xlabel("Posicion en x (m)")
ax.set_ylabel("Posicion en y (m)")
ax.set_title("Animacion del movimiento del electron")
ax.grid()        #mostrar cuadricula

#Dibujar la trayectoria
ax.plot(x, y, linestyle='--')
#punto animado
punto, = ax.plot([], [], 'o')
#crear teexto en la grafica para cada punto
texto = ax.text(0.02, 0.95, '', transform=ax.transAxes)

#Funcion de actualizacion para la animacion
def update(frame):
    punto.set_data([x[frame]], [y[frame]])    #mover el punto
    texto.set_text(f"t = {t_ns[frame]} ns")   #actualizar texto de tiempo
    return punto, texto      #retornar objetos

#Ejecuta la funcion update para crear la animacion
ani = FuncAnimation(fig, update, frames=len(t), interval=200, repeat=True)

#mostrar
plt.show()
