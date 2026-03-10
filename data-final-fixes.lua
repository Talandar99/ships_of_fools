local function remove_recipe_unlock(tech_name, recipe_name)
	local tech = data.raw.technology[tech_name]
	if not tech or not tech.effects then
		return
	end

	for i = #tech.effects, 1, -1 do
		local effect = tech.effects[i]
		if effect.type == "unlock-recipe" and effect.recipe == recipe_name then
			table.remove(tech.effects, i)
		end
	end

	if #tech.effects == 0 then
		tech.effects = nil
	end
end
local function remove_prerequisite(tech_name, prerequisite_to_remove)
	local tech = data.raw.technology[tech_name]
	if not tech or not tech.prerequisites then
		return
	end

	for i = #tech.prerequisites, 1, -1 do
		if tech.prerequisites[i] == prerequisite_to_remove then
			table.remove(tech.prerequisites, i)
		end
	end
end
local function hide_technology_and_rewire(old_tech, new_tech)
	local old = data.raw.technology[old_tech]
	local new = data.raw.technology[new_tech]

	if not old or not new then
		return
	end

	for _, tech in pairs(data.raw.technology) do
		if tech.prerequisites then
			for i = #tech.prerequisites, 1, -1 do
				if tech.prerequisites[i] == old_tech then
					table.remove(tech.prerequisites, i)

					local exists = false
					for _, p in pairs(tech.prerequisites) do
						if p == new_tech then
							exists = true
							break
						end
					end

					if not exists then
						table.insert(tech.prerequisites, new_tech)
					end
				end
			end
		end
	end

	if old.effects then
		new.effects = new.effects or {}
		for _, effect in pairs(old.effects) do
			table.insert(new.effects, effect)
		end
	end

	old.hidden = true
	old.enabled = false
end

local function hide_by_name(name)
	for proto_type, proto in pairs(data.raw) do
		local e = proto[name]
		if e and proto_type ~= "item" and proto_type ~= "recipe" then
			e.hidden = true
			if e.next_upgrade and e.minable then
				e.minable = {
					mining_time = e.minable.mining_time or 0.2,
					results = {},
				}
			end
		end
	end

	if data.raw.recipe[name] then
		local r = data.raw.recipe[name]
		r.hidden = true
		r.enabled = false
	end

	local item_types = {
		"item",
		"item-with-entity-data",
		"tool",
		"ammo",
		"capsule",
		"module",
		"gun",
		"armor",
		"repair-tool",
	}

	for _, t in pairs(item_types) do
		if data.raw[t] and data.raw[t][name] then
			data.raw[t][name].hidden = true
		end
	end
end
-- assembling machines changes
hide_technology_and_rewire("automation", "automation-science-pack")
hide_technology_and_rewire("automation-3", "production-science-pack")
data.raw["assembling-machine"]["steam-assembling-machine"].next_upgrade = "assembling-machine-2"
data.raw["assembling-machine"]["assembling-machine-2"].next_upgrade = "diesel-assembling-machine"
data.raw["assembling-machine"]["diesel-assembling-machine"].next_upgrade = nil
hide_by_name("assembling-machine-1")
hide_by_name("assembling-machine-3")

table.insert(
	data.raw["recipe"]["assembling-machine-2"].ingredients,
	{ type = "item", name = "iron-plate", amount = 15 }
)
-- steel furnace
hide_technology_and_rewire("advanced-material-processing", "logistic-science-pack")
for _, furnace in pairs(data.raw["furnace"]) do
	if furnace.next_upgrade == "steel-furnace" then
		furnace.next_upgrade = nil
	end
end
hide_by_name("steel-furnace")
-- mining drill changes
hide_technology_and_rewire("electric-mining-drill", "diesel-mining-drill")
hide_by_name("electric-mining-drill")

-- quality changes
hide_technology_and_rewire("epic-quality", "quality-module")
hide_technology_and_rewire("legendary-quality", "quality-module")
data.raw["assembling-machine"]["crusher"].allowed_effects = { "consumption", "speed", "productivity", "pollution" }
data.raw["furnace"]["recycler"].allowed_effects = { "consumption", "speed", "productivity", "pollution" }

-- science
hide_by_name("aps-pelagos-automation-science-pack")
hide_by_name("aps-pelagos-logistic-science-pack")
data.raw["recipe"]["automation-science-pack"].ingredients = {
	{ type = "item", name = "iron-gear-wheel", amount = 1 },
	{ type = "item", name = "wood", amount = 1 },
}
data.raw["recipe"]["logistic-science-pack"].ingredients = {
	{ type = "item", name = "transport-belt", amount = 1 },
	{ type = "item", name = "wood-transport-belt", amount = 1 },
}

-- foundation promethium science
data.raw["technology"]["foundation"].unit.ingredients = data.raw["technology"]["research-productivity"].unit.ingredients
table.insert(data.raw["technology"]["foundation"].prerequisites, "promethium-science-pack")
table.insert(
	data.raw["recipe"]["foundation"].ingredients,
	{ type = "item", name = "msppr-promethium-plate", amount = 1 }
)

-- lignumis deep miner is now burner
data.raw["mining-drill"]["deep-miner"].energy_source = {
	fuel_inventory_size = 1,
	type = "burner",
	usage_priority = "secondary-input",
	emissions_per_minute = { pollution = 200, noise = 2000 },
}
data.raw["mining-drill"]["deep-miner"].energy_usage = "15MW"

--thruster changes
--------------------------------------------------------------------------------------------
remove_prerequisite("planet-discovery-vulcanus", "space-platform-thruster")
remove_prerequisite("planet-discovery-fulgora", "space-platform-thruster")
remove_prerequisite("planet-discovery-nauvis", "space-platform-thruster")
remove_prerequisite("advanced-asteroid-processing", "space-platform-thruster")
remove_recipe_unlock("space-platform", "carbonic-asteroid-crushing")
table.insert(
	data.raw["technology"]["advanced-asteroid-processing"].effects,
	{ type = "unlock-recipe", recipe = "carbonic-asteroid-crushing" }
)
remove_recipe_unlock("advanced-asteroid-processing", "advanced-thruster-fuel")
remove_recipe_unlock("advanced-asteroid-processing", "advanced-thruster-oxidizer")
table.insert(
	data.raw["technology"]["space-platform-thruster"].effects,
	{ type = "unlock-recipe", recipe = "advanced-thruster-fuel" }
)
table.insert(
	data.raw["technology"]["space-platform-thruster"].effects,
	{ type = "unlock-recipe", recipe = "advanced-thruster-oxidizer" }
)
table.insert(data.raw["technology"]["space-platform-thruster"].prerequisites, "advanced-asteroid-processing")
table.insert(data.raw["technology"]["space-platform-thruster"].prerequisites, "asteroid-reprocessing")
data.raw["technology"]["space-platform-thruster"].unit.ingredients =
	data.raw["technology"]["advanced-asteroid-processing"].unit.ingredients
data.raw["technology"]["space-platform-thruster"].unit.count = 1000
table.insert(data.raw["technology"]["space-platform-thruster"].unit.ingredients, { "metallurgic-science-pack", 1 })
table.insert(data.raw["recipe"]["thruster"].ingredients, { type = "item", name = "tungsten-plate", amount = 10 })
table.insert(data.raw["recipe"]["thruster"].ingredients, { type = "item", name = "carbon-fiber", amount = 10 })

table.insert(data.raw["technology"]["promethium-science-pack"].prerequisites, "s1_gas_manipulation_science_pack")
--------------------------------------------------------------------------------------------
require("space-locked-recipes")
