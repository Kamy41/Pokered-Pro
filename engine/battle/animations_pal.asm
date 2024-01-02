SetAttackAnimPal:
	call GetPredefRegisters
	
	ld a, $f0
	ld [wAnimPalette], a
	
	ld a, [wGBC]
	and a
	ret z 
	
	ld a, [wIsInBattle]
	and a
	ret z

	;only continue for valid move animations
	ld a, [wAnimationID]
	and a
	ret z
	cp STRUGGLE
	ret nc	
	
	ld a, $e4
	ld [wAnimPalette], a
	
	push hl
	push bc
	push de
	ld a, [wcf91]
	push af
	
;doing a move animation, so find its type and apply color
	ld a, [H_WHOSETURN]
	and a
	ld hl, wPlayerMoveType
	jr z, .playermove
	ld hl, wEnemyMoveType
.playermove
	ld a, [hl]
	ld bc, $0000
	ld c, a
	ld hl, TypePalColorList
	add hl, bc
	ld a, [hl]
	ld b, a

	ld c, 4
.transfer
	; ld d, CONVERT_OBP0
	ld e, c
	dec e
	ld a, b	
	add VICTREEBEL+1
	ld [wcf91], a
	push bc
	callba TransferMonPal
	pop bc
	dec c
	jr nz, .transfer
	
	pop af
	ld [wcf91], a
	pop de
	pop bc
	pop hl
	ret	
TypePalColorList:
	db PAL_GREYMON;normal
	db PAL_GREYMON;fighting
	db PAL_CYANMON;flying
	db PAL_PURPLEMON;poison
	db PAL_BROWNMON;ground
	db PAL_GREYMON;rock
	db PAL_BLACK;untyped/bird
	db PAL_GREENMON;bug
	db PAL_PURPLEMON;ghost
	db PAL_BLACK;unused
	db PAL_BLACK;unused
	db PAL_BLACK;unused
	db PAL_BLACK;unused
	db PAL_BLACK;unused
	db PAL_BLACK;unused
	db PAL_BLACK;unused
	db PAL_BLACK;unused
	db PAL_BLACK;unused
	db PAL_BLACK;unused
	db PAL_BLACK;unused
	db PAL_REDMON;fire
	db PAL_BLUEMON;water
	db PAL_GREENMON;grass
	db PAL_YELLOWMON;electric
	db PAL_PINKMON;psychic
	db PAL_CYANMON;ice
	db PAL_BLUEMON;dragon
