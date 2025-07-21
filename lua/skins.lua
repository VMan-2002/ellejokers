-- Furry (Diamonda)
local atlas_hc = SMODS.Atlas {
	key = "skin_hc",
	path = "skin_hc_furry.png",
	px = 71,
	py = 95,
}
local atlas_lc = SMODS.Atlas {
	key = "skin_lc",
	path = "skin_lc_furry.png",
	px = 71,
	py = 95,
}
SMODS.DeckSkin {
	key = "furry",
	suit = "Diamonds",
	loc_txt = "Furry",
	palettes = {
		{
			key = 'lc',
			ranks = {'Jack', 'Queen', "King"},
			display_ranks = {"King", "Queen", "Jack"},
			atlas = atlas_lc.key,
			pos_style = 'collab'
		},
		{
			key = 'hc',
			ranks = {'Jack', 'Queen', "King"},
			display_ranks = {"King", "Queen", "Jack"},
			atlas = atlas_hc.key,
			pos_style = 'collab'
		},
	},
}
