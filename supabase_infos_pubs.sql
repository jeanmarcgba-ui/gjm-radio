-- =====================================================================
-- GJM Radio — infos défilantes et publicités (à exécuter une seule fois,
-- APRÈS supabase.sql) : Supabase → SQL Editor → New query → Run
-- =====================================================================

-- ---------- Infos défilantes ----------
create table if not exists public.annonces (
  id         uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  texte      text not null check (char_length(texte) between 2 and 300),
  actif      boolean not null default true
);
alter table public.annonces enable row level security;
revoke all on public.annonces from anon, authenticated;
grant select on public.annonces to anon;
grant select, insert, update, delete on public.annonces to authenticated;

drop policy if exists "voir les infos actives" on public.annonces;
create policy "voir les infos actives" on public.annonces
  for select to anon using (actif);

drop policy if exists "administrateur" on public.annonces;
create policy "administrateur" on public.annonces
  for all to authenticated
  using      ((select auth.jwt() ->> 'email') = 'jeanmarcgba@gmail.com')
  with check ((select auth.jwt() ->> 'email') = 'jeanmarcgba@gmail.com');

-- ---------- Publicités ----------
create table if not exists public.pubs (
  id         uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  titre      text not null check (char_length(titre) between 2 and 80),
  texte      text check (texte is null or char_length(texte) <= 200),
  image      text not null check (image ~* '^https://' and char_length(image) <= 600),
  lien       text check (lien is null or (lien ~* '^(https://|tel:|mailto:)' and char_length(lien) <= 600)),
  actif      boolean not null default true,
  fin        date,
  ordre      integer not null default 0
);
alter table public.pubs enable row level security;
revoke all on public.pubs from anon, authenticated;
grant select on public.pubs to anon;
grant select, insert, update, delete on public.pubs to authenticated;

drop policy if exists "voir les pubs en cours" on public.pubs;
create policy "voir les pubs en cours" on public.pubs
  for select to anon using (actif and (fin is null or fin >= current_date));

drop policy if exists "administrateur" on public.pubs;
create policy "administrateur" on public.pubs
  for all to authenticated
  using      ((select auth.jwt() ->> 'email') = 'jeanmarcgba@gmail.com')
  with check ((select auth.jwt() ->> 'email') = 'jeanmarcgba@gmail.com');

-- ---------- Images des pubs (stockage public, 3 Mo max) ----------
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('pubs', 'pubs', true, 3145728, array['image/jpeg','image/png','image/webp','image/gif'])
on conflict (id) do update set public = true, file_size_limit = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "pubs : admin envoie" on storage.objects;
create policy "pubs : admin envoie" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'pubs' and (select auth.jwt() ->> 'email') = 'jeanmarcgba@gmail.com');

drop policy if exists "pubs : admin modifie" on storage.objects;
create policy "pubs : admin modifie" on storage.objects
  for update to authenticated
  using      (bucket_id = 'pubs' and (select auth.jwt() ->> 'email') = 'jeanmarcgba@gmail.com')
  with check (bucket_id = 'pubs' and (select auth.jwt() ->> 'email') = 'jeanmarcgba@gmail.com');

drop policy if exists "pubs : admin supprime" on storage.objects;
create policy "pubs : admin supprime" on storage.objects
  for delete to authenticated
  using (bucket_id = 'pubs' and (select auth.jwt() ->> 'email') = 'jeanmarcgba@gmail.com');
