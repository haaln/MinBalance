local mod = get_mod("MinBalance")

-- Buff and Talent Functions
local function merge(dst, src)
    for k, v in pairs(src) do
        dst[k] = v
    end
    return dst
end
function mod.add_talent_buff_template(self, hero_name, buff_name, buff_data, extra_data)   
    local new_talent_buff = {
        buffs = {
            merge({ name = buff_name }, buff_data),
        },
    }
    if extra_data then
        new_talent_buff = merge(new_talent_buff, extra_data)
    elseif type(buff_data[1]) == "table" then
        new_talent_buff = {
            buffs = buff_data,
        }
        if new_talent_buff.buffs[1].name == nil then
            new_talent_buff.buffs[1].name = buff_name
        end
    end
    TalentBuffTemplates[hero_name][buff_name] = new_talent_buff
    BuffTemplates[buff_name] = new_talent_buff
    local index = #NetworkLookup.buff_templates + 1
    NetworkLookup.buff_templates[index] = buff_name
    NetworkLookup.buff_templates[buff_name] = index
end
function mod.modify_talent_buff_template(self, hero_name, buff_name, buff_data, extra_data)   
    local new_talent_buff = {
        buffs = {
            merge({ name = buff_name }, buff_data),
        },
    }
    if extra_data then
        new_talent_buff = merge(new_talent_buff, extra_data)
    elseif type(buff_data[1]) == "table" then
        new_talent_buff = {
            buffs = buff_data,
        }
        if new_talent_buff.buffs[1].name == nil then
            new_talent_buff.buffs[1].name = buff_name
        end
    end

    local original_buff = TalentBuffTemplates[hero_name][buff_name]
    local merged_buff = original_buff
    for i=1, #original_buff.buffs do
        if new_talent_buff.buffs[i] then
            merged_buff.buffs[i] = merge(original_buff.buffs[i], new_talent_buff.buffs[i])
        elseif original_buff[i] then
            merged_buff.buffs[i] = merge(original_buff.buffs[i], new_talent_buff.buffs)
        else
            merged_buff.buffs = merge(original_buff.buffs, new_talent_buff.buffs)
        end
    end

    TalentBuffTemplates[hero_name][buff_name] = merged_buff
    BuffTemplates[buff_name] = merged_buff
end
function mod.add_buff_template(self, buff_name, buff_data)   
    local new_talent_buff = {
        buffs = {
            merge({ name = buff_name }, buff_data),
        },
    }
    BuffTemplates[buff_name] = new_talent_buff
    local index = #NetworkLookup.buff_templates + 1
    NetworkLookup.buff_templates[index] = buff_name
    NetworkLookup.buff_templates[buff_name] = index
end
function mod.add_proc_function(self, name, func)
    ProcFunctions[name] = func
end
function mod.add_buff_function(self, name, func)
    BuffFunctionTemplates.functions[name] = func
end
function mod.modify_talent(self, career_name, tier, index, new_talent_data)
	local career_settings = CareerSettings[career_name]
    local hero_name = career_settings.profile_name
	local talent_tree_index = career_settings.talent_tree_index

	local old_talent_name = TalentTrees[hero_name][talent_tree_index][tier][index]
	local old_talent_id_lookup = TalentIDLookup[old_talent_name]
	local old_talent_id = old_talent_id_lookup.talent_id
	local old_talent_data = Talents[hero_name][old_talent_id]

    Talents[hero_name][old_talent_id] = merge(old_talent_data, new_talent_data)
end
function mod.add_buff(self, owner_unit, buff_name)
    if Managers.state.network ~= nil then
        local network_manager = Managers.state.network
        local network_transmit = network_manager.network_transmit

        local unit_object_id = network_manager:unit_game_object_id(owner_unit)
        local buff_template_name_id = NetworkLookup.buff_templates[buff_name]
        local is_server = Managers.player.is_server

        if is_server then
            local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")

            buff_extension:add_buff(buff_name)
            network_transmit:send_rpc_clients("rpc_add_buff", unit_object_id, buff_template_name_id, unit_object_id, 0, false)
        else
            network_transmit:send_rpc_server("rpc_add_buff", unit_object_id, buff_template_name_id, unit_object_id, 0, true)
        end
    end
end
function mod.add_talent(self, career_name, tier, index, new_talent_name, new_talent_data)
    local career_settings = CareerSettings[career_name]
    local hero_name = career_settings.profile_name
    local talent_tree_index = career_settings.talent_tree_index

    local new_talent_index = #Talents[hero_name] + 1

    Talents[hero_name][new_talent_index] = merge({
        name = new_talent_name,
        description = new_talent_name .. "_desc",
        icon = "icons_placeholder",
        num_ranks = 1,
        buffer = "both",
        requirements = {},
        description_values = {},
        buffs = {},
        buff_data = {},
    }, new_talent_data)

    TalentTrees[hero_name][talent_tree_index][tier][index] = new_talent_name
    TalentIDLookup[new_talent_name] = {
        talent_id = new_talent_index,
        hero_name = hero_name
    }
end

--Fix clients getting too much ult recharge on explosions
--Fix clients getting too much ult recharge on explosions
--Fix clients getting too much ult recharge on explosions
mod:add_proc_function("reduce_activated_ability_cooldown", function (player, buff, params)
	local player_unit = player.player_unit

	if Unit.alive(player_unit) then
		local attack_type = params[2]
		local target_number = params[4]
		local career_extension = ScriptUnit.extension(player_unit, "career_system")

		if not attack_type or attack_type == "heavy_attack" or attack_type == "light_attack" then
			career_extension:reduce_activated_ability_cooldown(buff.bonus)
		elseif attack_type == "aoe" then
            return
		elseif target_number and target_number == 1 then
			career_extension:reduce_activated_ability_cooldown(buff.bonus)
		end
	end
end)


--Mecenary Talents
--Mecenary Talents
--Mecenary Talents
--Mecenary Talents
mod:modify_talent_buff_template("empire_soldier", "markus_mercenary_ability_cooldown_on_damage_taken", {
    bonus = 0.5
})


-- Footknight Talents
-- Footknight Talents
-- Footknight Talents
-- Footknight Talents
mod:modify_talent_buff_template("empire_soldier", "markus_knight_ability_cooldown_on_damage_taken", {
   bonus = 0.5
})

mod:modify_talent_buff_template("empire_soldier", "markus_knight_power_level_on_stagger_elite_buff", {
    duration = 15
})
mod:modify_talent("es_knight", 2, 2, {
    description_values = {
        {
            value_type = "percent",
            value = 0.15 --BuffTemplates.markus_knight_power_level_on_stagger_elite_buff.multiplier
        },
        {
            value = 15 --BuffTemplates.markus_knight_power_level_on_stagger_elite_buff.duration
        }
    },
})
mod:modify_talent_buff_template("empire_soldier", "markus_knight_attack_speed_on_push_buff", {
    duration = 10
})
mod:modify_talent("es_knight", 2, 3, {
    description_values = {
        {
            value_type = "percent",
            value = 0.15 --BuffTemplates.markus_knight_attack_speed_on_push_buff.multiplier
        },
        {
            value = 10 --BuffTemplates.markus_knight_attack_speed_on_push_buff.duration
        }
    },
})
mod:modify_talent_buff_template("empire_soldier", "markus_knight_cooldown_on_stagger_elite", {
    buff_func = "buff_on_stagger_enemy"
})
mod:modify_talent_buff_template("empire_soldier", "markus_knight_cooldown_buff", {
    duration = 1.5,
    multiplier = 2,
	icon = "markus_knight_improved_passive_defence_aura"
})
mod:add_text("markus_knight_cooldown_on_stagger_elite_desc", "Subjecting an elite enemy to a stagger state grants the player an accelerated cooldown of their career skill by a magnitude of 200%% for 1500 milliseconds.")

mod:add_talent_buff_template("empire_soldier", "markus_knight_heavy_buff", {
    max_stacks = 1,
    stat_buff = "power_level_melee",
    icon = "markus_knight_ability_hit_target_damage_taken",
    multiplier = 1,
    duration = 10,
    refresh_durations = true,
})
mod:modify_talent("es_knight", 6, 2, {
    buffs = {
        "markus_knight_heavy_buff",
    },
    description = "rebaltourn_markus_knight_heavy_buff_desc",
    description_values = {},
})
mod:add_text("rebaltourn_markus_knight_heavy_buff_desc", "Valiant Charge increases Melee Power by 100%% for 10 seconds.")



--Huntsman
--Huntsman
--Huntsman
--Huntsman
ActivatedAbilitySettings.es_1[1].cooldown = 60
mod:modify_talent_buff_template("empire_soldier", "markus_huntsman_passive_crit_aura", {
    range = 20
})
mod:add_talent_buff_template("empire_soldier", "markus_huntsman_reload_passive", {
    stat_buff = "reload_speed",
	max_stacks = 1,
	multiplier = -0.15
})
table.insert(PassiveAbilitySettings.es_1.buffs, "markus_huntsman_reload_passive")
table.insert(PassiveAbilitySettings.es_1.buffs, "kerillian_waywatcher_passive_increased_zoom")
mod:add_text("career_passive_desc_es_1b", "Double effective range for ranged weapons and 15% increased reload speed.")

mod:modify_talent_buff_template("empire_soldier", "markus_huntsman_activated_ability_increased_reload_speed", {
	multiplier = -0.25
})
mod:modify_talent_buff_template("empire_soldier", "markus_huntsman_activated_ability_increased_reload_speed_duration", {
	multiplier = -0.25
})
mod:modify_talent_buff_template("empire_soldier", "markus_huntsman_activated_ability", {
	reload_speed_multiplier = -0.25
})
mod:add_talent_buff_template("empire_soldier", "gs_sniper_buff_1", {
    multiplier = -1,
    stat_buff = "reduced_spread",
})
mod:add_talent_buff_template("empire_soldier", "gs_sniper_buff_2", {
    multiplier = -1,
    stat_buff = "reduced_spread_hit",
})
mod:add_talent_buff_template("empire_soldier", "gs_sniper_buff_3", {
    multiplier = -3,
    stat_buff = "reduced_spread_moving",
})
mod:add_talent_buff_template("empire_soldier", "gs_sniper_buff_4", {
    multiplier = -3,
    stat_buff = "reduced_spread_shot",
})




--Waystalker
--Waystalker
--Waystalker
--Waystalker
--Waystalker
--Waystalker

mod:modify_talent("we_waywatcher", 2, 1, {
	description = "kerillian_waywatcher_movement_speed_on_special_kill_desc",
	name = "kerillian_waywatcher_movement_speed_on_special_kill",
	num_ranks = 1,
	icon = "kerillian_waywatcher_movement_speed_on_special_kill",
	description_values = {
		{
			value_type = "baked_percent",
			value = 1.15
		},
		{
			value = 10
		}
	},
	buffs = {
		"kerillian_waywatcher_movement_speed_on_special_kill"
	}
})

mod:modify_talent("we_waywatcher", 2, 3, {
    description_values = {
        {
            value_type = "baked_percent",
            value = 1.20
        },
        {
            value = 10
        }
    }
})
mod:modify_talent_buff_template("wood_elf", "kerillian_waywatcher_attack_speed_on_ranged_headshot_buff", {
    duration = 30,
	multiplier = 0.20
})





-- Battle Wizard Talents
-- Battle Wizard Talents
-- Battle Wizard Talents
-- Battle Wizard Talents
-- Battle Wizard Talents
mod:modify_talent_buff_template("bright_wizard", "sienna_adept_damage_reduction_on_ignited_enemy_buff", {
    multiplier = -0.01, -- -0.1,
	max_stacks = 1
})
mod:modify_talent("bw_adept", 5, 1, {
    description = "rebaltourn_sienna_adept_damage_reduction_on_ignited_enemy_desc",
    description_values = {
        {
            value_type = "percent",
            value = -0.01 --BuffTemplates.sienna_adept_damage_reduction_on_ignited_enemy_buff.multiplier
        }
    },
})
