# Actividad 8 — Errores y operaciones rechazadas

## Objetivo

Identificar cómo PostgreSQL registra las operaciones rechazadas por falta de permisos y los errores relacionados con la eliminación de roles que todavía tienen privilegios asignados.

## Procedimiento realizado

Se analizaron dos situaciones:

1. El usuario `soporte_ana` intentó eliminar un registro de la tabla `clientes` sin tener permisos DELETE.
2. El administrador intentó eliminar el rol `soporte_ana`, pero PostgreSQL rechazó la operación porque todavía tenía privilegios asignados sobre la tabla `clientes`.

Se consultó la bitácora para identificar los errores, los detalles y las sentencias SQL que provocaron cada situación.

## Análisis de resultados

La bitácora registró los dos errores e identificó al usuario que ejecutó cada operación, además de mostrar las sentencias que fueron rechazadas.

## Preguntas de análisis

**1. ¿El intento de soporte_ana causó algún daño? ¿Por qué debe auditarse de todos modos?**

No causó ningún daño porque PostgreSQL rechazó la operación al detectar que `soporte_ana` no tenía permisos para eliminar registros de la tabla `clientes`.

De todos modos, debe auditarse porque permite identificar intentos de operaciones no autorizadas, detectar posibles comportamientos sospechosos y conocer qué usuarios intentaron realizar acciones fuera de sus permisos.

**2. ¿Qué diferencia hay entre un error de autorización (esta actividad) y uno de autenticación (Actividad 5)?**

Un error de autenticación ocurre cuando un usuario no puede demostrar su identidad correctamente, por ejemplo, al utilizar una contraseña incorrecta o intentar conectarse con un usuario inexistente.

Un error de autorización ocurre cuando el usuario logró conectarse, pero intenta realizar una operación para la que no tiene permisos suficientes.

**3. ¿Qué indica el error de DROP ROLE sobre el orden correcto para dar de baja a un usuario?**

Indica que antes de eliminar un rol se deben revisar y retirar los privilegios que todavía tenga asignados, así como resolver las dependencias relacionadas con sus objetos.

El procedimiento correcto consiste en revisar sus permisos, revocarlos, transferir o eliminar los objetos que le pertenezcan cuando corresponda y finalmente eliminar el rol. PostgreSQL también permite utilizar `DROP OWNED BY` para gestionar dependencias, pero debe utilizarse con cuidado porque puede eliminar objetos.

## Conclusión

Esta actividad demuestra que PostgreSQL registra las operaciones rechazadas, lo que permite identificar intentos de acceso no autorizado y errores administrativos. La auditoría de estas situaciones es importante para mantener la seguridad de la información y controlar adecuadamente los privilegios de los usuarios.