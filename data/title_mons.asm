TitleMons:
; mons on the title screen are randomly chosen from here
IF DEF(_RED)
	db CHARMANDER
	db SQUIRTLE
	db BULBASAUR
ENDC
IF DEF(_GREEN)
	db BULBASAUR
	db CHARMANDER
	db SQUIRTLE
ENDC
IF DEF(_BLUE)
	db SQUIRTLE
	db BULBASAUR
	db CHARMANDER
ENDC
