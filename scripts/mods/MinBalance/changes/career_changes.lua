local mod = get_mod("MinBalance")

-- Footknight
-- Made Widecharge the standard Footknight ult
ActivatedAbilitySettings.es_2[1].cooldown = 40
mod:hook_origin(CareerAbilityESKnight, "_run_ability", function(self)
	self:_stop_priming()

	local owner_unit = self._owner_unit
	local is_server = self._is_server
	local status_extension = self._status_extension
	local career_extension = self._career_extension
	local buff_extension = self._buff_extension
	local talent_extension = ScriptUnit.extension(owner_unit, "talent_system")
	local network_manager = self._network_manager
	local network_transmit = network_manager.network_transmit
	local owner_unit_id = network_manager:unit_game_object_id(owner_unit)
	local buff_name = "markus_knight_activated_ability"

	buff_extension:add_buff(buff_name, {
		attacker_unit = owner_unit
	})

	if talent_extension:has_talent("markus_knight_ability_invulnerability", "empire_soldier", true) then
		buff_name = "markus_knight_ability_invulnerability_buff"

		buff_extension:add_buff(buff_name, {
			attacker_unit = owner_unit
		})

		local buff_template_name_id = NetworkLookup.buff_templates[buff_name]

		if is_server then
			network_transmit:send_rpc_clients("rpc_add_buff", owner_unit_id, buff_template_name_id, owner_unit_id, 0, false)
		else
			network_transmit:send_rpc_server("rpc_add_buff", owner_unit_id, buff_template_name_id, owner_unit_id, 0, false)
		end
	end
	
	if talent_extension:has_talent("markus_knight_wide_charge", "empire_soldier", true) then
		buff_name = "markus_knight_heavy_buff"

		buff_extension:add_buff(buff_name, {
			attacker_unit = owner_unit
		})

		local buff_template_name_id = NetworkLookup.buff_templates[buff_name]

		if is_server then
			network_transmit:send_rpc_clients("rpc_add_buff", owner_unit_id, buff_template_name_id, owner_unit_id, 0, false)
		else
			network_transmit:send_rpc_server("rpc_add_buff", owner_unit_id, buff_template_name_id, owner_unit_id, 0, false)
		end
	end

	status_extension:set_noclip(true)

	local hold_duration = 0.03
	local windup_duration = 0.15
	status_extension.do_lunge = {
		animation_end_event = "foot_knight_ability_charge_hit",
		allow_rotation = false,
		falloff_to_speed = 5,
		first_person_animation_end_event = "foot_knight_ability_charge_hit",
		dodge = true,
		first_person_animation_event = "foot_knight_ability_charge_start",
		first_person_hit_animation_event = "charge_react",
		damage_start_time = 0.3,
		duration = 1.5,
		initial_speed = 20,
		animation_event = "foot_knight_ability_charge_start",
		lunge_events = self._lunge_events,
		speed_function = function (lunge_time, duration)
			local end_duration = 0.25
			local rush_time = lunge_time - hold_duration - windup_duration
			local rush_duration = duration - hold_duration - windup_duration - end_duration
			local start_speed = 0
			local windup_speed = -3
			local end_speed = 20
			local rush_speed = 15
			local normal_move_speed = 2

			if rush_time <= 0 and hold_duration > 0 then
				local t = -rush_time / (hold_duration + windup_duration)

				return math.lerp(0, -1, t)
			elseif rush_time < windup_duration then
				local t_value = rush_time / windup_duration
				local interpolation_value = math.cos((t_value + 1) * math.pi * 0.5)

				return math.min(math.lerp(windup_speed, start_speed, interpolation_value), rush_speed)
			elseif rush_time < rush_duration then
				local t_value = rush_time / rush_duration
				local acceleration = math.min(rush_time / (rush_duration / 3), 1)
				local interpolation_value = math.cos(t_value * math.pi * 0.5)
				local offset = nil
				local step_time = 0.25

				if rush_time > 8 * step_time then
					offset = 0
				elseif rush_time > 7 * step_time then
					offset = (rush_time - 1.4) / step_time
				elseif rush_time > 6 * step_time then
					offset = (rush_time - 6 * step_time) / step_time
				elseif rush_time > 5 * step_time then
					offset = (rush_time - 5 * step_time) / step_time
				elseif rush_time > 4 * step_time then
					offset = (rush_time - 4 * step_time) / step_time
				elseif rush_time > 3 * step_time then
					offset = (rush_time - 3 * step_time) / step_time
				elseif rush_time > 2 * step_time then
					offset = (rush_time - 2 * step_time) / step_time
				elseif step_time < rush_time then
					offset = (rush_time - step_time) / step_time
				else
					offset = rush_time / step_time
				end

				local offset_multiplier = 1 - offset * 0.4
				local speed = offset_multiplier * acceleration * acceleration * math.lerp(end_speed, rush_speed, interpolation_value)

				return speed
			else
				local t_value = (rush_time - rush_duration) / end_duration
				local interpolation_value = 1 + math.cos((t_value + 1) * math.pi * 0.5)

				return math.lerp(normal_move_speed, end_speed, interpolation_value)
			end
		end,
		damage = {
			offset_forward = 2.4,
			height = 1.8,
			depth_padding = 0.6,
			hit_zone_hit_name = "full",
			ignore_shield = false,
			collision_filter = "filter_explosion_overlap_no_player",
			interrupt_on_max_hit_mass = true,
			power_level_multiplier = 1,
			interrupt_on_first_hit = false,
			damage_profile = "markus_knight_charge",
			width = 2,
			allow_backstab = false,
			stagger_angles = {
				max = 80,
				min = 25
			},
			on_interrupt_blast = {
				allow_backstab = false,
				radius = 3,
				power_level_multiplier = 1,
				hit_zone_hit_name = "full",
				damage_profile = "markus_knight_charge_blast",
				ignore_shield = false,
				collision_filter = "filter_explosion_overlap_no_player"
			}
		}
	}

	status_extension.do_lunge.damage.width = 5
	status_extension.do_lunge.damage.interrupt_on_max_hit_mass = false


	career_extension:start_activated_ability_cooldown()
	self:_play_vo()
end)
--Fix Hero Time not proccing if ally already disabled
mod:add_buff_function("markus_knight_movespeed_on_incapacitated_ally", function (owner_unit, buff, params)
    if not Managers.state.network.is_server then
        return
    end

    local side = Managers.state.side.side_by_unit[owner_unit]
    local player_and_bot_units = side.PLAYER_AND_BOT_UNITS
    local num_units = #player_and_bot_units
    local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")
    local buff_system = Managers.state.entity:system("buff_system")
    local template = buff.template
    local buff_to_add = template.buff_to_add
    local disabled_allies = 0

    for i = 1, num_units, 1 do
        local unit = player_and_bot_units[i]
        local status_extension = ScriptUnit.extension(unit, "status_system")
        local is_disabled = status_extension:is_disabled()

        if is_disabled then
            disabled_allies = disabled_allies + 1
        end
    end

	if not buff.disabled_allies then
		buff.disabled_allies = 0
	end

    if buff_extension:has_buff_type(buff_to_add) then
        if disabled_allies <= buff.disabled_allies then
            local buff_id = buff.buff_id

            if buff_id then
                buff_system:remove_server_controlled_buff(owner_unit, buff_id)

                buff.buff_id = nil
            end
        end
    elseif disabled_allies > 0 and disabled_allies > buff.disabled_allies then
        buff.buff_id = buff_system:add_buff(owner_unit, buff_to_add, owner_unit, true)
    end

	buff.disabled_allies = disabled_allies
end)



-- Grail Knight Changes
ActivatedAbilitySettings.es_4[1].cooldown = 60
mod:add_text("markus_questing_knight_crit_can_insta_kill_desc", "Critical Strikes instantly slay enemies if their current health is less than 3 times the amount of damage of the Critical Strike. Half effect versus Lords and Monsters.")
mod:modify_talent_buff_template("empire_soldier", "markus_questing_knight_crit_can_insta_kill",  {
	damage_multiplier = 3
})

--Waystalker
ActivatedAbilitySettings.we_3[1].cooldown = 50
local sniper_dropoff_ranges = {
	dropoff_start = 40,
	dropoff_end = 50
}
DamageProfileTemplates.arrow_sniper_ability_piercing.max_friendly_damage = 20
DamageProfileTemplates.arrow_sniper_trueflight = {
    charge_value = "projectile",
    no_stagger_damage_reduction_ranged = true,
    critical_strike = {
        attack_armor_power_modifer = {
            1.5,
            1,
            1,
            0.25,
            1,
            0.6
        },
        impact_armor_power_modifer = {
            1,
            1,
            0,
            1,
            1,
            1
        }
    },
    armor_modifier_near = {
        attack = {
            1.5,
            1,
            1,
            0.25,
            1,
            0.6
        },
        impact = {
            1,
            1,
            0,
            0,
            1,
            1
        }
    },
    armor_modifier_far = {
        attack = {
            1.5,
            1,
            2,
            0.25,
            1,
            0.6
        },
        impact = {
            1,
            1,
            0,
            0,
            1,
            0
        }
    },
    cleave_distribution = {
        attack = 0.375,
        impact = 0.375
    },
    default_target = {
        boost_curve_coefficient_headshot = 2.5,
        boost_curve_type = "ninja_curve",
        boost_curve_coefficient = 0.75,
        attack_template = "arrow_sniper",
        power_distribution_near = {
            attack = 0.5,
            impact = 0.3
        },
        power_distribution_far = {
            attack = 0.5,
            impact = 0.25
        },
        range_dropoff_settings = sniper_dropoff_ranges
    },
	max_friendly_damage = 0
}
Weapons.kerillian_waywatcher_career_skill_weapon.actions.action_career_hold.prioritized_breeds = {
    skaven_warpfire_thrower = 1,
    chaos_vortex_sorcerer = 1,
    skaven_gutter_runner = 1,
    skaven_pack_master = 1,
    skaven_poison_wind_globadier = 1,
    chaos_corruptor_sorcerer = 1,
    skaven_ratling_gunner = 1,
    beastmen_standard_bearer = 1,
}


--Removed bloodshot and ult interaction
mod:hook_origin(ActionCareerWEWaywatcher, "client_owner_post_update", function (self, dt, t, world, can_damage)
    local current_action = self.current_action

	if self.state == "waiting_to_shoot" and self.time_to_shoot <= t then
		self.state = "shooting"
	end

	if self.state == "shooting" then
		local has_extra_shots = self:_update_extra_shots(self.owner_buff_extension, 1)
		local add_spread = not self.extra_buff_shot

		self:fire(current_action, add_spread)

		if has_extra_shots and has_extra_shots > 1 then
			self.state = "waiting_to_shoot"
			self.time_to_shoot = t + 0.1
			self.extra_buff_shot = true
		else
			self.state = "shot"
		end

		local first_person_extension = self.first_person_extension

		if self.current_action.reset_aim_on_attack then
			first_person_extension:reset_aim_assist_multiplier()
		end

		local fire_sound_event = self.current_action.fire_sound_event

		if fire_sound_event then
			local play_on_husk = self.current_action.fire_sound_on_husk

			first_person_extension:play_hud_sound_event(fire_sound_event, nil, play_on_husk)
		end

		if self.current_action.extra_fire_sound_event then
			local position = POSITION_LOOKUP[self.owner_unit]

			WwiseUtils.trigger_position_event(self.world, self.current_action.extra_fire_sound_event, position)
		end
	end
end)

mod:add_proc_function("kerillian_waywatcher_consume_extra_shot_buff", function (player, buff, params)
    local is_career_skill = params[5]
    local should_consume_shot = nil

    if is_career_skill == "RANGED_ABILITY" or is_career_skill == nil then
        should_consume_shot = false
    else
        should_consume_shot = true
    end

    return should_consume_shot
end)



-- Battle Wizard Changes
ActivatedAbilitySettings.bw_2[1].cooldown = 60

----Firetrail nerf (Fatshark please)
--local buff_perks = require("scripts/unit_extensions/default_player_unit/buffs/settings/buff_perk_names")
--mod:add_buff_template("sienna_adept_ability_trail", {
--    leave_linger_time = 1,
--    name = "sienna_adept_ability_trail",
--    end_flow_event = "smoke",
--    start_flow_event = "burn",
--    on_max_stacks_overflow_func = "reapply_buff",
--    remove_buff_func = "remove_dot_damage",
--    apply_buff_func = "start_dot_damage",
--    update_start_delay = 0.5,
--    death_flow_event = "burn_death",
--    time_between_dot_damages = 1,
--    damage_type = "burninating",
--    damage_profile = "burning_dot",
--    update_func = "apply_dot_damage",
--    max_stacks = 1,
--    perk = buff_perks.burning
--})

