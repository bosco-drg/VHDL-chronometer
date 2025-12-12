# Mux_4x1x4b.vhd

## Description

Multiplexeur 4 entrées vers 1 sortie de 4 bits. Sélectionne l'une des 4 entrées (SEC_U, SEC_D, MIN_U, MIN_D) selon le signal de sélection.

## Ports

### Entrées
- **A** : Unités des secondes (4 bits)
- **B** : Dizaines des secondes (4 bits)
- **C** : Unités des minutes (4 bits)
- **D** : Dizaines des minutes (4 bits)
- **sel** : Signal de sélection (2 bits)

### Sorties
- **O** : Donnée sélectionnée (4 bits)

## Table de sélection

| sel | Sortie |
|-----|--------|
| 00  | A (SEC_U) |
| 01  | B (SEC_D) |
| 10  | C (MIN_U) |
| 11  | D (MIN_D) |

## Fonctionnement

Le multiplexeur utilise une structure `with...select` VHDL pour sélectionner rapidement l'une des 4 entrées:

```vhdl
sel = "00" → O = A (Secondes unités)
sel = "01" → O = B (Secondes dizaines)
sel = "10" → O = C (Minutes unités)
sel = "11" → O = D (Minutes dizaines)
```

## Rôle dans le système

Il crée le lien entre le compteur 2 bits (qui génère la séquence de sélection) et les données de temps à afficher. Cela permet d'afficher les 4 chiffres du temps en séquence rapide (multiplexage).

## Timing

Conversion combinatoire sans délai d'horloge.
