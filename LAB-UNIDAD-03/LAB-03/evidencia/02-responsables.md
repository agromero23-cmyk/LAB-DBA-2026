
# 8. Actividad 2 — Propietarios, custodios y usuarios

## 1. Matriz de responsabilidades

| **Conjunto de datos** | **Propietario** | **Custodio** | **Usuarios autorizados** | **Quién aprueba accesos** | **Quién aprueba correcciones** |
|---|---|---|---|---|---|
| `comercial.public.clientes` (PostgreSQL) | Gerente del área comercial | DBA | Personal de ventas y soporte autorizado | Gerente comercial | Gerente comercial |
| `auditoria.cambios_clientes` (PostgreSQL) | Responsable de auditoría | DBA de auditoría | Auditor y personal de seguridad autorizado | Responsable de auditoría | Responsable de auditoría |
| Bitácora de PostgreSQL | Responsable de seguridad de la información | DBA | Auditor y personal de seguridad autorizado | Responsable de seguridad | Responsable de seguridad |
| `comercial.clientes` (MongoDB) | Gerente del área comercial | Administrador de MongoDB | Personal de ventas y soporte autorizado | Gerente comercial | Gerente comercial |
| `comercial.system.profile` (MongoDB) | Responsable de seguridad de la información | Administrador de MongoDB | DBA y personal de auditoría autorizado | Responsable de seguridad | Responsable de seguridad |

## 2. Preguntas

### 1. ¿Por qué el propietario de `auditoria.cambios_clientes` no debería ser el mismo que opera `clientes`?

Porque se necesita mantener una separación de responsabilidades. Si la misma persona administra los datos de clientes y también controla los registros de auditoría, podría modificar información y alterar las evidencias de esos cambios.

Por eso, es mejor que el área de auditoría o seguridad sea responsable de los registros, mientras que el DBA se encargue de su administración técnica.

### 2. ¿Quién debería poder leer las bitácoras y la vista `dba.bitacora`? Relaciónalo con lo observado en el LAB-01 (secretos en la bitácora).

El acceso debería limitarse al personal de auditoría, seguridad de la información y administradores autorizados que necesiten consultar los registros.

En el LAB-01 se observó que las bitácoras pueden almacenar información sensible, como contraseñas u otros datos que no deberían quedar expuestos. Por eso, no todos los usuarios deben tener permiso para consultarlas.

También es importante evitar registrar secretos y proteger las bitácoras contra accesos o modificaciones no autorizadas.

### 3. ¿Qué ocurre con la responsabilidad sobre un dato cuando nadie la tiene asignada? Relaciónalo con el problema inicial de la unidad.

Cuando nadie tiene asignada la responsabilidad sobre un dato, los errores pueden pasar desapercibidos y nadie se encarga de verificar o corregir la información.

Esto provoca problemas de calidad, duplicidad, información incorrecta y falta de control. Se relaciona con el problema inicial de la unidad porque la falta de responsables definidos ocasionaba que los datos se administraran sin suficiente supervisión.

## 3. Conclusión

Esta actividad permitió identificar la importancia de asignar propietarios, custodios y usuarios autorizados para cada conjunto de datos.

También se comprendió que separar las responsabilidades ayuda a evitar conflictos de interés, proteger las bitácoras y mantener un mejor control sobre las modificaciones realizadas en las bases de datos.

La administración de los datos no depende solamente del DBA, sino también de las personas responsables de su uso, autorización y calidad.
