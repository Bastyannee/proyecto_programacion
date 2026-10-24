# Sprint 1 - Grupo 9

## Roles
| Integrante | Rol |
|---|---|
| Bastian Pérez Aguayo | Product Owner |
| Joaquin Andres Torres Zavala | Scrum Master |
| Cristóbal Araya Lillo | Desarrollador |
| Matias Ignacio Catril Perez | Desarrollador |

## Revisión

### Lo que terminamos
- **US-03 (Gestión de Equipos):** Adición y listado reactivo de Pokémon en el equipo.
  - *Criterio de aceptación cumplido:* Al seleccionar un Pokémon y agregarlo al equipo, se genera una instancia independiente dentro de la ventana del equipo.
  - *Criterio de aceptación cumplido:* Las nuevas incorporaciones se anexan ordenadamente al final de la lista del equipo activo.
- **US-04 (Personalización de Instancias):** Soporte para nombres personalizados (apodos).
### Tareas pendientes (Deuda técnica / Spillovers)
- **US-05 (Detalle de Pokémon en Equipo):** Despliegue de ficha técnica completa al seleccionar un Pokémon del equipo (tipos, región, movimientos, habilidades, debilidades, efectividad elemental y nombre original).
- **US-06 (Módulo de Filtros Avanzados):** Corrección y robustecimiento del motor de filtrado del catálogo:
  - Filtrado reactivo por tipo seleccionado.
  - Limpieza de filtros y restauración inmediata del listado maestro de Pokémon.
  - Manejo de estados vacíos y combinaciones excluyentes (más de dos tipos simultáneos o cruces de región/generación sin coincidencias).

### Lo que planeamos construir a continuación
- **Persistencia y Filtros:** Conectar el sistema de base de datos local con los filtros para búsquedas optimizadas e indexadas.
- **Gestión Multi-Equipo:** Habilitar la creación, alternancia y eliminación de múltiples equipos Pokémon de forma dinámica.
- **Personalización Visual (UI):** Implementar selector de tema claro / tema oscuro (*light/dark mode*).
- **Ficha Técnica Profunda:** Integrar cálculo y renderizado de debilidades/fortalezas, estadísticas base (ataque, defensa, velocidad), dimensiones físicas (peso, altura) y alternancia a versión *shiny*.
- **Módulo de Comparación:** Herramienta interactiva para contrastar atributos entre Pokémon individuales y métricas globales entre equipos.

## Retrospectiva

### Qué funcionó
- **Madurez en TDD:** Mayor consolidación en la disciplina de desarrollo guiado por pruebas, aplicando el ciclo *Red-Green-Refactor* con mayor consistencia.
- **Distribución de tareas:** Asignación técnica más equitativa y clara según los roles y habilidades de cada integrante.
- **Adopción de SCRUM y GitHub Projects:** Mejor sincronización del tablero Kanban con el avance real de las ramas y *pull requests*.

### Qué no funcionó
- **Gestión del tiempo:** Dificultad para coordinar entregas intermedias ante la sobrecarga de actividades paralelas.
- **Alineación de objetivos y ritmo:** Estimaciones de alcance desfasadas respecto al calendario y requerimientos inmediatos del curso.
- **Canales de comunicación:** Falta de fluidez y proactividad en la comunicación técnica cotidiana para destrabar impedimentos a tiempo.
- **Estimación de esfuerzo:** Subestimación del tiempo necesario para tareas complejas de lógica de negocio y pruebas de filtrado.

### Plan de acción
- [ ] **[Proceso - GitHub Flow]** El Scrum Master guiará una sesión técnica de 1 hora este sábado vía Teams/Discord para homologar la estrategia de ramificación (*feature branches*) y asegurar la protección de la rama `main` contra *commits* directos.
- [ ] **[Gestión - Backlog Refinement]** Realizar una sesión de refinamiento para redactar y granularizar las Historias de Usuario con suficiente antelación, permitiendo desglosar subtareas técnicas medibles antes de iniciar el desarrollo.
- [ ] **[Calidad - Validación Temprana]** Agendar una reunión de revisión intermedia con el profesor o ayudante antes del cierre del Sprint 2 para recibir retroalimentación técnica y validar los criterios de aceptación.