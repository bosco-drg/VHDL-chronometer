# Counter_2b.vhd

## Description

Compteur binaire 2 bits synchrone. Génère une séquence cyclique 00 → 01 → 10 → 11 → 00 sur chaque front montant de l'horloge.

## Ports

### Entrées
- **CLK** : Horloge d'entrée (front montant actif)
- **RESET** : Réinitialisation synchrone (actif à 1)

### Sorties
- **Q** : Valeur du compteur (2 bits)

## Fonctionnement

```
RESET = 1  →  Q = "00"
RESET = 0  →  Q commence à incrémenter:
              "00" → "01" → "10" → "11" → "00" → ...
```

Le compteur s'incrémente de 1 à chaque front montant de l'horloge.

## Rôle dans le système

Dans le projet chronomètre, ce compteur crée la séquence de sélection pour afficher successivement les 4 chiffres du temps. La fréquence de CLK_AFF doit être suffisamment élevée (quelques kHz) pour que le multiplexage soit invisible à l'oeil humain.

## Temps de réaction

Pour une horloge CLK à fréquence f:
- Période d'un compte complet (00 → 11 → 00): 4 × (1/f)
- Chaque afficheur est activé pendant (1/f) secondes
