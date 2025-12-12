# Affichage.vhd

## Description

Module principal de contrôle d'affichage pour un chronomètre 7 segments. Ce composant gère l'affichage multiplexé de 4 chiffres (dizaines et unités des minutes et secondes) sur des afficheurs 7 segments.

## Ports

### Entrées
- **CLK_AFF** : Horloge dédiée au multiplexage de l'affichage
- **RESET** : Signal de réinitialisation (actif à 1)
- **SEC_U** : Unités des secondes (4 bits)
- **SEC_D** : Dizaines des secondes (4 bits)
- **MIN_U** : Unités des minutes (4 bits)
- **MIN_D** : Dizaines des minutes (4 bits)

### Sorties
- **AFF** : Segments 7 segments (7 bits, actifs à 0) - codage: g f e d c b a
- **ANODES** : Anode des afficheurs (4 bits, actifs à 0) - AN3 AN2 AN1 AN0

## Fonctionnement

Le module utilise une technique de multiplexage pour afficher les 4 chiffres en séquence rapide:

1. **Counter_2b** : Génère une séquence 00 → 01 → 10 → 11 pour sélectionner chaque afficheur
2. **Mux_4x1x4b** : Sélectionne le chiffre à afficher selon le signal de sélection
3. **Transcodeur_7seg** : Convertit la valeur numérique en code 7 segments
4. **Transcodeur_anodes** : Active l'anode de l'afficheur correspondant

## Architecture

```
┌────────────────────────────────┐
│   Affichage (RTL)              │
├────────────────────────────────┤
│  Counter_2b       ┌─────┐      │
│    (sel)      ────┤     │      │
│                   │Mux  │───┐  │
│  SEC_U  ┐      ───┤ 4x1 │   │  │
│  SEC_D  ├────┤    │     │   │  │
│  MIN_U  │    └──────┤     │   └──────┐
│  MIN_D  └────┐   └─────┘   │  7seg ┌─┤
│              │             └───────┤ │
│         Transcodeur_anodes    └────┘ │
│              │
│            ANODES
```

## Exemple d'affichage

Pour afficher "12:34":
- MIN_D = 0x1 (1)
- MIN_U = 0x2 (2)
- SEC_D = 0x3 (3)
- SEC_U = 0x4 (4)

Le multiplexage scanne rapidement: 4 → 3 → 2 → 1 → 4 → ...
