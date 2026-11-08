# Actividad 5 — Analizar una finalidad secundaria

## 1. ¿El hecho de que la organización ya tenga los datos significa automáticamente que puede utilizarlos para cualquier finalidad?

No. Que la empresa ya tenga los datos personales de sus clientes no significa que pueda utilizarlos para cualquier propósito. Debe verificar que el nuevo uso sea compatible con la finalidad original, que exista una base legal adecuada y que se cumplan las obligaciones de privacidad.

## 2. ¿Qué preguntas debería realizar la organización antes de implementar este tratamiento?

La organización debería plantearse las siguientes preguntas:

- ¿Se informó a los clientes que sus datos podrían utilizarse para enviar promociones?
- ¿Existe una base legal que permita utilizar los datos con esta finalidad?
- ¿Es necesario utilizar la edad, la ciudad y el comportamiento de compra?
- ¿Los clientes pueden rechazar o dejar de recibir las promociones?
- ¿Cómo se protegerán los datos para evitar accesos no autorizados?

## 3. ¿Qué datos serían realmente necesarios?

Los datos necesarios dependerán de la estrategia de marketing. Se podrían utilizar las preferencias de compra y un identificador del cliente para personalizar las promociones. La ciudad solo sería necesaria si las ofertas dependen de la ubicación, mientras que la edad debería utilizarse únicamente si existe una justificación específica.

No sería necesario utilizar el RFC, ya que no tiene una relación directa con el envío de promociones.

## 4. ¿Necesitaría el área de marketing acceso directo a `clientes`?

No necesariamente. Lo recomendable es que marketing no tenga acceso directo a toda la tabla `clientes`, porque podría consultar información que no necesita para realizar sus funciones. En su lugar, podría recibir únicamente los datos necesarios mediante una vista SQL o un mecanismo de acceso controlado.

## 5. ¿Qué controles técnicos podrían limitar la información entregada?

- **Vistas SQL:** mostrar únicamente las columnas necesarias para marketing.
- **Permisos por usuario:** permitir el acceso solo a la información requerida.
- **Principio de mínimo privilegio:** evitar que marketing tenga permisos de administrador.
- **Seudonimización:** utilizar códigos en lugar de identificadores directos cuando sea posible.
- **Registro de auditoría:** registrar las consultas y operaciones realizadas.
- **Restricción de exportaciones:** limitar la descarga de información personal.
- **Control de preferencias:** respetar las solicitudes de los clientes que no quieran recibir promociones.

## Conclusión

La empresa debe evaluar la nueva finalidad antes de utilizar los datos de sus clientes para marketing. Aplicar el principio de minimización, limitar los permisos y utilizar vistas controladas ayuda a reducir la exposición de información personal. Además, debe verificar que el tratamiento tenga una base legal adecuada y respete los derechos de los clientes.