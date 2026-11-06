-- Lagos Media: tablas adicionales para perfiles sociales y certificaciones.
-- Ejecutar una sola vez en Supabase > SQL Editor antes de publicar la versión nueva.
create table if not exists public.social_profiles (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  platform text not null check (platform in ('facebook','instagram','youtube','linkedin')),
  profile_url text not null,
  description text,
  published boolean not null default true,
  display_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create table if not exists public.certifications (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  issuer text,
  issued_at text,
  description text,
  file_url text not null,
  mime_type text not null,
  published boolean not null default true,
  display_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
alter table public.social_profiles enable row level security;
alter table public.certifications enable row level security;
drop policy if exists "Public can read published social profiles" on public.social_profiles;
create policy "Public can read published social profiles" on public.social_profiles
  for select using (published = true);
drop policy if exists "Authenticated users manage social profiles" on public.social_profiles;
create policy "Authenticated users manage social profiles" on public.social_profiles
  for all to authenticated using (true) with check (true);
drop policy if exists "Public can read published certifications" on public.certifications;
create policy "Public can read published certifications" on public.certifications
  for select using (published = true);
drop policy if exists "Authenticated users manage certifications" on public.certifications;
create policy "Authenticated users manage certifications" on public.certifications
  for all to authenticated using (true) with check (true);

-- El bucket portfolio-media debe permitir PDF además de imágenes y video.
-- Si el bucket ya existe, actualizar desde Storage > Buckets > portfolio-media:
-- Allowed MIME types: image/*, video/mp4, video/webm, video/ogg, application/pdf
-- File size limit recomendado: 50 MB (certificaciones: el panel limita a 20 MB).
