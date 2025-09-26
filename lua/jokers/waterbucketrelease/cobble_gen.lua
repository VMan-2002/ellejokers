local gen = SMODS.Joker {
	key = 'cobble_gen',
	loc_txt = {
		name = 'Cobblestone Generator',
		text = {
			"{C:attention}Sell{} this Joker to create",
			"{C:attention}Water Bucket{} and {C:attention}Lava Bucket",
			"{C:inactive}(Must have room)"
		}
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mc() end,
	config = { extra = { } },
	loc_vars = function(self, info_queue, card)
		return { vars = { } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 1, y = 2 },
	cost = 6
}

gen.calculate = function(self, card, context)
	if context.selling_self then
		local eval = function(card) return not G.RESET_JIGGLES end
			juice_card_until(self, eval, true)
		
		local jokers = {}
		for i=1, #G.jokers.cards do 
			if G.jokers.cards[i] ~= self then
				jokers[#jokers+1] = G.jokers.cards[i]
			end
		end
		
		-- idk how else to do this lmao
		local success = #G.jokers.cards <= G.jokers.config.card_limit
		if success then 
			local bucket = SMODS.create_card({key="j_elle_water_bucket",no_edition=true})
			bucket:add_to_deck()
			G.jokers:emplace(bucket)
			
			success = #G.jokers.cards <= G.jokers.config.card_limit
			if success then 
				local bucket = SMODS.create_card({key="j_elle_lava_bucket",no_edition=true})
				bucket:add_to_deck()
				G.jokers:emplace(bucket)
			end
		end
		
		return {message = success and "Opened" or localize('k_no_room_ex')}
	end
end