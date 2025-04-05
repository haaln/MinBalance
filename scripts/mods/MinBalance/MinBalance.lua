local mod = get_mod("MinBalance")

-- Text Localization
local _language_id = Application.user_setting("language_id")
local _localization_database = {}
mod._quick_localize = function(self, text_id)
	local mod_localization_table = _localization_database
	if mod_localization_table then
		local text_translations = mod_localization_table[text_id]
		if text_translations then
			return text_translations[_language_id] or text_translations["en"]
		end
	end
end
function mod.add_text(self, text_id, text)
	if type(text) == "table" then
		_localization_database[text_id] = text
	else
		_localization_database[text_id] = {
			en = text,
		}
	end
end
mod:hook("Localize", function(func, text_id)
	local str = mod:_quick_localize(text_id)
	if str then
		return str
	end
	return func(text_id)
end)
NewDamageProfileTemplates = NewDamageProfileTemplates or {}
function mod:add_buff(buff_name, buff_data)
	local new_buff = {
		buffs = {
			merge({ name = buff_name }, buff_data),
		},
	}
	BuffTemplates[buff_name] = new_buff
	local index = #NetworkLookup.buff_templates + 1
	NetworkLookup.buff_templates[index] = buff_name
	NetworkLookup.buff_templates[buff_name] = index
end

-- Talent Changes
mod:dofile("scripts/mods/MinBalance/changes/talent_changes")

-- Weapon Changes
mod:dofile("scripts/mods/MinBalance/changes/weapon_changes")

-- Career Changes (Passives, Ultimates, etc.)
mod:dofile("scripts/mods/MinBalance/changes/career_changes")

	for _, buffs in pairs(TalentBuffTemplates) do
		table.merge_recursive(BuffTemplates, buffs)
	end

	return
end

--Add the new templates to the DamageProfile templates
--Setup proper linkin in NetworkLookup
for key, _ in pairs(NewDamageProfileTemplates) do
	i = #NetworkLookup.damage_profiles + 1
	NetworkLookup.damage_profiles[i] = key
	NetworkLookup.damage_profiles[key] = i
end
--Merge the tables together
table.merge_recursive(DamageProfileTemplates, NewDamageProfileTemplates)
--Do FS things
for name, damage_profile in pairs(DamageProfileTemplates) do
	if not damage_profile.targets then
		damage_profile.targets = {}
	end

	fassert(damage_profile.default_target, 'damage profile ["%s"] missing default_target', name)

	if type(damage_profile.critical_strike) == "string" then
		local template = PowerLevelTemplates[damage_profile.critical_strike]

		fassert(
			template,
			'damage profile ["%s"] has no corresponding template defined in PowerLevelTemplates. Wanted template name is ["%s"] ',
			name,
			damage_profile.critical_strike
		)

		damage_profile.critical_strike = template
	end

	if type(damage_profile.cleave_distribution) == "string" then
		local template = PowerLevelTemplates[damage_profile.cleave_distribution]

		fassert(
			template,
			'damage profile ["%s"] has no corresponding template defined in PowerLevelTemplates. Wanted template name is ["%s"] ',
			name,
			damage_profile.cleave_distribution
		)

		damage_profile.cleave_distribution = template
	end

	if type(damage_profile.armor_modifier) == "string" then
		local template = PowerLevelTemplates[damage_profile.armor_modifier]

		fassert(
			template,
			'damage profile ["%s"] has no corresponding template defined in PowerLevelTemplates. Wanted template name is ["%s"] ',
			name,
			damage_profile.armor_modifier
		)

		damage_profile.armor_modifier = template
	end

	if type(damage_profile.default_target) == "string" then
		local template = PowerLevelTemplates[damage_profile.default_target]

		fassert(
			template,
			'damage profile ["%s"] has no corresponding template defined in PowerLevelTemplates. Wanted template name is ["%s"] ',
			name,
			damage_profile.default_target
		)

		damage_profile.default_target = template
	end

	if type(damage_profile.targets) == "string" then
		local template = PowerLevelTemplates[damage_profile.targets]

		fassert(
			template,
			'damage profile ["%s"] has no corresponding template defined in PowerLevelTemplates. Wanted template name is ["%s"] ',
			name,
			damage_profile.targets
		)

		damage_profile.targets = template
	end
end

local no_damage_templates = {}

for name, damage_profile in pairs(DamageProfileTemplates) do
	local no_damage_name = name .. "_no_damage"

	if not DamageProfileTemplates[no_damage_name] then
		local no_damage_template = table.clone(damage_profile)

		if no_damage_template.targets then
			for _, target in ipairs(no_damage_template.targets) do
				if target.power_distribution then
					target.power_distribution.attack = 0
				end
			end
		end

		if no_damage_template.default_target.power_distribution then
			no_damage_template.default_target.power_distribution.attack = 0
		end

		no_damage_templates[no_damage_name] = no_damage_template
	end
end

DamageProfileTemplates = table.merge(DamageProfileTemplates, no_damage_templates)

local MeleeBuffTypes = MeleeBuffTypes or {
	MELEE_1H = true,
	MELEE_2H = true,
}
local RangedBuffTypes = RangedBuffTypes or {
	RANGED_ABILITY = true,
	RANGED = true,
}
local WEAPON_DAMAGE_UNIT_LENGTH_EXTENT = 1.919366
local TAP_ATTACK_BASE_RANGE_OFFSET = 0.6
local HOLD_ATTACK_BASE_RANGE_OFFSET = 0.65

for item_template_name, item_template in pairs(Weapons) do
	item_template.name = item_template_name
	item_template.crosshair_style = item_template.crosshair_style or "dot"
	local attack_meta_data = item_template.attack_meta_data
	local tap_attack_meta_data = attack_meta_data and attack_meta_data.tap_attack
	local hold_attack_meta_data = attack_meta_data and attack_meta_data.hold_attack
	local set_default_tap_attack_range = tap_attack_meta_data and tap_attack_meta_data.max_range == nil
	local set_default_hold_attack_range = hold_attack_meta_data and hold_attack_meta_data.max_range == nil

	if RangedBuffTypes[item_template.buff_type] and attack_meta_data then
		attack_meta_data.effective_against = attack_meta_data.effective_against or 0
		attack_meta_data.effective_against_charged = attack_meta_data.effective_against_charged or 0
		attack_meta_data.effective_against_combined =
			bit.bor(attack_meta_data.effective_against, attack_meta_data.effective_against_charged)
	end

	if MeleeBuffTypes[item_template.buff_type] then
		fassert(attack_meta_data, "Missing attack metadata for weapon %s", item_template_name)
		fassert(tap_attack_meta_data, "Missing tap_attack metadata for weapon %s", item_template_name)
		fassert(hold_attack_meta_data, "Missing hold_attack metadata for weapon %s", item_template_name)
		fassert(
			tap_attack_meta_data.arc,
			"Missing arc parameter in tap_attack metadata for weapon %s",
			item_template_name
		)
		fassert(
			hold_attack_meta_data.arc,
			"Missing arc parameter in hold_attack metadata for weapon %s",
			item_template_name
		)
	end

	local actions = item_template.actions

	for action_name, sub_actions in pairs(actions) do
		for sub_action_name, sub_action_data in pairs(sub_actions) do
			local lookup_data = {
				item_template_name = item_template_name,
				action_name = action_name,
				sub_action_name = sub_action_name,
			}
			sub_action_data.lookup_data = lookup_data
			local action_kind = sub_action_data.kind
			local action_assert_func = ActionAssertFuncs[action_kind]

			if action_assert_func then
				action_assert_func(item_template_name, action_name, sub_action_name, sub_action_data)
			end

			if action_name == "action_one" then
				local range_mod = sub_action_data.range_mod or 1

				if set_default_tap_attack_range and string.find(sub_action_name, "light_attack") then
					local current_attack_range = tap_attack_meta_data.max_range or math.huge
					local tap_attack_range = TAP_ATTACK_BASE_RANGE_OFFSET + WEAPON_DAMAGE_UNIT_LENGTH_EXTENT * range_mod
					tap_attack_meta_data.max_range = math.min(current_attack_range, tap_attack_range)
				elseif set_default_hold_attack_range and string.find(sub_action_name, "heavy_attack") then
					local current_attack_range = hold_attack_meta_data.max_range or math.huge
					local hold_attack_range = HOLD_ATTACK_BASE_RANGE_OFFSET
						+ WEAPON_DAMAGE_UNIT_LENGTH_EXTENT * range_mod
					hold_attack_meta_data.max_range = math.min(current_attack_range, hold_attack_range)
				end
			end

			local impact_data = sub_action_data.impact_data

			if impact_data then
				local pickup_settings = impact_data.pickup_settings

				if pickup_settings then
					local link_hit_zones = pickup_settings.link_hit_zones

					if link_hit_zones then
						for i = 1, #link_hit_zones, 1 do
							local hit_zone_name = link_hit_zones[i]
							link_hit_zones[hit_zone_name] = true
						end
					end
				end
			end
		end
	end
end

mod.on_enabled = function(self)
	mod:echo("Tourney balance enabled")
	updateValues()

end
