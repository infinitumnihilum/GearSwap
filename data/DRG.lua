-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
include('organizer-lib.lua')
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
--	state.CombatForm = get_combat_form()
	
	state.Buff = {}
  end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc', 'Multi'}
	options.DefenseModes = {'Normal', 'PDT', 'Reraise'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.CastingModes = {'Normal'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT', 'Reraise'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')

	select_default_macro_book(Main)
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end

	send_command('unbind ^`')
	send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {ammo="Angon",hands="Wyrm Finger Gauntlets +2"}
	sets.precast.JA.Jump = {ammo="Thew Bomblet",
		head="Otomi Helm",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Enif Corazza",hands="Ogier's Gauntlets",ring1="Rajas Ring",ring2="K'ayres ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.precast.JA['Ancient Circle'] = {legs="Drn. Brais +1"}
	sets.precast.JA['High Jump'] = {ammo="Thew Bomblet",
		head="Otomi Helm",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Enif Corazza",hands="Ogier's Gauntlets",ring1="Rajas Ring",ring2="K'ayres ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.precast.JA['Soul Jump'] = {ammo="Thew Bomblet",
		head="Otomi Helm",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Enif Corazza",hands="Ogier's Gauntlets",ring1="Rajas Ring",ring2="K'ayres ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.precast.JA['Spirit Jump'] = {ammo="Thew Bomblet",
		head="Otomi Helm",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Enif Corazza",hands="Ogier's Gauntlets",ring1="Rajas Ring",ring2="K'ayres ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Lncr. Schynbld. +2"}
	sets.precast.JA['Super Jump'] = {ammo="Thew Bomblet",
		head="Otomi Helm",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Enif Corazza",hands="Ogier's Gauntlets",ring1="Rajas Ring",ring2="K'ayres ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.precast.JA['Spirit Link'] = {hands="Lancer's vambraces +2"}
	sets.precast.JA['Call Wyvern'] = {body="Wyrm Mail"}
	sets.precast.JA['Deep Breathing'] = {hands="Wyrm Finger Gauntlets +2"}
	sets.precast.JA['Spirit Surge'] = {body="Wyrm Mail"}

	
	-- Healing Breath sets
	sets.HB = {ammo="Thew Bomblet",
		head="Drachen Armet",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Cizin Mail",hands="Ogier's Gauntlets",ring1="Rajas Ring",ring2="K'ayres ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.HB.Pre = {head="Drachen Armet"}
	sets.HB.Mid = {ammo="Thew Bomblet",
		head="Wyrm Armet +2",neck="Lancer's Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Wyvern Mail",hands="Ogier's Gauntlets",ring1="Rajas Ring",ring2="K'ayres ring",
		back="Updraft Mantle",waist="Glassblower's Belt",legs="Drn. Brais +1",feet="Wyrm Greaves +2"}
		
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Yaoyotl Helm",
		body="Mikinaak Breastplate",hands="Buremte Gloves",ring1="Spiral Ring",
		back="Letalis Mantle",legs="Cizin Breeches",feet="Ejekamal boots"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.midcast.Breath = 
	set_combine(
		sets.midcast.FastRecast, 
		{ head="Drachen Armet" })
	
	-- Fast cast sets for spells
	
	sets.precast.FC = {head="Drachen Armet", legs="Enif Cosciales", neck="Orunmila's Torque",ear2="Loquacious Earring"}
    
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Drachen Armet",
		body="Mikinaak Breastplate",hands="Ogier's Gauntlets",
		legs="Enif Cosciales",feet="Ejekamal boots"}	
		
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})

	sets.precast.WS = {ammo="Cheruski Needle",
		head="Otomi Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Gorney Haubert +1",hands="Lncr. Vmbrc. +2",ring1="Pyrosoul Ring",ring2="Ifrit Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {head="Yaoyotl Helm",back="Letalis Mantle"})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {neck="Light Gorget",waist="Light Belt"})
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {neck="Light Gorget",waist="Light Belt"})
	sets.precast.WS['Stardiver'].Mod = set_combine(sets.precast.WS['Stardiver'], {neck="Light Gorget",waist="Light Belt"})

	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {neck="Light Gorget"})
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS.Acc, {neck="Light Gorget"})
	sets.precast.WS['Drakesbane'].Mod = set_combine(sets.precast.WS['Drakesbane'], {waist="Light Belt"})


	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {head="Yaoyotl Helm",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Ares' cuirass +1",hands="Ogier's Gauntlets",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Crimson Cuisses",feet="Ejekamal boots"}
	

	-- Idle sets
	sets.idle = {}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = {main="Upukirex", sub="Pole Grip",ammo="Thew Bomblet",
		head="Ares' Mask +1",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Ares' cuirass +1",hands="Ares' gauntlets +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Atheling Mantle",waist="Goading Belt",legs="Crimson Cuisses",feet="Ares' Sollerets +1"}
	
	sets.idle.Field = {
		head="Yaoyotl Helm",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Ares' cuirass +1",hands="Ares' gauntlets +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Nierenschutz",legs="Crimson Cuisses",feet="Ejekamal boots"}

	sets.idle.Weak = {
		head="Twilight Helm",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Buremte Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Nierenschutz",legs="Cizin Breeches",feet="Ejekamal boots"}
	
	-- Defense sets
	sets.defense.PDT = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Mekira Meikogai",hands="Ogier's Gauntlets",ring1="Dark Ring",ring2="Dark Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Ejekamal boots"}

	sets.defense.Reraise = {
		head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Buremte Gloves",ring1="Dark Ring",ring2="Paguroidea Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Ejekamal boots"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Mekira Meikogai",hands="Ogier's Gauntlets",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Engulfer Cape",waist="Goading Belt",legs="Cizin Breeches",feet="Ejekamal boots"}

	sets.Kiting = {legs="Crimson Cuisses"}

	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {ammo="Thew bomblet",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Enif Corazza",hands="Ares' gauntlets +1",ring1="Rajas Ring",ring2="K'ayres ring",
		back="Atheling Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.engaged.Acc = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Enif Corazza",hands="Ares' gauntlets +1",ring1="Rajas Ring",ring2="K'ayres ring",
		back="Updraft Mantle",waist="Anguinus belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.engaged.Multi = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Enif Corazza",hands="Ares' Gauntlets +1",ring1="Rajas Ring",ring2="K'ayres ring",
		back="Atheling mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.engaged.Multi.PDT = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Cizin Mail",hands="Ogier's Gauntlets",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Cizin Graves"}
	sets.engaged.Multi.Reraise = {ammo="Thew Bomblet",
		head="Twilight Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Breastplate",hands="Ogier's Gauntlets",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.engaged.PDT = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Mikinaak Breastplate",hands="Ogier's Gauntlets",ring1="Dark Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.engaged.Acc.PDT = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Mikinaak Breastplate",hands="Ogier's Gauntlets",ring1="Dark Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.engaged.Reraise = {ammo="Thew Bomblet",
		head="Twilight Helm",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Ogier's Gauntlets",ring1="Dark Ring",ring2="Dark Ring",
		back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.engaged.Acc.Reraise = {ammo="Thew Bomblet",
		head="Twilight Helm",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Ogier's Gauntlets",ring1="Dark Ring",ring2="Dark Ring",
		back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
		
	-- Melee sets for in Adoulin, which has an extra 2% Haste from Ionis.
	sets.engaged.Adoulin = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Enif Corazza",hands="Ogier's Gauntlets",ring1="Rajas Ring",ring2="K'ayres ring",
		back="Atheling mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.engaged.Adoulin.Acc = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Enif Corazza",hands="Ogier's Gauntlets",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Atheling mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.engaged.Adoulin.Multi = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Enif Corazza",hands="Ares' Gauntlets +1",ring1="Rajas Ring",ring2="K'ayres ring",
		back="Atheling mantle",waist="Windbuffet belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.engaged.Adoulin.Multi.PDT = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Enif Corazza",hands="Ogier's Gauntlets",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Cizin Graves"}
	sets.engaged.Adoulin.Multi.Reraise = {ammo="Thew Bomblet",
		head="Twilight Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Breastplate",hands="Ogier's Gauntlets",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.engaged.Adoulin.PDT = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Mikinaak Breastplate",hands="Ogier's Gauntlets",ring1="Dark Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.engaged.Adoulin.Acc.PDT = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Mikinaak Breastplate",hands="Ogier's Gauntlets",ring1="Dark Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.engaged.Adoulin.Reraise = {ammo="Thew Bomblet",
		head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Ogier's Gauntlets",ring1="Dark Ring",ring2="Dark Ring",
		back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal boots"}
	sets.engaged.Adoulin.Acc.Reraise = {ammo="Thew Bomblet",
		head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Ogier's Gauntlets",ring1="Dark Ring",ring2="Dark Ring",
		back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal boots"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
	equip(sets.precast.FC)
	end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)

end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
		if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
		if player.hpp < 51 then
			classes.CustomClass = "Breath" -- This would cause it to look for sets.midcast.Breath 
		end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	
--	if state.DefenseMode == 'Reraise' or
--		(state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
--		equip(sets.Reraise)
--	end
end

-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
if spell.english:startswith('Healing Breath') or spell.english == 'Restoring Breath' then
		equip(sets.HB.Mid)
	end
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
if state.DefenseMode == 'Reraise' or
		(state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
	end
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)

end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

end

function job_update(cmdParams, eventArgs)
	--state.CombatForm = get_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

function get_combat_form()
	if areas.Adoulin:contains(world.area) and buffactive.ionis then
		return 'Adoulin'
	end
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	classes.CustomMeleeGroups:clear()
	if areas.Adoulin:contains(world.area) and buffactive.ionis then
		classes.CustomMeleeGroups:append('Adoulin')
	end
end

-- Job-specific toggles.
function job_toggle(field)

end

-- Request job-specific mode lists.
-- Return the list, and the current value for the requested field.
function job_get_mode_list(field)

end

-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_mode(field, val)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-- Handle notifications of user state values being changed.
function job_state_change(stateField, newValue)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function select_default_macro_book()
	set_macro_page(4)
end