# Actividad 14 — Escenario integral

## Matriz de problemas y riesgos

| Problema | Principio afectado | Riesgo | Control propuesto |
|---|---|---|---|
| 1. Todos los empleados de Analítica pueden consultar directamente la tabla `clientes`. | Mínimo privilegio y confidencialidad. | Acceso a información personal por empleados que no la necesitan. | Crear vistas SQL que muestren únicamente los datos necesarios para generar estadísticas. |
| 2. Analítica tiene acceso al nombre de los clientes. | Minimización de datos. | Identificación innecesaria de las personas durante los análisis. | Utilizar datos agregados o identificadores anónimos en lugar de nombres. |
| 3. Analítica puede consultar los correos electrónicos. | Minimización de datos y confidencialidad. | Uso indebido de los correos o envío de mensajes no autorizados. | Restringir el acceso a los correos y excluirlos de las consultas estadísticas. |
| 4. Analítica puede consultar los números de teléfono. | Minimización de datos. | Exposición de información de contacto sin una necesidad funcional. | Eliminar el acceso a este campo para el personal de Analítica. |
| 5. Analítica puede consultar el RFC. | Confidencialidad y mínimo privilegio. | Exposición de identificadores fiscales que podrían utilizarse indebidamente. | Restringir el RFC al personal autorizado que lo necesite para sus funciones. |
| 6. Los datos se conservan desde hace 12 años sin una política documentada de retención. | Limitación del plazo de conservación. | Acumulación de información innecesaria, mayores costos y consecuencias más graves ante una filtración. | Definir periodos de retención según la finalidad y las obligaciones legales, y revisar periódicamente los datos almacenados. |
| 7. No existe una política documentada de retención. | Responsabilidad y limitación del plazo de conservación. | No hay criterios claros para decidir cuándo eliminar o bloquear los datos. | Crear una política escrita que establezca plazos, responsables, excepciones y procedimientos de eliminación. |
| 8. Los desarrolladores reciben copias completas de la base de datos. | Minimización de datos y confidencialidad. | La información puede difundirse o quedar expuesta fuera del entorno de producción. | Entregar únicamente los datos necesarios para cada prueba y controlar la distribución de las copias. |
| 9. Las copias de desarrollo contienen información real de clientes. | Privacidad por diseño y seguridad. | Exposición de datos personales durante las pruebas y el desarrollo de software. | Utilizar datos ficticios o anonimizados para las pruebas. |
| 10. Marketing utiliza los correos electrónicos para campañas promocionales sin que exista documentación clara de las finalidades. | Limitación de la finalidad y transparencia. | Uso de datos para una finalidad que podría no estar informada o debidamente justificada. | Verificar la base legal aplicable, documentar la finalidad e implementar mecanismos para respetar las preferencias de los clientes. |
| 11. No existe documentación clara sobre la finalidad de cada dato. | Limitación de la finalidad y responsabilidad. | Los datos pueden utilizarse para propósitos incompatibles con aquellos para los que fueron recopilados. | Crear un inventario de datos que indique la finalidad, el responsable, los usuarios autorizados y el periodo de retención de cada campo. |
| 12. No se especifica una revisión periódica de los permisos de acceso. | Mínimo privilegio y responsabilidad. | Los empleados pueden conservar permisos que ya no necesitan. | Revisar los permisos periódicamente y retirarlos cuando cambien las funciones de los usuarios. |
| 13. No se mencionan controles para registrar las consultas realizadas a la base de datos. | Responsabilidad y seguridad. | Puede ser difícil detectar accesos indebidos o investigar incidentes. | Habilitar registros de auditoría y revisarlos periódicamente, protegiéndolos contra modificaciones no autorizadas. |
| 14. No se describe un procedimiento para eliminar datos cuando dejan de ser necesarios. | Limitación del plazo de conservación y minimización. | Los datos pueden permanecer almacenados indefinidamente en distintas ubicaciones. | Establecer procedimientos de eliminación o anonimización que contemplen tablas, copias de desarrollo, respaldos y sistemas relacionados. |

## Conclusión

La empresa presenta varios problemas relacionados con la privacidad y la seguridad de los datos personales. El acceso amplio a la tabla `clientes`, la utilización de información real en desarrollo y la falta de una política de retención aumentan los riesgos de exposición y uso indebido.

Para mejorar la situación, la empresa debe aplicar el principio de mínimo privilegio, limitar los datos utilizados por cada área, establecer periodos de retención y documentar las finalidades del tratamiento. También debe utilizar datos ficticios o anonimizados en las pruebas y revisar periódicamente los permisos de acceso.

Estas medidas ayudan a proteger la información de los 50,000 clientes y permiten administrar los datos de manera más segura y responsable.