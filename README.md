# the BiG BANG THEORY

Una estupenda comedia sobre un grupo de amigos científicos.
[Más info](https://es.wikipedia.org/wiki/The_Big_Bang_Theory)

## Funcionalidad

- Listado de todos los episodios organizados por temporada.
- Posibilidad de navegar al detalle de cada episodio.
- Poder seleccionar/deselecionar episodios como favoritos y tener una lista actualizada de los mismos.

## Comentarios

- Las dos arquitecturas nativas de Apple son:
	1. MVC para UIKit (el empleado en este caso práctico).
	2. MVVM para SwiftUI.
-  Nada de librerías de terceros. Las peticiones a red realizadas con *URLSession* y la concurrencia con *GCD*.
- Vista episodios: *UITableView* con *Dynamic Prototypes*.
- Vista detalle episodio: *UITableView* con *Static cells*.
- Fichero *FileManager*: creación de una caché para la gestión de imágenes y disminuir el número de peticiones a la red.
- *Auto-layout y constraints*: definidas las estríctamente necesarias para que cumplan con su cometido y con ello optimizando los recursos de renderizado.
