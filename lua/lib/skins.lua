-- Furry (Diamonds)
SMODS.Atlas {
	key = "skin_hc_furry",
	path = "skin_hc_furry.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "skin_lc_furry",
	path = "skin_lc_furry.png",
	px = 71,
	py = 95
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
			atlas = "elle_skin_lc_furry",
			pos_style = 'collab'
		},
		{
			key = 'hc',
			ranks = {'Jack', 'Queen', "King"},
			display_ranks = {"King", "Queen", "Jack"},
			atlas = "elle_skin_hc_furry",
			pos_style = 'collab',
			hc_default = true
		},
	},
}

-- Sarah (Clubs)
SMODS.Atlas {
	key = "skin_hc_sarah",
	path = "skin_hc_clubs.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "skin_lc_sarah",
	path = "skin_lc_clubs.png",
	px = 71,
	py = 95
}
SMODS.DeckSkin {
	key = "sarah",
	suit = "Clubs",
	loc_txt = "Blue Slimes",
	palettes = {
		{
			key = 'lc',
			ranks = {'Jack', 'Queen', "King"},
			display_ranks = {"King", "Queen", "Jack"},
			atlas = "elle_skin_lc_sarah",
			pos_style = 'collab'
		},
		{
			key = 'hc',
			ranks = {'Jack', 'Queen', "King"},
			display_ranks = {"King", "Queen", "Jack"},
			atlas = "elle_skin_hc_sarah",
			pos_style = 'collab',
			hc_default = true
		},
	},
}