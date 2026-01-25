local j = SMODS.Joker {
	key = 'not_cassie',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mall) end end,
	config = { extra = { } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = "Other", key = "elle_upgr_no_shop"}
		return { vars = { "#" } }
    end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 3, y = 4 },
	soul_pos = { x = 5, y = 3 },
	cost = 9,
	in_pool = function(self) return false end,
	no_doe = true,
	blueprint_compat = false,
	unlocked = false
}

--[[local gca_hook = SMODS.get_card_areas
function SMODS.get_card_areas(_type, _context)
	local r = gca_hook(_type, _context)
	print(inspect(r))
	--if (#SMODS.find_card("j_elle_not_cassie")>0) then  end
	return r
end]]