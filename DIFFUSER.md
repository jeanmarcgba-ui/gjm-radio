# GJM Radio — activer l'espace « Diffuser » (chaînes partenaires)

Avec cet espace, d'autres personnes peuvent proposer leur radio ou leur télé dans GJM Radio :

- **Avec un lien existant** : elles donnent le lien de leur direct.
- **Depuis leur téléphone** : le **Studio direct** envoie la caméra et le micro du téléphone en direct.

Vous validez chaque demande dans l'**Espace administrateur**. Une fois validée, la chaîne apparaît dans l'onglet **Partenaires**, chez tous les utilisateurs.

Ce qu'il faut : un compte **Supabase**, gratuit, pour les demandes. Et seulement pour le Studio direct : un compte **Livepeer Studio** (gratuit jusqu'à 1 000 minutes de direct par mois) ou **Cloudflare Stream** (à partir de 5 $ par mois).

---

## Étape 1 — Créer la base Supabase (une seule fois)

1. Allez sur **supabase.com** et connectez-vous.
2. Cliquez **New project**. Nom : `gjm-radio`. Choisissez un mot de passe et la région **Europe (Frankfurt ou Paris)**. Cliquez **Create new project** et attendez 2 minutes.
3. Dans le menu de gauche, ouvrez **SQL Editor**, puis **New query**.
4. Ouvrez le fichier `supabase.sql`, copiez **tout** son contenu et collez-le dans la fenêtre.
5. Cliquez **Run**. Le message « Success. No rows returned » doit apparaître.

> Le fichier donne les droits d'administrateur au compte **jeanmarcgba@gmail.com**. Pour utiliser un autre e-mail, remplacez-le aux 2 endroits du fichier **avant** de cliquer Run.

## Étape 2 — Créer votre compte administrateur

1. Dans Supabase, menu de gauche : **Authentication**, puis **Users**.
2. Cliquez **Add user**, puis **Create new user**.
3. E-mail : `jeanmarcgba@gmail.com`. Choisissez un mot de passe solide. Cochez **Auto Confirm User**.
4. Cliquez **Create user**.

C'est avec cet e-mail et ce mot de passe que vous vous connecterez dans l'appli.

## Étape 3 — Relier l'appli à Supabase

1. Dans Supabase : **Project Settings** (roue dentée), puis **API** (ou **Data API**).
2. Copiez :
   - **Project URL**, par exemple `https://abcdxyz.supabase.co` ;
   - la clé **anon public**, une longue suite qui commence par `eyJ…`. Si votre projet affiche plutôt une clé **publishable**, qui commence par `sb_publishable_…`, prenez celle-là.
   - **Ne prenez jamais la clé « service_role » ni la clé « secret ».**
3. Sur GitHub, dans le dépôt `gjm-radio`, ouvrez **config.json**, puis cliquez le crayon ✏️.
4. Collez les deux valeurs entre les guillemets :

```json
{
  "supabaseUrl": "https://abcdxyz.supabase.co",
  "supabaseKey": "eyJhbGciOi..."
}
```

5. Cliquez **Commit changes**. Après 2 minutes, l'espace est actif.

La clé « anon » peut être publique : la base ne laisse le public que **proposer** une chaîne et **voir** les chaînes validées. Les contacts et les clés de diffusion restent visibles par vous seul.

---

## Utilisation au quotidien

### Ce que fait un partenaire
1. Il ouvre GJM Radio et touche **Diffuser**, en haut à droite.
2. Dans **Proposer ma chaîne**, il remplit le nom, le type (radio ou télé), la catégorie, son contact, puis :
   - « J'ai déjà un lien de direct » : il colle son lien (pour la télé, l'appli vérifie que le lien répond) ;
   - « Je veux diffuser depuis mon téléphone » : pas de lien à donner.
3. Il touche **Envoyer ma demande**.

### Ce que vous faites
1. En bas de l'appli, touchez **Espace administrateur**, puis connectez-vous.
2. L'onglet **En attente** liste les demandes, avec le nom et le téléphone du demandeur.
3. **Tester le lien** lance la chaîne dans le lecteur pour vérifier qu'elle passe.
4. **Valider** : la chaîne apparaît dans **Partenaires** pour tout le monde. Il faut un lien de lecture pour valider.
5. **Refuser** ou **Supprimer** si la chaîne ne convient pas (contenu interdit, chaîne copiée sans droits…).
6. Vous pouvez corriger le lien ou le logo à tout moment, puis cliquer **Enregistrer**.

---

## Studio direct : diffuser depuis le téléphone

Pour chaque partenaire « Studio », vous lui créez un direct chez le service de diffusion. Vous mettez ensuite 2 liens dans sa demande.

### Avec Livepeer Studio (gratuit pour commencer)
1. Créez un compte sur **livepeer.studio**.
2. Allez dans **Streams**, puis **Create stream**. Donnez le nom de la chaîne du partenaire.
3. Sur la page du stream, notez :
   - la **Stream key** ;
   - le lien de lecture **HLS** (il se termine par `.m3u8`).
4. Dans l'Espace administrateur de GJM Radio, sur la demande du partenaire :
   - **Clé de diffusion** : `https://livepeer.studio/webrtc/` suivi de la Stream key ;
     exemple : `https://livepeer.studio/webrtc/abcd-1234-efgh-5678` ;
   - **Lien de lecture** : le lien HLS `.m3u8`.
5. Cliquez **Valider**, puis **Copier la clé**, et envoyez cette clé au partenaire par WhatsApp. Elle est privée : quiconque l'a peut diffuser sur cette chaîne.

### Avec Cloudflare Stream (payant, très stable)
1. Dans Cloudflare : **Stream**, puis **Live inputs**, puis **Create live input**.
2. Copiez le lien **WebRTC (WHIP)**, qui se termine par `/webRTC/publish`. C'est la **clé de diffusion**.
3. Copiez le lien **HLS**, qui se termine par `.m3u8`. C'est le **lien de lecture**.
4. Même suite que pour Livepeer : collez les 2 liens, Valider, Copier la clé, envoyer au partenaire.

### Ce que fait le partenaire pour passer en direct
1. GJM Radio, puis **Diffuser**, puis **Studio direct**.
2. Il colle sa clé de diffusion. Elle reste enregistrée sur son téléphone.
3. Il choisit **Télé** (caméra + micro) ou **Radio** (micro seul), et la caméra avant ou arrière.
4. Il touche **Démarrer le direct** et autorise la caméra et le micro.
5. Le badge rouge **EN DIRECT** et un chronomètre s'affichent. Les auditeurs le voient dans **Partenaires**, avec 5 à 20 secondes de décalage.
6. Pendant le direct, il garde l'appli ouverte et l'écran allumé, de préférence en Wi-Fi.
7. Pour finir, il touche **Arrêter le direct**.

---

## Bon à savoir
- **Données mobiles** : un direct télé consomme environ 500 Mo à 1 Go par heure chez le diffuseur, et un direct radio environ 30 Mo par heure.
- **Coûts** : avec Livepeer, au-delà de 1 000 minutes par mois ou de 100 spectateurs, le service devient payant. Surveillez votre tableau de bord.
- **Responsabilité** : vous êtes l'éditeur de l'appli. Validez seulement les chaînes dont le partenaire détient les droits ; la case « Je certifie » du formulaire le lui fait confirmer. Refusez toute chaîne copiée d'une chaîne payante.
- **Plusieurs administrateurs** : il faut modifier le fichier `supabase.sql`. Demandez-moi et je vous prépare la version.
