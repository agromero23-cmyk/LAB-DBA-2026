
# LAB-04 — Hardening y configuración segura de PostgreSQL

## Objetivo

Revisar la configuración de seguridad de PostgreSQL para identificar posibles riesgos, analizar los controles de acceso y proponer medidas que ayuden a proteger la base de datos contra conexiones no autorizadas.

## Entorno

- **Sistema de administración:** pgAdmin.
- **Sistema gestor de base de datos:** PostgreSQL.
- **Tipo de acceso:** usuario con privilegios limitados.
- **Herramientas utilizadas:** pgAdmin, SQL, Markdown y Git.
- **Repositorio:** `dba-sec-lab`.
- **Directorio del laboratorio:** `lab-04-hardening/`.

Durante la práctica se realizaron consultas de lectura para inspeccionar parámetros de configuración, roles, conexiones y controles de seguridad.

## Superficie de ataque inicial

Se comenzó identificando la información básica del servidor PostgreSQL y algunos parámetros relacionados con su exposición de red y autenticación.

Uno de los resultados obtenidos fue que el parámetro `listen_addresses` tiene el valor `*`, lo que indica que PostgreSQL escucha en todas las interfaces de red disponibles.

Esta configuración puede ser necesaria en determinados entornos, pero requiere controles adicionales para limitar las conexiones a los equipos autorizados.

También se identificó una limitación de permisos al intentar consultar el parámetro `config_file`, debido a que el usuario utilizado no cuenta con privilegios suficientes para realizar esa consulta.

## Hallazgos

Durante la revisión se identificaron los siguientes puntos:

1. **Exposición de red:** el parámetro `listen_addresses` tiene el valor `*`.
2. **Privilegios limitados:** no fue posible consultar `config_file` con el usuario actual.
3. **Reglas de acceso:** se revisó la importancia de analizar `pg_hba.conf` para identificar usuarios, bases de datos, redes y métodos de autenticación permitidos.
4. **Autenticación:** se identificó la necesidad de utilizar métodos seguros y evitar reglas de acceso demasiado amplias.
5. **Privilegios de usuarios:** es necesario comprobar que las cuentas tengan únicamente los permisos que requieren.
6. **Cifrado de conexiones:** debe verificarse si la sesión actual utiliza TLS y registrar el resultado real.

Los puntos relacionados con roles, TLS y otros parámetros deben considerarse pendientes de confirmar hasta contar con sus respectivas evidencias.

## Cambios realizados

Durante esta etapa se realizaron consultas de inspección y se prepararon archivos SQL y documentación para registrar los resultados del laboratorio.

Se documentaron los siguientes aspectos:

- Inspección inicial del servidor PostgreSQL.
- Revisión del parámetro `listen_addresses`.
- Análisis de las reglas de acceso de `pg_hba.conf`.
- Análisis conceptual de una regla de acceso permisiva.
- Preparación de consultas para verificar roles, parámetros de seguridad y cifrado TLS.

No se registran cambios directos en la configuración del servidor, ya que las actividades descritas se enfocaron en la inspección y el análisis. Cualquier modificación posterior deberá documentarse en `configuracion/cambios.md` después de comprobar que realmente se aplicó.

## Justificación de los cambios

La revisión de seguridad permite identificar configuraciones que podrían facilitar accesos no autorizados o aumentar la exposición del servidor.

Se recomienda limitar las conexiones a las interfaces y redes necesarias, restringir las reglas de autenticación a usuarios y bases de datos específicos, utilizar métodos de autenticación seguros y comprobar el cifrado de las conexiones.

También es importante separar las cuentas administrativas de las cuentas utilizadas por las aplicaciones, así como evitar que usuarios ordinarios tengan privilegios innecesarios.

Estas medidas siguen el principio de mínimo privilegio y ayudan a reducir la superficie de ataque de PostgreSQL.

## Verificación

La verificación se realiza mediante consultas SQL ejecutadas desde pgAdmin.

Las comprobaciones contempladas son:

- Consultar la versión de PostgreSQL y la base de datos actual.
- Revisar el parámetro `listen_addresses`.
- Inspeccionar las reglas de acceso de `pg_hba.conf`, cuando los permisos lo permitan.
- Revisar los roles y sus privilegios.
- Consultar los parámetros de seguridad disponibles.
- Comprobar si la conexión actual utiliza TLS.
- Registrar los errores de permisos que impidan completar alguna consulta.

Los resultados deben respaldarse con las capturas guardadas en el directorio `evidencias/`.

La verificación final se considerará completa cuando las consultas hayan sido ejecutadas y sus resultados hayan sido revisados. No se debe asumir que un control está habilitado únicamente porque exista una consulta preparada para comprobarlo.

## Conclusiones

El laboratorio permitió reconocer la importancia de revisar la configuración de PostgreSQL antes de aplicar medidas de hardening. Se identificó que escuchar en todas las interfaces puede aumentar la exposición de red si no existen controles adecuados.

También se comprendió que la seguridad no depende únicamente de las contraseñas, sino de la combinación de reglas de acceso, privilegios, restricciones de red y cifrado de las conexiones.

Como siguiente paso, es necesario completar las verificaciones pendientes, guardar las evidencias correspondientes y documentar cualquier cambio que se aplique de forma autorizada. Esto permitirá contar con un registro claro del estado de seguridad de PostgreSQL y de las medidas propuestas para mejorarlo.
