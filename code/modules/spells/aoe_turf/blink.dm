/datum/spell/aoe_turf/blink
	name = "Blink"
	desc = "This spell randomly teleports you a short distance."
	feedback = "BL"
	school = "conjuration"
	charge_max = 20
	spell_flags = Z2NOCAST | IGNOREDENSE | IGNORESPACE
	invocation = "none"
	invocation_type = INVOKE_NONE
	range = 7
	inner_radius = 1

	level_max = list(UPGRADE_TOTAL = 4, UPGRADE_SPEED = 4, UPGRADE_POWER = 4)
	cooldown_min = 5 //4 deciseconds reduction per rank
	hud_state = "wiz_blink"
	cast_sound = 'sounds/magic/blink.ogg'

/datum/spell/aoe_turf/blink/cast(list/targets, mob/user)
	if(!targets.len)
		return

	var/turf/T = pick(targets)
	var/turf/starting = get_turf(user)
	if(T)
		if(user.buckled)
			user.buckled = null
		user.forceMove(T)

		var/datum/effect/effect/system/smoke_spread/smoke = new /datum/effect/effect/system/smoke_spread()
		smoke.set_up(3, 0, starting)
		smoke.start()

		smoke = new()
		smoke.set_up(3, 0, T)
		smoke.start()

	return

/datum/spell/aoe_turf/blink/empower_spell()
	if(!..())
		return 0
	inner_radius += 1

	return "You've increased the inner range of [src]."
