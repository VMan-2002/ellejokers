--		[[ Consumables ]]
-- Parasite (Spectral)
SMODS.Consumable {
	key = 'parasite',
	set = 'Spectral',
	loc_txt = {
		name = "Parasite",
		text = {
			"Can {C:e_possessed}\"Upgrade\"{} specific Jokers.",
			"Carries over values when applicable.",
			"Destroys #1# random cards in hand"
		}
	},
	config = { extra = { cards = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	cost = 7,
	atlas = 'consumables',
	pos = { x = 1, y = 0 },
	can_use = function(self, card)
		-- immediately ignore if the init conditions aren't true
		if (#G.jokers.highlighted ~= 1 or #G.hand.cards < 3) then return false end
		
		local _curr = G.jokers.highlighted[1]
		
		if (elle_parasite_upgrades[_curr.config.center.key] == nil) then return false end
		
		local _upgr = G.P_CENTERS[elle_parasite_upgrades[_curr.config.center.key].upgrade]
		
		return (_upgr.unlocked or _upgr.parasite_bypass)
	end,
	use = function(self, card, area, copier)
		-- Code I took from Immolate (and tweaked ofc)
		local destroyed_cards = {}
		local temp_hand = {}
		for k, v in ipairs(G.hand.cards) do temp_hand[#temp_hand+1] = v end
		table.sort(temp_hand, function (a, b) return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card end)
		pseudoshuffle(temp_hand, pseudoseed('elle_parasite'))

		for i = 1, card.ability.extra.cards do destroyed_cards[#destroyed_cards+1] = temp_hand[i] end

		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
			return true end }))
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			func = function() 
				for i=#destroyed_cards, 1, -1 do
					destroyed_cards[i]:start_dissolve(nil, i == #destroyed_cards)
				end
				return true end }))
		delay(0.5)
		
		-- Card Upgrading
		upgrade_joker(G.jokers.highlighted[1], elle_parasite_upgrades)
	end
}

-- Resident (Tarot)
SMODS.Consumable {
	key = 'resident',
	set = 'Tarot',
	loc_txt = {
		name = "Resident",
		text = {
			"Enhances {C:attention}#1#{} selected",
			"card into a",
			"{C:attention}Slimed Card"
		}
	},
	cost = 4,
	atlas = 'consumables',
	pos = { x = 0, y = 1 },
	config = { extra = { }, max_highlighted = 1, mod_conv = "m_elle_slimed" },
	loc_vars = function(self, info_queue, card) return { vars = { card.ability.max_highlighted } } end,
}


--		[[ Enhancements/Editions ]]
-- Slimed Enhancement
SMODS.Enhancement {
	key = 'slimed',
	loc_txt = {
		name = "Slimed Card",
		text = {
			"{X:mult,C:white}X#1#{} Mult",
			"Card gets destroyed",
			"when discarded"
		}
	},
	atlas = 'enhancers',
	pos = { x = 0, y = 0 },
	config = { extra = { }, x_mult = 2 },
	loc_vars = function(self, info_queue, card) return { vars = { card.ability.x_mult } } end,
	calculate = function(self, card, context)
		if context.discard and context.other_card == card then
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.0,
				func = (function()
					card:start_dissolve({HEX("FFAE36")}, nil, 1.6)
					return true
				end)}))
			return {remove = true}
		end
	end
}

--		[[ MoreFluff Stuff ]]
--	colour card crashes game :(
--[[if next(SMODS.find_mod('MoreFluff')) then
	SMODS.Consumable {
		object_type = "Consumable",
		set = "Colour",
		name = "col_ellepink",
		key = "ellepink",
		pos = { x = 1, y = 2 },
		config = {
			val = 0,
			partial_rounds = 0,
			upgrade_rounds = 3,
		},
		loc_txt = {
			name = "ellepink.",
			text = {
				"Converts a random card in",
				"hand to a {C:attention}Slimed Card{} for every",
				"{C:attention}#4#{} rounds this has been held",
				"{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
			},
	  },
		cost = 4,
		atlas = "consumables",
		unlocked = true,
		discovered = true,
		display_size = { w = 71, h = 87 },
		pixel_size = { w = 71, h = 87 },
		can_use = function(self, card)
			return #G.hand.cards > 1
		end,
		use = function(self, card, area, copier)
			local rng_seed = "colours_ellepink"
			local blacklist = {}
			for i = 1, card.ability.val do
				local temp_pool = {}
				for k, v in pairs(G.hand.cards) do
					if not v.config.center_key == "m_elle_slimed" and not blacklist[v] then
						table.insert(temp_pool, v)
					end
				end
				local over = false
				if #temp_pool == 0 then
					break
				end
				local eligible_card = pseudorandom_element(temp_pool, pseudoseed(rng_seed))
				blacklist[eligible_card] = true
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() eligible_card:flip();play_sound('card1', 1);eligible_card:juice_up(0.3, 0.3);return true end }))
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function() eligible_card:flip();play_sound('tarot2', percent);eligible_card:set_ability(G.P_CENTERS.m_elle_slimed, nil, true);return true end }))
				card:juice_up(0.3, 0.5)
			end
			delay(0.6)
		end,
		loc_vars = function(self, info_queue, card)
			local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
			return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
		end
	}
end]]
