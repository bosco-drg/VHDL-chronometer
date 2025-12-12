# Affichage_tb.vhd

## Description

Banc de test (Testbench) pour le module `Affichage`. Simule l'affichage d'un chronomètre en testant l'ensemble du système de multiplexage 7 segments.

## Fonctionnement

Le testbench effectue les opérations suivantes:

### 1. Initialisation (t=0 ns)
- RESET = 1 (réinitialise les compteurs)
- Valeurs affichées: 12:34
  - MIN_D = 0x1 (1)
  - MIN_U = 0x2 (2)
  - SEC_D = 0x3 (3)
  - SEC_U = 0x4 (4)

### 2. Démarrage (t=50 ns)
- RESET = 0 (libère le module)
- Observation du multiplexage: 4 → 3 → 2 → 1 → 4 → ...

### 3. Changement de valeur (t=550 ns)
- Nouvelles valeurs affichées: AF:09
  - MIN_D = 0xA (A)
  - MIN_U = 0xF (F)
  - SEC_D = 0x0 (0)
  - SEC_U = 0x9 (9)

### 4. Fin de simulation (t=1050 ns)
- Arrêt avec message "Fin simulation"

## Signaux de test

```
Période d'horloge: 10 ns (fréquence 100 MHz)
Durée totale: 1050 ns
```

## Observation attendue

Chaque afficheur s'illumine à tour de rôle:
- t < 50 ns  : Initialisation
- t ≥ 50 ns  : Affichage "12:34" (cyclique)
- t ≥ 550 ns : Affichage "AF:09" (cyclique)

## Utilité

Ce testbench permet de vérifier:
1. Le bon fonctionnement du multiplexage
2. La synchronisation des anodes et segments
3. Le transcodage correct des valeurs numériques
4. Les transitions lors de changements de valeurs

## Exécution

Pour simuler ce testbench avec Vivado:
```bash
xvhdl Counter_2b.vhd Mux_4x1x4b.vhd Transcodeur_7seg.vhd Transcodeur_anodes.vhd Affichage.vhd
xvhdl Affichage_tb.vhd
xelab -debug all work.tb_Affichage
xsim -debug work.tb_Affichage
```
