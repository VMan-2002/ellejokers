local bucket = SMODS.Joker {
	key = 'lava_bucket',
	config = { extra = { mult_mod = 5, mult = 0 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.j_elle_obsidian
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 3, y = 2 },
	cost = 1,
	no_collection = true,
	blueprint_compat = false,
	in_pool = function(self) return false end,
	no_doe = true
}

bucket.calculate = function(self, card, context)
	if context.setting_blind then
		local lava_pos = 0
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then lava_pos = i end
		end
		
		local obsidian = false
		for i = -1, 1, 2 do -- Check both sides
			-- Check whether to turn into obsidian
			obsidian = obsidian or (G.jokers.cards[lava_pos+i] and G.jokers.cards[lava_pos+i].config.center_key == "j_elle_water_bucket")
			
			-- Make cobblestone
			if (G.jokers.cards[lava_pos+(i*2)] and G.jokers.cards[lava_pos+(i*2)].config.center_key == "j_elle_water_bucket" and G.jokers.cards[lava_pos+i].config.center_key ~= "j_elle_cobblestone") then
				slimeutils.transform_card(G.jokers.cards[lava_pos+(i)],"j_elle_cobblestone",{value=G.jokers.cards[lava_pos+(i)].sell_cost, instant = true, end_sound = "elle_fizz"})
			end
		end
		if obsidian then
			slimeutils.transform_card(card,"j_elle_obsidian",{instant = true, end_sound = "elle_fizz"})
		end
	end
end