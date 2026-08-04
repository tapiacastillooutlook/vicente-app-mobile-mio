# AETHERA: El Eco de las Escamas 🛸📲

Aplicación móvil desarrollada en **Flutter**, integrada con **Supabase** y basada en arquitectura limpia (**Clean Architecture + MVVM**). El proyecto está inspirado en el universo sci-fi / ufología de *Aethera* (Pleyadianos, Reptilianos, Resonancia Sónica, Mundo Anillo).

---

## 🛠️ Stack Tecnológico

- **Framework Móvil**: Flutter (Dart)
- **Backend / Base de Datos**: Supabase (Auth, Realtime, Database)
- **Estado & Inyección de Dependencias**: `provider`
- **Tipografía & Estética**: Sci-Fi Dark Mode con Google Fonts (`Orbitron`), acentos neón y efectos `Glassmorphism`.

---

## 📁 Estructura del Proyecto (Clean Architecture)

```text
lib/
├── core/
│   ├── constants/        # Credenciales e información global de la app
│   ├── services/         # Inicialización y singleton de Supabase
│   ├── theme/            # Tema Sci-Fi (AppTheme, Orbitron, Neon colors)
│   └── widgets/          # Componentes visuales reutilizables (GlassCard, WavePainter)
├── data/
│   ├── models/           # DTOs y mapeadores JSON (SightingModel, AlienSpeciesModel)
│   └── repositories/     # Repositorios de datos (SightingsRepository, SpeciesRepository, AuthRepository)
├── domain/
│   └── models/           # Entidades puras de dominio (SightingEntity, SpeciesEntity, UserEntity)
└── ui/
    ├── core/widgets/     # Widgets de interfaz común (CustomButton, CustomTextField)
    └── features/
        ├── auth/         # Vistas y ViewModel para inicio de sesión y registro
        ├── codex/        # Módulo Códex de Especies (Pleyadianos / Reptilianos)
        ├── home/         # Dashboard principal con BottomNavigationBar
        ├── nexo/         # Módulo Base El Nexo (Perfil del Agente / Estado del Sistema)
        ├── scanner/      # Módulo Escáner de Resonancia Sónica
        └── sightings/    # Módulo Radar de Avistamientos OVNI (Realtime)
```

---

## ✨ Funcionalidades Implementadas

1. **Autenticación (Auth)**
   - Inicio de sesión y registro integrados con Supabase Auth.
   - Manejo de estado de usuario con `AuthViewModel`.

2. **Radar de Avistamientos OVNI (`sightings`)**
   - Transmisión en tiempo real (Realtime stream) de reportes de OVNIs.
   - Formulario modal (`AddSightingDialog`) para registrar tipo de objeto, frecuencia y descripción.
   - Estilizado condicional según frecuencia (Armonía/Aguda para Pleyadianos, Ultra-baja para Reptilianos).

3. **Escáner de Resonancia Sónica (`scanner`)**
   - Ajustador interactivo de frecuencia por onda sónica.
   - Renderizado dinámico mediante `CustomPainter` (`FrequencyWavePainter`) con simulación de fase.

4. **Códex de Especies (`codex`)**
   - Fichas de conocimientos sobre civilizaciones extraterrestres (*Alianza de la Luz* vs *Hegemonía Oscura*).
   - Tarjetas cristalinas (`GlassCard`) con detalles sobre habilidades y frecuencias primarias.

5. **Base El Nexo (`nexo`)**
   - Dashboard de usuario/agente con resumen de perfil, rango y estado de los módulos operativos.

---

## 📌 Tareas Pendientes / Roadmap (TODO)

- [ ] **Configuración de Supabase Local (Docker)**:
  - Instalar **Docker Desktop** con soporte WSL 2 en el entorno de desarrollo.
  - Ejecutar `npx supabase start` para levantar los contenedores locales.
  - Aplicar las migraciones SQL para la tabla `sightings` con políticas RLS (Row Level Security) y habilitar Realtime.
  - Actualizar `lib/core/constants/supabase_constants.dart` con las credenciales locales (`localhost:54321`).
- [ ] **Módulo Forja de Resonancia**:
  - Implementar la interacción con armamento y artefactos sónicos (mencionados en el lore).
- [ ] **Pruebas Integradas & Despliegue**:
  - Ejecutar pruebas automatizadas en emulador de Android Studio.
