# Lagos Media — actualización de portafolio

## Cambios incluidos
- Conserva las galerías actuales de proyectos, videos e imágenes.
- Agrega perfiles profesionales de Facebook, Instagram, YouTube y LinkedIn, presentados en tarjetas con apertura tipo overlay y enlace directo al perfil.
- Agrega certificaciones en PDF o imagen. Las miniaturas de imagen mantienen proporción 4:3; los PDF se abren en el visor del navegador cuando el proveedor permite incrustarlos.
- Amplía el manejo de enlaces de Google Drive, OneDrive/SharePoint y Dropbox. Los enlaces de carpetas se conservan como enlaces externos; los archivos de Drive se intentan previsualizar con su URL de vista.

## Instalación de la actualización
1. Haz una copia de seguridad de los archivos actuales.
2. Sustituye `index.html`, `app.js` y `styles.css` por los de este ZIP. Conserva la carpeta `assets/`.
3. En Supabase > SQL Editor, ejecuta `supabase-migration-social-certifications.sql`.
4. En Supabase > Storage > Buckets > `portfolio-media`, permite `application/pdf` además de los MIME types que ya utilizabas. No elimines los tipos de imagen ni video.
5. Verifica las políticas de Storage existentes. El panel usa la sesión autenticada para subir archivos; el bucket debe permitir la escritura al usuario administrador autorizado.
6. Publica y prueba con sesión de administrador.

## Compatibilidad de Google Drive y OneDrive
- Google Drive: usa enlaces compartidos de archivos (`/file/d/ID/view`) y concede permiso de lector a cualquier persona que deba ver el recurso. El sistema transforma ese formato a una URL de vista para imágenes. Las carpetas se abren en Drive; no se convierten en una galería embebida.
- OneDrive/SharePoint: pega un enlace de uso compartido con permiso de visualización. Los enlaces se conservan y se ofrecen para abrir fuera del portafolio. La previsualización embebida depende del tipo de enlace, de la configuración de Microsoft y de las políticas de cookies/iframe del navegador. Los enlaces cortos `1drv.ms` no siempre pueden convertirse de forma segura a una URL directa desde el navegador.
- Para portadas o imágenes que deban aparecer como miniatura, lo más fiable es subir el archivo al bucket `portfolio-media` o usar una URL directa pública de imagen. Los enlaces a carpetas no son archivos de imagen.
- Si un archivo no es público o requiere iniciar sesión, los visitantes deberán autenticarse en el proveedor. No se puede saltar esa restricción desde el sitio.

## Seguridad
La migración crea políticas públicas de lectura únicamente para filas marcadas `published=true` y políticas de escritura para usuarios autenticados. Si el proyecto requiere restringir escrituras solo a un usuario administrador concreto, conserva o adapta la política de administrador que ya utilizabas; no amplíes permisos de forma indiscriminada. No compartas claves `service_role` en el frontend.

## Pruebas realizadas
Esta entrega contiene cambios de código y una migración SQL. La integración en vivo con Google Drive/OneDrive no puede certificarse sin probar enlaces reales con los permisos de cada cuenta. Ejecuta la migración antes de desplegar; sin esas tablas, la carga pública de contenido devolverá error.


## Corrección de guardado en Redes

Se corrigió la inserción del formulario de administración. Antes, al guardar un perfil social, el código enviaba `social` como nombre de tabla (`sb.from(tab)`), aunque la tabla real definida por la migración es `public.social_profiles`. Ahora la inserción usa el mismo mapeo que las consultas, edición y eliminación: `tableName()`.

No es necesario crear una tabla llamada `public.social`. La tabla correcta es `public.social_profiles`. Si la migración anterior ya se ejecutó y la sección Redes carga correctamente, basta con reemplazar `app.js` y publicar la actualización. Si aún no se ejecutó, ejecuta primero `supabase-migration-social-certifications.sql` en Supabase SQL Editor.


## Mejora de vista previa de redes sociales
Los perfiles de Instagram, Facebook, YouTube y LinkedIn ya no se cargan en un iframe vacío. El overlay muestra una tarjeta de perfil con plataforma, descripción y enlace directo. Esto evita el área blanca causada por `about:blank` y por las políticas anti-iframe de las redes sociales. Los sitios web y los PDF mantienen su vista previa integrada.


## Ajustes solicitados (noviembre 2026)
- Los perfiles sociales publicados ahora también aparecen dentro de "Todo el trabajo" y en el filtro "Redes" de Proyectos.
- Al abrir un perfil social, el overlay intenta cargar la URL real dentro del iframe y mantiene un botón visible para abrir el perfil en una pestaña nueva.
- Nota importante: Instagram, Facebook y LinkedIn pueden impedir la carga en iframe mediante políticas del propio proveedor (X-Frame-Options / Content-Security-Policy). Ningún cambio en el sitio puede anular esas restricciones del navegador/proveedor; en esos casos el botón externo es la vía fiable.
- Se añadieron reglas responsive para evitar desbordamiento horizontal en móvil y mantener el botón flotante de WhatsApp por encima del contenido, respetando las áreas seguras del dispositivo.
