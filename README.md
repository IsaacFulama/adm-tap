# Administration TAP

Application Flutter multiplateforme servant de base à une interface d'administration.

## État actuel

- Tableau de bord responsive avec thème Material 3.
- Navigation vers les sections Vue d'ensemble, Membres, Finances et Biens.
- Les indicateurs affichent volontairement « — » : aucune donnée métier n'est simulée comme si elle était réelle.
- Les sections Membres, Finances et Biens sont des espaces réservés en attendant la conception et la connexion du backend.

## Développement

Prérequis : Flutter SDK compatible avec la contrainte Dart de `pubspec.yaml`.

```bash
flutter pub get
flutter analyze
flutter test
```

## Architecture prévue

Garder l'interface séparée des données métier : ajouter des modèles typés, des repositories pour l'accès aux données, des services pour les cas d'usage et une couche API lorsque le contrat backend sera défini. Les secrets et les identifiants ne doivent jamais être codés en dur dans l'application.

## Limites

Cette version améliore la présentation et la navigation, mais n'implémente pas encore de stockage, d'authentification réelle ni de connexion API. Ne pas l'utiliser comme système de gestion en production avant l'implémentation de ces éléments.
