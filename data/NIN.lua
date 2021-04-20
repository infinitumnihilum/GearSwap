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
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    gear.MovementFeet = {name="Danzo Sune-ate"}
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Nin. Kyahan +1"
    
    select_movement_feet()
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama"}
    sets.precast.JA['Futae'] = {legs="Iga Tekko +2"}
    sets.precast.JA['Sange'] = {legs="Mochizuki Chainmail"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Adhemar Bonnet +1",
        body="Hachiya Chainmail +2",hands="Buremte Gloves",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Mochizuki kyahan +3"}
        -- Uk'uxkaj Cap, Daihanshi Habaki
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
        head="Adhemar Bonnet +1",neck="Ej Necklace",
        body="Hachiya Chainmail +2",hands="Buremte Gloves",ring1="Patricius Ring",
        back=gear.NinBack.TP,waist="Chaac Belt",legs="Manibozho Brais",feet="Mochizuki kyahan +3"}

    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",ear2="Loquacious Earring",hands="Thaumas Gloves",ring1="Prolix Ring"}
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Mochizuki Chainmail"})

    -- Snapshot for ranged
    sets.precast.RA = {hands="Manibozho Gloves",legs="Nahtirah Trousers",feet="Wurrukatte Boots"}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Yamarang",
        head="Hachiya Hatsuburi +2",neck=gear.ElementalGorget,ear1="Telos Earring",ear2="Odr Earring",
        body="Hizamaru haramaki +2",hands="Mochizuki Tekko",ring1="Rajas Ring",ring2="Epona's Ring",
        back=gear.NinBack.WS,waist=gear.ElementalBelt,legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Jukukik Feather",hands="Buremte Gloves",
        back=gear.NinBack.TP})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS,
        {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",feet="Daihanshi Habaki"})

    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS,
        {head="Adhemar Bonnet +1",hands="Hachiya Tekko",ring1="Stormsoul Ring",legs="Nahtirah Trousers"})

    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {feet="Daihanshi Habaki"})

    sets.precast.WS['Blade: Metsu'] = set_combine(sets.precast.WS,
        {ammo="Aurgelmir Orb", head="Hachiya Hatsuburi +2",hands="Herculean Gloves",ring1="Karieyh Ring",waist="Sailfi Belt +1"})

    sets.precast.WS['Aeolian Edge'] = {
        head="Wayfarer Circlet",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Wayfarer Robe",hands="Wayfarer Cuffs",ring1="Acumen Ring",ring2="Demon's Ring",
        back="Toro Cape",waist="Fotia Belt",legs="Shneddick Tights +1",feet="Daihanshi Habaki"}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Adhemar Bonnet +1",ear2="Loquacious Earring",
        body="Hachiya Chainmail +2",hands="Mochizuki Tekko",ring1="Prolix Ring",
        legs="Hizamaru hizayoroi +2",feet="Qaaxo Leggings"}
        
    sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {back=gear.NinBack.TP,feet="Iga Kyahan +2"})

    sets.midcast.ElementalNinjutsu = {
        head="Hachiya Hatsuburi +2",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Hachiya Chainmail +2",hands="Iga Tekko +2",ring1="Icesoul Ring",ring2="Acumen Ring",
        back="Toro Cape",waist=gear.ElementalObi,legs="Nahtirah Trousers",feet="Mochizuki kyahan +3"}

    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {ear1="Lifestorm Earring",ear2="Psystorm Earring",
        back=gear.NinBack.TP})

    sets.midcast.NinjutsuDebuff = {
        head="Hachiya Hatsuburi +2",neck="Stoicheion Medal",waist="Eschan Stone",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        hands="Mochizuki Tekko",ring2="Sangoma Ring",
        back=gear.NinBack.TP,feet="Hachiya Kyahan"}

    sets.midcast.NinjutsuBuff = {head="Adhemar Bonnet +1",neck="Ej Necklace",back=gear.NinBack.TP}

    sets.midcast.RA = {
        head="Adhemar Bonnet +1",neck="Ej Necklace",
        body="Hachiya Chainmail +2",hands="Hachiya Tekko",ring1="Beeline Ring",
        back=gear.NinBack.TP,legs="Nahtirah Trousers",feet="Qaaxo Leggings"}
    -- Hizamaru hizayoroi +2/Thurandaut Tights +1

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    
    -- Idle sets
    sets.idle = {
        head="Adhemar Bonnet +1",neck="Wiglen Gorget",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="flume belt +1",legs="Hizamaru hizayoroi +2",feet=gear.MovementFeet}

    sets.idle.Town = {main="Kikoku",sub="Izuna",ammo="Yamarang",
        head="Adhemar Bonnet +1",neck="Wiglen Gorget",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Hizamaru hizayoroi +2",feet=gear.MovementFeet}
    
    sets.idle.Weak = {
        head="Adhemar Bonnet +1",neck="Wiglen Gorget",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="flume belt +1",legs="Hizamaru hizayoroi +2",feet=gear.MovementFeet}
    
    -- Defense sets
    sets.defense.Evasion = {
        head="Adhemar Bonnet +1",neck="Ej Necklace",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Defending Ring",ring2="Beeline Ring",
        back=gear.NinBack.TP,waist="flume belt +1",legs="Nahtirah Trousers",feet="Mochizuki kyahan +3"}

    sets.defense.PDT = {ammo="Iron Gobbet",
        head="Adhemar Bonnet +1",neck="Twilight Torque",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="flume belt +1",legs="Nahtirah Trousers",feet="Mochizuki kyahan +3"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Adhemar Bonnet +1",neck="Twilight Torque",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="flume belt +1",legs="Nahtirah Trousers",feet="Mochizuki kyahan +3"}


    sets.Kiting = {feet=gear.MovementFeet}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Seki Shuriken",
        head="Adhemar bonnet +1",neck="Asperity Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}
    sets.engaged.Acc = {ammo="Yamarang",
        head="Adhemar Bonnet +1",neck="Asperity Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Mochizuki Chainmail",hands="Adhemar wristbands +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}
    sets.engaged.Evasion = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Ej Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Beeline Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}
    sets.engaged.Acc.Evasion = {ammo="Yamarang",
        head="Adhemar Bonnet +1",neck="Ej Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Beeline Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}
    sets.engaged.PDT = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Twilight Torque",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Defending Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}
    sets.engaged.Acc.PDT = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Twilight Torque",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Defending Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}

    -- Custom melee group: High Haste (~20% DW)
    sets.engaged.HighHaste = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Asperity Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}
    sets.engaged.Acc.HighHaste = {ammo="Yamarang",
        head="Adhemar Bonnet +1",neck="Asperity Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Mochizuki Chainmail",hands="Adhemar wristbands +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}
    sets.engaged.Evasion.HighHaste = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Ej Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Beeline Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}
    sets.engaged.Acc.Evasion.HighHaste = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Ej Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Beeline Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}
    sets.engaged.PDT.HighHaste = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Twilight Torque",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Defending Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}
    sets.engaged.Acc.PDT.HighHaste = {ammo="Yamarang",
        head="Adhemar Bonnet +1",neck="Twilight Torque",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Defending Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}

    -- Custom melee group: Embrava Haste (7% DW)
    sets.engaged.EmbravaHaste = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Asperity Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet Belt +1",legs="Manibozho Brais",feet="Mochizuki kyahan +3"}
    sets.engaged.Acc.EmbravaHaste = {ammo="Yamarang",
        head="Adhemar Bonnet +1",neck="Asperity Necklace",ear1="Telos Earring",ear2="Brutal Earring",
        body="Mochizuki Chainmail",hands="Adhemar wristbands +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Manibozho Brais",feet="Mochizuki kyahan +3"}
    sets.engaged.Evasion.EmbravaHaste = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Ej Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Beeline Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet Belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}
    sets.engaged.Acc.Evasion.EmbravaHaste = {ammo="Yamarang",
        head="Adhemar Bonnet +1",neck="Ej Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Beeline Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}
    sets.engaged.PDT.EmbravaHaste = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Twilight Torque",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Defending Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet Belt +1",legs="Manibozho Brais",feet="Mochizuki kyahan +3"}
    sets.engaged.Acc.PDT.EmbravaHaste = {ammo="Yamarang",
        head="Adhemar Bonnet +1",neck="Twilight Torque",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Defending Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Manibozho Brais",feet="Mochizuki kyahan +3"}

    -- Custom melee group: Max Haste (0% DW)
    sets.engaged.MaxHaste = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Asperity Necklace",ear1="Telos Earring",ear2="Brutal Earring",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet Belt +1",legs="Manibozho Brais",feet="Mochizuki kyahan +3"}
    sets.engaged.Acc.MaxHaste = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Asperity Necklace",ear1="Telos Earring",ear2="Brutal Earring",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Manibozho Brais",feet="Mochizuki kyahan +3"}
    sets.engaged.Evasion.MaxHaste = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Ej Necklace",ear1="Telos Earring",ear2="Brutal Earring",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Beeline Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet Belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}
    sets.engaged.Acc.Evasion.MaxHaste = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Ej Necklace",ear1="Telos Earring",ear2="Brutal Earring",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Beeline Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Hizamaru hizayoroi +2",feet="Mochizuki kyahan +3"}
    sets.engaged.PDT.MaxHaste = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Twilight Torque",ear1="Telos Earring",ear2="Brutal Earring",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Defending Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet Belt +1",legs="Manibozho Brais",feet="Mochizuki kyahan +3"}
    sets.engaged.Acc.PDT.MaxHaste = {ammo="Seki Shuriken",
        head="Adhemar Bonnet +1",neck="Twilight Torque",ear1="Telos Earring",ear2="Brutal Earring",
        body="Hachiya Chainmail +2",hands="Adhemar wristbands +1",ring1="Defending Ring",ring2="Epona's Ring",
        back=gear.NinBack.TP,waist="Windbuffet belt +1",legs="Manibozho Brais",feet="Mochizuki kyahan +3"}


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {body="Iga Ningi +2"}
    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Yonin = {}
    sets.buff.Innin = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Windbuffet belt +1, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(4, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(5, 3)
    else
        set_macro_page(1, 3)
    end
end
