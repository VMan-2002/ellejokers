local prototypes = SMODS.Joker {
	key = 'prototypes',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = slimeutils.table_create_badge(elle_badges.mall) end end,
	config = { extra = { count = 2, targets = {} } },
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 3, y = 5 },
	soul_pos = {x=5,y=3},
	cost = 10,
	blueprint_compat = false,
	in_pool = function(self) return false end,
	no_doe = true
}

-- copied from entropy lol
local function get_by_sortid(id)
    for i, v in pairs(G.jokers.cards) do
        if v.sort_id == id then return v end
    end
end

prototypes.calculate = function(self, card, context)
	if not context.blueprint then
		if context.setting_blind then
			card.ability.extra.targets = {}

			list = {}
			for i, v in ipairs(G.jokers.cards) do
				if v.config.center.blueprint_compat then list[#list+1] = v end
			end
			
			for i = 1, card.ability.extra.count do
				local ret = pseudorandom_element(list,"elle_prototypes",{in_pool = function(v, args)
					return v.config.center_key ~= "j_elle_prototypes" and v.config.center.blueprint_compat
				end})
				if ret then
					card.ability.extra.targets[#card.ability.extra.targets+1] = ret.sort_id
					for j, v in ipairs(list) do
						if v == ret then list[j]=nil break end
					end
				end
			end
			
			SMODS.calculate_effect({ message_card = card,
				message = localize("elle_41_activate"),
			}, card)
		end
	
		for _, v in ipairs(card.ability.extra.targets) do
			local bp = SMODS.blueprint_effect(card, get_by_sortid(v), context)
			if bp then SMODS.calculate_effect(bp, card) end
		end
	end
end
prototypes.loc_vars = function(self, info_queue, card)
	local ret = { vars = { card.ability.extra.count } }

	info_queue[#info_queue+1] = {set = "Other", key = "elle_upgr_no_shop"}

	-- Copied from VanillaRemade Brainstorm
	if card.area and card.area == G.jokers and #card.ability.extra.targets>0 then
		local card_pos = 0
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then card_pos = i break end
		end
		
		local nodelist = {}
		
		for i, v in ipairs(card.ability.extra.targets) do
			local j = get_by_sortid(v)
			if j.area == G.jokers then
				nodelist[#nodelist+1] = {
					n = G.UIT.R,
					config = { ref_table = card, align = "m", colour = mix_colours(G.C.BLUE, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
					nodes = {
						{ n = G.UIT.T, config = { text = ' ' .. localize({type = 'name_text', key = j.config.center_key, set = 'Joker'}) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
					}
				}
			end
		end
		
		local main_end = {
			{
				n = G.UIT.C,
				config = { align = "bm", minh = 0.4, padding = 0.1 },
				nodes = nodelist
			}
		}
		if #nodelist>0 then ret.main_end = main_end end
	end
	
	return ret
end