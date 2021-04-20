-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
include('organizer-lib.lua')
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'DPS', 'Acc', 'PDT', 'MDT')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'Reraise', 'Charm')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()
    
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {legs="caballarius breeches +1"}
    sets.precast.JA['Holy Circle'] = {feet="Rev. leggings"}
    sets.precast.JA['Shield Bash'] = {hands="Caballarius Gauntlets"}
    sets.precast.JA['Sentinel'] = {feet="Souveran schuhs +1"}
    sets.precast.JA['Rampart'] = {head="Caballarius Coronet"}
    sets.precast.JA['Fealty'] = {body="Caballarius surcoat +1"}
    sets.precast.JA['Divine Emblem'] = {feet="Creed Sabatons +2"}
    sets.precast.JA['Cover'] = {head="Reverence coronet"}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        head="Sulevia's Mask +2",
        body="Caballarius surcoat +1",hands="Souveran handschuhs +1",ring1="Leviathan Ring",ring2="Aquasoul Ring",
        back="Weard Mantle",legs="Caballarius breeches +1",feet="Xaddi Boots"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Sulevia's Mask +2",
        body="Sulevia's platemail +2",hands="Souveran handschuhs +1",ring2="Asklepian Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Caballarius breeches +1",feet="Xaddi Boots"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Incantor Stone",
        head="Creed armet +2",ear2="Loquacious Earring",ring2="Prolix Ring",legs="Enif Cosciales"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Aurgelmir orb",
        head="Valorous Mask",neck=gear.ElementalGorget,ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Sulevia's platemail +2",hands="Sulevia's gauntlets +2",ring1="Rajas Ring",ring2="Karieyh Ring",
        back=gear.PldBack.TP,waist=gear.ElementalBelt,legs="Souveran diechlings +1",feet="Sulevia's leggings +2"}

    sets.precast.WS.Acc = {ammo="Aurgelmir orb",
        head="Valorous Mask",neck=gear.ElementalGorget,ear1="Moonshade Earring",ear2="Telos earring",
        body="Sulevia's platemail +2",hands="Sulevia's gauntlets +2",ring1="Flamma Ring",ring2="Karieyh Ring",
        back=gear.PldBack.TP,waist=gear.ElementalBelt,legs="Souveran diechlings +1",feet="Sulevia's leggings +2"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ring1="Leviathan Ring",ring2="Aquasoul Ring"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Leviathan Ring"})

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {hands="Sulevia's gauntlets +2",ear1="Moonshade Earring" ,
	ear2="Thrud Earring",back="Rancorous mantle",neck="Fotia Gorget"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {waist="Fotia Belt"})

    sets.precast.WS['Sanguine Blade'] = {ammo="Aurgelmir orb",
        head="Valorous Mask",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Caballarius surcoat +1",hands="Sulevia's gauntlets +2",ring1="Shiva Ring",ring2="Flamma Ring",
        back="Toro Cape",waist="Caudata Belt",legs="Caballarius breeches +1",feet="Souveran schuhs +1"}
    
    sets.precast.WS['Atonement'] = {ammo="Iron Gobbet",
        head="Valorous Mask",neck=gear.ElementalGorget,ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Phorcys Korazin",hands="Souveran handschuhs +1",ring1="Rajas Ring",ring2="Vexer Ring",
        back="Weard Mantle",waist=gear.ElementalBelt,legs="Caballarius breeches +1",feet="Souveran schuhs +1"}
		
		sets.precast.WS['Savage Blade'] = {ammo="Iron Gobbet",
        head="Valorous Mask",neck=gear.ElementalGorget,ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Phorcys Korazin",hands="Souveran handschuhs +1",ring1="Rajas Ring",ring2="Vexer Ring",
        back="Weard Mantle",waist=gear.ElementalBelt,legs="Caballarius breeches +1",feet="Sulevia's leggings +2"}
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Sulevia's Mask +2",
        body="Caballarius surcoat +1",hands="Souveran handschuhs +1",
        waist="Zoran's Belt",legs="Enif Cosciales",feet="Souveran schuhs +1"}
        
    sets.midcast.Enmity = {ammo="Iron Gobbet",
        head="Loess barbuta",neck="Invidia Torque",
        body="Caballarius surcoat +1",hands="Souveran handschuhs +1",ring1="Vexer Ring",
        back="Fierabras's Mantle",waist="Goading Belt",legs="Caballarius breeches +1",feet="Eschite greaves"}

    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {legs="Enif Cosciales"})
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = {ammo="Iron Gobbet",
        head="Adaman Barbuta",neck="Invidia Torque",ear1="Hospitaler Earring",ear2="Bloodgem Earring",
        body="Caballarius surcoat +1",hands="Sulevia's gauntlets +2",ring1="Kunaji Ring",ring2="Asklepian Ring",
        back="Fierabras's Mantle",waist="Chuq'aba Belt",legs="Caballarius breeches +1",feet="Souveran schuhs +1"}

    sets.midcast['Enhancing Magic'] = {neck="Colossus's Torque",waist="Olympus Sash",legs="Caballarius breeches +1"}
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    sets.resting = {neck="Coatl gorget +1",
        ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt"}
    

    -- Idle sets
    sets.idle = {ammo="Iron Gobbet",
        head="Jumalik Helm",neck="Coatl gorget +1",ear1="Creed Earring",ear2="Ethereal Earring",
        body="Ares' Cuirass +1",hands="Souveran handschuhs +1",ring1="Defending Ring",ring2="Paguroidea Ring",
        back=gear.PldBack.TP,waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Souveran schuhs +1"}

    sets.idle.Town = {main="Maligance sword",ammo="Incantor Stone",
        head="Sulevia's Mask +2",neck="Coatl gorget +1",ear1="Telos earring",ear2="Brutal Earring",
        body="Ares' Cuirass +1",hands="Souveran handschuhs +1",ring1="Defending Ring",ring2="Paguroidea Ring",
        back=gear.PldBack.TP,waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Souveran schuhs +1"}
    
    sets.idle.Weak = {ammo="Iron Gobbet",
        head="Sulevia's Mask +2",neck="Coatl gorget +1",ear1="Telos earring",ear2="Brutal Earring",
        body="Caballarius surcoat +1",hands="Souveran handschuhs +1",ring1="Defending Ring",ring2="Paguroidea Ring",
        back=gear.PldBack.TP,waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Souveran schuhs +1"}
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {back="Repulse Mantle"}
    sets.MP = {neck="Coatl gorget +1",waist="Flume Belt +1"}
    sets.MP_Knockback = {neck="Coatl gorget +1",waist="Flume Belt +1",back="Repulse Mantle"}
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {main="Anahera Sword",sub="Killedar Shield"} -- Ochain
    sets.MagicalShield = {main="Anahera Sword",sub="Aegis"} -- Aegis

    -- Basic defense sets.
        
    sets.defense.PDT = {ammo="Iron Gobbet",
        head="Sulevia's Mask +2",neck="Twilight Torque",ear1="Creed Earring",ear2="Ethereal Earring",
        body="Caballarius surcoat +1",hands="Souveran handschuhs +1",ring1="Defending Ring",ring2="Moonlight ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs="Souveran diechlings +1",feet="Souveran schuhs +1"}
    sets.defense.HP = {ammo="Iron Gobbet",
        head="Sulevia's Mask +2",neck="Twilight Torque",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Caballarius surcoat +1",hands="Souveran handschuhs +1",ring1="Defending Ring",ring2="Meridian Ring",
        back="Weard Mantle",waist="Creed Baudrier",legs="Caballarius breeches +1",feet="Souveran schuhs +1"}
    sets.defense.Reraise = {ammo="Iron Gobbet",
        head="Twilight Helm",neck="Twilight Torque",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Twilight Mail",hands="Souveran handschuhs +1",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Weard Mantle",waist="Flume Belt +1",legs="Caballarius breeches +1",feet="Souveran schuhs +1"}
    sets.defense.Charm = {ammo="Iron Gobbet",
        head="Sulevia's Mask +2",neck="Lavalier +1",ear1="Creed Earring",ear2="Buckler Earring",
        body="Caballarius surcoat +1",hands="Souveran handschuhs +1",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt +1",legs="Caballarius breeches +1",feet="Souveran schuhs +1"}
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = {ammo="Demonry Stone",
        head="Sulevia's Mask +2",neck="Twilight Torque",ear1="Creed Earring",ear2="Ethereal Earring",
        body="Caballarius surcoat +1",hands="Souveran handschuhs +1",ring1="Dark Ring",ring2="Shadow Ring",
        back="Engulfer Cape +1",waist="Creed Baudrier",legs="Souveran diechlings +1",feet="Souveran schuhs +1"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {ammo="Aurgelmir Orb",
        head="Flamma zucchetto +2",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Telos earring",
        body="Sulevia's platemail +2",hands="Sulevia's gauntlets +2",ring1="Moonlight Ring",ring2="Flamma Ring",
        back=gear.PldBack.TP,waist="Sailfi belt +1",legs="Souveran diechlings +1",feet="Souveran schuhs +1"}
		
	sets.engaged.DPS = {ammo="Aurgelmir Orb",
        head="Flamma zucchetto +2",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Telos earring",
        body="Sulevia's platemail +2",hands="Sulevia's gauntlets +2",ring1="Moonlight Ring",ring2="Flamma Ring",
        back=gear.PldBack.TP,waist="Sailfi belt +1",legs="Sulevia's Cuisses +2",feet="Flamma gambieras +2"}

    sets.engaged.Acc = {ammo="Aurgelmir Orb",
        head="Flamma zucchetto +2",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Telos earring",
        body="Sulevia's platemail +2",hands="Sulevia's gauntlets +2",ring1="Moonlight Ring",ring2="Flamma Ring",
        back="Weard Mantle",waist="Sailfi belt +1",legs="Souveran diechlings +1",feet="Xaddi Boots"}

    sets.engaged.DW = {ammo="Aurgelmir orb",
        head="Flamma zucchetto +2",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Telos earring",
        body="Sulevia's platemail +2",hands="Sulevia's gauntlets +2",ring1="Moonlight Ring",ring2="Flamma Ring",
        back=gear.PldBack.TP,waist="Sailfi belt +1",legs="Souveran diechlings +1",feet="Xaddi Boots"}

    sets.engaged.DW.Acc = {ammo="Aurgelmir orb",
        head="Flamma zucchetto +2",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Sulevia's platemail +2",hands="Sulevia's gauntlets +2",ring1="Moonlight Ring",ring2="Flamma Ring",
        back="Weard Mantle",waist="Zoran's Belt",legs="Souveran diechlings +1",feet="Xaddi Boots"}

    sets.engaged.PDT = set_combine(sets.engaged, {ammo="Aurgelmir Orb",
        head="Sulevia's Mask +2",neck="Twilight Torque",ear1="Creed Earring",ear2="Ethereal Earring",
        body="Caballarius surcoat +1",hands="Souveran handschuhs +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs="Caballarius breeches +1",feet="Souveran schuhs +1"})
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {body="Caballarius surcoat +1",neck="Twilight Torque",ring1="Defending Ring"})
	sets.engaged.MDT = {ammo="Demonry Stone",
        head="Sulevia's Mask +2",neck="Twilight Torque",ear1="Creed Earring",ear2="Ethereal Earring",
        body="Caballarius surcoat +1",hands="Souveran handschuhs +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Engulfer Cape +1",waist="Creed Baudrier",legs="Souveran diechlings +1",feet="Souveran schuhs +1"}
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)

    sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {body="Caballarius surcoat +1",neck="Twilight Torque",ring1="Defending Ring"})
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc, {body="Caballarius surcoat +1",neck="Twilight Torque",ring1="Defending Ring"})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Cover = {head="Reverence coronet", body="Caballarius surcoat +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(5, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 2)
    elseif player.sub_job == 'RDM' then
        set_macro_page(3, 2)
    else
        set_macro_page(2, 1)
    end
end

