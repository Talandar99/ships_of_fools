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
force_setting("bool", "maraxsis-msppr", true)

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

-- dynamic_platform lighting force deep dark
force_setting("bool", "dynamic_platform_deep_darkness", true)

-- nuclear science pack
force_setting("bool", "lock-nuclear-science-pack-behind-cerys", true)
force_setting("bool", "refillable-mixed-oxide-reactor-equipment", true)
force_setting("bool", "nuclear-assembling-machine", true)
force_setting("bool", "refillable-fission-reactor-equipment", true)
force_setting("bool", "nuclear-science-pack-centrifuge-prod-bonus", true)
force_setting("bool", "lock-mixed-oxide-reactor-behind-maraxsis-salt-reactor", true)
force_setting("bool", "spidertron-require-fuel-cells", true)

-- fusion machines
force_setting("bool", "refillable-fusion-reactor-equipment", true)
force_setting("bool", "fusion-assembling-machine", true)
force_setting("bool", "fusion-lab", true)
force_setting("bool", "fusion-reactor-and-generator-buff", true)
force_setting("bool", "fusion-fuel-cell-buff", true)

-- depths of nauvis
force_setting("bool", "deep-sea-mechanic", true)
force_setting("bool", "block-elevated-rails-on-deep-sea", true)
force_setting("bool", "generate-uranium-only-on-water", true)

--local parts production
force_setting("bool", "gleba-local-rocket-part", true)
force_setting("bool", "vulcanus-local-rocket-part", true)
force_setting("bool", "aquilo-local-rocket-part", true)
force_setting("bool", "arig-local-rocket-part", true)
force_setting("bool", "vesta-local-rocket-part", true)
force_setting("bool", "lignumis-local-rocket-part", true)
