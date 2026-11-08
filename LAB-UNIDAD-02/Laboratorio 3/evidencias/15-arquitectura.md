# Actividad 15 — Propuesta de arquitectura de datos protegidos

## 1. Objetivo

Diseñar una arquitectura conceptual que permita separar la información de los clientes de acuerdo con su finalidad, aplicando controles de acceso, minimización, protección de información sensible, retención, trazabilidad, eliminación y atención de solicitudes.

La propuesta busca que cada área tenga acceso únicamente a los datos necesarios para realizar sus actividades, reduciendo los riesgos de exposición y uso indebido de la información personal.

## 2. Arquitectura propuesta

```text
                     BASE DE DATOS PRINCIPAL
                       Información de clientes
                                |
              +-----------------+-----------------+
              |                 |                 |
              v                 v                 v
          OPERACIÓN         ANALÍTICA          AUDITORÍA
              |                 |                 |
              v                 v                 v
        Datos necesarios    Datos agregados    Registros de
        para atender        o anonimizados     accesos y
        a los clientes      para reportes      modificaciones
              |                 |                 |
              v                 v                 v
        Acceso por rol      Datos mínimos      Acceso restringido
        y permisos          necesarios         al personal autorizado
              |                 |                 |
              +-----------------+-----------------+
                                |
                                v
                      CONTROLES DE PRIVACIDAD
                                |
              +-----------------+-----------------+
              |                 |                 |
              v                 v                 v
          Retención         Eliminación       Atención de
          limitada          segura            solicitudes
```

## 3. Componentes de la arquitectura

### 3.1. Base de datos principal

Almacena la información necesaria para las actividades de la empresa, como nombre, correo electrónico, teléfono, RFC y otros datos de los clientes.

**Controles propuestos:**
- Registrar la finalidad de cada dato personal.
- Evitar almacenar información que no sea necesaria.
- Asignar permisos de acceso según las funciones de cada usuario.
- Proteger los datos mediante medidas de seguridad adecuadas.
- Evitar que todas las áreas consulten directamente la tabla completa de clientes.

### 3.2. Área de operación

Se utiliza para realizar actividades como atención al cliente, administración de cuentas y facturación.

**Controles propuestos:**
- Permitir el acceso únicamente al personal autorizado.
- Mostrar solamente los campos necesarios para cada actividad.
- Restringir el acceso al RFC y otros datos de identificación según las responsabilidades del usuario.
- Registrar las consultas y modificaciones importantes.
- Conservar los datos durante el tiempo necesario o el exigido por las obligaciones legales.

### 3.3. Área de analítica

Se utiliza para generar reportes, estadísticas mensuales y analizar tendencias de los clientes.

**Controles propuestos:**
- Utilizar datos agregados o anonimizados cuando sea posible.
- Evitar mostrar nombres, correos, teléfonos y RFC si no son necesarios.
- Crear vistas de base de datos con los campos requeridos para los análisis.
- Evitar el acceso directo a la información completa de los clientes.
- Definir un periodo de conservación para los reportes.
- Verificar que los resultados no permitan identificar a los clientes cuando se utilicen datos anonimizados.

### 3.4. Área de auditoría

Se encarga de registrar y revisar las actividades relacionadas con el acceso y manejo de la información.

**Controles propuestos:**
- Registrar accesos, modificaciones, exportaciones y eliminaciones relevantes.
- Guardar la fecha, el usuario y la acción realizada.
- Restringir los registros al personal autorizado.
- Proteger los registros contra modificaciones no autorizadas.
- Revisar periódicamente los eventos para detectar actividades sospechosas.
- Establecer un periodo de conservación para los registros de auditoría.

## 4. Controles generales de protección

| Control | Propuesta técnica | Objetivo |
|---|---|---|
| Acceso | Utilizar roles y permisos específicos para cada área. | Evitar accesos innecesarios a los datos personales. |
| Minimización | Crear vistas que incluyan solamente los campos necesarios. | Reducir la cantidad de información expuesta. |
| Protección de información sensible | Restringir el acceso a datos como el RFC y aplicar cifrado cuando corresponda. | Evitar la divulgación y el uso indebido de información. |
| Retención | Definir periodos de conservación según la finalidad y las obligaciones legales. | Evitar almacenar datos indefinidamente. |
| Trazabilidad | Registrar accesos, cambios, consultas relevantes y eliminaciones. | Identificar quién realizó cada acción y cuándo. |
| Eliminación | Implementar procedimientos para eliminar o anonimizar los datos cuando ya no sean necesarios. | Evitar la acumulación innecesaria de información. |
| Atención de solicitudes | Establecer un procedimiento para recibir, verificar y atender solicitudes de los titulares. | Facilitar el ejercicio de los derechos sobre los datos personales. |

## 5. Atención de solicitudes de los titulares

La empresa deberá establecer un procedimiento para atender las solicitudes relacionadas con los datos personales de sus clientes.

El procedimiento será el siguiente:

1. Recibir la solicitud del titular.
2. Verificar su identidad de manera adecuada.
3. Identificar los datos y sistemas relacionados con la solicitud.
4. Analizar la solicitud y determinar las acciones correspondientes.
5. Realizar las modificaciones, restricciones o eliminaciones que procedan, respetando las obligaciones legales aplicables.
6. Registrar la atención de la solicitud y comunicar la respuesta al titular.

También se deberán revisar las copias de los datos que existan en reportes, sistemas de desarrollo y otros sistemas relacionados cuando corresponda.

## 6. Política de retención y eliminación

La empresa deberá establecer reglas para determinar cuánto tiempo conservar cada tipo de información.

- Los datos de operación se conservarán mientras sean necesarios para su finalidad y durante los periodos exigidos por la ley.
- Los reportes de analítica se conservarán únicamente durante el tiempo necesario.
- Los registros de auditoría tendrán un periodo definido de conservación.
- Los datos que ya no sean necesarios deberán eliminarse o anonimizarse cuando no exista una obligación de conservarlos.
- Las copias de respaldo deberán contar con procedimientos para controlar su conservación y eliminación.

La eliminación deberá considerar las tablas relacionadas, las copias de desarrollo y los sistemas que contengan información duplicada.

## 7. Beneficios de la arquitectura propuesta

- Disminuye el riesgo de accesos no autorizados.
- Reduce la exposición de los datos personales.
- Facilita la aplicación del principio de minimización.
- Permite controlar el tiempo de conservación de la información.
- Mejora la detección de actividades sospechosas.
- Facilita la atención de solicitudes de los titulares.
- Permite que cada área trabaje con información adecuada para su función.

## 8. Conclusión

La arquitectura propuesta permite separar la información de los clientes según su finalidad. El área de operación tendrá acceso a los datos necesarios para atender a los clientes, analítica utilizará principalmente datos agregados o anonimizados y auditoría conservará registros de las actividades relevantes.

La aplicación de roles, vistas de base de datos, políticas de retención, procedimientos de eliminación y registros de auditoría ayuda a reducir los riesgos relacionados con el tratamiento de datos personales. Aunque la propuesta es conceptual y no requiere implementar físicamente toda la arquitectura, demuestra cómo los principios de privacidad pueden convertirse en decisiones técnicas concretas.



