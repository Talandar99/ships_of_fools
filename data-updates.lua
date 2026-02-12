data.raw["assembling-machine"]["burner-assembling-machine"].crafting_speed = 0.50
data.raw["assembling-machine"]["steam-assembling-machine"].crafting_speed = 0.75
data.raw["assembling-machine"]["assembling-machine-2"].crafting_speed = 1.00

table.insert(data.raw["technology"]["planet-discovery-nauvis"].prerequisites, "planetslib-cerys-cargo-drops")
data.raw["technology"]["moon-discovery-cerys"].prerequisites =
	{ "planet-discovery-fulgora", "advanced-asteroid-processing" }

--table.insert(data.raw["technology"]["space-platform-thruster"].prerequisites, "advanced-asteroid-processing")
