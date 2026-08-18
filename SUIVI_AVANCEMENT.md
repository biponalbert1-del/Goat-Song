# GOAT SONG - Suivi d'avancement

Derniere mise a jour: 2026-08-16

## Legende

- `[x]` Termine et verifie
- `[~]` En cours ou socle pose
- `[ ]` A faire
- `[!]` Bloque ou decision requise

## Regle de travail

On avance module par module pour garder le projet propre:

1. Choisir un seul module.
2. Lire le besoin dans `README.md`.
3. Coder le module avec une structure claire.
4. Lancer `flutter analyze`.
5. Lancer les tests utiles.
6. Verifier le build Android quand le module touche aux dependances natives.
7. Mettre a jour ce fichier.

## Etat global

- [x] Mise a jour Flutter vers 3.47.0 / Dart 3.13.0.
- [x] Generation du projet Flutter Android/iOS.
- [x] Installation et correction des packages principaux.
- [x] Structure Clean Architecture initiale.
- [x] Build Android debug valide.
- [x] `flutter analyze` sans erreur.
- [x] Tests unitaires initiaux valides.

## Decisions techniques

- Theme par defaut: noir + bleu.
- Theme clair: blanc + couleur secondaire.
- Couleur secondaire: modifiable via disque de selection.
- Fonds d'ecran: images integrees + image locale choisie par l'utilisateur.
- Android minSdk: 26, requis par `media_cast_dlna`.
- Android compileSdk: 36 force sur les modules pour compatibilite AndroidX.
- `metadata_god` retire temporairement: incompatible avec Gradle 9 via CargoKit.
- `on_audio_query_android` est vendore dans `third_party/on_audio_query_android` pour compatibilite AGP moderne.

## Modules

### 1. Socle projet

- [x] `android/` et `ios/` generes.
- [x] `lib/` structure par couches.
- [x] `assets/` structure pour icons, images, wallpapers, languages.
- [x] `test/` initialise.
- [x] `pubspec.yaml` corrige et resolu.

### 2. Theme, couleurs et fonds

- [x] Theme noir/bleu par defaut.
- [x] Theme clair blanc.
- [x] Couleur secondaire via disque de couleur.
- [x] Presets de fonds rendus en Flutter, sans assets manquants.
- [x] Selection d'image locale via `file_picker`.
- [x] Persistence complete et migration de preferences.
- [x] Galerie visuelle premium des fonds.
- [ ] Extraction dynamique depuis pochette album.

### 3. Lecteur principal UI

- [~] Ecran player initial.
- [~] Cassette animee initiale.
- [~] Controles lecture/pause, suivant, precedent, shuffle, repeat visuels.
- [ ] Connexion au vrai moteur audio.
- [ ] Barre de progression reactive.
- [ ] Mini player global.
- [ ] Etats vide, chargement, erreur.

### 4. Moteur audio

- [~] Stubs audio engine crees.
- [~] Crossfade controller de base.
- [~] Sleep timer engine de base.
- [ ] Player A/B avec `just_audio`.
- [ ] Queue de lecture.
- [ ] Play/pause/seek/next/previous.
- [ ] Crossfade reel 5s-45s.
- [ ] Auto-pause casque/appels avec `audio_session`.
- [ ] Background audio avec `audio_service`.

### 5. Fonctions DJ et effets

- [~] Structure equalizer / FX / nightclub.
- [ ] Jingles via `audioplayers`.
- [ ] Mode boite de nuit.
- [ ] Bass boost / virtualizer Android.
- [ ] Presets EQ.
- [ ] Visualiseur audio temps reel.

### 6. Mediatheque locale

- [~] Ecran mediatheque initial.
- [ ] Permissions audio/images.
- [ ] Scan local via `on_audio_query`.
- [ ] Modeles Song, Album, Artist, Playlist.
- [ ] Stockage favoris/statistiques avec Hive.
- [ ] Top played, recently added, recently played.
- [ ] Playlists personnalisables.
- [ ] Navigation par dossiers.

### 7. Recherche globale

- [ ] Barre de recherche globale.
- [ ] Filtre titre, artiste, album, playlist.
- [ ] Resultats instantanes.
- [ ] Etats aucun resultat / chargement.

### 8. Pochettes et metadata

- [ ] Lecture tags audio.
- [ ] Extraction pochette locale.
- [ ] Fallback pochette distante Deezer/LastFM.
- [ ] Cache local pochettes.
- [ ] Editeur tags.
- [!] Remplacer proprement `metadata_god` par une solution compatible Gradle 9.

### 9. Paroles synchronisees

- [~] Stub `LyricsSyncEngine`.
- [ ] Parser LRC.
- [ ] API LRCLIB.
- [ ] Affichage karaoke.
- [ ] Synchronisation avec position audio.
- [ ] Fallback paroles non synchronisees.

### 10. Widgets et lockscreen

- [~] Stubs `widget_engine`.
- [ ] Home widget Android/iOS.
- [ ] Notifications media.
- [ ] Lockscreen avec pochette.
- [ ] Commandes Bluetooth/casque.

### 11. Cast, DLNA et mode voiture

- [~] Packages et permissions de base.
- [ ] Chromecast.
- [ ] DLNA/UPnP.
- [ ] Mode voiture UI.
- [ ] Verification Android Auto / CarPlay.

### 12. Localisation dynamique

- [~] Assets `fr.json` et `en.json`.
- [ ] Loader JSON local.
- [ ] Selection langue.
- [ ] Packs OTA.
- [ ] Cache local des langues.

### 13. Monetisation

- [~] Package AdMob et IDs test configures.
- [ ] Service AdMob.
- [ ] Bannieres discretes.
- [ ] Interstitiels controles.
- [ ] Rewarded ads pour fonctions Pro 24h.
- [ ] Regie directe prioritaire.
- [ ] Pass premium sans pubs.

### 14. Sauvegarde et restauration

- [ ] Export preferences + BDD.
- [ ] Import sauvegarde.
- [ ] ZIP via `archive`.
- [ ] Gestion conflits.

### 15. Qualite et livraison

- [x] `flutter analyze` OK.
- [x] `flutter test` OK.
- [x] APK debug genere.
- [ ] Tests widgets UI.
- [x] Tests unitaires theme/preferences.
- [ ] Tests integration audio.
- [ ] Icones finales.
- [ ] Splash final.
- [ ] Configuration signing release.

## Prochain module propose

Module 3: Lecteur principal UI.

Objectif: transformer l'ecran player initial en interface premium stable avant de connecter le vrai moteur audio.

Taches:

- [ ] Revoir layout mobile du player.
- [ ] Ajouter mini etats piste vide / demo.
- [ ] Ameliorer cassette animee.
- [ ] Ajouter controles visuels pour repeat/shuffle/nightclub.
- [ ] Preparer les callbacks vers le moteur audio.
