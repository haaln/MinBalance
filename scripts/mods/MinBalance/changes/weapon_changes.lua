local mod = get_mod("MinBalance")

--Manbow
function add_chain_actions(action_no, action_from, new_data)
    local value = "allowed_chain_actions"
    local row = #action_no[action_from][value] + 1
    action_no[action_from][value][row] = new_data
end

for _, weapon in ipairs{
    "longbow_empire_template",
} do
    local weapon_template = Weapons[weapon]
    local action_one = weapon_template.actions.action_one
    local action_two = weapon_template.actions.action_two
    add_chain_actions(action_one, "shoot_charged_heavy", {
        sub_action = "default",
        start_time = 0, -- 0.3
        action = "action_wield",
        input = "action_wield",
        end_time = math.huge
    })
end

Weapons.longbow_empire_template.actions.action_one.shoot_charged_heavy.allowed_chain_actions[4].start_time = 0.25
Weapons.longbow_empire_template.actions.action_one.shoot_charged_heavy.allowed_chain_actions[4].sub_action = "default"
Weapons.longbow_empire_template.actions.action_one.shoot_charged_heavy.allowed_chain_actions[4].action = "action_one"
Weapons.longbow_empire_template.actions.action_one.shoot_charged_heavy.allowed_chain_actions[4].release_required = "action_two_hold"
Weapons.longbow_empire_template.actions.action_one.shoot_charged_heavy.allowed_chain_actions[4].input = "action_one"

Weapons.longbow_empire_template.actions.action_one.shoot_charged_heavy.reload_event_delay_time = 0.1
Weapons.longbow_empire_template.actions.action_one.shoot_charged_heavy.override_reload_time = nil
Weapons.longbow_empire_template.actions.action_one.shoot_charged_heavy.allowed_chain_actions[2].start_time = 0.68

Weapons.longbow_empire_template.actions.action_one.default.allowed_chain_actions[2].start_time = 0.4
Weapons.longbow_empire_template.actions.action_one.default.override_reload_time = 0.15
Weapons.longbow_empire_template.actions.action_two.default.heavy_aim_flow_delay = nil
Weapons.longbow_empire_template.actions.action_two.default.heavy_aim_flow_event = nil
Weapons.longbow_empire_template.actions.action_two.default.aim_zoom_delay = 100
Weapons.longbow_empire_template.ammo_data.reload_time = 0
Weapons.longbow_empire_template.ammo_data.reload_on_ammo_pickup = true


SpreadTemplates.empire_longbow.continuous.still = {max_yaw = 0.25, max_pitch = 0.25 }
SpreadTemplates.empire_longbow.continuous.moving = {max_yaw = 0.4, max_pitch = 0.4 }
SpreadTemplates.empire_longbow.continuous.crouch_still = {max_yaw = 0.75, max_pitch = 0.75 }
SpreadTemplates.empire_longbow.continuous.crouch_moving = {max_yaw = 2, max_pitch = 2 }
SpreadTemplates.empire_longbow.continuous.zoomed_still = {max_yaw = 0, max_pitch = 0}
SpreadTemplates.empire_longbow.continuous.zoomed_moving = {max_yaw = 0.4, max_pitch = 0.4 }
SpreadTemplates.empire_longbow.continuous.zoomed_crouch_still = {max_yaw = 0, max_pitch = 0 }
SpreadTemplates.empire_longbow.continuous.zoomed_crouch_moving = {max_yaw = 0.4, max_pitch = 0.4 }

function add_chain_actions(action_no, action_from, new_data)
    local value = "allowed_chain_actions"
    local row = #action_no[action_from][value] + 1
    action_no[action_from][value][row] = new_data
end

for _, weapon in ipairs{
    "longbow_empire_template",
} do
    local weapon_template = Weapons[weapon]
    local action_one = weapon_template.actions.action_one
    local action_two = weapon_template.actions.action_two
    add_chain_actions(action_one, "shoot_charged", {
        sub_action = "default",
        start_time = 0, -- 0.3
        action = "action_wield",
        input = "action_wield",
        end_time = math.huge
    })
end

Weapons.longbow_empire_template.actions.action_one.shoot_charged.allowed_chain_actions[4].start_time = 0.4
Weapons.longbow_empire_template.actions.action_one.shoot_charged.allowed_chain_actions[4].sub_action = "default"
Weapons.longbow_empire_template.actions.action_one.shoot_charged.allowed_chain_actions[4].action = "action_one"
Weapons.longbow_empire_template.actions.action_one.shoot_charged.allowed_chain_actions[4].release_required = "action_two_hold"
Weapons.longbow_empire_template.actions.action_one.shoot_charged.allowed_chain_actions[4].input = "action_one"

Weapons.longbow_empire_template.actions.action_one.shoot_charged.allowed_chain_actions[2].start_time = 0.7
Weapons.longbow_empire_template.actions.action_one.shoot_charged.reload_event_delay_time = 0.15
Weapons.longbow_empire_template.actions.action_one.shoot_charged.override_reload_time = nil
Weapons.longbow_empire_template.actions.action_one.shoot_charged.speed = 11000

Weapons.longbow_empire_template.actions.action_two.default.aim_zoom_delay = 0.01
Weapons.longbow_empire_template.actions.action_two.default.heavy_aim_flow_event = nil
Weapons.longbow_empire_template.actions.action_two.default.default_zoom = "zoom_in_trueflight"
Weapons.longbow_empire_template.actions.action_two.default.buffed_zoom_thresholds = { "zoom_in_trueflight", "zoom_in" }
DamageProfileTemplates.arrow_sniper_kruber.armor_modifier_near.attack = { 1, 1.25, 1.5, 1, 0.75, 0.25 }

--Masterwork Pistol
Weapons.heavy_steam_pistol_template_1.actions.action_one.fast_shot.impact_data.damage_profile = "tb_shot_sniper_pistol_burst"
local shotgun_dropoff_ranges = {
	dropoff_start = 8,
	dropoff_end = 15
}
NewDamageProfileTemplates.tb_shot_sniper_pistol_burst = {
	charge_value = "instant_projectile",
	no_stagger_damage_reduction_ranged = true,
	shield_break = true,
	critical_strike = {
		attack_armor_power_modifer = {
			0.5,
			0.5,
			0.5,
			0.5,
			0.5,
			0.5
		},
		impact_armor_power_modifer = {
			0.5,
			0.5,
			0.5,
			0.5,
			0.5,
			0.5
		}
	},
	armor_modifier_near = {
		attack = {
			0.5,
			0.5,
			0.5,
			0.5,
			0.5,
			0.5
		},
		impact = {
			0.5,
			0.5,
			0.5,
			0.5,
			0.5,
			0
		}
	},
	armor_modifier_far = {
		attack = {
			0.5,
			0.5,
			0.5,
			0.5,
			0.5,
			0
		},
		impact = {
			0.5,
			0.5,
			0.5,
			0.5,
			0.5,
			0
		}
	},
	cleave_distribution = {
		attack = 0.2,
		impact = 0.2
	},
	default_target = {
		headshot_boost_boss = 0.3,
		boost_curve_coefficient_headshot = 1,
		boost_curve_type = "smiter_curve",
		boost_curve_coefficient = 1,
		attack_template = "shot_sniper",
		power_distribution_near = {
			attack = 0.8,
			impact = 0.5
		},
		power_distribution_far = {
			attack = 0.4,
			impact = 0.4
		},
		range_dropoff_settings = shotgun_dropoff_ranges
	}
}

--Coruscation
Weapons.bw_deus_01_template_1.actions.action_one.default.allowed_chain_actions[1].start_time = 0.6
Weapons.bw_deus_01_template_1.actions.action_one.default.allowed_chain_actions[1].start_time = 0.5
Weapons.bw_deus_01_template_1.actions.action_one.default.total_time = 0.65
Weapons.bw_deus_01_template_1.actions.action_one.default.shot_count = 10
DamageProfileTemplates.staff_magma.default_target.power_distribution_near.attack = 0.12
DamageProfileTemplates.staff_magma.default_target.power_distribution_far.attack = 0.06
PlayerUnitStatusSettings.overcharge_values.magma_basic = 4
ExplosionTemplates.magma.aoe.duration = 1
ExplosionTemplates.magma.aoe.damage_interval = 10
PlayerUnitStatusSettings.overcharge_values.magma_charged_2 = 10
PlayerUnitStatusSettings.overcharge_values.magma_charged = 14
local buff_perks = require("scripts/unit_extensions/default_player_unit/buffs/settings/buff_perk_names")
mod:add_buff_template("burning_magma_dot", {
        duration = 6,
        name = "burning_magma_dot",
        remove_buff_func = "remove_dot_damage",
        end_flow_event = "smoke",
        start_flow_event = "burn",
		update_start_delay = 1,
        reapply_start_flow_event = true,
        apply_buff_func = "start_dot_damage",
        death_flow_event = "burn_death",
        time_between_dot_damages = 2.5,
        refresh_durations = true,
        damage_type = "burninating",
        damage_profile = "burning_dot",
        update_func = "apply_dot_damage",
        reapply_buff_func = "reapply_dot_damage",
        max_stacks = 2,
        perk = buff_perks.burning
})

--Halberd
--light 1
--DamageProfileTemplates.medium_slashing_axe_linesman.targets[2].power_distribution.attack = 0.225
--DamageProfileTemplates.medium_slashing_axe_linesman.targets[3].power_distribution.attack = 0.15
--DamageProfileTemplates.medium_slashing_axe_linesman.cleave_distribution.attack = 0.4
--DamageProfileTemplates.medium_slashing_axe_linesman.targets[1].armor_modifier.attack[1] = 1.25
Weapons.two_handed_halberds_template_1.actions.action_one.light_attack_left.allowed_chain_actions[2].start_time = 0.5
Weapons.two_handed_halberds_template_1.actions.action_one.light_attack_left.damage_profile = "tb_halberd_light_slash"
NewDamageProfileTemplates.tb_halberd_light_slash = {
	armor_modifier = "armor_modifier_axe_linesman_M",
	critical_strike = "critical_strike_axe_linesman_M",
	charge_value = "light_attack",
	cleave_distribution = {
		attack = 0.4,
		impact = 0.25
	},
	default_target = "default_target_axe_linesman_M",
	targets = {
		{
			boost_curve_coefficient_headshot = 1.5,
			boost_curve_type = "linesman_curve",
			attack_template = "heavy_slashing_linesman",
			power_distribution = {
				attack = 0.25,
				impact = 0.2
			},
			armor_modifier = {
				attack = {
					1.25,
					0.3,
					1.5,
					1,
					0.75
				},
				impact = {
					0.9,
					0.75,
					1,
					1,
					0.75
				}
			}
		},
		{
			boost_curve_type = "linesman_curve",
			attack_template = "slashing_linesman",
			power_distribution = {
				attack = 0.225,
				impact = 0.125
			}
		},
		{
			boost_curve_type = "linesman_curve",
			attack_template = "light_slashing_linesman",
			power_distribution = {
				attack = 0.15,
				impact = 0.1
			}
		}
	}
}

--light 2
Weapons.two_handed_halberds_template_1.actions.action_one.light_attack_stab.damage_profile = "tb_halberd_light_stab"
NewDamageProfileTemplates.tb_halberd_light_stab = {
    charge_value = "light_attack",
	cleave_distribution = {
        attack = 0.075,
        impact = 0.075
    },
    critical_strike = {
        attack_armor_power_modifer = {
            1,
            .8,
            2.5,
            1,
            1
        },
        impact_armor_power_modifer = {
            1,
            1,
            1,
            1,
            1
        }
    },
    armor_modifier = {
        attack = {
            1,
            .7,
            2.25,
            1,
            0.75
        },
        impact = {
            1,
            0.75,
            1,
            1,
            0.75
        }
    },
    default_target = {
        boost_curve_coefficient_headshot = 2,
        boost_curve_type = "ninja_curve",
        boost_curve_coefficient = 1,
        attack_template = "stab_smiter",
        power_distribution = {
            attack = 0.25,
            impact = 0.125
        }
    },
    melee_boost_override = 2.5
}
--Heavy 2
--DamageProfileTemplates.heavy_slashing_linesman_polearm.targets[1].armor_modifier.attack[1] = 1.15
--DamageProfileTemplates.heavy_slashing_linesman_polearm.targets[1].power_distribution.attack = 0.45
--DamageProfileTemplates.heavy_slashing_linesman_polearm.targets[2].power_distribution.attack = 0.35
--DamageProfileTemplates.heavy_slashing_linesman_polearm.targets[3].power_distribution.attack = 0.25
--DamageProfileTemplates.heavy_slashing_linesman_polearm.targets[4].power_distribution.attack = 0.15
--DamageProfileTemplates.heavy_slashing_linesman_polearm.default_target.power_distribution.attack = 0.10
Weapons.two_handed_halberds_template_1.actions.action_one.heavy_attack_left.damage_profile = "tb_halberd_heavy_slash"
NewDamageProfileTemplates.tb_halberd_heavy_slash = {
	armor_modifier = "armor_modifier_linesman_H",
	critical_strike = "critical_strike_linesman_H",
	charge_value = "heavy_attack",
	cleave_distribution = "cleave_distribution_linesman_executioner_H",
	default_target =  {
		boost_curve_type = "linesman_curve",
		boost_curve_coefficient_headshot = 0.25,
		attack_template = "light_slashing_linesman",
		power_distribution = {
			attack = 0.1,
			impact = 0.05
		}
	},
	targets = {
		{
			boost_curve_coefficient_headshot = 1,
			boost_curve_type = "linesman_curve",
			attack_template = "heavy_slashing_linesman",
			power_distribution = {
				attack = 0.45,
				impact = 0.25
			},
			armor_modifier = {
				attack = {
					1.15,
					0.5,
					1.5,
					1,
					0.75
				},
				impact = {
					0.9,
					0.5,
					1,
					1,
					0.75
				}
			}
		},
		{
			boost_curve_type = "linesman_curve",
			boost_curve_coefficient_headshot = 1,
			attack_template = "heavy_slashing_linesman",
			power_distribution = {
				attack = 0.35,
				impact = 0.15
			}
		},
		{
			boost_curve_type = "linesman_curve",
			attack_template = "slashing_linesman",
			power_distribution = {
				attack = 0.25,
				impact = 0.1
			}
		},
		{
			boost_curve_type = "linesman_curve",
			attack_template = "slashing_linesman",
			power_distribution = {
				attack = 0.15,
				impact = 0.075
			}
		}
	},
}
--Heavy 1
Weapons.two_handed_halberds_template_1.actions.action_one.heavy_attack_stab.damage_profile = "tb_halberd_heavy_stab"
NewDamageProfileTemplates.tb_halberd_heavy_stab = {
    charge_value = "heavy_attack",
   	cleave_distribution = {
		attack = 0.075,
		impact = 0.075
	},
    critical_strike = {
		attack_armor_power_modifer = {
			1,
			0.56,
			2.5,
			1,
			1
		},
		impact_armor_power_modifer = {
			1,
			1,
			1,
			1,
			1
		}
	},
	armor_modifier = {
		attack = {
			1,
			0.3,
			2,
			1,
			0.75
		},
		impact = {
			1,
			0.5,
			1,
			1,
			0.75
		}
	},
	default_target = {
		boost_curve_coefficient_headshot = 1,
		boost_curve_type = "ninja_curve",
		boost_curve_coefficient = 0.75,
		attack_template = "heavy_stab_smiter",
		power_distribution = {
			attack = 0.2,
			impact = 0.15
		}
	},
	targets = {
		{
			boost_curve_coefficient_headshot = 2,
			boost_curve_type = "ninja_curve",
			boost_curve_coefficient = 0.75,
			attack_template = "heavy_stab_smiter",
			armor_modifier = {
				attack = {
					1,
					0.56,
					2,
					1,
					0.75
				},
				impact = {
					1,
					0.65,
					1,
					1,
					0.75
				}
			},
			power_distribution = {
				attack = 0.45,
				impact = 0.25
			}
		}
	},
	melee_boost_override = 2.5
}
--light 3 and push stab
--DamageProfileTemplates.medium_slashing_smiter_2h.default_target.boost_curve_coefficient_headshot = 2.5
Weapons.two_handed_halberds_template_1.actions.action_one.light_attack_down.damage_profile = "tb_halberd_light_chop"
Weapons.two_handed_halberds_template_1.actions.action_one.light_attack_last.damage_profile = "tb_halberd_light_chop"
NewDamageProfileTemplates.tb_halberd_light_chop = {
    charge_value = "light_attack",
	cleave_distribution = {
        attack = 0.075,
        impact = 0.075
    },
    critical_strike = {
        attack_armor_power_modifer = {
            1,
            .76,
            2.5,
            1,
            1
        },
        impact_armor_power_modifer = {
            1,
            1,
            1,
            1,
            1
        }
    },
    armor_modifier = {
        attack = {
            1.25,
            .76,
            2.5,
            1,
            0.75
        },
        impact = {
            1,
            0.8,
            1,
            1,
            0.75
        }
    },
    default_target = {
        boost_curve_coefficient_headshot = 1.5,
        boost_curve_type = "ninja_curve",
        boost_curve_coefficient = 1,
        attack_template = "stab_smiter",
        power_distribution = {
            attack = 0.325,
            impact = 0.2
        }
    },
    melee_boost_override = 2.5,
	shield_break = true
}



--
--
--
--Dual Daggers Elf
Weapons.dual_wield_daggers_template_1.actions.action_one.light_attack_left.additional_critical_strike_chance = 0.1
Weapons.dual_wield_daggers_template_1.actions.action_one.light_attack_right.additional_critical_strike_chance = 0.1
Weapons.dual_wield_daggers_template_1.actions.action_one.heavy_attack.allowed_chain_actions[5].start_time = 0.35
Weapons.dual_wield_daggers_template_1.actions.action_one.heavy_attack_stab.allowed_chain_actions[5].start_time = 0.35
Weapons.dual_wield_daggers_template_1.max_fatigue_points = 6
Weapons.dual_wield_daggers_template_1.buffs.change_dodge_distance.external_optional_multiplier = 1.25
Weapons.dual_wield_daggers_template_1.buffs.change_dodge_speed.external_optional_multiplier = 1.25

--Dual Axes
--Heavies
Weapons.dual_wield_axes_template_1.actions.action_one.heavy_attack.anim_time_scale = 0.925  --1.035
Weapons.dual_wield_axes_template_1.actions.action_one.heavy_attack_2.anim_time_scale = 1.1 --1.035
Weapons.dual_wield_axes_template_1.actions.action_one.heavy_attack_3.additional_critical_strike_chance = 0.2 --0
--push
Weapons.dual_wield_axes_template_1.actions.action_one.push.damage_profile_inner = "light_push"
Weapons.dual_wield_axes_template_1.actions.action_one.push.fatigue_cost = "action_stun_push"

--1h sword
Weapons.one_handed_swords_template_1.dodge_count = 4
--Weapons.two_handed_halberds_template_1.dodge_count = 4

--Flaming Flail
Weapons.one_handed_flails_flaming_template.actions.action_one.light_attack_left.hit_mass_count = TANK_HIT_MASS_COUNT
Weapons.one_handed_flails_flaming_template.actions.action_one.light_attack_right.hit_mass_count = TANK_HIT_MASS_COUNT
Weapons.one_handed_flails_flaming_template.actions.action_one.heavy_attack.anim_time_scale = 1.1
DamageProfileTemplates.heavy_blunt_smiter_burn.default_target.power_distribution.impact = 0.375
DamageProfileTemplates.flaming_flail_explosion.default_target.power_distribution.attack = 0.06
DamageProfileTemplates.flaming_flail_explosion.default_target.power_distribution.impact = 0.25
DamageProfileTemplates.heavy_blunt_smiter_burn.default_target.power_distribution.attack = 0.25

--Weapon Swap Fixes (moonfire, Coru, MWP, Jav)
Weapons.we_deus_01_template_1.actions.action_one.default.total_time = 0.7
Weapons.we_deus_01_template_1.actions.action_one.default.allowed_chain_actions[1].start_time =  0.4
Weapons.we_deus_01_template_1.actions.action_one.shoot_charged.total_time = 0.55
Weapons.we_deus_01_template_1.actions.action_one.shoot_charged.allowed_chain_actions[1].start_time = 0.45
Weapons.we_deus_01_template_1.actions.action_one.shoot_special_charged.total_time = 0.5 Weapons.we_deus_01_template_1.actions.action_one.shoot_special_charged.allowed_chain_actions[1].start_time = 0.4

Weapons.bw_deus_01_template_1.actions.action_two.default.allowed_chain_actions[1].start_time = 0.5

Weapons.heavy_steam_pistol_template_1.actions.action_one.shoot.total_time = 0.3
Weapons.heavy_steam_pistol_template_1.actions.action_one.shoot.allowed_chain_actions[1].start_time =  0.3

Weapons.javelin_template.actions.action_one.throw_charged.allowed_chain_actions[2].start_time = 0.3
Weapons.javelin_template.actions.action_one.default.allowed_chain_actions[2].start_time = 0.4
Weapons.javelin_template.actions.action_one.default_left.allowed_chain_actions[2].start_time = 0.4
Weapons.javelin_template.actions.action_one.default_chain_01.allowed_chain_actions[2].start_time = 0.45
Weapons.javelin_template.actions.action_one.default_chain_02.allowed_chain_actions[2].start_time = 0.45
Weapons.javelin_template.actions.action_one.default_chain_03.allowed_chain_actions[2].start_time = 0.45
Weapons.javelin_template.actions.action_one.stab_01.allowed_chain_actions[2].start_time = 0.4
Weapons.javelin_template.actions.action_one.stab_02.allowed_chain_actions[2].start_time = 0.4
Weapons.javelin_template.actions.action_one.chain_stab_03.allowed_chain_actions[2].start_time = 0.45
Weapons.javelin_template.actions.action_one.heavy_stab.allowed_chain_actions[2].start_time = 0.45

--Coghammer weapon swap buffer fix
Weapons.two_handed_cog_hammers_template_1.actions.action_one.default = {
	aim_assist_ramp_decay_delay = 0.1,
	anim_end_event = "attack_finished",
	kind = "melee_start",
	attack_hold_input = "action_one_hold",
	aim_assist_max_ramp_multiplier = 0.4,
	aim_assist_ramp_multiplier = 0.2,
	anim_event = "attack_swing_charge",
	anim_end_event_condition_func = function (unit, end_reason)
		return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
	end,
	total_time = math.huge,
	buff_data = {
		{
			start_time = 0,
			external_multiplier = 0.6,
			buff_name = "planted_charging_decrease_movement"
		}
	},
	allowed_chain_actions = {
		{
			sub_action = "light_attack_left",
			start_time = 0,
			end_time = 0.3,
			action = "action_one",
			input = "action_one_release"
		},
		{
			sub_action = "heavy_attack_left",
			start_time = 0.6,
			end_time = 1.2,
			action = "action_one",
			input = "action_one_release"
		},
		{
			sub_action = "default",
			start_time = 0,
			action = "action_two",
			input = "action_two_hold"
		},
		{
			sub_action = "default",
			start_time = 0,
			action = "action_wield",
			input = "action_wield"
		},
		{
			start_time = 0.6,
			end_time = 1.2,
			blocker = true,
			input = "action_one_hold"
		},
		{
			sub_action = "heavy_attack_left",
			start_time = 1,
			action = "action_one",
			auto_chain = true
		}
	}
}
Weapons.two_handed_cog_hammers_template_1.actions.action_one.default_left.allowed_chain_actions = {
	{
		sub_action = "light_attack_right",
		start_time = 0,
		end_time = 0.3,
		action = "action_one",
		input = "action_one_release"
	},
	{
		sub_action = "heavy_attack_right",
		start_time = 0.6,
		end_time = 1.2,
		action = "action_one",
		input = "action_one_release"
	},
	{
		sub_action = "default",
		start_time = 0,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0,
		action = "action_wield",
		input = "action_wield"
	},
	{
		start_time = 0.6,
		end_time = 1.2,
		blocker = true,
		input = "action_one_hold"
	},
	{
		sub_action = "heavy_attack_right",
		start_time =1,
		action = "action_one",
		auto_chain = true
	}
}
Weapons.two_handed_cog_hammers_template_1.actions.action_one.default_right.allowed_chain_actions = {
	{
		sub_action = "light_attack_last",
		start_time = 0,
		end_time = 0.3,
		action = "action_one",
		input = "action_one_release"
	},
	{
		sub_action = "heavy_attack_left",
		start_time = 0.6,
		end_time = 1.2,
		action = "action_one",
		input = "action_one_release"
	},
	{
		sub_action = "default",
		start_time = 0,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0,
		action = "action_wield",
		input = "action_wield"
	},
	{
		start_time = 0.6,
		end_time = 1.2,
		blocker = true,
		input = "action_one_hold"
	},
	{
		sub_action = "heavy_attack_left",
		start_time = 1,
		action = "action_one",
		auto_chain = true
	}
}
Weapons.two_handed_cog_hammers_template_1.actions.action_one.default_last.allowed_chain_actions = {
	{
		sub_action = "light_attack_up_right_last",
		start_time = 0,
		end_time = 0.3,
		action = "action_one",
		input = "action_one_release"
	},
	{
		sub_action = "heavy_attack_right",
		start_time = 0.6,
		end_time = 1.2,
		action = "action_one",
		input = "action_one_release"
	},
	{
		sub_action = "default",
		start_time = 0,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0,
		action = "action_wield",
		input = "action_wield"
	},
	{
		start_time = 0.6,
		end_time = 1.2,
		blocker = true,
		input = "action_one_hold"
	},
	{
		sub_action = "heavy_attack_right",
		start_time = 1,
		action = "action_one",
		auto_chain = true
	}
}
--Lights 1/2/3/4
Weapons.two_handed_cog_hammers_template_1.actions.action_one.light_attack_left.anim_event = "attack_swing_up_pose"
Weapons.two_handed_cog_hammers_template_1.actions.action_one.light_attack_left.allowed_chain_actions = {
	{
		sub_action = "default_left",
		start_time = 0.65,
		end_time = 1.2,
		action = "action_one",
		input = "action_one"
	},
	{
		sub_action = "default_left",
		start_time = 0.65,
		end_time = 1.2,
		action = "action_one",
		input = "action_one_hold"
	},
	{
		sub_action = "default",
		start_time = 1.2,
		action = "action_one",
		input = "action_one_hold"
	},
	{
		sub_action = "default",
		start_time = 1.2,
		action = "action_one",
		input = "action_one"
	},
	{
		sub_action = "default",
		start_time = 0,
		end_time = 0.3,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0.6,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0.6,
		action = "action_wield",
		input = "action_wield"
	}
}
Weapons.two_handed_cog_hammers_template_1.actions.action_one.light_attack_left.baked_sweep = {
	{
		0.31666666666666665,
		0.3103722333908081,
		0.5904569625854492,
		-0.2657968997955322,
		0.7223937511444092,
		-0.29107052087783813,
		0.5494855046272278,
		0.302474707365036
	},
	{
		0.35277777777777775,
		0.1775137186050415,
		0.6366815567016602,
		-0.19225668907165527,
		0.7879757285118103,
		-0.14280153810977936,
		0.5783776640892029,
		0.1555033177137375
	},
	{
		0.3888888888888889,
		0.051915526390075684,
		0.6041536331176758,
		-0.08548450469970703,
		0.8273890018463135,
		-0.0234444011002779,
		0.5306860208511353,
		-0.18234620988368988
	},
	{
		0.425,
		-0.12680041790008545,
		0.4566812515258789,
		-0.04089641571044922,
		0.6963638663291931,
		0.19201868772506714,
		0.41889646649360657,
		-0.5502110719680786
	},
	{
		0.46111111111111114,
		-0.26615601778030396,
		0.21436119079589844,
		-0.12140655517578125,
		0.37910813093185425,
		0.4430711269378662,
		0.2820264995098114,
		-0.7618570327758789
	},
	{
		0.49722222222222223,
		-0.1962783932685852,
		0.1402301788330078,
		-0.22664093971252441,
		0.17541848123073578,
		0.5380390882492065,
		0.08140674978494644,
		-0.8204360008239746
	},
	{
		0.5333333333333333,
		-0.13591063022613525,
		0.1464986801147461,
		-0.29386401176452637,
		0.0605529323220253,
		0.579397976398468,
		-0.1304379105567932,
		-0.8022575974464417
	}
}
Weapons.two_handed_cog_hammers_template_1.actions.action_one.light_attack_right.allowed_chain_actions = {
	{
		sub_action = "default_right",
		start_time = 0.6,
		end_time = 1.2,
		action = "action_one",
		input = "action_one"
	},
	{
		sub_action = "default_right",
		start_time = 0.6,
		end_time = 1.2,
		action = "action_one",
		input = "action_one_hold"
	},
	{
		sub_action = "default",
		start_time = 1.2,
		action = "action_one",
		input = "action_one"
	},
	{
		sub_action = "default",
		start_time = 1.2,
		action = "action_one",
		input = "action_one_hold"
	},
	{
		sub_action = "default",
		start_time = 0,
		end_time = 0.3,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0.6,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0.6,
		action = "action_wield",
		input = "action_wield"
	}
}
Weapons.two_handed_cog_hammers_template_1.actions.action_one.light_attack_last.allowed_chain_actions = {
	{
		sub_action = "default_last",
		start_time = 0.65,
		end_time = 1.2,
		action = "action_one",
		input = "action_one"
	},
	{
		sub_action = "default_last",
		start_time = 0.65,
		end_time = 1.2,
		action = "action_one",
		input = "action_one_hold"
	},
	{
		sub_action = "default",
		start_time = 1.2,
		action = "action_one",
		input = "action_one"
	},
	{
		sub_action = "default",
		start_time = 1.2,
		action = "action_one",
		input = "action_one_hold"
	},
	{
		sub_action = "default",
		start_time = 0,
		end_time = 0.3,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0.6,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0.6,
		action = "action_wield",
		input = "action_wield"
	}
}
Weapons.two_handed_cog_hammers_template_1.actions.action_one.light_attack_up_right_last.allowed_chain_actions = {
	{
		sub_action = "default",
		start_time = 0.65,
		end_time = 1.2,
		action = "action_one",
		input = "action_one"
	},
	{
		sub_action = "default",
		start_time = 0.65,
		end_time = 1.2,
		action = "action_one",
		input = "action_one_hold"
	},
	{
		sub_action = "default",
		start_time = 1.2,
		action = "action_one",
		input = "action_one"
	},
	{
		sub_action = "default",
		start_time = 1.2,
		action = "action_one",
		input = "action_one_hold"
	},
	{
		sub_action = "default",
		start_time = 0,
		end_time = 0.3,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0.6,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0.6,
		action = "action_wield",
		input = "action_wield"
	}
}
--Pushstab
Weapons.two_handed_cog_hammers_template_1.actions.action_one.push.allowed_chain_actions = {
	{
		sub_action = "default",
		start_time = 0.4,
		action = "action_one",
		release_required = "action_two_hold",
		input = "action_one"
	},
	{
		sub_action = "default",
		start_time = 0.4,
		action = "action_one",
		release_required = "action_two_hold",
		input = "action_one_hold"
	},
	{
		sub_action = "light_attack_bopp",
		start_time = 0.4,
		action = "action_one",
		end_time = 0.8,
		input = "action_one_hold",
		hold_required = {
			"action_two_hold",
			"action_one_hold"
		}
	},
	{
		sub_action = "default",
		start_time = 0.4,
		action = "action_two",
		send_buffer = true,
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0.4,
		action = "action_wield",
		input = "action_wield"
	}
}
Weapons.two_handed_cog_hammers_template_1.actions.action_one.light_attack_bopp.allowed_chain_actions = {
	{
		sub_action = "default_left",
		start_time = 0.75,
		action = "action_one",
		input = "action_one"
	},
	{
		sub_action = "default_left",
		start_time = 0.75,
		action = "action_one",
		input = "action_one_hold"
	},
	{
		sub_action = "default",
		start_time = 1.5,
		action = "action_one",
		input = "action_one"
	},
	{
		sub_action = "default",
		start_time = 1.5,
		action = "action_one",
		input = "action_one_hold"
	},
	{
		sub_action = "default",
		start_time = 0.65,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0.65,
		action = "action_wield",
		input = "action_wield"
	}
}
--Heavies
Weapons.two_handed_cog_hammers_template_1.actions.action_one.heavy_attack_left.allowed_chain_actions = {
	{
		sub_action = "default_left",
		start_time = 0.6,
		action = "action_one",
		release_required = "action_one_hold",
		input = "action_one"
	},
	{
		sub_action = "default_left",
		start_time = 0.6,
		action = "action_one",
		release_required = "action_one_hold",
		input = "action_one_hold"
	},
	{
		sub_action = "default",
		start_time = 2.2,
		action = "action_one",
		input = "action_one"
	},
	{
		sub_action = "default",
		start_time = 2.2,
		action = "action_one",
		input = "action_one_hold"
	},
	{
		sub_action = "default",
		start_time = 0,
		end_time = 0.3,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0.75,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0.5,
		action = "action_wield",
		input = "action_wield"
	}
}
Weapons.two_handed_cog_hammers_template_1.actions.action_one.heavy_attack_right.allowed_chain_actions = {
	{
		sub_action = "default_right",
		start_time = 0.6,
		action = "action_one",
		release_required = "action_one_hold",
		input = "action_one"
	},
	{
		sub_action = "default_right",
		start_time = 0.6,
		action = "action_one",
		release_required = "action_one_hold",
		input = "action_one_hold"
	},
	{
		sub_action = "default",
		start_time = 2,
		action = "action_one",
		input = "action_one"
	},
	{
		sub_action = "default",
		start_time = 2,
		action = "action_one",
		input = "action_one_hold"
	},
	{
		sub_action = "default",
		start_time = 0,
		end_time = 0.3,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0.75,
		action = "action_two",
		input = "action_two_hold"
	},
	{
		sub_action = "default",
		start_time = 0.5,
		action = "action_wield",
		input = "action_wield"
	}
}




