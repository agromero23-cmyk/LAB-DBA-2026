# Actividad 12 — Privacidad por diseño

## 1. ¿Qué problemas identificas?

El principal problema es que el desarrollador quiere recopilar demasiados datos personales sin demostrar que sean necesarios para el funcionamiento de la aplicación. Guardar información por si se necesita en el futuro aumenta los riesgos de filtraciones, accesos no autorizados y uso indebido de los datos.

Además, algunos campos contienen información sensible desde el punto de vista de la privacidad, como el salario, la fecha de nacimiento y el RFC. También existe el riesgo de conservar datos durante más tiempo del necesario.

## 2. ¿Qué principio de privacidad se está ignorando?

Se están ignorando principalmente los principios de **minimización de datos y privacidad por diseño**.

La minimización establece que solo deben recopilarse los datos necesarios para cumplir una finalidad específica. La privacidad por diseño implica considerar la protección de los datos personales desde la etapa de diseño y desarrollo de la aplicación, en lugar de intentar corregir los problemas después.

También se relacionan los principios de limitación de la finalidad y limitación del plazo de conservación.

## 3. ¿Qué preguntas realizarías antes de aprobar el diseño?

Antes de aprobar la estructura de la tabla, realizaría las siguientes preguntas:

- ¿Cuál es la finalidad principal de la aplicación?
- ¿Qué datos son indispensables para registrar a un cliente?
- ¿Para qué se utilizará cada campo?
- ¿Quiénes tendrán acceso a los datos?
- ¿Existe una justificación legal para recopilar cada dato?
- ¿Cuánto tiempo se conservará la información?
- ¿Cómo se protegerán los datos contra accesos no autorizados?
- ¿Se pueden utilizar datos menos detallados para cumplir la misma finalidad?
- ¿Cómo podrán los clientes ejercer sus derechos sobre sus datos personales?
- ¿Qué procedimiento se seguirá para eliminar los datos cuando dejen de ser necesarios?

## 4. ¿Qué datos eliminarías?

Eliminaría los campos que no sean necesarios para la finalidad principal de la aplicación.

Por ejemplo, si la aplicación únicamente necesita registrar clientes y permitir el contacto básico, propondría inicialmente los siguientes campos:

| Campo | Justificación |
|---|---|
| id | Permite identificar cada registro de manera única. |
| nombre | Permite identificar al cliente. |
| correo | Permite contactar al cliente por medios electrónicos, si es necesario. |
| telefono | Se conservaría únicamente si se necesita contacto telefónico. |
| fecha_alta | Permite administrar la fecha de registro, si es necesaria para el funcionamiento del sistema. |

Los demás campos no deberían incluirse automáticamente. Su incorporación dependería de una finalidad concreta y de una justificación adecuada.

## 5. ¿Qué datos requerirían una justificación adicional?

| Dato | Justificación necesaria |
|---|---|
| rfc | Explicar si se necesita para facturación u obligaciones fiscales. |
| edad | Justificar si se necesita para verificar requisitos o prestar el servicio. |
| direccion | Explicar si se requiere para entregas, visitas u otro servicio específico. |
| ciudad | Justificar su uso para operaciones, entregas o análisis autorizados. |
| codigo_postal | Determinar si es necesario para envíos, facturación o ubicación. |
| fecha_nacimiento | Justificar por qué es necesaria la fecha completa en lugar de un dato menos detallado, como un rango de edad. |
| ocupacion | Explicar qué servicio requiere conocer la ocupación del cliente. |
| salario | Justificar por qué se necesita información económica y qué medidas adicionales de protección requiere. |
| estado_civil | Explicar qué finalidad concreta requiere este dato y por qué no puede omitirse. |

La presencia de estos campos no significa que todos estén prohibidos, sino que su recopilación debe justificarse de acuerdo con la finalidad del sistema.

## 6. ¿Cómo aplicarías privacidad por defecto?

Aplicaría privacidad por defecto mediante las siguientes medidas:

- **Recopilación mínima:** incluir únicamente los campos indispensables para el servicio.
- **Acceso restringido:** asignar permisos según las funciones de cada usuario.
- **Protección de datos:** utilizar conexiones seguras, controles de acceso y medidas adecuadas para proteger la información almacenada.
- **Retención limitada:** establecer periodos de conservación según la finalidad y las obligaciones aplicables.
- **Opciones privadas por defecto:** evitar que los datos personales se compartan automáticamente con otras áreas o servicios.
- **Consentimiento y transparencia:** informar a los clientes sobre las finalidades del tratamiento y obtener consentimiento cuando corresponda.
- **Eliminación segura:** establecer procedimientos para eliminar o anonimizar los datos cuando dejen de ser necesarios, salvo que deban conservarse por una obligación aplicable.
- **Auditoría:** registrar y revisar los accesos a la información personal.
- **Pruebas de seguridad:** comprobar que los permisos y mecanismos de protección funcionen correctamente antes de poner la aplicación en producción.

## Conclusión

La aplicación no debería recopilar todos los datos personales bajo la idea de que podrían ser útiles en el futuro. Antes de diseñar la base de datos, es necesario definir la finalidad del sistema y justificar cada campo.

Aplicar la minimización de datos y la privacidad por diseño permite reducir riesgos, evitar la recopilación innecesaria de información y proteger la privacidad de los clientes desde el inicio del desarrollo.