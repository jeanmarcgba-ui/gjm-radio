-- =====================================================================
-- GJM Radio — pubs vidéo et audio (à exécuter une seule fois,
-- APRÈS supabase_infos_pubs.sql) : Supabase → SQL Editor → New query → Run
-- =====================================================================

-- Type de pub (image, vidéo, audio) et lien du fichier vidéo/audio
alter table public.pubs add column if not exists media text not null default 'image';
alter table public.pubs add column if not exists media_url text;
alter table public.pubs alter column image drop not null;

alter table public.pubs drop constraint if exists pubs_media_check;
alter table public.pubs add constraint pubs_media_check check (media in ('image','video','audio'));

alter table public.pubs drop constraint if exists pubs_media_url_check;
alter table public.pubs add constraint pubs_media_url_check
  check (media_url is null or (media_url ~* '^https://' and char_length(media_url) <= 600));

-- Une pub image a une image ; une pub vidéo ou audio a un fichier
alter table public.pubs drop constraint if exists pubs_contenu_check;
alter table public.pubs add constraint pubs_contenu_check
  check ((media = 'image' and image is not null) or (media in ('video','audio') and media_url is not null));

-- Stockage : fichiers jusqu'à 20 Mo, images + vidéos + audios
update storage.buckets
set file_size_limit = 20971520,
    allowed_mime_types = array['image/jpeg','image/png','image/webp','image/gif',
      'video/mp4','video/webm','video/quicktime',
      'audio/mpeg','audio/mp3','audio/mp4','audio/aac','audio/ogg','audio/wav','audio/webm']
where id = 'pubs';
