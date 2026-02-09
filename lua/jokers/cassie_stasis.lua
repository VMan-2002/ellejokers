local cassie = SMODS.Joker {
	key = 'cassie2',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = slimeutils.table_create_badge(elle_badges.mall) end end,
	config = { extra = { cracked = false } },
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue+1] = {set = "Other", key = "elle_upgr_no_shop"}
		return { vars = { } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 2, y = 4 },
	cost = 8,
	blueprint_compat = false,
	in_pool = function(self) return false end,
	no_doe = true,
	unlocked = false
}

-- You are not without consequences
local csc_hook = Card.can_sell_card
function Card:can_sell_card(context, ...)
	if (self.config.center_key == "j_elle_cassie2") then return false end
	return csc_hook(self, context, ...)
end

-- Hide the cost
local upd_ref = Card.update
function Card:update(...)
	upd_ref(self, ...)
	
	if (self.config.center_key == "j_elle_cassie2") then self.sell_cost_label = '?' end
end

-- Force the cost to 0
local sc_ref = Card.set_cost
function Card:set_cost(...)
	sc_ref(self, ...)
	
	if (self.config.center_key == "j_elle_cassie2") then self.sell_cost = 0 end
end