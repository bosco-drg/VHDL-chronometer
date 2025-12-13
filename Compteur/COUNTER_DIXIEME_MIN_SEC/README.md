Le fichier counter_dixieme_min_sec.vhd implémente un compteur hiérarchique permettant de compter les dixièmes de secondes, les secondes (unités et dizaines) et les minutes (unités et dizaines). Il regroupe plusieurs compteurs 4 bits connectés en cascade.

Entrées :

clk : horloge principale

ARESET : reset asynchrone actif à ‘1’

CE : signal d’activation du comptage

Sorties :

LED_OUT : valeur du compteur de dixièmes de seconde

OUT_UNIT_SEC : chiffre des unités de secondes (0 à 9)

OUT_DIZ_SEC : chiffre des dizaines de secondes (0 à 5)

OUT_UNIT_MIN : chiffre des unités de minutes (0 à 9)

OUT_DIZ_MIN : chiffre des dizaines de minutes (0 à 5)

TC : signal de débordement global (passe à ‘1’ à la fin d’un cycle complet)

Structure interne :

counteurdixieme : compte de 0 à 9 sur clk, produit TC_ds

Counter_Unit_4b_RE : compte les unités de secondes (0 à 9) sur les fronts du signal TC_ds

Counter_Diz_4b_RE : compte les dizaines de secondes (0 à 5) sur les fronts du signal TC_s

Counter_Unit_4b_RE : compte les unités de minutes (0 à 9) sur les fronts du signal TC_dizs

Counter_Diz_4b_RE : compte les dizaines de minutes (0 à 5) sur les fronts du signal TC_min et fournit TC

Le signal de débordement de chaque étage sert d’horloge au suivant. Le reset remet tous les compteurs à zéro. Le CE active le comptage sur le premier étage, les suivants comptent à chaque débordement.

Le fichier tb_counter_dixieme_min_sec.vhd est un testbench pour vérifier le bon fonctionnement du module principal. Il génère une horloge, active le reset puis le CE, et observe les sorties du compteur. Chaque sortie du composant est connectée à un signal distinct dans le testbench.

Signaux utilisés dans le testbench :

clk_int : horloge simulée (période 1 ns)

ARESET_int : signal de reset

CE_int : enable du comptage

LED_OUT_int, OUT_UNIT_SEC_int, OUT_DIZ_SEC_int, OUT_UNIT_MIN_int, OUT_DIZ_MIN_int : sorties connectées au compteur

TC_int : débordement global

Déroulement du test :

Reset actif au début pour initialiser les compteurs

Activation du CE après quelques cycles pour lancer le comptage

Observation des signaux de sorties pendant plusieurs centaines de cycles

Nouveau reset pour vérifier la remise à zéro