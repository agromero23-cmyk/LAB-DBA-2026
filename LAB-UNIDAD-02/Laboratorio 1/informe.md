## 7. Actividad 1 — Clasificación de los datos

### Matriz de clasificación

| Campo | ¿Identifica directamente? | ¿Puede contribuir a identificar? | ¿Requiere protección? | Justificación |
|---|---|---|---|---|
| id | No | Sí | Sí | Aunque es un identificador interno, puede relacionarse con otros datos de la persona. |
| nombre | Sí | Sí | Sí | Permite identificar a una persona, especialmente si se incluye nombre y apellidos. |
| correo | Sí | Sí | Sí | Puede identificar directamente a una persona si está asociado con ella. |
| telefono | Sí | Sí | Sí | Permite contactar e identificar a una persona mediante su número telefónico. |
| rfc | Sí | Sí | Sí | Es un identificador fiscal que permite asociar información con una persona. |
| edad | No | Sí | Sí | Puede contribuir a identificar a una persona cuando se combina con otros datos. |
| ciudad | No | Sí | Sí | Permite conocer la ubicación general y puede ayudar a distinguir a una persona. |
| codigo_postal | No | Sí | Sí | Puede reducir el área de búsqueda y facilitar la identificación al combinarse con otros datos. |
| fecha_alta | No | Sí | Sí | Puede relacionarse con registros y otros datos para identificar a un cliente. |

### Preguntas respondidas

**1. ¿Qué campos identifican directamente a una persona?**

Los campos que pueden identificar directamente a una persona son el nombre, el correo electrónico, el teléfono y el RFC, ya que permiten reconocerla o relacionar información con ella.

**2. ¿Qué campos no identifican por sí solos, pero podrían contribuir a hacerlo?**

Los campos como el ID, la edad, la ciudad, el código postal y la fecha de alta generalmente no identifican por sí solos a una persona, pero pueden contribuir a identificarla cuando se combinan con otros datos.

**3. ¿Qué combinación de campos podría incrementar el riesgo de reidentificación?**

La combinación de nombre, edad, ciudad, código postal y fecha de alta puede incrementar el riesgo de reidentificación, ya que permite reducir las posibilidades de encontrar a una persona específica. También combinar el correo electrónico o teléfono con otros datos facilita relacionar la información con su propietario.

**4. ¿Todos los datos que deben protegerse son necesariamente datos personales sensibles desde el punto de vista jurídico?**

No. No todos los datos que requieren protección son considerados datos personales sensibles desde el punto de vista jurídico. Los datos personales son aquellos que permiten identificar o hacer identificable a una persona, mientras que los datos personales sensibles son aquellos que pueden afectar su esfera más íntima, como la información sobre salud, origen racial o étnico, creencias religiosas o preferencias sexuales. Sin embargo, los datos personales comunes también deben protegerse para evitar su uso indebido.


**8. Actividad 2 — Enmascaramiento (masking)**

**1. ¿Qué información continúa existiendo en la tabla original?**

En la tabla original clientes continúan existiendo todos los datos registrados, como el nombre, correo electrónico, teléfono, RFC, edad, ciudad y código postal. La información no se elimina, solamente se limita el acceso a ciertos campos.
**2. ¿Qué información puede visualizar el usuario soporte?**

El usuario soporte puede visualizar únicamente los campos y registros que se permiten en la vista creada para él. Por ejemplo, puede consultar el ID, la edad, la ciudad y la fecha de alta, sin tener acceso a datos privados como el correo, teléfono y RFC, si estos fueron excluidos de la vista.
**3. ¿Por qué no es suficiente ocultar los datos únicamente en la aplicación?**

Porque un usuario podría acceder directamente a la base de datos y consultar la información que la aplicación oculta. Por eso, es importante configurar permisos directamente en el sistema gestor de bases de datos para controlar qué información puede consultar cada usuario.

**4. ¿Qué ocurriría si soporte tuviera acceso directo a clientes?**

Si el usuario soporte tuviera permisos de lectura sobre la tabla original clientes, podría consultar directamente los datos personales que contiene, incluso aquellos que se ocultaron en la aplicación o en la vista. Esto aumentaría el riesgo de exposición de información confidencial.

## 20. Preguntas de reflexión
1. ¿Cuál es la diferencia entre enmascaramiento y seudonimización?
El enmascaramiento oculta parte de un dato para que no se vea completo, por ejemplo, mostrar solo algunos dígitos de un teléfono. La seudonimización sustituye los datos que identifican a una persona por códigos o identificadores diferentes.
2. ¿Por qué la seudonimización no significa anonimización?
Porque los datos seudonimizados todavía pueden relacionarse con una persona si se cuenta con información adicional, como una tabla que relaciona los códigos con las identidades reales.
3. ¿Por qué eliminar nombre y RFC no garantiza que un conjunto de datos sea anónimo?
Porque otros datos, como la edad, la ciudad y el código postal, pueden combinarse para identificar indirectamente a una persona.
4. ¿Qué función tienen los cuasi-identificadores?
Son datos que, por sí solos, generalmente no identifican directamente a una persona, pero al combinarse con otros pueden ayudar a descubrir su identidad.
5. ¿Por qué es importante separar el mapa de seudonimización?
Porque contiene la relación entre los códigos utilizados y las identidades reales. Mantenerlo separado reduce el riesgo de que alguien pueda identificar a las personas si obtiene acceso a los datos seudonimizados.
6. ¿Qué principio de seguridad se aplica al impedir que el analista acceda al mapa?
Se aplica el principio de mínimo privilegio, que consiste en dar a cada usuario únicamente los permisos necesarios para realizar sus actividades.
7. ¿Por qué una vista puede ser preferible a entregar acceso directo a la tabla?
Porque una vista permite mostrar únicamente los datos necesarios para el trabajo del usuario, ocultando información confidencial y evitando que consulte directamente toda la tabla original.
8. ¿Qué diferencia existe entre proteger un dato para visualización y protegerlo contra acceso no autorizado?
Proteger un dato para visualización significa ocultarlo o mostrarlo parcialmente. Protegerlo contra el acceso no autorizado significa establecer permisos y controles para impedir que personas sin autorización puedan consultarlo.
9. ¿Por qué la retención forma parte de la protección de datos?
Porque permite establecer durante cuánto tiempo se conservará la información y cuándo debe eliminarse, evitando mantener datos personales durante más tiempo del necesario.
10. ¿Qué riesgo existe si una organización conserva información indefinidamente?
Existe un mayor riesgo de filtraciones, robo de información, uso indebido y acceso no autorizado. Además, se pueden conservar datos que ya no son necesarios para las actividades de la organización.14. Actividad 7 — Retención de datos
