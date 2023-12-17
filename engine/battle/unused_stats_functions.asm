DoubleSelectedStats:	
	ret
HalveSelectedStats:	
	ret
UndoBurnParStats:
	ld hl, wBattleMonStatus
	ld de, wPlayerStatsToDouble
	ld a, [H_WHOSETURN]
	and a
	jr z, .checkburn
	ld hl, wEnemyMonStatus
	ld de, wEnemyStatsToDouble
.checkburn
	ld a, [hl]		;load statuses
	and 1 << BRN	;test for burn 
	jr z, .checkpar
	ld a, $01
	ld [de], a	;set attack to be doubled to undo the stat change of BRN
	call DoubleSelectedStats
	jr .return
.checkpar
	ld a, [hl]		;load statuses
	and 1 << PAR	;test for paralyze 
	jr z, .return
	ld a, $04
	ld [de], a	;set speed to be doubled (done twice) to undo the stat change of PAR
	call DoubleSelectedStats
	call DoubleSelectedStats
.return
	xor a
	ld [de], a	;reset the stat change bits
	ret
