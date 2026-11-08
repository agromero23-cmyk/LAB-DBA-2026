# Actividad 8 — Derecho de cancelación y ciclo de vida

## Análisis previo a la eliminación

Antes de eliminar un registro de la tabla principal `clientes`, es necesario revisar dónde más puede encontrarse la información de esa persona. Aunque la solicitud de cancelación haya sido autorizada, primero se deben identificar las copias y los sistemas relacionados.

## Mapa de la información

    clientes
       |
       ├── otras tablas relacionadas
       ├── respaldos
       ├── réplicas
       ├── registros de auditoría
       ├── reportes y copias para analítica
       ├── archivos exportados
       └── sistemas externos

## Revisión de los elementos relacionados

| Elemento | ¿Qué se debe revisar? |
|---|---|
| Otras tablas relacionadas | Identificar si existen registros de la persona en otras tablas de la base de datos. |
| Respaldos | Revisar si la información aparece en copias de seguridad y establecer cómo se atenderá su eliminación según las políticas de conservación. |
| Réplicas | Verificar si los cambios realizados en la base de datos principal se reflejan correctamente en las réplicas. |
| Registros de auditoría | Comprobar si contienen datos personales y determinar qué información debe conservarse por motivos de seguridad o cumplimiento. |
| Reportes y copias para analítica | Identificar si los datos se utilizaron para generar reportes o conjuntos de datos derivados. |
| Archivos exportados | Buscar archivos CSV, Excel u otros documentos que contengan información de la persona. |
| Sistemas externos | Revisar si los datos fueron compartidos con aplicaciones, proveedores u otros sistemas y determinar las acciones necesarias. |

## ¿Por qué eliminar un registro de una tabla no necesariamente significa que toda la información relacionada con esa persona haya desaparecido de la organización?

Eliminar un registro de la tabla principal no garantiza que toda la información personal haya desaparecido, porque pueden existir copias en respaldos, réplicas, reportes, archivos exportados, registros de auditoría y sistemas externos.

Por esta razón, es necesario identificar dónde se encuentran los datos y establecer un procedimiento para atender la cancelación en cada ubicación correspondiente. También se deben revisar las obligaciones legales de conservación, ya que cierta información puede necesitar mantenerse durante un periodo determinado.

La organización debe documentar las acciones realizadas, verificar que se hayan aplicado correctamente y evitar que los datos eliminados vuelvan a incorporarse desde un respaldo o una copia antigua. Si existen datos que deban conservarse legalmente, se debe restringir su uso según corresponda.

## Conclusión

El derecho de cancelación requiere revisar el ciclo de vida completo de los datos personales, no solamente la tabla principal. Antes de ejecutar un `DELETE`, se deben identificar las relaciones, copias y sistemas involucrados, definir las acciones necesarias y comprobar que la solicitud se atienda de manera segura y conforme a las obligaciones aplicables.