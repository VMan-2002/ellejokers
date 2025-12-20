local cassie = SMODS.Joker {
	key = 'cassie2',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mall) end end,
	config = { extra = { cracked = false } },
	loc_vars = function(self, info_queue, card) return { vars = { } } end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 2, y = 4 },
	cost = 5,
	blueprint_compat = false,
	in_pool = function(self) return false end,
	no_doe = true,
	unlocked = false
}

-- You are not without consequences
local eternal_hook = SMODS.is_eternal
function SMODS.is_eternal(card, ...)
	local eh = eternal_hook(card, ...)
	
	if (card.config.center_key == "j_elle_cassie2") then return true end
	
	return eh
end