local sophie = SMODS.Joker {
	key = 'sophie',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mall) end end,
	config = { extra = { mult_mod = 1, mult = 0, cap = 10, req = 25 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult, card.ability.extra.cap } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 3, y = 0 },
	soul_pos = { x = 3, y = 1 },
	cost = 6,
	unlocked = false,
	blueprint_compat = true,
	check_for_unlock = function(self, args)
		if args.type == "round_win" then return G.GAME.chips/G.GAME.blind.chips >= to_big(10) end
	end
}

sophie.calculate = function(self, card, context)
	-- Add the mult stuff
	if context.end_of_round and context.cardarea == G.jokers and not context.blueprint and math.floor(G.GAME.chips / G.GAME.blind.chips) ~= 1 then
		local _count = math.floor(G.GAME.chips / G.GAME.blind.chips)-1
		
		-- ...what?
		-- this happens in multiplayer sometimes for some reason
		if (to_number(_count) < 0) then 
			card:juice_up(1,1)
			print("Attempted to set Sophie to negative value: ".._count)
			return {
				message = "...what?"
			}
		end
		
		local _mult = math.min(_count * card.ability.extra.mult_mod, card.ability.extra.cap)
		
		card.ability.extra.mult = card.ability.extra.mult + _mult
		
		card:juice_up(.1,.1)
		
		return {
			message = localize { type = 'variable', key = 'a_mult', vars = { _mult } }
		}
	end
	
	if context.joker_main then
		if card.ability.extra.mult ~= 0 then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
			}
		end
	end
end

sophie.slime_upgrade = {
	card = "j_elle_fallen",
	values = function(self, card) return { mult = card.ability.extra.mult } end,
	can_use = function(self, card) return to_big(card.ability.extra.mult) >= to_big(card.ability.extra.req) end,
	loc_vars = function(self, card) return { card.ability.extra.req } end
}

