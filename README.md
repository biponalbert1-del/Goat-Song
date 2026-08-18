# GOAT SONG

GOAT SONG est le socle Flutter d'un lecteur musical premium: theme bleu/noir, lecteur cassette anime, mediatheque, reglages DJ, egaliseur et paroles synchronisees.

## Etat actuel

- Interface Flutter sans dependances externes pour rester facile a lancer.
- Ecran principal utilisable avec cassette animee, controles, mini-mediatheque, equalizer et crossfade.
- Architecture preparee pour ajouter le vrai moteur audio, Deezer/LRCLIB, AdMob, Firebase et stockage local.

## Lancement

Le SDK Flutter local doit contenir `dart.exe`. Ensuite:

```powershell
flutter pub get
flutter run
```
Projet Goat Song : LECTEUR MUSICAL AUDIO-PRO ("CASSETTE CLUB PLAYER")

    Rôle de l'IA : Tu es un Architecte Logiciel Senior et un Expert Développeur Flutter/Mobile. Ton objectif est de concevoir et coder un lecteur de musique mobile ultra-fluide, haute performance, moderne et entièrement monétisé pour Android et iOS.

1. VISION GÉNÉRALE & CONCEPT DE L'APPLICATION

L'application est un lecteur de musique local offline combinant l'esthétique rétro d'une cassette audio animée avec la puissance d'un moteur audio DJ avancé (Crossfade, effets, égaliseur) et une intelligence visuelle (thème dynamique basé sur la pochette).

Elle est conçue pour fonctionner de manière fluide, en multilingue (avec téléchargement dynamique), tout en intégrant une monétisation hybride (AdMob + Régie directe).
2. FONCTIONNEMENT ET SPÉCIFICATIONS DES MODULES
A. Moteur Audio & Fonctions DJ ("Audio Engine")

    Double Lecteur & Crossfade Dynamique (Fondu enchaîné) :

        Deux instances de lecteur audio (Player A et Player B) tournant en parallèle pour supprimer tout blanc entre deux pistes.

        L'utilisateur définit un seuil de chevauchement configurable par curseur (de 5s à 45s).

        Calcul en temps réel : Dès que Temps restant≤Seuil choisi, le Player B démarre avec un Fade-In pendant que le Player A effectue un Fade-Out.

    Jingles / SoundFX Injector :

        Un moteur secondaire (FX Player) permet d'intercaler un son de transition (Alarme, Claquement de doigts, Scratch DJ, etc.) pile au moment du croisement des deux chansons.

    Bouton Casque : "Mode Ambiance Boîte de Nuit" :

        Un bouton dédié en forme de casque sur le lecteur principal.

        Lorsqu'il est activé, il applique un effet DSP de Réverbération Spatiale (Reverb) + Bass Boost simulant l'acoustique d'un club/night-club.

    Égaliseur Graphique N-Bandes :

        Contrôle des bandes de fréquences (60Hz à 14kHz), amplification des basses (Bass Boost) et effets 3D (Virtualizer).

        Gestion de presets (Rock, Pop, Jazz, Bass Booster, Club, etc.).

        Visualiseur d'ondes audio réactif en temps réel.

    Gestion Intelligente de la Lecture & Modes :

        Bouton Mode : Lecture normale, Répéter tout, Répéter 1 titre (Loop), et Mode Aléatoire (Shuffle) intelligent sans doublons.

        Auto-pause lors de la déconnexion du casque (Événement becomingNoisy) ou d'un appel téléphonique entrant, avec reprise automatique.

        Minuteur de Veille (Sleep Timer) avec option de Fondu Progressif (Sleep Fade) : baisse le volume de 100% à 0% de façon fluide pendant les 30 dernières secondes avant la mise en pause.

B. Visuel Intelligents, Cassette Animée & Paroles

    Pochette & Cassette Animée en Rotation :

        L'écran de lecture principal affiche un visuel de cassette audio vintage dont les rouleaux tournent en rythme pendant la lecture.

        L'image de la pochette d'album est "gravée" au centre du sticker de la cassette.

    Téléchargement Automatique de Pochette Manquante :

        Si le fichier MP3/audio local n'a pas d'image intégrée, l'application interroge automatiquement l'API Deezer/Last.FM via la combinaison Artiste + Titre.

        L'image téléchargée est sauvegardée en cache local pour la cassette.

    Thème Dynamique Réactif (PaletteGenerator) :

        L'application analyse les pixels de la pochette d'album (locale ou téléchargée).

        Elle extrait la couleur dominante et d'accentuation pour générer dynamiquement le dégradé d'arrière-plan de l'interface et la couleur des boutons principaux.

    Paroles Synchronisées (.LRC) :

        Extraction des paroles intégrées aux tags ID3 (USLT/SYLT) ou recherche automatique hors-ligne/en ligne via l'API LRCLIB (avec fallback sur Genius).

        Défilement automatique du texte avec surbrillance ligne par ligne en fonction du temps actuel de la musique.

C. Médiathèque Complexe, Recherche & Ergonomie

    Médiathèque Intelligente (Stockage Hive) :

        Toutes les chansons : Avec menus de tri (Par A-Z, Par Date d'ajout, Par Durée, Par Popularité).

        Les plus jouées (Top Played) : Incrémente un compteur à chaque écoute > 30s.

        Ajoutés récemment : Trié par date de découverte sur le stockage.

        Lus récemment : Historique des 50 derniers morceaux écoutés.

        Favoris : Gestion par icône Cœur.

        Albums & Artistes : Vues en grilles et listes dédiées.

        Playlists : Création, modification et réorganisation personnalisée.

    Recherche Globale Instantanée :

        Barre de recherche accessible partout, filtrant en temps réel par Titre, Artiste, Album et Playlist.

    Widget Écran d'Accueil (Home Screen Widget) :

        Widget natif (Android/iOS) affichant la pochette actuelle, le titre, l'artiste et les contrôles (Play/Pause/Suivant).

    Notifications Interactives & Écran de Verrouillage (Lockscreen) :

        Affichage de la pochette grand format sur l'écran de verrouillage via AudioService.

        Contrôles complets dans la barre de notification (Progression, Favoris, Play/Pause/Suivant).

        Prise en charge complète des commandes Bluetooth / Casque volant voiture.

D. Multilingue Dynamique & Mises à Jour

    Dynamic Localization (Pack de Langues Téléchargeables OTA) :

        L'application s'ouvre dans la langue du système ou propose un sélecteur de langues.

        Les packs de langues sont des fichiers JSON téléchargés à la demande depuis un serveur/CDN et stockés en cache local sans nécessiter de republier l'app sur les Stores.

    In-App Updates :

        Notification directe dans l'application lorsqu'une nouvelle version de l'application est disponible sur le Google Play Store / App Store.

E. Monétisation Hybride

    Google AdMob :

        Bannières discrètes en bas des listes de la médiathèque.

        Interstitiels déclenchés lors de transitions naturelles (ex: tous les 6 changements de piste).

        Vidéos Récompensées (Rewarded Ads) : Permettent de débloquer le Mode Boîte de nuit (Casque) ou l'Égaliseur Pro gratuitement pendant 24 heures.

    Régie Directe / Sponsor Local :

        Module prioritaire capable d'afficher la bannière d'un annonceur local vendu en direct avant de basculer sur AdMob.

    Modèle Freemium / Pass Pro :

        In-App Purchase pour désactiver 100 % des publicités.

3. LISTE DES FRAMEWORKS ET DÉPENDANCES (pubspec.yaml)
YAML

name: cassette_club_player
description: Lecteur audio complet, rétro et intelligent avec monétisation.

environment:
  sdk: ">=3.0.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter

  # --- ARCHITECTURE & STATE MANAGEMENT ---
  flutter_bloc: ^8.1.3         # Gestion d'état robuste (Clean Architecture)
  get_it: ^7.6.0               # Injection de dépendances (Service Locator)

  # --- MOTEUR AUDIO, EFFETS & CASSETTE ---
  just_audio: ^0.9.36          # Moteur Audio principal & Crossfade bi-lecteur
  audioplayers: ^5.2.1         # Moteur secondaire pour Jingles/FX
  audio_service: ^0.18.12      # Arrière-plan, Lockscreen & Notifications
  audio_session: ^0.1.18       # Détection casque débranché & interruptions appels
  equalizer_flutter: ^1.1.0    # Égaliseur natif, Bass Boost, Virtualizer

  # --- WIDGET & INTERACTIONS NATIVES ---
  home_widget: ^0.6.0          # Widget Écran d'accueil Android & iOS

  # --- THÈME DYNAMIQUE & GRAPHISME ---
  palette_generator: ^0.3.3+3  # Extraction des couleurs de la pochette
  cached_network_image: ^3.3.1 # Cache des pochettes web téléchargées
  flutter_spinkit: ^5.2.0      # Animations pour la cassette et chargeurs

  # --- TÉLÉCHARGEMENT DE POCHETTES & PAROLES ---
  http: ^1.2.0                 # Client HTTP pour APIs (Deezer, LastFM, LRCLIB)
  metadata_god: ^1.0.0         # Lecture/Écriture des tags ID3 (Pochettes, paroles)

  # --- SCAN MÉDIATHÈQUE & STOCKAGE BDD ---
  on_audio_query: ^2.9.0       # Scan rapide des titres, albums, artistes
  hive_flutter: ^1.1.0         # BDD NoSQL rapide (Favoris, Stats, Playlists, Langues)
  path_provider: ^2.1.2        # Gestion du stockage local des fichiers

  # --- MONÉTISATION & MISES À JOUR ---
  google_mobile_ads: ^5.1.0    # AdMob (Bannières, Interstitiels, Rewarded)
  in_app_update: ^4.0.1        # Mises à jour in-app Play Store
  
  # --- OUTILS DE GÉNÉRATION AUTOMATIQUE (CLI) ---
  flutter_launcher_icons: ^0.13.1  # [AJOUT] Générateur d'icônes d'application Android/iOS
  flutter_native_splash: ^2.4.0    # [AJOUT] Générateur de Splash Screen natif au démarrage

4. ARCHITECTURE DU PROJET (CLEAN ARCHITECTURE)
Plaintext

mon_projet_player/
│
├── assets/                         # DOSSIERS D'ASSETS À LA RACINE DU PROJET
│   ├── icons/                      # Logos et icônes SVG de l'application
│   │   ├── app_logo.svg
│   │   ├── app_logo_symbol.svg
│   │   ├── app_logo_dark.svg
│   │   └── app_logo_gold.svg
│   │
│   ├── images/                     # Images raster et éléments graphiques
│   │   ├── default_cover.png       # Pochette d'album par défaut
│   │   ├── cassette_body.png       # Texture pour le lecteur cassette
│   │   │
│   │   ├── categories/             # 👈 GROS BOUTONS DE LA MÉDIATHÈQUE
│   │   │   ├── img_recently_played.png
│   │   │   ├── img_most_played.png
│   │   │   ├── img_recently_added.png
│   │   │   └── img_favorites.png
│   │   │
│   │   └── wallpapers/             # 👈 FONDS D'ÉCRAN DE L'APPLICATION
│   │       ├── default_bg.jpg
│   │       ├── vintage_cassette_bg.jpg
│   │       └── abstract_dark_bg.jpg
│   │
│   └── languages/                  # Packs JSON de langue OTA (i18n)
│       ├── fr.json
│       └── en.json
│
├── lib/                            # CODE SOURCE FLUTTER
│   │
│   ├── main.dart                   # Initialisation Hive, AudioServices, AdMob, HomeWidget
│   │
│   ├── core/                       # UTILITIES & CONFIGURATIONS GLOBALES
│   │   ├── constants/
│   │   │   ├── api_keys.dart       # Clés API (AdMob, Deezer, LRCLIB, LastFM)
│   │   │   └── app_assets.dart     # Centralisation des chemins SVG/PNG (Logos, Wallpapers, Boutons)
│   │   ├── theme/                  # DYNAMIC THEME & BACKGROUND
│   │   │   ├── app_theme.dart      # Charte graphique globale dérivée du Logo
│   │   │   ├── dynamic_theme.dart  # PaletteGenerator basé sur les pochette/cassette
│   │   │   └── background_theme_manager.dart # Manager Hive + BLoC/Notifier pour Opacité & Fond d'écran
│   │   ├── localization/           # DynamicLanguageManager (Téléchargement JSON OTA)
│   │   ├── updater/                # InAppUpdateManager
│   │   ├── network/                # PROTOCOLES DE DIFFUSION SANS FIL (CAST)
│   │   │   ├── chromecast_manager.dart # Service Google Cast / Chromecast
│   │   │   └── dlna_upnp_service.dart  # Streaming réseau vers enceintes Hi-Fi / TV
│   │   └── utils/                  # Formatters de temps, Calculs DSP, Helpers audio
│   │
│   ├── data/                       # COUCHE DONNÉES, STOCKAGE & APIS
│   │   ├── models/                 # Song, Album, Artist, Playlist, Lyrics, Tag, BackgroundConfig
│   │   ├── datasources/
│   │   │   ├── local/              # STOCKAGE ET SCANNER LOCAL
│   │   │   │   ├── audio_scanner.dart # Scan rapide des médias via on_audio_query
│   │   │   │   ├── tag_editor_service.dart # Éditeur de métadonnées ID3 (pochettes, titres)
│   │   │   │   ├── playlist_file_manager.dart # Import/Export des playlists .m3u / .m3u8
│   │   │   │   ├── backup_service.dart # Export/Import BDD Hive & préférences en ZIP
│   │   │   │   └── theme_preferences_box.dart # Persistance de l'opacité et de l'image de fond
│   │   │   └── remote/             # APIS EXTÉRIEURES
│   │   │       ├── cover_art_api.dart # Recouvrement via Deezer, LastFM, Discogs
│   │   │       ├── lyrics_api.dart    # API LRCLIB pour paroles synchronisées (.LRC)
│   │   │       ├── lastfm_scrobbler.dart # Scrobbling automatique des écoutes
│   │   │       └── language_api.dart  # Téléchargement packs de langues
│   │   └── repositories/           # Abstraction & agrégation des données local/remote
│   │
│   ├── audio_engine/               # MOTEUR AUDIO AVANCÉ (Cœur Technologique Hi-Fi)
│   │   ├── crossfade_controller.dart # Double lecteur (Player A/B) pour fondu enchaîné seamless
│   │   ├── playback_mode_handler.dart# Logique Répétition (1/All), Shuffle intelligent, Queue
│   │   ├── sleep_timer_engine.dart # Minuteur de mise en veille avec fondu de sortie (30s)
│   │   ├── audio_session_handler.dart# Auto-pause (casque débranché, appels entrants, interruptions)
│   │   ├── audio_service_handler.dart# Bridge Android/iOS (Lockscreen, Notification & Wearables)
│   │   ├── fx_jingle_player.dart   # FX Player pour bruits mécaniques rétro (Bande, Clac)
│   │   ├── equalizer_engine.dart   # Égaliseur N-Bandes, Bass Boost, Virtualizer 3D
│   │   ├── nightclub_reverb.dart   # DSP Reverb (Mode Boîte de nuit / Spatial Casque)
│   │   ├── replay_gain_processor.dart # Normalisation automatique du volume d'écoute
│   │   ├── bit_perfect_handler.dart# Direct DAC / USB Audio pour écoute sans perte (Hi-Res FLAC)
│   │   └── lyrics_sync_engine.dart # Synchro et défilement temps réel des paroles .LRC
│   │
│   ├── widget_engine/              # WIDGET ÉCRAN D'ACCUEIL & LOCKSCREEN
│   │   ├── home_widget_service.dart# Synchronisation Titre/Pochette avec le Widget
│   │   └── background_widget_handler.dart # Actions interactives (Play/Pause/Next) depuis le Widget
│   │
│   └── features/                   # MODULES FONCTIONNELS (UI + BLoC)
│       │
│       ├── common_widgets/         # WIDGETS REUTILISABLES
│       │   └── app_background_wrapper.dart # 👈 Enveloppe Scaffold gérant l'image de fond + l'opacité
│       │
│       ├── splash/                 # ÉCRAN DE DÉMARRAGE & INITIALISATION
│       │   ├── bloc/               # SplashBloc
│       │   └── ui/
│       │       └── splash_screen.dart # Logo animé centré + version app
│       │
│       ├── search/                 # RECHERCHE GLOBALE INSTANTANÉE
│       │   ├── bloc/               # SearchBloc
│       │   └── ui/                 # Filtres dynamiques (Titre, Artiste, Album, Genre)
│       │
│       ├── library/                # MÉDIATHÈQUE COMPLÈTE & GESTION DU CONTENU
│       │   ├── bloc/               # LibraryBloc
│       │   └── screens/
│       │       ├── library_main_screen.dart # Grille des 4 gros boutons (Favoris, Lus récemment, etc.)
│       │       ├── songs_tab.dart   # Liste globale des titres
│       │       ├── favorites_tab.dart # Morceaux coup de cœur
│       │       ├── played_history_tab.dart # Historique d'écoute
│       │       ├── top_played_tab.dart # Statistiques d'écoute
│       │       ├── recently_added_tab.dart # Nouveautés ajoutées
│       │       ├── albums_screen.dart
│       │       ├── artists_screen.dart
│       │       ├── playlists_screen.dart # Playlists persos + Import/Export .m3u
│       │       └── folder_browser_tab.dart # Navigation arborescente par dossiers physiques
│       │
│       ├── player/                 # LECTEUR PRINCIPAL & ANIMATIONS RETRO
│       │   ├── bloc/               # PlayerBloc
│       │   └── ui/
│       │       ├── main_player_screen.dart
│       │       ├── playback_mode_buttons.dart
│       │       ├── rotating_cassette.dart # Cassette animée avec micro-logo
│       │       ├── lyrics_view.dart    # Affichage Paroles synchronisées Karaoke
│       │       ├── cast_button.dart    # Bouton de streaming Chromecast / DLNA
│       │       └── nightclub_button.dart
│       │
│       ├── car_mode/               # MODE CONDUITE & INTEGRATION VEHICULE
│       │   ├── car_service_handler.dart
│       │   └── ui/
│       │       └── car_player_screen.dart
│       │
│       ├── tag_editor/             # ÉDITEUR DE METADONNÉES ID3
│       │   ├── bloc/               # TagEditorBloc
│       │   └── ui/
│       │       └── tag_editor_dialog.dart
│       │
│       ├── sleep_timer/            # MINUTEUR DE VEILLE
│       │   └── sleep_timer_dialog.dart
│       │
│       ├── equalizer/              # ÉCRAN ÉGALISEUR & FX
│       │   └── equalizer_screen.dart
│       │
│       ├── dj_settings/            # RÉGLAGES ENCHAÎNEMENT DJ
│       │   └── crossfade_settings.dart
│       │
│       ├── backup_restore/         # SAUVEGARDE & RESTAURATION
│       │   └── backup_screen.dart
│       │
│       ├── ads/                    # MONÉTISATION
│       │   ├── admob_service.dart
│       │   └── direct_ad_manager.dart
│       │
│       └── settings/               # PARAMÈTRES, THEME & BRANDING
│           ├── language_picker.dart
│           ├── background_picker_screen.dart # 👈 Sélecteur de Fond d'écran + Slider d'opacité
│           ├── premium_screen.dart # Logo Dorée VIP & Achats In-App
│           └── about_screen.dart   # Version officielle, Crédits & Logo complet