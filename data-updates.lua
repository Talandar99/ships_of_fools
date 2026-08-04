--table.insert(data.raw["technology"]["space-platform-thruster"].prerequisites, "advanced-asteroid-processing")
data:extend({
	{
		type = "recipe",
		name = "stone-furnace-from-bricks",
		enabled = true,
		energy_required = 0.5,
		icons = {
			{
				icon = data.raw.item["stone-furnace"].icon,
				icon_size = data.raw.item["stone-furnace"].icon_size or 64,
			},
			{
				icon = data.raw.item["stone-brick"].icon,
				icon_size = data.raw.item["stone-brick"].icon_size or 64,
				scale = 0.25,
				shift = { 8, 8 },
			},
		},
		ingredients = {
			{ type = "item", name = "stone-brick", amount = 3 },
		},
		results = {
			{ type = "item", name = "stone-furnace", amount = 1 },
		},
	},
})
data:extend({
	{
		type = "recipe",
		name = "logistic-science-pack-cerys",
		icons = {
			{
				icon = data.raw.tool["logistic-science-pack"].icon,
				icon_size = data.raw.tool["logistic-science-pack"].icon_size or 64,
			},
		},
		enabled = false,
		energy_required = 6,
		category = "cryogenics",
		additional_categories = { "fulgoran-cryogenics" },
		ingredients = {
			{ type = "item", name = "transport-belt", amount = 1 },
			{ type = "fluid", name = "lubricant", amount = 10 },
		},
		surface_conditions = {
			{

				property = "cerys-ambient-radiation",
				min = 400,
			},
		},
		results = { { type = "item", name = "logistic-science-pack", amount = 1 } },
		crafting_machine_tint = {
			primary = { r = 0.0, g = 1.0, b = 0.0, a = 1.000 },
			secondary = { r = 0.0, g = 1.0, b = 0.0, a = 1.000 },
		},
		allow_productivity = true,
	},
})
table.insert(
	data.raw["technology"]["cerys-lubricant-synthesis"].effects,
	{ type = "unlock-recipe", recipe = "logistic-science-pack-cerys" }
)
data.extend({
	{
		type = "recipe",
		name = "vulcanus-local-rocket-part",
		icons = {
			{ icon = "__base__/graphics/icons/rocket-part.png", icon_size = 64 },
			{ icon = "__space-age__/graphics/icons/vulcanus.png", icon_size = 64, scale = 0.25, shift = { 8, 8 } },
		},
		energy_required = 3,
		enabled = false,
		hide_from_player_crafting = true,
		auto_recycle = false,
		category = "rocket-building",
		ingredients = {
			{ type = "item", name = "processing-unit", amount = 1 },
			{ type = "item", name = "tungsten-plate", amount = 2 },
			{ type = "fluid", name = "heavy-oil", amount = 150 },
		},
		surface_conditions = {
			{
				property = "pressure",
				min = 4000,
				max = 4000,
			},
		},
		results = { { type = "item", name = "rocket-part", amount = 1 } },
		allow_productivity = true,
	},
})
