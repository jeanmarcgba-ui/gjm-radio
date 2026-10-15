-- =====================================================================
-- GJM Radio — base des chaînes partenaires (Supabase)
-- À coller dans Supabase → SQL Editor → New query → Run (une seule fois)
-- =====================================================================

create table if not exists public.chaines (
  id            uuid primary key default gen_random_uuid(),
  created_at    timestamptz not null default now(),
  type          text not null check (type in ('radio','tv')),
  nom           text not null check (char_length(nom) between 2 and 80),
  mode          text not null default 'lien' check (mode in ('lien','studio')),
  lien          text check (lien is null or (lien ~* '^https://' and char_length(lien) <= 500)),
  logo          text check (logo is null or (logo ~* '^https://' and char_length(logo) <= 500)),
  categorie     text check (categorie is null or char_length(categorie) <= 40),
  description   text check (description is null or char_length(description) <= 500),
  contact_nom   text not null check (char_length(contact_nom) between 1 and 80),
  contact_tel   text not null check (char_length(contact_tel) between 4 and 30),
  contact_email text check (contact_email is null or char_length(contact_email) <= 120),
  cle_diffusion text,
  statut        text not null default 'attente' check (statut in ('attente','valide','refuse'))
);

alter table public.chaines enable row level security;

-- Droits par colonne : le public ne peut ni lire les contacts ni la clé de diffusion,
-- et ne peut pas choisir lui-même le statut d'une demande.
revoke all on public.chaines from anon, authenticated;
grant insert (type, nom, mode, lien, logo, categorie, description, contact_nom, contact_tel, contact_email)
  on public.chaines to anon, authenticated;
grant select (id, type, nom, lien, logo, categorie, description, statut) on public.chaines to anon;
grant select, update, delete on public.chaines to authenticated;

-- 1) Tout le monde peut PROPOSER une chaîne (elle arrive « en attente »)
drop policy if exists "proposer une chaine" on public.chaines;
create policy "proposer une chaine" on public.chaines
  for insert to anon, authenticated
  with check (statut = 'attente' and cle_diffusion is null);

-- 2) Le public voit seulement les chaînes validées (colonnes publiques uniquement)
drop policy if exists "voir les chaines validees" on public.chaines;
create policy "voir les chaines validees" on public.chaines
  for select to anon
  using (statut = 'valide' and lien is not null);

-- 3) Seul l'administrateur (ce compte e-mail) peut tout lire, valider, modifier, supprimer
drop policy if exists "administrateur" on public.chaines;
create policy "administrateur" on public.chaines
  for all to authenticated
  using      ((select auth.jwt() ->> 'email') = 'jeanmarcgba@gmail.com')
  with check ((select auth.jwt() ->> 'email') = 'jeanmarcgba@gmail.com');

-- 4) Liste publique utilisée par l'appli (respecte les règles ci-dessus)
create or replace view public.chaines_publiques with (security_invoker = true) as
  select id, type, nom, lien, logo, categorie, description
  from public.chaines
  where statut = 'valide' and lien is not null;

grant select on public.chaines_publiques to anon;
