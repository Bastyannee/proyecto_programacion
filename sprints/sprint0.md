# Sprint 0 - Grupo 9

## Roles
| Integrante | Rol |
|---|---|
| Cristóbal Araya Lillo | Desarrollador |
| Bastian Pérez Aguayo | Scrum Master |
| Joaquin Andres Torres Zavala | Product Owner |
| Matias Ignacio Catril Perez | Desarrollador |

## Revisión

### Lo que terminamos
- **US-01 (Hito Técnico):** Configuración inicial del entorno y creación de la aplicación base en Flutter.
- **US-02 (Funcionalidad):** Conexión exitosa con la PokéAPI mediante protocolo HTTP y parseo básico de datos JSON.
- **Prototipo Funcional:** Renderizado de una lista preliminar de Pokémones en pantalla utilizando `FutureBuilder` para manejar estados de carga.

### Lo que planeamos construir a continuación
- **Filtros Avanzados de la Pokédex:** Implementar la búsqueda avanzada por tipo de Pokémon, generación y la visualización de versiones *shiny*.
- **Interfaz de Usuario (UI) y Branding:** Diseñar una UI atractiva y responsiva, definir la paleta de colores del proyecto y establecer un nombre oficial para la aplicación.
- **Gestión Ágil en GitHub:** Vincular de forma estricta las Historias de Usuario (HU) con sus tareas técnicas desglosadas en el tablero Kanban.

## Retrospectiva

### Qué funcionó
- **Adaptabilidad técnica:** El equipo logró aprender rápidamente los fundamentos de Dart y estructurar los primeros widgets en Flutter.
- **Disposición y comunicación:** Hubo excelente disposición para coordinar reuniones extraordinarias de sincronización técnica fuera de las horas de laboratorio.

### Qué no funcionó
- **Falta de metodología rigurosa:** No se aplicó la disciplina de TDD. Programamos la solución primero y dejamos las pruebas de lado, violando el ciclo *Red-Green-Refactor*.
- **Desorden en herramientas de gestión:** No se utilizó el tablero Kanban de GitHub Projects de manera activa para mover tarjetas, lo que generó un desfase entre el estado real del desarrollo y lo visualizado en el tablero.
- **Distribución de carga:** La asignación de tareas no fue clara desde el inicio, lo que provocó una distribución desequilibrada de los *commits* en el repositorio.

### Plan de acción
- [ ] **[Proceso - GitHub]** El Scrum Master guiará una sesión técnica de 1 hora este jueves por Teams para unificar el flujo de ramas (GitHub Flow) y asegurar que nadie suba código directo a `main`.
- [ ] **[Metodología - TDD]** El equipo se compromete a no aprobar ningún Pull Request (PR) en el *Code Review* si no incluye su respectivo archivo de pruebas unitarias (`_test.dart`) y commits con prefijos `RED:`, `GREEN:` y `REFACTOR:`.
- [ ] **[Gestión - Kanban]** Cada integrante moverá sus tareas asignadas a la columna *Doing* en el tablero de GitHub Projects al momento de iniciar el desarrollo, y el Scrum Master revisará el tablero cada viernes para evitar cuellos de botella.
