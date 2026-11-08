# Actividad 11 — Diseñar una matriz de gobierno de datos

## Matriz de gobierno de datos

| Dato | Finalidad | Responsable | Usuarios autorizados | Protección | Retención | Acción al finalizar |
|---|---|---|---|---|---|---|
| nombre | Identificar al cliente y brindarle atención. | Atención al cliente | Atención al cliente y Dirección cuando sea necesario. | Control de acceso y permisos por usuario. | Mientras sea necesario para prestar el servicio y cumplir las obligaciones aplicables. | Eliminar o bloquear cuando deje de ser necesario, salvo obligación de conservación. |
| correo | Contactar al cliente y enviar información relacionada con el servicio. | Atención al cliente | Atención al cliente; Marketing solo cuando exista una base legal adecuada. | Acceso restringido y protección de la información almacenada. | Mientras sea necesario para la comunicación y la finalidad establecida. | Eliminar o actualizar cuando deje de ser necesario. |
| telefono | Contactar al cliente para resolver consultas o problemas. | Atención al cliente | Personal de atención que necesite comunicarse con el cliente. | Acceso restringido y registro de accesos cuando corresponda. | Mientras sea necesario para la atención y las obligaciones aplicables. | Eliminar o bloquear cuando ya no sea necesario. |
| rfc | Realizar facturación y cumplir obligaciones fiscales. | Facturación | Personal de facturación y DBA autorizado cuando sea necesario. | Acceso restringido y protección durante el almacenamiento y la transmisión. | Durante el plazo exigido por las obligaciones fiscales aplicables. | Eliminar o bloquear al finalizar el plazo legal, si no existe otra obligación de conservación. |
| edad | Verificar requisitos del servicio y generar estadísticas justificadas. | Responsable del servicio o Analítica | Personal autorizado que necesite el dato para una finalidad específica. | Limitar el acceso y utilizar rangos de edad o datos anonimizados cuando sea posible. | Solo durante el tiempo necesario para la finalidad establecida. | Eliminar o anonimizar cuando deje de ser necesario. |
| ciudad | Conocer la ubicación general del cliente y elaborar estadísticas. | Atención al cliente o Analítica | Atención al cliente cuando sea necesario; Analítica mediante datos agregados cuando sea posible. | Limitar permisos y evitar combinar información innecesaria que permita identificar al cliente. | Mientras sea necesaria para el servicio o el análisis autorizado. | Eliminar o anonimizar cuando deje de ser necesaria. |
| codigo_postal | Apoyar envíos, verificar ubicaciones o realizar trámites que lo requieran. | Atención al cliente o Facturación, según la finalidad. | Personal que gestione envíos o trámites relacionados. | Acceso restringido según las funciones del usuario. | Mientras sea necesario para la finalidad y durante los plazos legales aplicables. | Eliminar o bloquear cuando deje de ser necesario, salvo obligación de conservación. |

## Justificación de los permisos

Los permisos se asignan según las funciones de cada área. Atención al cliente puede consultar los datos necesarios para resolver problemas, mientras que Facturación necesita acceso al RFC cuando debe emitir comprobantes fiscales.

Analítica debería trabajar preferentemente con información agregada o anonimizada, y el DBA debe administrar la base de datos sin consultar información personal salvo que sea necesario para una tarea autorizada.

Dirección solo debería acceder a los datos personales cuando exista una necesidad justificada para sus funciones.

## Conclusión

El gobierno de datos permite definir quién puede consultar cada dato, para qué puede utilizarlo y durante cuánto tiempo debe conservarse. Aplicar el principio de mínimo privilegio reduce los accesos innecesarios y ayuda a proteger la información personal de los clientes.

Cada permiso debe justificarse por una necesidad funcional y revisarse periódicamente.