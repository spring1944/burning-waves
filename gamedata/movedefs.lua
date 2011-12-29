local moveDefs 	=	 {
	{
		name					=	"TANK_Light",
		footprintX		=	2,
		maxWaterDepth	=	8,
		maxSlope			=	22,
		heatmapping		=	false,
	},
	
	{
		name					=	"BOAT_Small",
		footprintX		=	1,
		minWaterDepth	=	5,
		crushStrength	=	10,
		heatmapping		=	false,
	},
	{
		name					=	"BOAT_Medium",
		footprintX		=	2,
		minWaterDepth	=	5,
		crushStrength	=	10,
		heatmapping		=	false,
	},
	{
		name					=	"BOAT_RiverSmall",
		footprintX		=	4,
		minWaterDepth	=	6,
		crushStrength	=	10,
		heatmapping		=	false,
	},
	{
		name					=	"BOAT_River",
		footprintX		=	8,
		minWaterDepth	=	6,
		crushStrength	=	10,
		heatmapping		=	false,
	},
	{
		name					=	"BOAT_LightPatrol",
		footprintX		=	2,
		minWaterDepth	=	10,
		crushStrength	=	10,
		heatmapping		=	false,
	},
	{
		name					=	"BOAT_Destroyer",
		footprintX		=	6,
		minWaterDepth	=	20,
		crushStrength	=	10,
		heatmapping		=	false,
	},
	
	{
		name					=	"BOAT_Carrier",
		footprintX		=	12,
		minWaterDepth	=	20,
		crushStrength	=	10,
		heatmapping		=	false,
	},
	{
		name					=	"BOAT_LandingCraft",
		footprintX		=	16,
		minWaterDepth	=	2,
		crushStrength	=	10,
		heatmapping		=	false,
	},
	{
		name					=	"BOAT_Sub",
		footprintX		=	8,
		minWaterDepth	=	40,
		crushStrength	=	10,
		submarine	=	1,
		heatmapping		=	false,
	},
}

return moveDefs