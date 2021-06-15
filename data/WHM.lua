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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main=gear.FastcastStaff,ammo="Homiliary",
        head="Inyanga tiara +2",neck="Orison Locket",ear1 ="Malignance earring",ear2="Loquacious Earring",
        body="Ebers Bliaud +1",hands="Fanatic gloves",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Ayanmo cosciales +2",feet="Chelona Boots +1"}
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Orison Pantaloons +2"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {main="Queller rod",sub="Sors shield",ammo="Impatiens"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Inyanga tiara +2",ear1="Roundel Earring",
        body="Ebers Bliaud +1",hands="Yaoyotl Gloves",
        back="Refraction Cape",legs="Ayanmo cosciales +2",feet="Gendewitha Galoshes"}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = ""
    sets.precast.WS = {
        head="Inyanga tiara +2",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Ebers Bliaud +1",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Refraction Cape",waist=gear.ElementalBelt,legs="Ayanmo cosciales +2",feet="Gendewitha Galoshes"}
    
    sets.precast.WS['Flash Nova'] = {
        head="Inyanga tiara +2",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Ebers Bliaud +1",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Strendu Ring",
        back="Toro Cape",waist="Thunder Belt",legs="Ayanmo cosciales +2",feet="Gendewitha Galoshes"}
    

    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Inyanga tiara +2",ear2="Loquacious Earring",
        body="Ebers Bliaud +1",hands="Dynasty Mitts",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Goading Belt",legs="Ayanmo cosciales +2",feet="Gendewitha Galoshes"}
    
    -- Cure sets
    gear.default.obi_waist = "Goading Belt"
    gear.default.obi_back = "Mending Cape"

    sets.midcast.CureSolace = {main="Queller rod",sub="Sors shield",ammo="Homiliary",
        head="Gendewitha Caubeen",neck="Orison Locket",ear1="Mendicant's earring",ear2="Orison Earring",
        body="Ebers Bliaud +1",hands="Bokwus Gloves",ring1="Ephedra",ring2="Sirona's Ring",
        back="Mending Cape",waist=gear.ElementalObi,legs="Ebers pantaloons +1",feet="Piety Duckbills +1"}

    sets.midcast.Cure = {main="Queller rod",sub="Sors shield",ammo="Homiliary",
        head="Gendewitha Caubeen",neck="Orison Locket",ear1="Mendicant's earring",ear2="Orison Earring",
        body="Ebers Bliaud +1",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Sirona's Ring",
        back="Mending Cape",waist=gear.ElementalObi,legs="Ebers pantaloons +1",feet="Piety Duckbills +1"}

    sets.midcast.Curaga = {main="Queller rod",sub="Sors shield",ammo="Homiliary",
        head="Gendewitha Caubeen",neck="Orison Locket",ear1="Mendicant's earring",ear2="Orison Earring",
        body="Ebers Bliaud +1",hands="Theophany Mitts",ring1="Prolix Ring",ring2="Sirona's Ring",
        back="Mending Cape",waist=gear.ElementalObi,legs="Ebers pantaloons +1",feet="Piety Duckbills +1"}

    sets.midcast.CureMelee = {ammo="Homiliary",
        head="Gendewitha Caubeen",neck="Orison Locket",ear1="Mendicant's earring",ear2="Orison Earring",
        body="Ebers Bliaud +1",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Sirona's Ring",
        back="Mending Cape",waist=gear.ElementalObi,legs="Ebers pantaloons +1",feet="Piety Duckbills +1"}

    sets.midcast.Cursna = {main="Gada",sub="Sors shield",
        head="Orison Cap +2",neck="Malison Medallion",
        body="Ebers Bliaud +1",hands="Fanatic gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Mending Cape",waist="Goading Belt",legs="Ebers pantaloons +1",feet="Gendewitha Galoshes"}

    sets.midcast.StatusRemoval = {
        head="Orison Cap +2",legs="Orison Pantaloons +2"}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {main="Gada",sub="Sors shield",
        head="Umuthi Hat",neck="Colossus's Torque",
        body="Manasa Chasuble",hands="Dynasty Mitts",
        back="Mending Cape",waist="Olympus Sash",legs="Ebers pantaloons +1",feet="Orison Duckbills +2"}

    sets.midcast.Stoneskin = {
        head="Inyanga tiara +2",neck="Orison Locket",ear2="Loquacious Earring",
        body="Ebers Bliaud +1",hands="Dynasty Mitts",
        back="Swith Cape +1",waist="Siegel Sash",legs="Ayanmo cosciales +2",feet="Gendewitha Galoshes"}

    sets.midcast.Auspice = {hands="Dynasty Mitts",feet="Orison Duckbills +2"}

    sets.midcast.BarElement = {main="Gada",sub="Sors shield",
        head="Orison Cap +2",neck="Colossus's Torque",
        body="Orison Bliaud +2",hands="Orison Mitts +2",
        back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons",feet="Orison Duckbills +2"}

    sets.midcast.Regen = {main="Queller Rod",sub="Sors shield",
        head="Inyanga tiara +2",body="Piety Briault",hands="Orison Mitts +2",
        legs="Theophany Pantaloons"}

    sets.midcast.Protectra = {ring1="Defending Ring",feet="Piety Duckbills +1"}

    sets.midcast.Shellra = {ring1="Defending Ring",legs="Piety Pantaloons"}


    sets.midcast['Divine Magic'] = {main="Queller Rod",sub="Sors shield",
        head="Inyanga tiara +2",neck="Colossus's Torque",ear1="Psystorm Earring",ear2="Mendicant's earring",
        body="Ebers Bliaud +1",hands="Yaoyotl Gloves",ring2="Sangoma Ring",
        back="Refraction Cape",waist=gear.ElementalObi,legs="Theophany Pantaloons",feet="Gendewitha Galoshes"}

    sets.midcast['Dark Magic'] = {main="Queller Rod", sub="Sors shield",
        head="Inyanga tiara +2",neck="Aesir Torque",ear1="Psystorm Earring",ear2="Mendicant's earring",
        body="Ebers Bliaud +1",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Piety Duckbills +1"}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Lehbrailg +2", sub="Mephitis Grip",
        head="Inyanga tiara +2",neck="Weike Torque",ear1="Psystorm Earring",ear2="Mendicant's earring",
        body="Ebers Bliaud +1",hands="Yaoyotl Gloves",ring1="Aquasoul Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Piety Duckbills +1"}

    sets.midcast.IntEnfeebles = {main="Lehbrailg +2", sub="Mephitis Grip",
        head="Inyanga tiara +2",neck="Weike Torque",ear1="Psystorm Earring",ear2="Mendicant's earring",
        body="Ebers Bliaud +1",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Piety Duckbills +1"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main=gear.Staff.HMP, 
        body="Ebers bliaud +1",hands="Inyanga dastanas +2",
        waist="Austerity Belt",legs="Assiduity pants +1",feet="Chelona Boots +1"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Daybreak", sub="Sors shield",ammo="Homiliary",
        head="Inyanga tiara +2",neck="Twilight Torque",ear1="Mendicant's earring",ear2="Loquacious Earring",
        body="Ebers bliaud +1",hands="Inyanga dastanas +2",ring1="Defending Ring",ring2="Inyanga Ring",
        back="Umbra Cape",waist="Witful Belt",legs="Assiduity pants +1",feet="Inyanga crackows +2"}

    sets.idle.PDT = {main="Queller Rod", sub="Sors shield",ammo="Homiliary",
        head="Inyanga tiara +2",neck="Twilight Torque",ear1="Mendicant's earring",ear2="Loquacious Earring",
        body="Ebers bliaud +1",hands="Fanatic gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbra Cape",waist="Witful Belt",legs="Ayanmo cosciales +2",feet="Inyanga crackows +2"}

    sets.idle.Town = {main="Queller Rod", sub="Sors shield",ammo="Homiliary",
        head="Inyanga tiara +2",neck="Twilight Torque",ear1="Mendicant's earring",ear2="Loquacious Earring",
        body="Ebers bliaud +1",hands="Inyanga dastanas +2",ring1="Defending Ring",ring2="Inyanga Ring",
        back="Umbra Cape",waist="Witful Belt",legs="Assiduity pants +1",feet="Inyanga crackows +2"}
    
    sets.idle.Weak = {main="Queller Rod",sub="Sors shield",ammo="Homiliary",
        head="Inyanga tiara +2",neck="Twilight Torque",ear1="Mendicant's earring",ear2="Loquacious Earring",
        body="Ebers bliaud +1",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Meridian Ring",
        back="Umbra Cape",waist="Witful Belt",legs="Assiduity pants +1",feet="Gendewitha Galoshes"}
    
    -- Defense sets

    sets.defense.PDT = {main=gear.Staff.PDT,sub="Achaq Grip",
        head="Gendewitha Caubeen",neck="Twilight Torque",
        body="Ebers bliaud +1",hands="Fanatic gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbra Cape",legs="Ayanmo cosciales +2",feet="Gendewitha Galoshes"}

    sets.defense.MDT = {main=gear.Staff.PDT,sub="Achaq Grip",
        head="Inyanga tiara +2",neck="Twilight Torque",
        body="Ebers Bliaud +1",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Mending Cape",legs="Bokwus Slops",feet="Gendewitha Galoshes"}

    sets.Kiting = {feet="Inyanga crackows +2"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
        head="Inyanga tiara +2",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Ebers Bliaud +1",hands="Dynasty Mitts",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Umbra Cape",waist="Goading Belt",legs="Ayanmo cosciales +2",feet="Gendewitha Galoshes"}


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Orison Mitts +2",back="Mending Cape"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Mending Cape"
    else
        gear.default.obi_back = "Toro Cape"
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(4, 14)
end
