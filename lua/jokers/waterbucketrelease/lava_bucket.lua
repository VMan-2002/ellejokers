local bucket = SMODS.Joker {
	key = 'lava_bucket',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mc) end end,
	config = { extra = { mult_mod = 5, mult = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 3, y = 2 },
	cost = 1,
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
				play_sound("elle_fizz", 1.6, 0.4)
				transform_joker(G.jokers.cards[lava_pos+(i)],"j_elle_cobblestone",{value=G.jokers.cards[lava_pos+(i)].sell_cost},true)
			end
		end
		if obsidian then
			play_sound("elle_fizz", 1, 0.6)
			change_joker_ability(card,"j_elle_obsidian")
		end
	end
end