# Transcodeur_anodes.vhd

## Description

Transcodeur pour anode combinatoire. Convertit un signal de sélection 2 bits en vecteur 4 bits qui active l'une des 4 anodes (afficheurs 7 segments). Utilise la logique active à 0.

## Ports

### Entrées
- **sel_anode** : Sélection de l'anode (2 bits)

### Sorties
- **vect_anode** : Vecteur anode (4 bits, actifs à 0) - AN3 AN2 AN1 AN0

## Table de transcodage

| sel_anode | vect_anode | Anode activée |
|-----------|-----------|---------------|
| 00        | 1110      | AN0 (actif à 0) |
| 01        | 1101      | AN1 (actif à 0) |
| 10        | 1011      | AN2 (actif à 0) |
| 11        | 0111      | AN3 (actif à 0) |

## Fonctionnement

Transcodeur "one-hot": à chaque instant, un seul bit est à 0 (celui correspondant à l'anode active).

```
sel_anode = "00" → AN0 active  → vect_anode = "1110"
sel_anode = "01" → AN1 active  → vect_anode = "1101"
sel_anode = "10" → AN2 active  → vect_anode = "1011"
sel_anode = "11" → AN3 active  → vect_anode = "0111"
```

## Logique Active à 0

Utilisée avec afficheurs à anode commune:
- Anode au potentiel haut (1) → Afficheur éteint
- Anode au potentiel bas (0) → Afficheur allumé

## Rôle dans le système

Assure qu'un seul afficheur 7 segments est actif à la fois dans le multiplexage. Travaille en synchronisation avec le compteur 2 bits pour afficher les 4 chiffres du temps.

## Timing

Conversion combinatoire sans délai d'horloge.
