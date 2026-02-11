data.raw["assembling-machine"]["burner-assembling-machine"].crafting_speed = 0.50
data.raw["assembling-machine"]["steam-assembling-machine"].crafting_speed = 0.75
data.raw["assembling-machine"]["assembling-machine-2"].crafting_speed = 1.00

table.insert(data.raw["technology"]["planet-discovery-nauvis"].prerequisites, "planetslib-cerys-cargo-drops")
data.raw["technology"]["moon-discovery-cerys"].prerequisites = { "agricultural-science-pack" }
table.insert(data.raw["technology"]["planet-discovery-aquilo"].prerequisites, "planetaris-compression-science")
table.insert(
	data.raw["technology"]["planet-discovery-aquilo"].unit.ingredients,
	{ "planetaris-compression-science-pack", 1 }
)
