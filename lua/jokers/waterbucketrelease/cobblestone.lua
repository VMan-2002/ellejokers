local cobble = SMODS.Joker {
	key = 'cobblestone',
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mc() end,
	config = { extra = { mult = 3, value = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.value } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 2, y = 3 },
	cost = 0,
	blueprint_compat = false,
	in_pool = function(self) return false end,
	no_doe = true
}



-- Set the cost
local sc_ref = Card.set_cost
function Card:set_cost()
	local sc = sc_ref(self)
	
	if (self.config.center_key == "j_elle_cobblestone") then
		self.sell_cost = math.max(1,self.ability.extra.mult * self.ability.extra.value)
		self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
	end
	
	return sc
end