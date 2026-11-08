# 14. Actividad 7 — Comparar protección en reposo y protección en tránsito

| **Situación** | **Mecanismo apropiado** | **¿Qué protege?** |
|---|---|---|
| Contraseña de usuario | Hash seguro, como Argon2id o bcrypt | Evita almacenar la contraseña original en texto plano. |
| RFC almacenado en una tabla | Cifrado simétrico | Protege el RFC almacenado y permite recuperarlo con la clave correcta. |
| Consulta enviada desde un cliente al servidor | TLS | Protege la información durante la comunicación entre el cliente y PostgreSQL. |
| Respaldo de una base de datos | Cifrado del respaldo | Evita que personas no autorizadas puedan leer la información del archivo de respaldo. |
| Clave criptográfica | Gestor de secretos o sistema de gestión de claves (KMS) | Protege las claves y limita el acceso a personas autorizadas. |

## Conclusión

La protección de datos en reposo y en tránsito es importante para mantener segura la información. El hash se utiliza para proteger las contraseñas, el cifrado permite proteger datos que necesitan recuperarse y TLS protege la comunicación entre sistemas. Además, los respaldos y las claves criptográficas deben almacenarse de forma segura.