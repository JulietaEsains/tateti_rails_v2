# Trabajo Práctico de Programación Avanzada (UTN-FRM) - TATETI

Esta es la API de una aplicación de TATETI multijugador hecha con Ruby on Rails y el SGBD PostreSQL.

La parte de Front-end se encuentra en este repositorio: https://github.com/JulietaEsains/tateti_react

## End-points y requests

Todos los end-points esperan que los datos en el cuerpo de la solicitud estén en formato JSON, y devuelven datos en formato JSON en el cuerpo de la respuesta.

## Usuario

### Iniciar sesión

El end-point authentication#login (url/auth/login) espera un POST con credenciales que identifican a un usuario previamente registrado:

```
{
	"email": "ejemplo@email.com",
	"password": "contraseñaEjemplo"
}
```

Si la solicitud tiene éxito, la respuesta tendrá un estado HTTP de 200 (OK) y el cuerpo contendrá el token necesario para que el usuario autentique otras solicitudes:

```
{
	"token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE2NTYzNzI3ODF9.iPOR3KdJ790dSeRehVSTufN2Gxjo7V8S3Fp2patt6Bo"
}
```
Si la solicitud no tiene éxito, la respuesta tendrá un estado HTTP de 401 (No autorizado) y el cuerpo estará vacío.

### Crear usuario

El end-point users#create (url/users) espera un POST con credenciales que identifican a un usuario por crearse:

```
{
	"name": "Nombre Ejemplo",
	"username": "ejemplo123",
	"email": "ejemplo@email.com",
	"password": "contraseñaEjemplo"
}
```

Si la solicitud tiene éxito, la respuesta tendrá un estado HTTP de 201 (Creado) y la respuesta contendrá los datos del nuevo usuario:

```
{
	"user": {
		"id": 1,
		"name": "Nombre Ejemplo",
		"username": "ejemplo123",
		"email": "ejemplo@email.com",
		"password_digest": "$2a$12$vch30zpT5ACf25yL9Bb16OdZGAJ0W3yXWAUN83OtTyF/BoBC61WFq",
		"created_at": "2022-06-20T23:32:00.954Z",
		"updated_at": "2022-06-20T23:32:00.954Z"
	}
}
```

Si la solicitud no tiene éxito, la respuesta tendrá un estado HTTP de 400 (Petición mala o error del cliente) y el cuerpo estará vacío.

## Partida

Todas las solicitudes de las partidas (games) deben incluir un token de autenticación en la cabecera o serán rechazadas con un estado 401 (No autorizado).

Las partidas están asociadas con usuarios (player_x y player_o). Las acciones traerán una partida sólo si el usuario asociado al token de la cabecera es uno de esos dos usuarios. Sino, la respuesta tendrá el estado 404 (No encontrado), excepto por la acción index que retornaría un arreglo de partidas vacío.

### Mostrar partidas de un usuario

El end-point games#index (url/games) es un GET y devuelve todas las partidas asociadas a un usuario. El cuerpo de la respuesta contendrá un arreglo de partidas:

```
{
	"games": [
		{
			"id": 1,
			"player_x_id": 1,
			"player_o_id": 2,
			"over": false,
			"cells": [
				"X",
				"",
				"O",
				"X",
				"O",
				"",
				"O",
				"X",
				""
			],
			"turn": "X",
			"created_at": "2022-06-20T22:42:49.995Z",
			"updated_at": "2022-06-20T22:45:51.570Z"
		},
		{
			"id": 2,
			"player_x_id": 1,
			"player_o_id": null,
			"over": false,
			"cells": [
				"",
				"",
				"",
				"",
				"",
				"",
				"",
				"",
				""
			],
			"turn": "X",
			"created_at": "2022-06-20T23:54:54.178Z",
			"updated_at": "2022-06-20T23:54:54.178Z"
		}
	]
}
```

### Crear partida


El end-point games#create (url/games) espera un POST con un cuerpo de solicitud vacío. Si la solicitud tiene éxito, la respuesta tendrá un estado HTTP de 201 (Creado) y el cuerpo contendrá los datos de la partida creada con el player_x establecido para el usuario que realizó esta solicitud:

```
{
	"game": {
		"id": 3,
		"player_x_id": 1,
		"player_o_id": null,
		"over": false,
		"cells": [
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			""
		],
		"turn": "X",
		"created_at": "2022-06-20T23:59:25.868Z",
		"updated_at": "2022-06-20T23:59:25.868Z"
	}
}
```

Si la solicitud no tiene éxito, la respuesta tendrá un estado HTTP de 400 (error del lado del cliente) y el cuerpo sería la descripción de los errores.

### Mostrar partida

El end-point games#show (url/games/:id) es un GET especificando el id de la partida en cuestión. Si la solicitud tiene éxito tendrá un estado de 200 (OK) y el cuerpo contendrá datos de la partida:

```
{
	"game": {
		"id": 1,
		"player_x_id": 1,
		"player_o_id": 2,
		"over": false,
		"cells": [
			"X",
			"",
			"O",
			"X",
			"O",
			"",
			"O",
			"X",
			""
		],
		"turn": "X",
		"created_at": "2022-06-20T22:42:49.995Z",
		"updated_at": "2022-06-20T22:45:51.570Z"
	}
}
```
### Unirse a una partida (como jugador O)

El end-point games#update (url/games/:id) espera un PATCH vacío para unirse a una partida existente.

Si la solicitud tiene éxito, la respuesta tendrá un estado HTTP de 200 (OK) y el cuerpo contendrá los datos de la partida en cuestión:

```
{
	"game": {
		"player_o_id": 2,
		"id": 3,
		"player_x_id": 1,
		"over": false,
		"cells": [
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			""
		],
		"turn": "X",
		"created_at": "2022-06-20T23:59:25.868Z",
		"updated_at": "2022-06-21T00:07:26.761Z"
	}
}
```

Si la solicitud no tiene éxito, la respuesta tendrá un estado HTTP de 400 (error del lado del cliente) y la respuesta estará vacía (si no se puede unir, si ya tiene un player_o o si quien realiza la solicitud es player_x) o tendrá una descripción de los errores.

### Realizar una jugada

El end-point games#update (url/games/:id) espera un PATCH con cambios a una partida existente:

```
{
  "game": {
    "cell": {
      "index": 0,
      "value": "X"
    },
    "over": false,
		"turn": "O"
  }
}
```

Si la solicitud tiene éxito, la respuesta tendrá un estado HTTP de 200 (OK) y el cuerpo contendrá los datos de la partida modificada:

```
{
	"game": {
		"turn": "O",
		"id": 3,
		"player_x_id": 1,
		"player_o_id": 2,
		"over": false,
		"cells": [
			"X",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			""
		],
		"created_at": "2022-06-20T23:59:25.868Z",
		"updated_at": "2022-06-21T00:12:52.838Z"
	}
}
```

Si la solicitud no tiene éxito, la respuesta tendrá un estado HTTP de 400 (error del lado del cliente) y el cuerpo sería la descripción de los errores.
