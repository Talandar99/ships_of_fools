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
