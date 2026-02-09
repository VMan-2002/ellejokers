local drago = SMODS.Joker {
	key = 'drago',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = slimeutils.table_create_badge(elle_badges.friends) end end,
	config = { extra = { } },
	loc_vars = function(self, info_queue, card)
		local ench = G.GAME.current_round.elle_drago_ench or 'm_bonus'

		info_queue[#info_queue+1] = {set = "Other", key = "elle_crossover", specific_vars = {"Drago","@dragothedemon.bsky.social"} }
		info_queue[#info_queue+1] = G.P_CENTERS[ench]
		return { vars = { localize({type = 'name_text', key = ench, set = 'Enhanced'}) } } end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 0, y = 2 },
	soul_pos = { x = 5, y = 3 },
	cost = 6,
	blueprint_compat = false
}

drago.calculate = function(self, card, context)
	if context.check_enhancement and context.other_card.config.center.key == "m_wild" then
		return{
			[G.GAME.current_round.elle_drago_ench] = true
		}
	end
end

local function get_drago_ench()
end

local get_enchs_hook = SMODS.get_enhancements
function SMODS.get_enhancements(card)
	local list = get_enchs_hook(card)
	if #SMODS.find_card("j_elle_drago")>0 then list.m_wild = nil end
	return list
end


function ellejokers.reset_game_globals.drago(run_start)
	local pool = {}
	for _, v in ipairs(G.P_CENTER_POOLS.Enhanced) do
		if v.key ~= "m_wild" then pool[#pool+1] = v.key end
	end
	G.GAME.current_round.elle_drago_ench = SMODS.poll_enhancement({key = "elle_drago", guaranteed=true, options = pool})
end