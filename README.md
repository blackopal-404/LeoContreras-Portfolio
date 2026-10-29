# Lagos Media — Creative & Digital Portfolio

Portafolio responsive hecho con HTML, CSS y JavaScript puro. No necesita compilación.

## Ejecutar
1. Descomprime el ZIP.
2. Abre la carpeta en VS Code.
3. Abre `index.html` directamente o con Live Server.

## Incluye
- Estética más profesional que combina el portafolio inicial con el lenguaje visual de So Cool Tech.
- Charcoal, magenta, plum y cyan usados como acentos, glassmorphism discreto y tipografía Orbitron + DM Sans.
- Responsive para escritorio, tablet y móvil.
- Proyectos con filtros y modal con iframe para sitios web.
- Galería de videos reproducibles en la página.
- Galería de imágenes.
- Switch de tema claro/oscuro.
- Panel local de administración para proyectos, videos e imágenes y exportación JSON.
- CTA de WhatsApp, redes sociales y correo.
- Imágenes de referencia de marca en `assets/`.

## Datos de contacto
El botón WhatsApp usa el número facilitado para So Cool Tech: +504 9693-9045. Redes y correo también usan los enlaces compartidos previamente. Si este portafolio personal debe usar otros datos, actualízalos en `index.html` y `app.js`.

## Seguridad
El panel de administración es solo una demostración front-end. Usuario `admin`, contraseña `LagosMedia2026!`. La contraseña se encuentra en el código del navegador y los datos se guardan en `localStorage`; no es autenticación segura ni sincronización entre dispositivos. Para producción, conectar un backend con autenticación, base de datos y almacenamiento de medios.

Los proyectos y medios son ejemplos de presentación y deben revisarse/reemplazarse con trabajos reales antes de publicar. Algunos sitios externos impiden la vista previa dentro de un iframe; el botón “Abrir sitio” ofrece el enlace directo.


## Personalizar tu fotografía
Coloca tu fotografía en `assets/mi-foto.jpg`. El espacio reservado se convierte automáticamente en imagen; si el archivo no existe, se muestra una guía de reemplazo. Usa una foto vertical de buena calidad (idealmente 4:5).

Esta edición suaviza el lenguaje gamer, reduce el neón y agrega una sección editorial horizontal para presentar el perfil.

## Cambios de esta versión
- Guardado local con `localStorage`, sincronización automática entre pestañas del mismo origen y refresco de las galerías tras guardar.
- Confirmaciones y edición mediante diálogos propios del diseño; sin `alert()`, `confirm()` ni `prompt()` para la gestión del contenido.
- Ajustes responsive para el panel, formularios, tarjetas y ventana de vista previa en móvil.

**Límite importante:** este proyecto sigue siendo HTML/CSS/JS estático. El contenido editado queda guardado en el navegador y no se publica automáticamente en GitHub Pages/Netlify ni se comparte con visitantes en otros dispositivos. Para gestión real del sitio hace falta una API con autenticación y una base de datos (por ejemplo Supabase) y conectar este panel a ese servicio.

## Versión 5: carga de imágenes y video
- Desde Administración se puede arrastrar y soltar o seleccionar una foto de perfil. La imagen se aplica al Hero sin editar archivos.
- Se pueden subir imágenes de portada de proyectos y elementos de la galería, o continuar usando una URL HTTPS.
- Imágenes rasterizadas se reducen a un máximo de 1600 px y se convierten a WebP para reducir tamaño; GIF y SVG se conservan sin conversión.
- Para videos, se admite URL directa compatible (por ejemplo MP4/WebM), enlaces de YouTube y Vimeo; también se permite subir archivos pequeños de hasta 5 MB.
- Los enlaces externos de imágenes deben ser públicos y directos al archivo para que puedan visualizarse. Google Drive/Dropbox pueden requerir enlaces de descarga directa; una página de vista previa no siempre sirve como imagen.
- Las cargas se guardan en el almacenamiento del navegador actual. Para publicarlas a todos los visitantes y compartirlas entre dispositivos hace falta almacenamiento remoto y backend.
