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
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc','Hybrid')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')

    update_combat_form()
    
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
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
    sets.precast.JA.Meditate = {head="Myochin Kabuto",hands="Sakonji kote +3",back=gear.SamBack.TP}
    sets.precast.JA['Warding Circle'] = {head="Myochin Kabuto"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji kote +3"}
	sets.precast.JA.Seigan = {head="Kasuga Kabuto +1"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Flamma zucchetto +2",
        body="Kasuga Domaru +1",hands="Otronif Gloves",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Kasuga Haidate +1",feet="Flamma gambieras +2"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {Ammo="Knobkierrie",
        head="valorous mask",neck="Samurai's nodowa +2",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Sakonji domaru +3",hands="Valorous mitts",ring1="Flamma Ring",ring2="Karieyh Ring",
        back=gear.SamBack.WS,waist="Fotia Belt",legs="Wakido haidate +3",feet="Flamma gambieras +2"}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {back=gear.SamBack.WS})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {waist="Fotia Belt"}, {neck="Samurai's nodowa +2"}, {back=gear.SamBack.WS}, {feet="Flamma gambieras +2"})
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {waist="Fotia Belt"}, {neck="Samurai's nodowa +2"}, {back=gear.SamBack.WS}, {feet="Flamma gambieras +2"})
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {head="valorous mask"}, {neck="Fotia Gorget"}, {hands="Sakonji kote +3"}, {body="Kendatsuba samue +1"}, {back=gear.SamBack.WS})
    sets.precast.WS['Tachi: Fudo'].Mod = set_combine(sets.precast.WS['Tachi: Fudo'], {waist="Fotia Belt"}, {back=gear.SamBack.WS})

    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {neck="Samurai's nodowa +2"}, {ring2="Niqmaddu Ring"},{feet="Flamma gambieras +2"},{back=gear.SamBack.WS})
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"},{back=gear.SamBack.WS})
    sets.precast.WS['Tachi: Shoha'].Mod = set_combine(sets.precast.WS['Tachi: Shoha'], {waist="Fotia Belt"},{back=gear.SamBack.WS})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Thrud Earring",ear2="Telos Earring",},{back=gear.SamBack.WS})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Brutal earring",ear2="Telos Earring",},{back=gear.SamBack.WS})
    sets.precast.WS['Tachi: Rana'].Mod = set_combine(sets.precast.WS['Tachi: Rana'], {waist="Fotia Belt"},{back=gear.SamBack.WS})

    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"}, {back=gear.SamBack.WS})

    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"}, {back=gear.SamBack.WS})

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"}, {back=gear.SamBack.WS})

    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {neck="Fortia Gorget",waist="Fotia Belt"},{back=gear.SamBack.WS})

    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {neck="Fortia Gorget",waist="Fotia Belt"},{back=gear.SamBack.WS})



    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Flamma zucchetto +2",
        body="Kasuga Domaru +1",hands="Otronif Gloves",
        legs="Phorcys Dirs",feet="Flamma gambieras +2"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {main="Masamune", sub="Utu Grip",Ammo="Aurgelmir orb",
        head="Hizamaru Somen +1",neck="Wiglen Gorget",ear1="Brutal Earring",ear2="Telos Earring",
        body="Kendatsuba samue +1",hands="Wakido kote +3",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back=gear.SamBack.TP,waist="Flume Belt +1",legs="Kendatsuba hakama +1",feet="Danzo Sune-ate"}
    
    sets.idle.Field = {
        head="Flamma zucchetto +2",neck="Wiglen Gorget",ear1="Brutal earring",ear2="Telos Earring",
        body="Kendatsuba samue +1",hands="Wakido kote +3",ring1="Defending Ring",ring2="Paguroidea Ring",
        back=gear.SamBack.TP,waist="Flume Belt +1",legs="Kendatsuba hakama +1",feet="Danzo Sune-ate"}

    sets.idle.Weak = {
        head="Twilight Helm",neck="Wiglen Gorget",ear1="Brutal earring",ear2="Telos Earring",
        body="Twilight Mail",hands="Sakonji kote +3",ring1="Defending Ring",ring2="Paguroidea Ring",
        back=gear.SamBack.TP,waist="Flume Belt +1",legs="Kendatsuba hakama +1",feet="Danzo Sune-ate"}
    
    -- Defense sets
    sets.defense.PDT = {ammo="Iron Gobbet",
        head="Flamma zucchetto +2",neck="Twilight Torque",ear1="Brutal earring",ear2="Telos Earring",
        body="Kendatsuba samue +1",hands="Sakonji kote +3",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back=gear.SamBack.TP,waist="Flume Belt +1",legs="Kasuga Haidate +1",feet="Amm Greaves"}

    sets.defense.Reraise = {
        head="Twilight Helm",neck="Twilight Torque",ear1="Brutal earring",ear2="Telos Earring",
        body="Twilight Mail",hands="Sakonji kote +3",ring1="Defending Ring",ring2="Paguroidea Ring",
        back=gear.SamBack.TP,waist="Flume Belt +1",legs="Kendatsuba hakama +1",feet="Flamma gambieras +2"}

    sets.defense.MDT = {Ranged="Demonry Stone",
        head="Flamma zucchetto +2",neck="Twilight Torque",ear1="Brutal earring",ear2="Telos Earring",
        body="Kendatsuba samue +1",hands="Wakido kote +3",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape +1",waist="Flume Belt +1",legs="Kendatsuba hakama +1",feet="Amm Greaves"}

    sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {Ammo="Aurgelmir orb",
        head="Flamma zucchetto +2",neck="Samurai's nodowa +2",ear1="Brutal earring",ear2="Telos Earring",
        body="Kendatsuba samue +1",hands="Wakido kote +3",ring1="Niqmaddu Ring",ring2="Flamma ring",
        back=gear.SamBack.TP,waist="Ioskeha Belt +1",legs="Kendatsuba hakama +1",feet="Flamma gambieras +2"}
    sets.engaged.Acc = {Ammo="Aurgelmir orb",
        head="Flamma zucchetto +2",neck="Samurai's nodowa +2",ear1="Brutal earring",ear2="Telos Earring",
        body="Kendatsuba samue +1",hands="Buremete Gloves",ring1="Rajas Ring",ring2="Flamma ring",
        back=gear.SamBack.TP,waist="Ioskeha Belt +1",legs="Kendatsuba hakama +1",feet="Flamma gambieras +2"}
    sets.engaged.PDT = {Ammo="Aurgelmir orb",
        head="Flamma zucchetto +2",neck="Twilight Torque",ear1="Brutal earring",ear2="Telos Earring",
        body="Kendatsuba samue +1",hands="Otronif gloves",ring1="Defending Ring",ring2="Dark Ring",
        back=gear.SamBack.TP,waist="Ioskeha Belt +1",legs="Kendatsuba hakama +1",feet="Amm Greaves"}
    sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
        head="Flamma zucchetto +2",neck="Twilight Torque",ear1="Brutal earring",ear2="Telos Earring",
        body="Kendatsuba samue +1",hands="Wakido kote +3",ring1="Defending Ring",ring2="Flamma ring",
        back="Takaha Mangle",waist="Ioskeha Belt +1",legs="Kendatsuba hakama +1",feet="Amm Greaves"}
    sets.engaged.Reraise = {Ammo="Aurgelmir orb",
        head="Twilight Helm",neck="Twilight Torque",ear1="Brutal earring",ear2="Telos Earring",
        body="Twilight Mail",hands="Sakonji kote +3",ring1="Beeline Ring",ring2="Flamma ring",
        back="Takaha Mangle",waist="Ioskeha Belt +1",legs="Kendatsuba hakama +1",feet="Flamma gambieras +2"}
    sets.engaged.Acc.Reraise = {Ammo="Aurgelmir orb",
        head="Twilight Helm",neck="Twilight Torque",ear1="Brutal earring",ear2="Telos Earring",
        body="Twilight Mail",hands="Wakido kote +3",ring1="Beeline Ring",ring2="Flamma ring",
        back="Takaha Mangle",waist="Ioskeha Belt +1",legs="Kendatsuba hakama +1",feet="Flamma gambieras +2"}
	sets.engaged.Hybrid = {Ammo="Aurgelmir orb",
        head="Flamma zucchetto +2",neck="Samurai's nodowa +2",ear1="Brutal earring",ear2="Telos Earring",
        body="Kendatsuba samue +1",hands="Wakido kote +3",ring1="Defending Ring",ring2="Flamma ring",
        back=gear.SamBack.TP,waist="Ioskeha Belt +1",legs="Kendatsuba hakama +1",feet="Amm Greaves"}
        
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
    -- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
    sets.engaged.Adoulin = {Ammo="Aurgelmir orb",
        head="Flamma zucchetto +2",neck="Samurai's nodowa +2",ear1="Brutal earring",ear2="Telos Earring",
        body="Kendatsuba samue +1",hands="Buremete Gloves",ring1="Rajas Ring",ring2="Flamma ring",
        back=gear.SamBack.TP,waist="Ioskeha Belt +1",legs="Kasuga Haidate +1",feet="Flamma gambieras +2"}
    sets.engaged.Adoulin.Acc = {Ammo="Aurgelmir orb",
        head="Flamma zucchetto +2",neck="Samurai's nodowa +2",ear1="Brutal earring",ear2="Telos Earring",
        body="Kendatsuba samue +1",hands="Wakido kote +3",ring1="Rajas Ring",ring2="Flamma ring",
        back=gear.SamBack.TP,waist="Anguinus belt",legs="Kasuga Haidate +1",feet="Xaddi Boots"}
    sets.engaged.Adoulin.PDT = {Ammo="Aurgelmir orb",
        head="Flamma zucchetto +2",neck="Twilight Torque",ear1="Brutal earring",ear2="Telos Earring",
        body="Kendatsuba samue +1",hands="Sakonji kote +3",ring1="Defending Ring",ring2="Flamma ring",
        back="Iximulew Cape",waist="Ioskeha Belt +1",legs="Kasuga Haidate +1",feet="Flamma gambieras +2"}
    sets.engaged.Adoulin.Acc.PDT = {ammo="Honed Tathlum",
        head="Flamma zucchetto +2",neck="Twilight Torque",ear1="Brutal earring",ear2="Telos Earring",
        body="Kendatsuba samue +1",hands="Sakonji kote +3",ring1="Defending Ring",ring2="Flamma ring",
        back="Letalis Mantle",waist="Ioskeha Belt +1",legs="Otronif Brais +1",feet="Flamma gambieras +2"}
    sets.engaged.Adoulin.Reraise = {Ammo="Aurgelmir orb",
        head="Twilight Helm",neck="Twilight Torque",ear1="Brutal earring",ear2="Telos Earring",
        body="Twilight Mail",hands="Wakido kote +3",ring1="Beeline Ring",ring2="Flamma ring",
        back="Ik Cape",waist="Ioskeha Belt +1",legs="Kasuga Haidate +1",feet="Flamma gambieras +2"}
    sets.engaged.Adoulin.Acc.Reraise = {Ammo="Aurgelmir orb",
        head="Twilight Helm",neck="Twilight Torque",ear1="Brutal earring",ear2="Telos Earring",
        body="Twilight Mail",hands="Wakido kote +3",ring1="Beeline Ring",ring2="Flamma ring",
        back="Letalis Mantle",waist="Ioskeha Belt +1",legs="Kasuga Haidate +1",feet="Flamma gambieras +2"}
	sets.engaged.Adoulin.Hybrid = {Ammo="Aurgelmir orb",
        head="Flamma zucchetto +2",neck="Samurai's nodowa +2",ear1="Brutal earring",ear2="Telos Earring",
        body="Kendatsuba samue +1",hands="Wakido kote +3",ring1="Defending Ring",ring2="Flamma ring",
        back=gear.SamBack.TP,waist="Flume Belt +1",legs="Kendatsuba hakama +1",feet="Amm Greaves"}


    sets.buff.Sekkanoki = {hands="Unkai Kote +2"}
    sets.buff.Sengikori = {feet="Unkai Sune-ate +2"}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
        if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
            if spell.english:startswith("Tachi:") then
                send_command('@input /ws "Penta Thrust" '..spell.target.raw)
                eventArgs.cancel = true
            end
        end
    end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
        end
    end
end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 11)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 11)
    elseif player.sub_job == 'THF' then
        set_macro_page(7, 11)
    elseif player.sub_job == 'NIN' then
        set_macro_page(7, 11)
    else
        set_macro_page(7, 11)
    end
end
