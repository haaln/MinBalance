return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`MinBalance` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("MinBalance", {
			mod_script       = "scripts/mods/MinBalance/MinBalance",
			mod_data         = "scripts/mods/MinBalance/MinBalance_data",
			mod_localization = "scripts/mods/MinBalance/MinBalance_localization",
		})
	end,
	packages = {
		"resource_packages/MinBalance/MinBalance",
	},
}
