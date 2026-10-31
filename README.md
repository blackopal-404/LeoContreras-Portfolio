# Lagos Media Portfolio — Supabase

Esta versión conserva el diseño y las secciones del portfolio, pero reemplaza el guardado de contenido en `localStorage` por Supabase.

## Configuración ya incorporada

- Supabase Project URL y publishable key en `app.js`.
- Supabase JS v2 cargado desde jsDelivr en `index.html`.
- Lectura pública de proyectos, videos e imágenes publicados.
- Inicio de sesión del administrador con Supabase Auth (correo + contraseña).
- Alta, edición y eliminación desde el panel.
- Carga de imágenes y videos al bucket público `portfolio-media`.
- Fotografía de perfil guardada en Storage y referencia en `profile`.
- Preferencia de tema claro/oscuro conservada localmente; el contenido ya no depende del navegador.

## Paso 1 — Reiniciar los datos de prueba (opcional, recomendado si quieres comenzar vacío)

En Supabase abre **SQL Editor → New query**, copia el contenido de `supabase-clean-start.sql` y ejecútalo. Esto elimina los registros actuales de `images`, `videos`, `projects`, `profile` y `portfolio_settings`; no elimina las tablas, políticas, bucket ni usuario administrador.

## Paso 2 — Comprobar Authentication

En Supabase abre **Authentication → Users** y confirma que existe el usuario administrador con el correo que usarás en el panel. Si aún no existe, créalo allí. El inicio de sesión del sitio utiliza ese correo y su contraseña; ya no existen credenciales demo dentro del JavaScript.

## Paso 3 — Comprobar tablas y permisos

Deben existir las tablas `profile`, `projects`, `videos`, `images` y `portfolio_settings`, con RLS habilitado. Para que el sitio funcione:

- Lectura pública: `profile` y `portfolio_settings`; y filas `published = true` en `projects`, `videos` e `images`.
- Escritura: solo el usuario administrador autenticado.
- Storage: bucket público `portfolio-media`; descarga pública y políticas de escritura para el administrador autenticado.

El código espera los campos ya definidos en el proyecto: `projects.cover_image`, `projects.project_url`, `videos.video_url`, `images.url` y `profile.photo_url`.

## Paso 4 — Publicar en GitHub Pages

1. Descomprime el ZIP.
2. Reemplaza en el repositorio los archivos `app.js` e `index.html` por los de esta versión. Conserva la carpeta `assets` original completa.
3. No subas el directorio `.git` incluido en el ZIP (el paquete de entrega no debería incluirlo).
4. Haz commit y push a la rama que publica GitHub Pages.
5. Espera a que termine el despliegue y abre el sitio en una ventana privada o fuerza recarga con `Ctrl + F5`.

## Paso 5 — Probar

1. Abre el sitio y comprueba que los listados aparecen vacíos (si ejecutaste el SQL de reinicio).
2. Abre **Administrar contenido** e inicia sesión con el correo y contraseña de Supabase Auth.
3. Crea un proyecto de prueba, una imagen y un video con URL o archivo.
4. Abre el sitio en otro navegador. El contenido debe aparecer allí también, porque se lee desde Supabase.
5. Elimina el contenido de prueba desde el panel.

## Límites y notas

- El bucket configurado se llama `portfolio-media` y el código limita los videos subidos desde el panel a 50 MB. Para videos más grandes se recomienda YouTube, Vimeo o un enlace HTTPS directo.
- Las imágenes se optimizan a WebP cuando el formato lo permite; GIF y SVG se conservan.
- Los archivos ya cargados a Storage no se borran automáticamente al eliminar el registro de una tabla; revisa Storage si quieres retirar también esos archivos.
- La publishable key está pensada para uso en el navegador. Nunca agregues una `service_role` o secret key al frontend.
- Esta entrega todavía requiere una prueba real en el navegador contra el proyecto Supabase y la publicación en GitHub Pages. La validación local de sintaxis no sustituye esa prueba.
