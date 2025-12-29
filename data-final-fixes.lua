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
	-- ENTITY
	for proto_type, proto in pairs(data.raw) do
		local e = proto[name]
		if e and proto_type ~= "item" and proto_type ~= "recipe" then
			-- ukryj entity
			e.hidden = true

			-- jeśli jest częścią upgrade chaina, mining NIE MOŻE dawać hidden itemu
			if e.next_upgrade and e.minable then
				e.minable = {
					mining_time = e.minable.mining_time or 0.2,
					results = {},
				}
			end
		end
	end

	-- RECIPE
	if data.raw.recipe[name] then
		local r = data.raw.recipe[name]
		r.hidden = true
		r.enabled = false
	end

	-- ITEM (item-like)
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
-- mining drill changes
hide_technology_and_rewire("electric-mining-drill", "diesel-mining-drill")
hide_by_name("electric-mining-drill")

-- quality changes
hide_technology_and_rewire("epic-quality", "quality-module")
hide_technology_and_rewire("legendary-quality", "quality-module")
for _, furnace in pairs(data.raw["mining-drill"]) do
	furnace.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
end
data.raw["assembling-machine"]["crusher"].allowed_effects = { "consumption", "speed", "productivity", "pollution" }
data.raw["furnace"]["recycler"].allowed_effects = { "consumption", "speed", "productivity", "pollution" }
