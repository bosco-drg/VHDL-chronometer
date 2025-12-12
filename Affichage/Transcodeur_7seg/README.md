# Transcodeur_7seg.vhd

## Description

Transcodeur 7 segments combinatoire. Convertit une valeur hexadécimale 4 bits en signal de commande pour un afficheur 7 segments à cathode commune.

## Ports

### Entrées
- **A** : Valeur hexadécimale (4 bits, 0x0 à 0xF)

### Sorties
- **O** : Segments 7 segments (7 bits, actifs à 0) - codage: g f e d c b a

## Table de transcodage

| Entrée | Segment |
|--------|---------|
| 0x0    | 1000000 |
| 0x1    | 1111001 |
| 0x2    | 0100100 |
| 0x3    | 0110000 |
| 0x4    | 0011001 |
| 0x5    | 0010010 |
| 0x6    | 0000010 |
| 0x7    | 1111000 |
| 0x8    | 0000000 |
| 0x9    | 0010000 |
| 0xA    | 0001000 |
| 0xB    | 0000011 |
| 0xC    | 1000110 |
| 0xD    | 0100001 |
| 0xE    | 0000110 |
| 0xF    | 0001110 |

## Codage des segments

```
    a
   ---
f |   | b
  | g |
   ---
e |   | c
  |   |
   ---
    d
```

Bits de sortie: [g f e d c b a] (bit 6 à bit 0)

## Affichage des caractères

Le transcodeur affiche:
- 0-9 : Chiffres décimaux
- A-F : Caractères hexadécimaux majuscules

## Logique

Active à 0: quand un segment doit être affiché, sa sortie est à 0 (cathode commune)

## Rôle dans le système

Convertit les valeurs numériques du chronomètre en signals de commande pour les afficheurs 7 segments.
