/obj/item/clothing/shoes/proc/step_action() //this was made to rewrite clown shoes squeaking
	SEND_SIGNAL(src, COMSIG_SHOES_STEP_ACTION)

/obj/item/clothing/shoes/sneakers/mime
	name = "mime shoes"
	icon_state = "mime"
	item_color = "mime"

/obj/item/clothing/shoes/combat //basic syndicate combat boots for nuke ops and mob corpses
	name = "combat boots"
	desc = "High speed, low drag combat boots."
	icon_state = "jackboots"
	item_state = "jackboots"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	armor = list("melee" = 25, "bullet" = 25, "laser" = 25, "energy" = 25, "bomb" = 50, "bio" = 10, "rad" = 0, "fire" = 70, "acid" = 50)
	strip_delay = 70
	resistance_flags = NONE
	permeability_coefficient = 0.05 //Thick soles, and covers the ankle
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes

/obj/item/clothing/shoes/combat/combat_knife/ComponentInitialize()
	. = ..()
	new /obj/item/kitchen/knife/combat(src)

/obj/item/clothing/shoes/combat/swat //overpowered boots for death squads
	name = "\improper SWAT boots"
	desc = "High speed, no drag combat boots."
	permeability_coefficient = 0.01
	clothing_flags = NOSLIP
	armor = list("melee" = 40, "bullet" = 30, "laser" = 25, "energy" = 25, "bomb" = 50, "bio" = 30, "rad" = 30, "fire" = 90, "acid" = 50)

/obj/item/clothing/shoes/sandal
	desc = "A pair of rather plain wooden sandals."
	name = "sandals"
	icon_state = "wizard"
	strip_delay = 50
	equip_delay_other = 50
	permeability_coefficient = 0.9

/obj/item/clothing/shoes/sandal/marisa
	desc = "A pair of magic black shoes."
	name = "magic shoes"
	icon_state = "black"
	resistance_flags = FIRE_PROOF |  ACID_PROOF

/obj/item/clothing/shoes/sandal/magic
	name = "magical sandals"
	desc = "A pair of sandals imbued with magic."
	resistance_flags = FIRE_PROOF |  ACID_PROOF

/obj/item/clothing/shoes/galoshes
	desc = "A pair of yellow rubber boots, designed to prevent slipping on wet surfaces."
	name = "galoshes"
	icon_state = "galoshes"
	permeability_coefficient = 0.01
	clothing_flags = NOSLIP
	slowdown = SHOES_SLOWDOWN+1
	strip_delay = 50
	equip_delay_other = 50
	resistance_flags = NONE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 40, "acid" = 75)
	can_be_bloody = FALSE
	custom_price = 100

/obj/item/clothing/shoes/galoshes/dry
	name = "absorbent galoshes"
	desc = "A pair of purple rubber boots, designed to prevent slipping on wet surfaces while also drying them."
	icon_state = "galoshes_dry"

/obj/item/clothing/shoes/galoshes/dry/step_action()
	var/turf/open/t_loc = get_turf(src)
	SEND_SIGNAL(t_loc, COMSIG_TURF_MAKE_DRY, TURF_WET_WATER, TRUE, INFINITY)

/obj/item/clothing/shoes/clown_shoes
	desc = "The prankster's standard-issue clowning shoes. Damn, they're huge! Ctrl-click to toggle waddle dampeners."
	name = "clown shoes"
	icon_state = "clown"
	item_state = "clown_shoes"
	slowdown = SHOES_SLOWDOWN+1
	item_color = "clown"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes/clown
	var/datum/component/waddle
	var/enabled_waddle = TRUE

/obj/item/clothing/shoes/clown_shoes/clowncrocs
	desc = "The prankster's standard-issue clowning crocs. Damn, they're cool! These crocs seems smaller than the clown's standard shoes. Ctrl-click to toggle waddle dampeners."
	name = "clown crocs"
	icon_state = "clowncrocs"
	item_state = "clowncrocs"

/obj/item/clothing/shoes/clown_shoes/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/effects/clownstep1.ogg'=1,'sound/effects/clownstep2.ogg'=1), 50)

/obj/item/clothing/shoes/clown_shoes/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_SHOES)
		if(enabled_waddle)
			waddle = user.AddComponent(/datum/component/waddling)
		if(user.mind && user.mind.assigned_role == "Clown")
			SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "clownshoes", /datum/mood_event/clownshoes)

/obj/item/clothing/shoes/clown_shoes/dropped(mob/user)
	. = ..()
	QDEL_NULL(waddle)
	if(user.mind && user.mind.assigned_role == "Clown")
		SEND_SIGNAL(user, COMSIG_CLEAR_MOOD_EVENT, "clownshoes")

/obj/item/clothing/shoes/clown_shoes/CtrlClick(mob/living/user)
	if(!isliving(user))
		return
	if(user.get_active_held_item() != src)
		to_chat(user, "You must hold the [src] in your hand to do this.")
		return
	if (!enabled_waddle)
		to_chat(user, span_notice("You switch off the waddle dampeners!"))
		enabled_waddle = TRUE
	else
		to_chat(user, span_notice("You switch on the waddle dampeners!"))
		enabled_waddle = FALSE

/obj/item/clothing/shoes/clown_shoes/jester
	name = "jester shoes"
	desc = "A court jester's shoes, updated with modern squeaking technology."
	icon_state = "jester_shoes"

/obj/item/clothing/shoes/jackboots
	name = "jackboots"
	desc = "Nanotrasen-issue Security combat boots for combat scenarios or combat situations. All combat, all the time."
	icon_state = "jackboots"
	item_state = "jackboots"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	item_color = "hosred"
	strip_delay = 50
	equip_delay_other = 50
	resistance_flags = NONE
	permeability_coefficient = 0.05 //Thick soles, and covers the ankle
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes
	force = 1

/obj/item/clothing/shoes/jackboots/fast
	slowdown = -1

/obj/item/clothing/shoes/jackboots/warden
	name = "warden's spur jackboots"
	desc = "Nanotrasen-issue Security combat boots for combat scenarios or combat situations. All combat, all the time. These boots have spurs attached to them."
	icon_state = "spurboots"
	item_state = "spurboots"

/obj/item/clothing/shoes/jackboots/warden/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/effects/spurstep.ogg'))

/obj/item/clothing/shoes/winterboots
	name = "winter boots"
	desc = "Boots lined with 'synthetic' animal fur."
	icon_state = "winterboots"
	item_state = "winterboots"
	permeability_coefficient = 0.15
	cold_protection = FEET|LEGS
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET|LEGS
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes

/obj/item/clothing/shoes/winterboots/ice_boots
	name = "ice hiking boots"
	desc = "A pair of winter boots with special grips on the bottom, designed to prevent slipping on frozen surfaces."
	icon_state = "iceboots"
	item_state = "iceboots"
	clothing_flags = NOSLIP_ICE

/obj/item/clothing/shoes/workboots
	name = "work boots"
	desc = "Nanotrasen-issue Engineering lace-up work boots for the especially blue-collar."
	icon_state = "workboots"
	item_state = "jackboots"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	permeability_coefficient = 0.15
	strip_delay = 40
	equip_delay_other = 40
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes

/obj/item/clothing/shoes/workboots/mining
	name = "mining boots"
	desc = "Steel-toed mining boots for mining in hazardous environments. Very good at keeping toes uncrushed."
	icon_state = "explorer"
	resistance_flags = FIRE_PROOF

/obj/item/clothing/shoes/cult
	name = "\improper Nar'Sien invoker boots"
	desc = "A pair of boots worn by the followers of Nar'Sie."
	icon_state = "cult"
	item_state = "cult"
	item_color = "cult"
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT

/obj/item/clothing/shoes/cult/alt
	name = "cultist boots"
	icon_state = "cultalt"

/obj/item/clothing/shoes/cult/alt/ghost
	item_flags = DROPDEL

/obj/item/clothing/shoes/cult/alt/ghost/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CULT_TRAIT)

/obj/item/clothing/shoes/cyborg
	name = "cyborg boots"
	desc = "Shoes for a cyborg costume."
	icon_state = "boots"

/obj/item/clothing/shoes/laceup
	name = "laceup shoes"
	desc = "The height of fashion, and they're pre-polished!"
	icon_state = "laceups"
	equip_delay_other = 50

/obj/item/clothing/shoes/roman
	name = "roman sandals"
	desc = "Sandals with buckled leather straps on it."
	icon_state = "roman"
	item_state = "roman"
	strip_delay = 100
	equip_delay_other = 100
	permeability_coefficient = 0.9

/obj/item/clothing/shoes/griffin
	name = "griffon boots"
	desc = "A pair of costume boots fashioned after bird talons."
	icon_state = "griffinboots"
	item_state = "griffinboots"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes

/obj/item/clothing/shoes/bhop
	name = "jump boots"
	desc = "A specialized pair of combat boots with a built-in propulsion system for rapid foward movement."
	icon_state = "jetboots"
	item_state = "jetboots"
	item_color = "hosred"
	resistance_flags = FIRE_PROOF
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes
	actions_types = list(/datum/action/item_action/bhop)
	permeability_coefficient = 0.05
	var/jumpdistance = 5 //-1 from to see the actual distance, e.g 4 goes over 3 tiles
	var/jumpspeed = 3
	var/recharging_rate = 60 //default 6 seconds between each dash
	var/recharging_time = 0 //time until next dash

/obj/item/clothing/shoes/bhop/ui_action_click(mob/user, action)
	if(!isliving(user))
		return

	if(recharging_time > world.time)
		to_chat(user, span_warning("The boot's internal propulsion needs to recharge still!"))
		return

	var/atom/target = get_edge_target_turf(user, user.dir) //gets the user's direction

	if (user.throw_at(target, jumpdistance, jumpspeed, spin = FALSE, diagonals_first = TRUE))
		playsound(src, 'sound/effects/stealthoff.ogg', 50, 1, 1)
		user.visible_message(span_warning("[usr] dashes forward into the air!"))
		recharging_time = world.time + recharging_rate
	else
		to_chat(user, span_warning("Something prevents you from dashing forward!"))

/obj/item/clothing/shoes/singery
	name = "yellow performer's boots"
	desc = "These boots were made for dancing."
	icon_state = "ysing"
	equip_delay_other = 50

/obj/item/clothing/shoes/singerb
	name = "blue performer's boots"
	desc = "These boots were made for dancing."
	icon_state = "bsing"
	equip_delay_other = 50

/obj/item/clothing/shoes/bronze
	name = "bronze boots"
	desc = "A giant, clunky pair of shoes crudely made out of bronze. Why would anyone wear these?"
	icon = 'icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "clockwork_treads"

/obj/item/clothing/shoes/bronze/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/machines/clockcult/integration_cog_install.ogg' = 1, 'sound/magic/clockwork/fellowship_armory.ogg' = 1), 50)

/obj/item/clothing/shoes/wheelys
	name = "Wheely-Heels"
	desc = "Uses patented retractable wheel technology. Never sacrifice speed for style - not that this provides much of either." //Thanks Fel
	icon_state = "wheelys"
	item_state = "wheelys"
	actions_types = list(/datum/action/item_action/wheelys)
	var/wheelToggle = FALSE //False means wheels are not popped out
	var/obj/vehicle/ridden/scooter/wheelys/W

/obj/item/clothing/shoes/wheelys/Initialize()
	. = ..()
	W = new /obj/vehicle/ridden/scooter/wheelys(null)

/obj/item/clothing/shoes/wheelys/ui_action_click(mob/user, action)
	if(!isliving(user))
		return
	if(!istype(user.get_item_by_slot(SLOT_SHOES), /obj/item/clothing/shoes/wheelys))
		to_chat(user, span_warning("You must be wearing the wheely-heels to use them!"))
		return
	if(!(W.is_occupant(user)))
		wheelToggle = FALSE
	if(wheelToggle)
		W.unbuckle_mob(user)
		wheelToggle = FALSE
		return
	W.forceMove(get_turf(user))
	W.buckle_mob(user)
	wheelToggle = TRUE

/obj/item/clothing/shoes/wheelys/dropped(mob/user)
	if(wheelToggle)
		W.unbuckle_mob(user)
		wheelToggle = FALSE
	..()

/obj/item/clothing/shoes/wheelys/Destroy()
	QDEL_NULL(W)
	. = ..()

/obj/item/clothing/shoes/kindleKicks
	name = "Kindle Kicks"
	desc = "They'll sure kindle something in you, and it's not childhood nostalgia..."
	icon_state = "kindleKicks"
	item_state = "kindleKicks"
	actions_types = list(/datum/action/item_action/kindleKicks)
	var/lightCycle = 0
	var/active = FALSE

/obj/item/clothing/shoes/kindleKicks/ui_action_click(mob/user, action)
	if(active)
		return
	active = TRUE
	set_light(2, 3, rgb(rand(0,255),rand(0,255),rand(0,255)))
	addtimer(CALLBACK(src, .proc/lightUp), 5)

/obj/item/clothing/shoes/kindleKicks/proc/lightUp(mob/user)
	if(lightCycle < 15)
		set_light(2, 3, rgb(rand(0,255),rand(0,255),rand(0,255)))
		lightCycle += 1
		addtimer(CALLBACK(src, .proc/lightUp), 5)
	else
		set_light(0)
		lightCycle = 0
		active = FALSE

/obj/item/clothing/shoes/russian
	name = "russian boots"
	desc = "Comfy shoes."
	icon_state = "rus_shoes"
	item_state = "rus_shoes"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes

/obj/item/clothing/shoes/cowboy
	name = "cowboy boots"
	desc = "A small sticker lets you know they've been inspected for snakes, It is unclear how long ago the inspection took place..."
	icon_state = "cowboy_brown"
	permeability_coefficient = 0.05 //these are quite tall
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes
	custom_price = 35 //poor assistants cant afford 50 credits
	var/list/occupants = list()
	var/max_occupants = 4

/obj/item/clothing/shoes/cowboy/Initialize()
	. = ..()
	if(prob(2))
		var/mob/living/simple_animal/hostile/retaliate/poison/snake/bootsnake = new/mob/living/simple_animal/hostile/retaliate/poison/snake(src)
		occupants += bootsnake


/obj/item/clothing/shoes/cowboy/equipped(mob/living/carbon/user, slot)
	. = ..()
	if(slot == SLOT_SHOES)
		for(var/mob/living/occupant in occupants)
			occupant.forceMove(user.drop_location())
			user.visible_message(span_warning("[user] recoils as something slithers out of [src]."), span_userdanger(" You feel a sudden stabbing pain in your [pick("foot", "toe", "ankle")]!"))
			user.Knockdown(20) //Is one second paralyze better here? I feel you would fall on your ass in some fashion.
			user.apply_damage(5, BRUTE, pick(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG))
			if(istype(occupant, /mob/living/simple_animal/hostile/retaliate/poison))
				user.reagents.add_reagent(/datum/reagent/toxin, 7)
		occupants.Cut()

/obj/item/clothing/shoes/cowboy/MouseDrop_T(mob/living/target, mob/living/user)
	. = ..()
	if(user.stat || !(user.mobility_flags & MOBILITY_USE) || user.restrained() || !Adjacent(user) || !user.Adjacent(target) || target.stat == DEAD)
		return
	if(occupants.len >= max_occupants)
		to_chat(user, span_notice("[src] are full!"))
		return
	if(istype(target, /mob/living/simple_animal/hostile/retaliate/poison/snake) || istype(target, /mob/living/simple_animal/hostile/headcrab) || istype(target, /mob/living/carbon/alien/larva))
		occupants += target
		target.forceMove(src)
		to_chat(user, span_notice("[target] slithers into [src]"))

/obj/item/clothing/shoes/cowboy/container_resist(mob/living/user)
	if(!do_after(user, 1 SECONDS, target = user))
		return
	user.forceMove(user.drop_location())
	occupants -= user

/obj/item/clothing/shoes/cowboy/white
	name = "white cowboy boots"
	icon_state = "cowboy_white"

/obj/item/clothing/shoes/cowboy/black
	name = "black cowboy boots"
	desc = "You get the feeling someone might have been hanged in these boots."
	icon_state = "cowboy_black"

/obj/item/clothing/shoes/cowboy/fancy
	name = "bilton wrangler boots"
	desc = "A pair of authentic haute couture boots from Japanifornia. You doubt they have ever been close to cattle."
	icon_state = "cowboy_fancy"
	permeability_coefficient = 0.08

/obj/item/clothing/shoes/cowboy/lizard
	name = "lizard skin boots"
	desc = "You can hear a faint hissing from inside the boots; you hope it is just a mournful ghost."
	icon_state = "lizardboots_green"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 40, "acid" = 0) //lizards like to stay warm

/obj/item/clothing/shoes/cowboy/lizard/masterwork
	name = "\improper Hugs-The-Feet lizard skin boots"
	desc = "A pair of masterfully crafted lizard skin boots. Finally a good application for the station's most bothersome inhabitants."
	icon_state = "lizardboots_blue"

/obj/effect/spawner/lootdrop/lizardboots
	name = "random lizard boot quality"
	desc = "Which ever gets picked, the lizard race loses"
	icon = 'icons/obj/clothing/shoes.dmi'
	icon_state = "lizardboots_green"
	loot = list(
		/obj/item/clothing/shoes/cowboy/lizard = 7,
		/obj/item/clothing/shoes/cowboy/lizard/masterwork = 1)

/obj/item/clothing/shoes/pathtreads
	name = "pathfinder treads"
	desc = "Massive boots made from chitin, they look hand-crafted."
	icon_state = "pathtreads"
	item_state = "pathtreads"
	strip_delay = 50
	body_parts_covered = LEGS|FEET
	resistance_flags = FIRE_PROOF
	heat_protection = LEGS|FEET
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	cold_protection = LEGS|FEET
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/shoes/xeno_wraps //Standard for all digitigrade legs and feets
	name = "footwraps"
	desc = "Standard issue NanoTrasen cloth footwraps for those with podiatric deficiencies. They're quite itchy and scratchy."
	icon_state = "footwraps"
	item_state = "footwraps"
	xenoshoe = EITHER_STYLE // This can be worn by digitigrade or straight legs, or a hybridization thereof (one prosthetic one digitigrade). Xenoshoe variable will default to NO_DIGIT, excluding digitigrade feet.
	mutantrace_variation = MUTANTRACE_VARIATION // Yes these shoes account for non-straight leg situations, such as jumpskirts

/obj/item/clothing/shoes/xeno_wraps/jackboots // Footwraps woven with security-grade materials, still somewhat inferior to full jackboots.
	name = "reinforced footwraps"
	desc = "These make your feet feel snug and secure, while still being breathable and light."
	icon_state = "footwraps_s"
	item_state = "footwraps_s"
	strip_delay = 25 // Half time to take off
	equip_delay_other = 25 // Half time
	resistance_flags = NONE
	permeability_coefficient = 0.70 // Fabric is more permeable than boot, but still somewhat resistant
	// pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes -- No storage pocket for wraps
	xenoshoe = EITHER_STYLE // This can be worn by digitigrade or straight legs, or a hybridization thereof (one prosthetic one digitigrade). Xenoshoe variable will default to NO_DIGIT, excluding digitigrade feet.
	mutantrace_variation = MUTANTRACE_VARIATION // Yes these shoes account for non-straight leg situations, such as jumpskirts

/obj/item/clothing/shoes/xeno_wraps/command  // Not applicable unless 11505 merges - Digitigrade-exclusive shoes for Command positions
	name = "command footwraps"
	desc = "These Command-grade NanoTrasen fiber footwraps exude an air of refinement not often felt by those with alien podiatric structures."
	icon_state = "footwraps_c"
	item_state = "footwraps_c"
	xenoshoe = YES_DIGIT // This is digitigrade leg exclusive
	mutantrace_variation = MUTANTRACE_VARIATION // Yes these shoes account for non-straight leg situations, such as jumpskirts

/obj/item/clothing/shoes/xeno_wraps/engineering
	name = "engineering footwraps"
	desc = "Standard issue NanoTrasen cloth footwraps, specially made for the frequent glass treader."
	icon_state = "footwraps_e"
	item_state = "footwraps_e"
	xenoshoe = YES_DIGIT 
	mutantrace_variation = MUTANTRACE_VARIATION

/obj/item/clothing/shoes/xeno_wraps/science
	name = "science footwraps"
	desc = "Standard issue NanoTrasen cloth footwraps, to reduce fatigue when standing at a console all day."
	icon_state = "footwraps_sc"
	item_state = "footwraps_sc"
	xenoshoe = YES_DIGIT 
	mutantrace_variation = MUTANTRACE_VARIATION

/obj/item/clothing/shoes/xeno_wraps/medical
	name = "medical footwraps"
	desc = "Standard issue NanoTrasen cloth footwraps, for when you dont want other people's blood all over your feet."
	icon_state = "footwraps_m"
	item_state = "footwraps_m"
	xenoshoe = YES_DIGIT
	mutantrace_variation = MUTANTRACE_VARIATION

/obj/item/clothing/shoes/xeno_wraps/cargo
	name = "cargo footwraps"
	desc = "Standard issue NanoTrasen cloth footwraps, with reinforcment to protect against falling crates."
	icon_state = "footwraps_ca"
	item_state = "footwraps_ca"
	xenoshoe = YES_DIGIT 
	mutantrace_variation = MUTANTRACE_VARIATION


/obj/item/clothing/shoes/airshoes
	name = "air shoes"
	desc = "Footwear that uses propulsion technology to keep you above the ground and let you move faster."
	icon_state = "airshoes"
	obj_flags = UNIQUE_RENAME //im not fucking naming them 'sonic 11's you can do that yourself ffm
	actions_types = list(/datum/action/item_action/airshoes, /datum/action/item_action/dash)
	var/airToggle = FALSE
	var/obj/vehicle/ridden/scooter/airshoes/A
	permeability_coefficient = 0.05
	var/recharging_time = 0 
	var/jumpdistance = 7 //Increased distance so it might see some offensive use
	var/jumpspeed = 5 //fast
	var/recharging_rate = 60 
	syndicate = TRUE

/obj/item/clothing/shoes/airshoes/Initialize()
	. = ..()
	A = new/obj/vehicle/ridden/scooter/airshoes(null)
	
/obj/item/clothing/shoes/airshoes/ui_action_click(mob/user, action)
	if(!isliving(user))
		return
	if(!istype(user.get_item_by_slot(SLOT_SHOES), /obj/item/clothing/shoes/airshoes))
		to_chat(user, span_warning("You must be wearing the air shoes to use them!"))
		return
	if(istype(action,/datum/action/item_action/airshoes))
		if(!(A.is_occupant(user)))
			airToggle = FALSE
		if(airToggle)
			A.unbuckle_mob(user)
			airToggle = FALSE
			return
		A.forceMove(get_turf(user))
		A.buckle_mob(user)
		airToggle = TRUE
	else if(istype(action,/datum/action/item_action/dash))
		if(recharging_time > world.time)
			to_chat(user, span_warning("The boot's internal propulsion needs to recharge still!"))
			return
		
		var/atom/target = get_edge_target_turf(user, user.dir) //gets the user's direction
		if (user.throw_at(target, jumpdistance, jumpspeed, spin = FALSE, diagonals_first = TRUE))
			playsound(src, 'sound/effects/stealthoff.ogg', 50, 1, 1)
			user.visible_message(span_warning("[usr] dashes forward into the air!"))
			recharging_time = world.time + recharging_rate
		else
			to_chat(user, span_warning("Something prevents you from dashing forward!"))

/obj/item/clothing/shoes/airshoes/dropped(mob/user)
	if(airToggle)
		A.unbuckle_mob(user)
		airToggle = FALSE
	..()
/obj/item/clothing/shoes/airshoes/Destroy()
	QDEL_NULL(A)
	. = ..()
