# 10. Actividad 4 — Protección de datos durante la comunicación

## Descripción del problema

Hasta este momento se ha trabajado en la protección de la información almacenada en la base de datos. Sin embargo, también es importante proteger los datos mientras viajan entre el cliente y el servidor PostgreSQL.

Si la conexión no está protegida, una persona que pueda observar el tráfico de red podría intentar obtener información sensible transmitida durante la comunicación.

## ¿Qué es TLS?

TLS (Transport Layer Security) es un protocolo de seguridad que permite proteger la comunicación entre el cliente y el servidor mediante el cifrado de los datos transmitidos.
