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

-- pelagos methane on vesta
force_setting("bool", "pelagos-methane-on-vesta", true)
-- lignumis
force_setting("bool", "ltdi-enable-progressive-recipes-for-belts", true)
--
