# GJM Radio — guide d'installation

Application installable (PWA) avec deux modes :
- **Radio** : radios FM de Côte d'Ivoire, d'Afrique, de France et du monde en direct.
- **Télé** : chaînes de télé gratuites diffusées en direct sur internet (RTI 1, chaînes ivoiriennes, africaines, France 24, Africa 24, TV5Monde…).

## Contenu du dossier

| Fichier | Rôle |
|---|---|
| index.html | L'application complète |
| manifest.webmanifest | Nom, couleurs et icônes pour l'installation |
| sw.js | Garde l'appli ouvrable sans connexion |
| icon-192.png, icon-512.png, icon-maskable-512.png | Icônes de l'appli (votre logo) |
| logo.png | Logo affiché dans l'appli |
| programme.json | Les programmes des chaînes et radios (à compléter, voir plus bas) |
| config.json | Lien vers votre base Supabase pour l'espace « Diffuser » (à remplir, voir DIFFUSER.md) |
| supabase.sql | Script à coller une fois dans Supabase (pas utilisé par l'appli elle-même) |
| supabase_infos_pubs.sql | 2e script à coller une fois dans Supabase : infos défilantes et publicités |
| supabase_pubs_media.sql | 3e script à coller une fois dans Supabase : pubs vidéo et audio |
| DIFFUSER.md | Guide de l'espace « Diffuser » : partenaires, administration, Studio direct |

## Mise en ligne sur GitHub Pages (étape par étape)

1. Connectez-vous sur github.com avec le compte **jeanmarcgba-ui**.
2. Cliquez sur **+** (en haut à droite) → **New repository**.
3. Nom du dépôt : `gjm-radio`. Cochez **Public**. Cliquez **Create repository**.
4. Sur la page du dépôt vide, cliquez **uploading an existing file**.
5. Décompressez `gjm-radio.zip` sur votre ordinateur, puis glissez **les 14 fichiers** (pas le dossier) dans la zone d'envoi.
6. En bas, cliquez **Commit changes**.
7. Allez dans **Settings** → **Pages** (menu de gauche).
8. Sous **Branch**, choisissez `main` et le dossier `/ (root)`, puis **Save**.
9. Attendez 1 à 2 minutes et rechargez la page : le lien apparaît en haut :
   `https://jeanmarcgba-ui.github.io/gjm-radio/`

## Installer l'appli sur le téléphone

1. Ouvrez le lien ci-dessus dans Kiwi Browser ou Chrome.
2. Touchez le bouton **Installer l'appli** en haut de l'écran
   (ou menu ⋮ → **Installer l'application** / **Ajouter à l'écran d'accueil**).
3. L'icône GJM Radio apparaît sur l'écran d'accueil comme une vraie appli.

## Utilisation

- **Infos défilantes et publicités** : vous publiez depuis l'Espace administrateur une bande d'infos qui défile en haut de l'appli et des pubs (image, vidéo ou audio, avec un lien) affichées dans un carré sous le lecteur. Les utilisateurs peuvent couper le son des pubs. Voir **DIFFUSER.md**.
- **Diffuser** (bouton en haut à droite) : d'autres personnes proposent leur radio ou leur télé, ou diffusent en direct depuis leur téléphone (Studio direct). Vous validez dans l'**Espace administrateur** (lien en bas de l'appli), puis la chaîne apparaît dans l'onglet **Partenaires**. Mise en route : voir **DIFFUSER.md**.
- **Radio / Télé** : le grand bouton en haut passe d'un mode à l'autre. Favoris, récentes et chaînes ajoutées sont séparés pour chaque mode.
- **Plein écran** (mode Télé) : bouton à droite des commandes, ou double-touche sur l'image. Le téléphone passe à l'horizontale.
- **Onglets Radio** : Côte d'Ivoire, Partenaires, Afrique, France, Sport, Monde, Favoris, Récentes, Mes radios.
- **Onglets Télé** : TNT, Partenaires, Côte d'Ivoire, Afrique, France & Info, Sport, Documentaires, Séries, Films & Nollywood, Favoris, Récentes, Mes chaînes. Dans Sport, Documentaires, Séries et Films, les chaînes en français sont en tête, puis celles en anglais.
- **TNT** : les 7 chaînes de la TNT ivoirienne, dans l'ordre des canaux.
  - RTI 1 et 7 Info : direct dans l'appli (si le direct de RTI 1 ne répond pas, un bouton ouvre RTI Play).
  - RTI 2 et La 3 : bouton « Regarder sur RTI Play », la plateforme officielle et gratuite de la RTI.
  - NCI : bouton « Regarder sur nci.ci », son site officiel.
  - A+ Ivoire et Life TV : pas de direct gratuit officiel sur internet (elles passent par Canal+ et Orange TV). L'appli l'explique. Si elles publient un jour un lien de direct public, ajoutez-le dans « Mes chaînes ».
- **Seulement les chaînes qui marchent** : à l'ouverture d'un onglet télé, l'appli teste chaque chaîne depuis le téléphone et n'affiche que celles qui répondent (« 12 en marche · test 30/80 » pendant le test). Le résultat est gardé 6 heures, donc les ouvertures suivantes sont immédiates. Une chaîne en panne est retestée 2 heures plus tard et revient toute seule si elle remarche.
- **Coupures** : si une chaîne coupe pendant qu'on la regarde, l'appli tente de reprendre automatiquement (« Reconnexion… »), puis essaie ses autres liens. Si rien ne marche, la chaîne est retirée de la liste.
- **Contenu pour adultes** : aucune chaîne pour adultes n'est proposée. Un filtre supplémentaire bloque tout nom ou catégorie de ce type, en télé comme en radio.
- **Onglet 18+ (privé)** : dernier onglet du mode Télé. Il est vide au départ : vous y ajoutez vous-même vos liens. Il est protégé par un code :
  1. Touchez **18+**, créez un code de 4 à 8 chiffres, cochez « J'ai 18 ans ou plus », puis **Créer le code**.
  2. Ajoutez vos liens (nom + adresse https du direct). Chaque lien est testé : seuls ceux qui marchent s'affichent.
  3. **Afficher aussi les liens en panne** montre tous vos liens, pour supprimer ceux qui ne marchent plus.
  4. L'onglet se reverrouille quand vous changez d'onglet, quand vous quittez l'appli, après 15 minutes, ou avec le bouton **Verrouiller**.
  5. Ces chaînes n'apparaissent ni dans Récentes, ni dans la recherche, ni sur l'écran de verrouillage du téléphone.
  6. Code oublié : touchez « Code oublié ? Tout effacer » deux fois. Le code et tous les liens 18+ sont supprimés.
- **Langue** (bouton sous le volume) : en télé, choisissez la langue du son et les sous-titres quand la chaîne en propose, ou passez à la même chaîne dans une autre langue (ex. France 24 English → France 24 Français). En radio, l'appli propose des stations du même genre dans votre langue. Votre langue préférée est retenue. Une traduction automatique en direct n'est pas possible.
- **Qualité** (mode Télé) : le bouton « Qualité » sous le volume ouvre le choix : Auto (selon la connexion), Économie 360p, Moyenne 480p, HD 720p, Full HD 1080p. Le choix est gardé pour toutes les chaînes. Si une chaîne n'existe pas dans la qualité choisie, l'appli prend la plus proche en dessous. Certaines chaînes n'ont qu'une seule qualité : l'appli l'indique.
- **Programme** : le bouton « Programme » affiche la grille du jour et des 6 jours suivants pour la chaîne ou la radio choisie. Ce qui passe en ce moment s'affiche aussi sous le nom de la chaîne et dans la liste.
- **Recherche** : tapez le nom d'une radio (Nostalgie, RFI, Fréquence 2…).
- **Étoile** : ajoute une radio aux favoris.
- **Horloge** : minuterie d'arrêt (15, 30, 60, 90 min ; touchez plusieurs fois pour changer, une dernière fois pour désactiver).
- **Mes radios / Mes chaînes** : ajoutez une radio ou une télé absente des listes (radio paroissiale, télé d'un client…) avec son nom et le lien https de son direct (pour la télé, un lien qui finit en .m3u8).
- Le son continue écran éteint, avec les commandes sur l'écran de verrouillage.

## Remplir les programmes (fichier programme.json)

Aucun service gratuit ne fournit automatiquement les programmes des chaînes ivoiriennes. Les programmes se mettent donc dans le fichier `programme.json`, que vous modifiez directement sur GitHub. Au départ, il ne contient que les journaux de 13h et 20h de RTI 1 : vérifiez ces horaires et complétez.

1. Sur github.com, ouvrez le dépôt `gjm-radio`, puis cliquez sur le fichier **programme.json**.
2. Cliquez sur le crayon ✏️ (**Edit this file**) en haut à droite du fichier.
3. Ajoutez ou modifiez les émissions en suivant ce modèle :

```json
{
  "tele": {
    "RTI 1": [
      { "jours": "tous", "debut": "13:00", "fin": "13:30", "titre": "Journal de 13h" },
      { "jours": "tous", "debut": "20:00", "fin": "20:45", "titre": "Journal de 20h" },
      { "jours": "sam", "debut": "21:00", "fin": "22:30", "titre": "Film du samedi", "info": "Comédie ivoirienne" }
    ],
    "Ecclesia TV": [
      { "jours": "dim", "debut": "09:00", "fin": "11:00", "titre": "Messe du dimanche" }
    ]
  },
  "radio": {
    "Nom exact de la radio": [
      { "jours": "lun-ven", "debut": "07:00", "fin": "08:00", "titre": "Le réveil" }
    ]
  }
}
```

4. Règles à respecter :
   - Le nom de la chaîne s'écrit comme dans l'appli (les majuscules et les accents ne comptent pas).
   - Heures d'Abidjan au format `20:00`. Une émission peut passer minuit (ex. `23:30` → `01:00`).
   - `jours` : `tous`, `lun-ven`, `sam-dim`, ou une liste comme `lun,mer,ven`. Jours : lun, mar, mer, jeu, ven, sam, dim.
   - `info` est facultatif (petite description sous le titre).
   - Gardez les guillemets `"`, les virgules entre les lignes, et aucune virgule après la dernière ligne d'une liste.
5. En bas, cliquez **Commit changes**. Les téléphones voient le nouveau programme à la prochaine ouverture de l'appli (comptez 1 à 2 minutes).

Si l'appli n'affiche plus aucun programme après une modification, c'est qu'il manque une virgule ou un guillemet : vérifiez le fichier sur https://jsonlint.com.

## Bon à savoir

- Il faut une connexion internet. Consommation approximative : radio ≈ 60 Mo par heure, télé ≈ 300 Mo à 1 Go par heure selon la qualité.
- La liste des stations vient de l'annuaire libre Radio Browser. Si une radio ne répond pas, c'est que son flux est arrêté ou ne diffuse pas en https : essayez-en une autre.
- Les catégories (Sport, Documentaires, Séries, Films) ne contiennent que des chaînes gratuites. Les grandes chaînes de sport (Canal+ Sport, beIN Sports principales, NBA…) et de Nollywood (Africa Magic, ROK, Nollywood TV) sont payantes et n'y sont donc pas. Certaines chaînes gratuites (Pluto TV, par exemple) peuvent être bloquées selon le pays : l'appli l'indique alors comme indisponible.
- La télé ne contient que des chaînes **gratuites** diffusées publiquement. Les chaînes payantes (bouquets Canal+, etc.) ne sont pas incluses et ne doivent pas être ajoutées : les diffuser sans droits est illégal, surtout dans une appli vendue.
- Certaines chaînes n'émettent pas 24h/24 (indiqué dans la liste) ou changent de lien. Si un lien ne marche pas, l'appli essaie automatiquement les autres liens de la chaîne. La liste se met à jour toute seule.
- Pour une mise à jour : renvoyez le nouveau `index.html` dans le dépôt, et dans `sw.js` changez `gjm-radio-v16` en `gjm-radio-v17` (puis v18, etc.). Ce n'est pas nécessaire quand vous modifiez seulement `programme.json`.

## Si un onglet reste vide après une mise à jour

1. Vérifiez sur GitHub que les 9 fichiers sont bien dans le dépôt et datent tous de la même mise à jour.
2. Dans Kiwi ou Chrome : menu ⋮ → **Paramètres** → **Paramètres des sites** → **Stockage** (ou « Toutes les données des sites »), cherchez `github.io` et effacez ses données. Vos favoris de l'appli seront remis à zéro.
3. Fermez complètement l'appli, puis rouvrez-la. Les onglets Sport, Documentaires et Séries mettent quelques secondes à se remplir sur une connexion lente.
