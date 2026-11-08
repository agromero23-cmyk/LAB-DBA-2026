# Actividad 1 — Inventario y finalidad de los datos

## Matriz de clasificación de datos personales

| Campo | ¿Es dato personal? | Finalidad | ¿Es necesario? | Nivel de acceso | Retención |
|---|---|---|---|---|---|
| id | Sí, porque identifica un registro asociado a una persona. | Identificar y diferenciar a cada cliente. | Sí, porque permite administrar los registros. | Medio: personal autorizado. | Mientras la cuenta esté activa y sea necesario conservar el registro. |
| nombre | Sí, porque permite identificar directamente a una persona. | Conocer la identidad del cliente. | Sí, para identificar al cliente y brindarle atención. | Medio: personal autorizado. | Mientras exista una relación con el cliente y sea necesario conservarlo. |
| correo | Sí, porque permite identificar o contactar a una persona. | Enviar notificaciones y comunicarse con el cliente. | Sí, si se requiere contacto por correo electrónico. | Medio: personal autorizado. | Mientras sea necesario para la comunicación y el servicio. |
| telefono | Sí, porque permite contactar directamente a una persona. | Realizar llamadas o enviar mensajes relacionados con el servicio. | Depende: solo si se necesita contacto telefónico. | Alto: personal autorizado que requiera utilizarlo. | Hasta que deje de ser necesario, salvo obligaciones legales de conservación. |
| rfc | Sí, porque es un identificador fiscal asociado a una persona. | Realizar facturación y cumplir obligaciones fiscales. | Depende: cuando se requiere para facturación u otra obligación aplicable. | Alto: acceso restringido al personal autorizado. | Durante el plazo legal aplicable a la documentación fiscal. |
| edad | Sí, cuando está asociada con una persona identificada o identificable. | Verificar requisitos del servicio y conocer rangos de edad. | Depende: si es relevante para la finalidad del sistema. | Medio: personal autorizado. | Mientras sea necesaria para la finalidad establecida. |
| ciudad | Sí, cuando se relaciona con un cliente identificado. | Conocer la ubicación general del cliente y generar estadísticas. | Depende: si se necesita para prestar el servicio. | Bajo o medio: según su uso y la posibilidad de identificar al cliente. | Mientras sea necesaria para el servicio o los análisis autorizados. |
| codigo_postal | Sí, porque puede ayudar a identificar o localizar a una persona al combinarse con otros datos. | Registrar la ubicación del cliente y apoyar envíos o facturación. | Depende: si el servicio requiere conocer su ubicación. | Medio: personal autorizado. | Mientras se necesite para el servicio y durante los plazos legales aplicables. |
| fecha_alta | Sí, porque está vinculada al registro de un cliente. | Conocer cuándo se registró el cliente y controlar su cuenta. | Sí, para administrar la cuenta y consultar su antigüedad. | Bajo o medio: personal autorizado según sus funciones. | Mientras la cuenta esté activa y durante el periodo necesario para fines administrativos. |

## Justificación general

Los campos se consideran datos personales cuando están relacionados con una persona identificada o identificable. Cada dato debe recopilarse únicamente cuando sea necesario para una finalidad específica.

El nivel de acceso depende de la sensibilidad de la información y de las funciones de cada usuario. Por ejemplo, el RFC y el teléfono requieren mayores restricciones que la fecha de registro. La retención debe limitarse al tiempo necesario para cumplir la finalidad del sistema y las obligaciones legales aplicables. Cuando los datos dejen de ser necesarios, deben eliminarse o bloquearse de forma segura cuando corresponda.

Los periodos de retención son criterios generales y deben ajustarse a las políticas de la organización y a las disposiciones legales aplicables.

