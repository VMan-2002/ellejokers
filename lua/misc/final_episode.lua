SMODS.Challenge {
	key = "final_episode",
	jokers = {{
		id = "j_elle_tenna",
		eternal=true,
		ability = {elle_protected = true}
	}},
	vouchers = {
		{id = "v_overstock_norm"}
	},
	rules = {
		modifiers = {
			{id="joker_slots", value = 4}
		},
		custom = {
			{id="scaling", value = 2}
		}
	},
	restrictions = {
		banned_cards = {
			{id = "v_hieroglyph"},
			{id = "v_petroglyph"},
			{id = "v_directors_cut"},
			{id = "v_retcon"},
			{id = "v_clearance_sale"},
			{id = "v_liquidation"},
			{id = "j_elle_rebecca"},
			{id = "j_elle_spamton"} --glooby :(
		}
	},
	apply = function()
		G.GAME.starting_params.elle_final_episode = true
		G.GAME.starting_params.elle_tenna_money = "k_points"
	end
}

SMODS.Atlas {
	key = "bl_final_episode",
	path = "bl_final_episode.png",
	px = 34,
	py = 34,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 21
}

local myblind = SMODS.Blind {
	key = "final_episode",
	atlas = "bl_final_episode",
	dollars = 8,
	mult = 2,
	pos = { x = 0, y = 0 },
	in_pool = function(self) return false end,
	ignore_showdown_check = true,
	boss_colour = HEX("DA1F52"),
	boss = {showdown = true, min = 10, max = 10},
	vars = {}
}

get_new_boss_ref = get_new_boss
function get_new_boss(...)
	if G.GAME.starting_params.elle_final_episode and ((G.GAME.round_resets.ante)%G.GAME.win_ante == 0 and G.GAME.round_resets.ante >= 2) then
		return myblind.key
	end
	return get_new_boss_ref(...)
end

attention_text_ref = attention_text
function attention_text(args, ...)
	if G.GAME.starting_params.elle_tenna_money and args.cover == G.HUD:get_UIE_by_ID('dollar_text_UI').parent then
		local dollar = localize('$')
		local dollarstart, dollarend = string.find(args.text, dollar, nil, true)
		args.text = string.sub(args.text, 0, dollarstart - 1) .. string.sub(args.text, dollarend + 1)
	end
	return attention_text_ref(args, ...)
end

ellejokers.traverse = function(a, cond, rem)
	rem = rem or 24
	if cond(a) then
		return a
	elseif rem ~= 0 then
		local ret
		for k,v in pairs(a) do
			if type(v) == "table" then
				ret = ellejokers.traverse(v, cond, rem - 1)
				if ret ~= nil then return ret end
			end
		end
	end
	return nil
end
local safeget = function(a, ...)
	for i,v in pairs({...}) do
		if type(a) == "table" and a[v] ~= nil then
			a = a[v]
		else
			return nil
		end
	end
	return a
end

local uibox_ref = create_UIBox_HUD
function create_UIBox_HUD()
    local orig = uibox_ref()
	if G.GAME.starting_params.elle_tenna_money then
		local money_container = ellejokers.traverse(orig, function(a)
			return safeget(a, "nodes", 1, "nodes", 1, "nodes", 1, "config", "id") == "dollar_text_UI"
		end)
		if money_container then
			print("Money container mod")
			table.insert(money_container.nodes, 1, {
				n = G.UIT.R,
				config = {align = "cm", minh = 0.33, maxw = 1.35},
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = localize(G.GAME.starting_params.elle_tenna_money),
							scale = 0.34,
							colour = G.C.UI.TEXT_LIGHT,
							shadow = true
						}
					}
				}
			})
			money_container.nodes[2].nodes[1].nodes[1].config.object.config.string[1].prefix = ""
		end
	end
	return orig
end