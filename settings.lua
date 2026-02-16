-- force start on pelagos
APS.set_fixed_choice("pelagos")

local function force_setting(setting_type, setting_name, value)
	local setting = data.raw[setting_type .. "-setting"][setting_name]
	if setting then
		if setting_type == "bool" then
			setting.forced_value = value
		else
			setting.allowed_values = { value }
		end
		setting.default_value = value
		setting.hidden = true
	end
end

-- enable all settings in msppr
force_setting("bool", "space-spidertron-compatibility", true)
force_setting("bool", "lignumis-msppr", true)
force_setting("bool", "quality-assembler-require-promethium-plates", true)
force_setting("bool", "msppr-cerys", true)
-- force pelagos science addition to progression
force_setting("bool", "pelagos-contribute-to-aquilo-discovery", true)
force_setting("bool", "pelagos-contribute-to-promethium-science", true)
-- pelagos methane on vesta
force_setting("bool", "pelagos-methane-on-vesta", true)
-- lignumis
force_setting("bool", "ltdi-enable-progressive-recipes-for-belts", true)
-- force arig science addition to progression
force_setting("bool", "compression-for-aquilo", true)
force_setting("bool", "compression-for-promethium", true)
-- fulgoran enemy disable loot
force_setting("bool", "fulgenemy-disable-loot", true)
-- molten plastic
force_setting("bool", "replace-plastic", true)
force_setting("bool", "dynamic-recipes", true)
