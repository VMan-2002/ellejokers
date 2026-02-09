local spam = SMODS.Joker {
	key = 'spamton',
	config = { extra = { cost = { reroll = 4 }, cards = { jokers = {}, consumables = {}, booster = {} } } },
	loc_vars = function(self, info_queue, card) return { vars = { colours = {HEX("ffaec9"),HEX("fff200")} } } end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 6, y = 4 },
	cost = 5
}

local spamton_sets = {
	def = {
		"Joker",
		"Consumeables",
		"Playing Card"
	},
	big = {
		"Joker",
		"Booster",
		"Voucher"
	}
}

-- Open shop
spam.slime_active = {
	calculate = function(self, card)
		G.FUNCS.overlay_menu({ definition = create_UIbox_spamton() })
	end,
	can_use = function(self, card) return true end,
	should_close = function(self, card) return true end,
	name = function(self, card) return localize("elle_joker_open") end
}

-- Restock shop
spam.calculate = function(self, card, context)
	if (context.end_of_round and context.main_eval and not context.blueprint) then
		G.GAME.elle_popup_shops.spamton.reset_on_open = true
		return { message = localize("elle_shop_restock") }
	end
end

-- Reroll shop while inside UI (targetting cardareas)
local function spamton_visible_reroll(set)
	-- Remove old cards
	for i2 = #G.elle_spamton_shop.cards,1, -1 do
		local c = G.elle_spamton_shop:remove_card(G.elle_spamton_shop.cards[i])
		c:remove()
		c = nil
	end

	-- Add cards
	for i = 1, 4 -#G.elle_spamton_shop.cards do
		
		local new_shop_card = SMODS.create_card({set=pseudorandom_element(set, "elle_spamton_set"), area=G.elle_spamton_shop, skip_materialize = true, bypass_discovery_center = true})
		G.elle_spamton_shop:emplace(new_shop_card)
		create_shop_card_ui(new_shop_card)
		new_shop_card:juice_up()
		--print("added joker")
	end
end

-- Shop UI
function create_UIbox_spamton()
	--print(G.GAME.elle_popup_shops.spamton.first_open)
	G.elle_spamton_shop = CardArea(
		G.hand.T.x,
		G.hand.T.y+G.ROOM.T.y + 9,
		3.6*G.CARD_W,
		1.05*G.CARD_H, 
		{card_limit = 4, type = 'shop', highlight_limit = 1, negative_info = true})

	-- Track whether this shop is open
	G.GAME.elle_popup_shop_open = "spamton"
	
	-- Reload areas if not first time opening
	if not G.GAME.elle_popup_shops.spamton.first_open then
		ellejokers.popup_shop.load_shop_areas("spamton")
		--save_run()
	else G.GAME.elle_popup_shops.spamton.first_open = false end


	-- Reroll the shop on open if expected to
	if (G.GAME.elle_popup_shops.spamton.reset_on_open) then
		G.GAME.elle_popup_shops.spamton.reset_on_open = false
		
		G.E_MANAGER:add_event(Event({ func = function()
			spamton_visible_reroll(spamton_sets.def)
			return true
		end}))
	end
	
	return create_UIBox_generic_options({
		no_back = true,
		contents = {
			{n = G.UIT.R, config = {align="cm", padding = .2}, nodes = {
				-- Left side (Actual shop)
				{n = G.UIT.C, config = {align="cm", minw=8, minh=4, colour = G.C.BLACK, outline = 2, outline_colour = G.C.WHITE}, nodes = {
					{n=G.UIT.O, config={object = G.elle_spamton_shop}}
				}},
				-- Right side (Buttons)
				{n = G.UIT.C, config = {align="tm", padding=.1, colour = G.C.BLACK, outline = 2, outline_colour = G.C.WHITE}, nodes = {
					{n=G.UIT.R, config={align="cl", minw=4.6, padding=.2, colour=G.C.L_BLACK, func="elle_spamton_can_reroll", button = "elle_spamton_reroll"}, nodes= {
						{n=G.UIT.R, config={align="cl"}, nodes= {
							{n=G.UIT.T, config={text = "$", scale=0.6, colour = G.C.WHITE}},
							{n=G.UIT.T, config={ref_table = G.GAME.elle_popup_shops.spamton, ref_value = 'reroll', scale=0.6, colour = G.C.WHITE}},
							{n=G.UIT.T, config={text = " REROLL!", scale=0.6, colour = G.C.WHITE}},
						}},
					}},
					{n=G.UIT.R, config={align="cl", minw=4.6, padding=.2, colour=G.C.L_BLACK, func="elle_spamton_can_big_reroll", button = "elle_spamton_big_reroll"}, nodes= {
						{n=G.UIT.R, config={align="cl"}, nodes= {
							{n=G.UIT.T, config={text = "$", scale=0.6, colour = G.C.WHITE}},
							{n=G.UIT.T, config={ref_table = G.GAME.elle_popup_shops.spamton, ref_value = 'reroll2', scale=0.6, colour = G.C.WHITE}},
							{n=G.UIT.T, config={text = " BIG DEALS!!!", scale=0.6, colour = G.C.WHITE}},
						}},
					}},
					{n=G.UIT.R, config={align="cl", minw=4.6, padding=.2, func="elle_spamton_hover", button = "exit_overlay_menu", colour=G.C.L_BLACK}, nodes= {
						{n=G.UIT.T, config={text = "ESCAPE", scale=1.7, colour = G.C.WHITE}},
					}}
				}},
			}},
		}
	})
end

-- Reroll button update
function G.FUNCS.elle_spamton_can_reroll(e)
	e.config.colour = e.states.hover.is and G.C.L_BLACK or G.C.BLACK
	if ((G.GAME.dollars-G.GAME.bankrupt_at) - G.GAME.elle_popup_shops.spamton.reroll < 0) and G.GAME.elle_popup_shops.spamton.reroll ~= 0 then 
		e.config.button = nil
		e.children[1].children[1].config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.children[1].children[2].config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.children[1].children[3].config.colour = G.C.UI.BACKGROUND_INACTIVE
	else
		e.config.button = 'elle_spamton_reroll'
		e.children[1].children[1].config.colour = G.C.WHITE
		e.children[1].children[2].config.colour = G.C.WHITE
		e.children[1].children[3].config.colour = G.C.WHITE
	end
end

-- Reroll shop
function G.FUNCS.elle_spamton_reroll(e)
	stop_use() -- This was in the vanilla reroll callback for some reason
	ease_dollars(-G.GAME.elle_popup_shops.spamton.reroll)
	G.E_MANAGER:add_event(Event({ trigger = 'immediate', func = function()
		
		play_sound('coin2')
		play_sound('other1')
		
		spamton_visible_reroll(spamton_sets.def)
		--print("done :3")
		return true
	end}))
	
	-- The game is automatically saved by becca_visible_reroll()
	--G.E_MANAGER:add_event(Event({ func = function() save_run(); return true end})) -- Save the game :)
end

-- Reroll2 button update
function G.FUNCS.elle_spamton_can_big_reroll(e)
	e.config.colour = e.states.hover.is and G.C.L_BLACK or G.C.BLACK
	if ((G.GAME.dollars-G.GAME.bankrupt_at) - G.GAME.elle_popup_shops.spamton.reroll2 < 0) and G.GAME.elle_popup_shops.spamton.reroll2 ~= 0 then 
		e.config.button = nil
		e.children[1].children[1].config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.children[1].children[2].config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.children[1].children[3].config.colour = G.C.UI.BACKGROUND_INACTIVE
	else
		e.config.button = 'elle_spamton_big_reroll'
		e.children[1].children[1].config.colour = G.C.WHITE
		e.children[1].children[2].config.colour = G.C.WHITE
		e.children[1].children[3].config.colour = G.C.WHITE
	end
end

-- Reroll2 shop
function G.FUNCS.elle_spamton_big_reroll(e)
	stop_use() -- This was in the vanilla reroll callback for some reason
	ease_dollars(-G.GAME.elle_popup_shops.spamton.reroll2)
	G.E_MANAGER:add_event(Event({ trigger = 'immediate', func = function()
		
		play_sound('coin2')
		play_sound('other1')
		
		spamton_visible_reroll(spamton_sets.big)
		--print("done :3")
		return true
	end}))
	
	-- The game is automatically saved by becca_visible_reroll()
	--G.E_MANAGER:add_event(Event({ func = function() save_run(); return true end})) -- Save the game :)
end

-- Other Button update
function G.FUNCS.elle_spamton_hover(e)
	e.config.colour = e.states.hover.is and G.C.L_BLACK or G.C.BLACK
end

-- DEALMAKER Price code borrowed from nxkoo (and modified ofc)
local oldsetcost = Card.set_cost
function Card:set_cost()
    local g = oldsetcost(self)
    if self.area and self.area == G.elle_spamton_shop then
		self.cost = math.max(pseudorandom("elle_spamton_price_" .. self.sort_id, 0, 100), 0.001)
    end
    return g
end

local cost_rate = 0.5
local cost_dt = cost_rate
local oldgameupdate = Game.update
function Game:update(dt)
    local g = oldgameupdate(self, dt)
    if G.elle_spamton_shop and G.elle_spamton_shop.cards then
        cost_dt = cost_dt + dt
        if cost_dt >= cost_rate then
            cost_dt = cost_dt - cost_rate
			for i, v in ipairs(G.elle_spamton_shop.cards) do
				v:set_cost()
			end
			cost_rate = pseudorandom("elle_spamton_rate", 2, 5)/10
			G.GAME.elle_popup_shops.spamton.reroll = math.max(pseudorandom("elle_spamton_reroll", 0, 100), 0.001)
			G.GAME.elle_popup_shops.spamton.reroll2 = math.max(pseudorandom("elle_spamton_big_reroll", 0, 100) + math.floor(G.GAME.elle_popup_shops.spamton.reroll), 0.001)
        end
    end
    return g
end