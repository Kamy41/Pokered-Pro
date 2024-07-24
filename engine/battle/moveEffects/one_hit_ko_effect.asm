OneHitKOEffect_:
;;;;;;;;;;;;;; edited to compare Attack instead of Speed 
	ld hl, wDamage
	xor a
	ld [hli], a
	ld [hl], a ; set the damage output to zero
	dec a
	ld [wCriticalHitOrOHKO], a
	ld hl, wBattleMonAttack + 1
	ld de, wEnemyMonAttack + 1
	ld a, [H_WHOSETURN]
	and a
	jr z, .compareAttack
	ld hl, wEnemyMonAttack + 1
	ld de, wBattleMonAttack + 1
.compareAttack
; set damage to 65535 and OHKO flag if the user's current attack is higher than the target's
	ld a, [de]
	dec de
	ld b, a
	ld a, [hld]
	sub b
	ld a, [de]
	ld b, a
	ld a, [hl]
	sbc b
	jr c, .userIsWeaker
	ld hl, wDamage
	ld a, $ff
	ld [hli], a
	ld [hl], a
	ld a, $2
	ld [wCriticalHitOrOHKO], a
	ret
.userIsWeaker
; keep damage at 0 and set move missed flag if target's current attack is higher instead
	ld a, $1
	ld [wMoveMissed], a
	ret
