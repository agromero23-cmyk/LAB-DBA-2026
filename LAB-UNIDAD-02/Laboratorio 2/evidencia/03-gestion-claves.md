# 9. Actividad 3 — El problema de la gestión de claves

## 9.1 Identificar una mala práctica

### Pregunta

**¿Qué ocurriría si esta clave fuera una clave utilizada realmente por una organización y el archivo se publicara en un repositorio Git?**

Si el archivo se publicara en un repositorio Git, una persona que tuviera acceso al código podría obtener la clave y utilizarla para descifrar información sensible, como los RFC de los clientes. Esto representaría un riesgo para la privacidad y la seguridad de la organización.

Aunque el archivo se elimine después, la clave podría permanecer en el historial de Git y seguir expuesta.

## 9.2 Regla del laboratorio

No se deben almacenar claves, contraseñas, tokens ni secretos reales en un repositorio. Para esta práctica se utilizan valores ficticios con fines demostrativos.

El archivo `sql/ejemplo-mala-practica.sql` debe eliminarse antes de realizar la entrega final.
