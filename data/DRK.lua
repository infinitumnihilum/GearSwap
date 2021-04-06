	

    -------------------------------------------------------------------------------------------------------------------
    -- Initialization function that defines sets and variables to be used.
    -------------------------------------------------------------------------------------------------------------------
     
    -- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
     
    -- Initialization function for this job file.
    function get_sets()
            -- Load and initialize the include file.
            include('Mote-Include.lua')
    end
     
     
    -- Setup vars that are user-independent.
    function job_setup()
                    state.Buff['Aftermath'] = buffactive['Aftermath: Lv.1'] or
                    buffactive['Aftermath: Lv.2'] or
                    buffactive['Aftermath: Lv.3']
                    or false
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
			
			adjust_engaged_sets()
	 
            -- Additional local binds
            send_command('bind ^` input /ja "Hasso" <me>')
            send_command('bind !` input /ja "Seigan" <me>')
     
            select_default_macro_book()
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
            sets.precast.JA['Diabolic Eye'] = {hands="Abyss Gauntlets +2"}
            sets.precast.JA['Arcane Circle'] = {feet="Ignominy Sollerets"}
            sets.precast.JA['Nether Void'] = {legs="Bale Flanchard +2"}
     
                   
            -- Waltz set (chr and vit)
            sets.precast.Waltz = {ammo="Sonia's Plectrum",
                    head="Yaoyotl Helm",
                    body="Mikinaak Breastplate",hands="Buremte Gloves",
                    legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
                   
            -- Don't need any special gear for Healing Waltz.
            sets.precast.Waltz['Healing Waltz'] = {}
           
            -- Fast cast sets for spells
                     
            -- Midcast Sets
            sets.midcast.FastRecast = {ammo="Impatiens",
                    head="Cizin Helm",neck="Orunmila's Torque",ear1="Loquacious Earring",ear2="Moonshade Earring",
                    body="Nuevo Coselete",hands="Cizin Mufflers",ring1="Prolix Ring",ring2="K'ayres Ring",
                    back="Letalis Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
                   
            -- Specific spells
            sets.midcast.Utsusemi = {ammo="Impatiens",
                    head="Cizin Helm",neck="Orunmila's Torque",ear1="Loquacious Earring",ear2="Moonshade Earring",
                    body="Nuevo Coselete",hands="Cizin Mufflers",ring1="Prolix Ring",ring2="K'ayres Ring",
                    waist="Goading Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
     
            sets.midcast.DarkMagic = {ammo="Impatiens",
                    head="Appetence Crown",neck="Aesir Torque",ear1="Loquacious Earring",ear2="Moonshade Earring",
                    body="Nuevo Coselete",hands="Pavor Gauntlets",ring1="Prolix Ring",ring2="K'ayres Ring",
                    back="Merciful Cape",waist="Goading Belt",legs="Bale Flanchard +2",feet="Karieyh Sollerets +1"}
           
		    sets.midcast.EnfeeblingMagic = sets.midcast.DarkMagic
		   
            sets.midcast['Dread Spikes'] = {body="Bale Cuirass +2"}
           
            sets.midcast.Stun = set_combine(sets.midcast.DarkMagic, {
                    head="Cizin Helm",ear1="Lifestorm Earring",ear2="Psystorm Earring",
                    ring2="Balrahn's Ring"})
                   
            sets.midcast.Drain = {ammo="Impatiens",
                    head="Appetence Crown",neck="Aesir Torque",ear1="Loquacious Earring",ear2="Hirudinea Earring",
                    body="Nuevo Coselete",hands="Pavor Gauntlets",ring1="Prolix Ring",ring2="K'ayres Ring",
                    back="Merciful Cape",waist="Goading Belt",legs="Bale Flanchard +2",feet="Karieyh Sollerets +1"}
                   
            sets.midcast.Aspir = sets.midcast.Drain
						                   
            -- Weaponskill sets
            -- Default set for any weaponskill that isn't any more specifically defined
            sets.precast.WS = {ammo="Hagneia Stone",
                    head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Brutal Earring",ear2="Moonshade Earring",
                    body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="Spiral Ring",
                    back="Atheling Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
            sets.precast.WS.Acc = set_combine(sets.precast.WS, {back="Letalis Mantle"})
     
            -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
            sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS, {neck="Soil Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring"})
            sets.precast.WS['Catastrophe'].Acc = set_combine(sets.precast.WS.Acc, {neck="Soil Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring"})
            sets.precast.WS['Catastrophe'].Mod = set_combine(sets.precast.WS['Catastrophe'], {waist="Soil Belt",ear1="Bladeborn Earring",ear2="Steelflash Earring"})
     
            sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {neck="Soil Gorget",legs="Cizin Breeches"})
            sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS.Acc, {neck="Soil Gorget",legs="Cizin Breeches"})
            sets.precast.WS['Entropy'].Mod = set_combine(sets.precast.WS['Entropy'], {waist="Soil Belt",legs="Cizin Breeches"})
     
            sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {neck="Soil Gorget",ring2="Candent Ring"})
            sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {neck="Soil Gorget",ring2="Candent Ring"})
            sets.precast.WS['Resolution'].Mod = set_combine(sets.precast.WS['Resolution'], {waist="Soil Belt",ring2="Candent Ring"})
     
     
           
            -- Sets to return to when not performing an action.
           
            -- Resting sets
            sets.resting = {head="Yaoyotl Helm",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Ares' cuirass +1",hands="Cizin Mufflers",ring1="Sheltered Ring",ring2="Paguroidea Ring",
                    back="Letalis Mantle",waist="Goading Belt",legs="Blood Cuisses",feet="Ejekamal Boots"}
           
     
            -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
            sets.idle.Town = {
                    head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Ares' Cuirass +1",hands="Cizin Mufflers",ring1="Sheltered Ring",ring2="Paguroidea Ring",
                    back="Letalis Mantle",waist="Goading Belt",legs="Blood Cuisses",feet="Ejekamal Boots"}
           
            sets.idle.Field = {
                    head="Yaoyotl Helm",neck="Bale Choker",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Ares' Cuirass +1",hands="Cizin Mufflers",ring1="Sheltered Ring",ring2="Paguroidea Ring",
                    back="Shadow Mantle",waist="Goading Belt",legs="Blood Cuisses",feet="Ejekamal Boots"}
     
            sets.idle.Weak = {
                    head="Twilight Helm",neck="Bale Choker",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Twilight Mail",hands="Buremte Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
                    back="Letalis Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Ejekamal Boots"}
           
            -- Defense sets
            sets.defense.PDT = {
                    head="Cizin Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Cizin Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
                    back="Mollusca Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Cizin Greaves"}
     
            sets.defense.Reraise = {
                    head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Twilight Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Paguroidea Ring",
                    back="Mollusca Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Cizin Greaves"}
     
            sets.defense.MDT = {
                    head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Cizin Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
                    back="Engulfer Cape",waist="Dynamic Belt",legs="Cizin Breeches",feet="Cizin Greaves"}
     
            sets.Kiting = {legs="Blood Cuisses"}
     
            sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
     
            -- Engaged sets
     sets.engaged = {ammo="Hagneia Stone",
		head="Otomi Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Pak Corselet",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
	sets.engaged.Acc = {ammo="Hagneia Stone",
		head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Pak Corselet",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
	sets.engaged = {ammo="Hagneia Stone",
		head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Pak Corselet",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
	sets.engaged.Multi = {ammo="Hagneia Stone",
		head="Otomi Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Pak Corselet",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Cetl Belt",legs="Cizin Breeches",feet="Ejekamal Boots"}
	sets.engaged.Reraise = {ammo="Fire Bomblet",
		head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Cizin Muffler",ring1="Dark Ring",ring2="Dark Ring",
		back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Cizin Greaves"}
	
	 
            -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
            -- sets if more refined versions aren't defined.
            -- If you create a set with both offense and defense modes, the offense mode should be first.
            -- EG: sets.engaged.Dagger.Accuracy.Evasion
           
            -- Normal melee group
            sets.engaged.Apocalypse = {ammo="Hagneia Stone",
                    head="Otomi Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Pak Corselet",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
                    back="Letalis Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
            sets.engaged.Apocalypse.Acc = {ammo="Hagneia Stone",
                    head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Pak Corselet",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
                    back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
            sets.engaged.Apocalypse.AM = {ammo="Hagneia Stone",
                    head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Pak Corselet",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
                    back="Letalis Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
            sets.engaged.Apocalypse.Multi = {ammo="Hagneia Stone",
                    head="Otomi Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Pak Corselet",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
                    back="Letalis Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Ejekamal Boots"}
            sets.engaged.Apocalypse.Multi.PDT = {ammo="Hagneia Stone",
                    head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Cizin Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
                    back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Cizin Graves"}
            sets.engaged.Apocalypse.Multi.Reraise = {ammo="Hagneia Stone",
                    head="Twilight Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Twilight Breastplate",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="Mars's Ring",
                    back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal Boots"}
            sets.engaged.Apocalypse.PDT = {ammo="Fire Bomblet",
                    head="Cizin Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Cizin Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
                    back="Mollusca Mantle",waist="Nierenschutz",legs="Cizin Breeches",feet="Cizin Greaves"}
            sets.engaged.Apocalypse.Acc.PDT = {ammo="Fire Bomblet",
                    head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Cizin Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
                    back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Cizin Greaves"}
            sets.engaged.Apocalypse.Reraise = {ammo="Fire Bomblet",
                    head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Twilight Mail",hands="Cizin Muffler",ring1="Dark Ring",ring2="Dark Ring",
                    back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Cizin Greaves"}
            sets.engaged.Apocalypse.Acc.Reraise = {ammo="Fire Bomblet",
                    head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Twilight Mail",hands="Cizin Muffler",ring1="Dark Ring",ring2="DarkRing",
                    back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Cizin Greaves"}
					

            -- Custom Melee Group
            sets.engaged['Senbaak Nagan'] = {ammo="Hagneia Stone",
                    head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Pak Corselet",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
                    back="Letalis Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
            sets.engaged['Senbaak Nagan'].Acc = {ammo="Hagneia Stone",
                    head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="Mars's Ring",
                    back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
            sets.engaged['Senbaak Nagan'].Multi = {ammo="Hagneia Stone",
                    head="Otomi Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
                    back="Letalis Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Ejekamal Boots"}
            sets.engaged['Senbaak Nagan'].Multi.PDT = {ammo="Hagneia Stone",
                    head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Cizin Mail",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="Mars's Ring",
                    back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Cizin Graves"}
            sets.engaged['Senbaak Nagan'].Multi.Reraise = {ammo="Hagneia Stone",
                    head="Twilight Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Pak Corselet",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="Mars's Ring",
                    back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal Boots"}
            sets.engaged['Senbaak Nagan'].PDT = {ammo="Hagneia Stone",
                    head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
                    back="Mollusca Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
            sets.engaged['Senbaak Nagan'].Acc.PDT = {ammo="Hagneia Stone",
                    head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
                    back="Mollusca Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
            sets.engaged['Senbaak Nagan'].Reraise = {ammo="Hagneia Stone",
                    head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Twilight Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
                    back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
            sets.engaged['Senbaak Nagan'].Acc.Reraise = {ammo="Hagneia Stone",
                    head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Twilight Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
                    back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
     
    end
     
    -------------------------------------------------------------------------------------------------------------------
    -- Job-specific hooks that are called to process player actions at specific points in time.
    -------------------------------------------------------------------------------------------------------------------
     
  
    -- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
    -- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
    function job_precast(spell, action, spellMap, eventArgs)
            if spell.action_type == 'Magic' then
            equip(sets.precast.FC)
            end
    end
     
 
     
     
    -- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
    function job_midcast(spell, action, spellMap, eventArgs)
            if spell.action_type == 'Magic' then
                equip(sets.midcast.FastRecast)
            end
    end
     
    -- Run after the default midcast() is done.
    -- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
    function job_post_midcast(spell, action, spellMap, eventArgs)
            if state.DefenseMode == 'Reraise' or
                    (state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
                    equip(sets.Reraise)
            end
    end
     
    -- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
  --  function job_aftercast(spell, action, spellMap, eventArgs)
  --      if not spell.interrupted then
  --              if state.Buff[spell.english] ~= nil then
  --                      state.Buff[spell.english] = true
  --              end
  --       end
  --  end
     
    -------------------------------------------------------------------------------------------------------------------
    -- Customization hooks for idle and melee sets, after they've been automatically constructed.
    -------------------------------------------------------------------------------------------------------------------
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
     
    -- Called when a player gains or loses a buff.
    -- buff == buff gained or lost
    -- gain == true if the buff was gained, false if it was lost.
    function job_buff_change(buff, gain)
            if buff:startswith('Aftermath') then
                state.Buff.Aftermath = gain
                adjust_melee_groups()
                handle_equipping_gear(player.status)
        end
    end
     
     
    -------------------------------------------------------------------------------------------------------------------
    -- User code that supplements self-commands.
    -------------------------------------------------------------------------------------------------------------------
     
    -- Called by the 'update' self-command, for common needs.
    -- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	adjust_engaged_sets()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function adjust_engaged_sets()
	state.CombatWeapon = player.equipment.main
	adjust_melee_groups()
end

function adjust_melee_groups()
	classes.CustomMeleeGroups:clear()
	if state.Buff.Aftermath then
		classes.CustomMeleeGroups:append('AM')
	end
end
     
    function select_default_macro_book()
            -- Default macro set/book
                    set_macro_page(1, 1)
                    -- I realize this will be better used with different /subs per book,
                    -- but I won't worry about that till I get this working properly.
    end