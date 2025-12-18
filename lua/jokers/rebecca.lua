-- TO-DO:
--	- Dialogue stuff
--	- Sprite stuff
--	- Dialogue writing
--		- Mention shop info
--			- 1 Pack per ante
--			- 

SMODS.Atlas {
	key = "rebecca",
	path = "becca_test.png",
	px = 96,
	py = 128
}

do -- Rebecca Joker stuff
	local becca = SMODS.Joker {
		key = 'rebecca',
		set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mall) end end,
		config = { extra = { cost = { reroll = 4 }, cards = { jokers = {}, consumables = {}, booster = {} } } },
		loc_vars = function(self, info_queue, card) return { vars = {} } end,
		rarity = 3,
		atlas = 'jokers',
		pos = { x = 0, y = 1 },
		cost = 9
	}

	becca.slime_active = {
		calculate = function(self, card)
			G.FUNCS.overlay_menu({ definition = create_UIbox_becca() })
		end,
		can_use = function(self, card) return true end,
		should_close = function(self, card) return true end,
		name = function(self, card) return localize("elle_joker_open") end
	}

	-- Restock shop
	becca.calculate = function(self, card, context)
		if (context.ante_change) then
			G.GAME.elle_rebecca.reset_on_open = true
			return { message = localize("elle_rebecca_restock") }
		end
	end
end

local becca_cardareas = {
	"elle_becca_shop_jokers",
	"elle_becca_shop_consumables",
	"elle_becca_shop_booster"
}

--local becca_obj = Sprite(0,0,192,256,"rebecca",{x=0,y=0})

-- Reroll shop while inside UI (targetting cardareas)
local function becca_visible_reroll(booster)
	-- Remove old cards
	for i,v in ipairs(becca_cardareas) do
		for i2 = #G[v].cards,1, -1 do
			if (not booster and v == "elle_becca_shop_booster") then break end
			local c = G[v]:remove_card(G[v].cards[i])
			c:remove()
			c = nil
		end
	end

	-- Jokers
	for i = 1, 2 -#G.elle_becca_shop_jokers.cards do
		local new_shop_card = SMODS.create_card({set="Joker", area=G.elle_becca_shop_jokers, bypass_discovery_center = true})
		G.elle_becca_shop_jokers:emplace(new_shop_card)
		create_shop_card_ui(new_shop_card)
		new_shop_card:juice_up()
		--print("added joker")
	end
	-- Consumables
	for i = 1, 2-#G.elle_becca_shop_consumables.cards do
		local new_shop_card = SMODS.create_card({set="Consumeables", area=G.elle_becca_shop_consumables, bypass_discovery_center = true})
		G.elle_becca_shop_consumables:emplace(new_shop_card)
		create_shop_card_ui(new_shop_card)
		
		new_shop_card:juice_up()
		--print("added consumable")
	end
	-- Booster pack
	if booster then
		for i = 1, 1-#G.elle_becca_shop_booster.cards do
			local new_shop_card = SMODS.create_card({set="Booster", area=G.elle_becca_shop_booster, bypass_discovery_center = true})
			G.elle_becca_shop_booster:emplace(new_shop_card)
			create_shop_card_ui(new_shop_card)
			
			new_shop_card:juice_up()
			new_shop_card.T.h = new_shop_card.T.h*1.27
			new_shop_card.T.w = new_shop_card.T.w*1.27
			
			--print("added booster")
		end
	end
	
	G.E_MANAGER:add_event(Event({ func = function() save_run(); return true end})) -- Save the game :)
end

-- Copied very loosely from HotPot
local function reload_becca_areas()
    for _, key in ipairs(becca_cardareas) do
		--print(key)
        if G.GAME.elle_rebecca.data[key] then
			--print("data found")
			G[key]:load(G.GAME.elle_rebecca.data[key])
			--print(#G[key].cards.." cards")
            for k, v in ipairs(G[key].cards) do
                create_shop_card_ui(v)
                if v.ability.consumeable then v:start_materialize() end
            end
            G.GAME.elle_rebecca.data[key] = nil
        end
    end
end

do -- Game hooks
	-- Init game hook - initialize game variables
	local hook = Game.init_game_object
	function Game:init_game_object()
		local g = hook(self)
		
		g.elle_rebecca = {
			default_reroll = 4,
			reroll = 4,
			reroll_cost = 2,
			reset_on_open = true,
			data = {},
			first_open=true,
			open=false
		}
		
		return g
	end
	
	-- Use card hook
	local uc_hook = G.FUNCS.use_card
	function G.FUNCS.use_card(e)
		local c = e.config.ref_table
		
		-- Check cardarea
		local from_becca = false
		for i,v in ipairs(becca_cardareas) do
			if G[v] == c.area then
				from_becca = true
				break
			end
		end
		
		local uc = uc_hook(e)
		
		-- Save the card being removed
		if (from_becca) then
			G.E_MANAGER:add_event(Event({ func = function()
				G.FUNCS.exit_overlay_menu()
				save_run()
			return true end}))
		end
		
		return uc
	end
	
	-- Highlight card hook, removes buy & use button from consumables
	local hl_hook = Card.highlight
	function Card:highlight(is_highlighted)
		local hl = hl_hook(self, is_highlighted)
		
		if self.area == G.elle_becca_shop_consumables and self.children.buy_and_use_button then
			self.children.buy_and_use_button:remove()
			self.children.buy_and_use_button = nil
		end
		
		return hl
	end
	
	-- Copied loosely from HotPot
	local car = CardArea.remove
	function CardArea:remove()
		for _, key in ipairs(becca_cardareas) do
			if self == G[key] then G.GAME.elle_rebecca.data[key] = self:save() save_run() end
		end
		car(self)
	end
	
	-- Update cards in rebecca menu
	local csa = Card.set_ability
	function Card:set_ability(...)
		local old_center = self.config.center
		if G.GAME.elle_rebecca.open and old_center and not next(SMODS.find_card(old_center.key, true)) then
			G.GAME.used_jokers[old_center.key] = nil
		end
		csa(self, ...)
		if G.GAME.elle_rebecca.open then 
			if self.config.center.key then
				G.GAME.used_jokers[self.config.center.key] = true
			end
		end
	end
	local cr = Card.remove
	function Card:remove(...)
		local old_center = self.config.center
		if G.GAME.elle_rebecca.open and old_center and not next(SMODS.find_card(old_center.key, true)) then
			G.GAME.used_jokers[old_center.key] = nil
		end
		cr(self, ...)
	end

	local eom = G.FUNCS.exit_overlay_menu
	function G.FUNCS.exit_overlay_menu(...)
		eom(...)
		if (G.GAME.elle_rebecca.open) then
			G.GAME.elle_rebecca.open = false
			G.E_MANAGER:add_event(Event({ func = function() save_run(); return true end})) -- Save the game :)
		end
	end
end

-- Shop UI
function create_UIbox_becca()
	--print(G.GAME.elle_rebecca.first_open)
	G.elle_becca_shop_jokers = CardArea(
		G.hand.T.x,
		G.hand.T.y+G.ROOM.T.y + 9,
		2.1*G.CARD_W,
		1.05*G.CARD_H, 
		{card_limit = 2, type = 'shop', highlight_limit = 1, negative_info = true})

	G.elle_becca_shop_consumables = CardArea(
		G.hand.T.x,
		G.hand.T.y+G.ROOM.T.y + 9,
		2.1*G.CARD_W,
		1.05*G.CARD_H, 
		{card_limit = 2, type = 'shop', highlight_limit = 1})

	G.elle_becca_shop_booster = CardArea(
		G.hand.T.x,
		G.hand.T.y+G.ROOM.T.y + 9,
		1.05*G.CARD_W,
		1.05*G.CARD_H-0.25, 
		{card_limit = 1, type = 'shop', highlight_limit = 1})
	
	-- Track whether this shop is open
	G.GAME.elle_rebecca.open = true
	
	-- Reload areas if not first time opening
	if not G.GAME.elle_rebecca.first_open then
		reload_becca_areas()
		save_run()
	else G.GAME.elle_rebecca.first_open = false end


	-- Reroll the shop on open if expected to
	if (G.GAME.elle_rebecca.reset_on_open) then
		G.GAME.elle_rebecca.reset_on_open = false
		
		G.E_MANAGER:add_event(Event({ func = function()
			G.GAME.elle_rebecca.reroll = G.GAME.elle_rebecca.default_reroll
			becca_visible_reroll(true)
			return true
		end}))
	end
	
	return create_UIBox_generic_options({
		no_back = true,
		contents = {
			-- Title stuff
			{n = G.UIT.R, config = {align="cm"}, nodes = {
				-- Center box
				{n = G.UIT.C, config = {align="cm", minw=2, colour=G.C.BLACK, padding=.2, r=.1, emboss=.05}, nodes = {
					-- Please stack them vertically pretty please :innocent:
					{n = G.UIT.C, config = {align="cm", padding=.1}, nodes = {
						{n = G.UIT.R, config = {align="cm"}, nodes = {
							{n = G.UIT.T, config = {text = localize("elle_rebecca_title1"), colour=G.C.WHITE, scale=0.5}}}},
						{n = G.UIT.R, config = {align="cm"}, nodes = {
							{n = G.UIT.T, config = {text = localize("elle_rebecca_title2"), colour=G.C.UI.TEXT_INACTIVE, scale=0.3}}}}
					}}
				}}
			}},
			-- Main Area
			{n = G.UIT.R, config = {align="cm"}, nodes = {
				-- Left side (Actual shop)
				{n = G.UIT.C, config = {align="cm", padding=.1}, nodes = {
					-- Shop box
					{n = G.UIT.R, config = {align="cm", colour=G.C.BLACK, outline=1, padding=.1, r=.1, emboss=.1}, nodes = {
						-- Top half
						{n = G.UIT.R, config = {align="cm", padding = 0.15}, nodes = {
							-- Booster pack thingy
							{n=G.UIT.C, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
								{n=G.UIT.C, config={align = "cm", minw=2.5, padding = 0.2, r=0.2, colour = G.C.BLACK, maxh = G.elle_becca_shop_booster.T.h+0.4}, nodes={
									{n=G.UIT.T, config={text = localize("elle_rebecca_booster"), scale = 0.35, colour = G.C.L_BLACK, vert = true}},
									{n=G.UIT.O, config={object = G.elle_becca_shop_booster}},
								}}
							}},
							-- Jonklers
							{n=G.UIT.C, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
								{n=G.UIT.T, config={text = localize("elle_rebecca_joker"), scale = 0.35, colour = G.C.BLACK, vert = true}},
								{n=G.UIT.O, config={object = G.elle_becca_shop_jokers}},
							}}
						}},
						-- Bottom half
						{n = G.UIT.R, config = {align="cm", padding = 0.15}, nodes = {
							-- Buttons
							{n=G.UIT.C, config={align = "cm", minw = 2.9}, nodes={
								{n=G.UIT.C, config={align = "cm", padding = 0.15}, nodes={
									-- Reroll Button
									{n=G.UIT.R, config={align = "cm", minw = 2.5, minh = 1.4, r=0.15,colour = G.C.GREEN, button = 'elle_rebecca_reroll', func = 'elle_rebecca_can_reroll', hover = true,shadow = true}, nodes = {
										{n=G.UIT.R, config={align = "cm", padding = 0.07, focus_args = {button = 'x', orientation = 'cr'}, func = 'set_button_pip'}, nodes={
											{n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
												{n=G.UIT.T, config={text = localize('k_reroll'), scale = 0.4, colour = G.C.WHITE, shadow = true}},
											}},
											{n=G.UIT.R, config={align = "cm", maxw = 1.3, minw = 1}, nodes={
												{n=G.UIT.T, config={text = localize('$'), scale = 0.7, colour = G.C.WHITE, shadow = true}},
												{n=G.UIT.T, config={ref_table = G.GAME.elle_rebecca, ref_value = 'reroll', scale = 0.75, colour = G.C.WHITE, shadow = true}},
											}}
										}}
									}},
									-- Exit button (for people who don't know you can just press ESC)
									UIBox_button({ button = "exit_overlay_menu", label = { "Exit" }, minh=.8, minw=2.5, colour = G.C.RED })
								}},
							}},
							-- Consumables
							{n=G.UIT.C, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
								{n=G.UIT.T, config={text = localize("elle_rebecca_consumable"), scale = 0.35, colour = G.C.BLACK, vert = true}},
								{n=G.UIT.O, config={object = G.elle_becca_shop_consumables}},
							}}
						}}
					}}
				}},
				-- Right side (Rebecca omggg haiii)
				--[[{n = G.UIT.C, config = {minw=2, minh=2, colour = G.C.MONEY, padding =.1}, nodes = {
					--{n = G.UIT.T, config = {text = becca_menu_card.ability.extra.test, colour=G.C.WHITE, scale=.3}},
					
					-- Right side (Rebecca omggg haiii)
					{n = G.UIT.C, config = {align="cm", minw=6}, nodes = {
						{n = G.UIT.R, config = {align="tr", padding = 0.15}, nodes = {
							UIBox_button({ button = "elle_rebecca_test", label = { "save(test)" }, minh=.6, minw=2.4, colour = G.C.BLUE }),
							UIBox_button({ button = "elle_rebecca_test2", label = { "load(test)" }, minh=.6, minw=2.4, colour = G.C.FILTER })
						}}
					}}
				}}]]
			}},
		}
	})
end

do -- Button Callbacks
	-- Reroll button update
	function G.FUNCS.elle_rebecca_can_reroll(e)
		if ((G.GAME.dollars-G.GAME.bankrupt_at) - G.GAME.elle_rebecca.reroll < 0) and G.GAME.elle_rebecca.reroll ~= 0 then 
			e.config.colour = G.C.UI.BACKGROUND_INACTIVE
			e.config.button = nil
			--e.children[1].children[1].config.shadow = false	-- IDK what these are for, blame LocalThunk :shrug:
			--e.children[2].children[1].config.shadow = false
			--e.children[2].children[2].config.shadow = false
		else
			e.config.colour = G.C.GREEN
			e.config.button = 'elle_rebecca_reroll'
			--e.children[1].children[1].config.shadow = true
			--e.children[2].children[1].config.shadow = true
			--e.children[2].children[2].config.shadow = true
		end
	end

	-- Reroll shop
	function G.FUNCS.elle_rebecca_reroll(e)
		stop_use() -- This was in the vanilla reroll callback for some reason
		ease_dollars(-G.GAME.elle_rebecca.reroll)
		G.GAME.elle_rebecca.reroll = G.GAME.elle_rebecca.reroll + G.GAME.elle_rebecca.reroll_cost
		G.E_MANAGER:add_event(Event({ trigger = 'immediate', func = function()
			--print("rerolling :)")
			
			play_sound('coin2')
			play_sound('other1')
			
			becca_visible_reroll()
			--print("done :3")
			
			return true
		end}))
		
		-- The game is automatically saved by becca_visible_reroll()
		--G.E_MANAGER:add_event(Event({ func = function() save_run(); return true end})) -- Save the game :)
	end
end