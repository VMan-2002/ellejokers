local gen = SMODS.Joker {
	key = 'cobble_gen',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mc) end end,
	config = { extra = { odds = 20 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.j_elle_cobblestone
		info_queue[#info_queue+1] = G.P_CENTERS.j_elle_obsidian
		
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'elle_cobble_gen')
		return { vars = { numerator, denominator } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 1, y = 3 },
	cost = 6
}

gen.calculate = function(self, card, context)
	if context.setting_blind then
		local card_pos = 0
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then card_pos = i break end
		end
		
		if card_pos>1 then
			if SMODS.pseudorandom_probability(card, 'elle_cobble_gen', 1, card.ability.extra.odds) then
				change_joker_ability(card,"j_elle_obsidian",{calculate = function(self, card) play_sound("elle_fizz", 1, 0.6) end})
			else
				change_joker_ability(G.jokers.cards[card_pos-1], "j_elle_cobblestone", {vars={value=G.jokers.cards[card_pos-1].sell_cost},end_sound="elle_fizz"})
			end
		end
	end
end
	
	-- Old behaviour
	--[[if context.selling_self then
		local eval = function(card) return not G.RESET_JIGGLES end
			juice_card_until(self, eval, true)
		
		local jokers = {}
		for i=1, #G.jokers.cards do 
			if G.jokers.cards[i] ~= self then
				jokers[#jokers+1] = G.jokers.cards[i]
			end
		end
		
		local ed = card.edition.key
		
		-- idk how else to do this lmao
		local success = #G.jokers.cards <= G.jokers.config.card_limit
		if success or ed == "e_negative" then
			
			local bucket = SMODS.create_card({key="j_elle_water_bucket",edition=ed})
			bucket:add_to_deck()
			G.jokers:emplace(bucket)
			
			success = #G.jokers.cards <= G.jokers.config.card_limit
			if success or ed == "e_negative" then 
				local bucket = SMODS.create_card({key="j_elle_lava_bucket",edition=ed})
				bucket:add_to_deck()
				G.jokers:emplace(bucket)
			end
		end
		
		return {message = success and "Opened" or localize('k_no_room_ex')}
	end
end]]