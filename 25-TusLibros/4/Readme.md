# Entrega 4 Tus Libros
El servidor debe correr en el puerto 8082.

El cliente fue testeado en la ultima version de chrome, y la ultima version de firefox.

## Usuarios
Hay dos usuarios cargados en el servidor:
* **clientId**: validUser | **password**: validPassword
Este usuario es valido para hacer todas las operaciones
* **clientId**: expiredCardUser | **password**: expiredCardUserPassword
Este usuario es valido para loggearse, pero no es valido para hacer checkout, ya que tiene cargada una tarjeta expirada.
Por lo que al hacer checkout muestra el error de tarjeta expirada.

Cualquier otra combinacion, muestra el error correspondiente.

## Funcionalidad Extra
A parte de la funcionalidad solicitada, decidimos agregar:
1) **Filtros** al catalogo, se puede filtrar y ordenar por:
 - autor
 - nombre
 - precio
2) **Wishlist** a la que el cliente puede agregar libros para tener guardados y comprar en algun momento.
at: 'expiredCardUser' put: 'expiredCardUserPassword';