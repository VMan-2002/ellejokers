ellejokers.popup_shop = {
	-- List of cardareas to remove Buy & Use button from
	no_use_areas = {
		"elle_becca_shop_consumables",
		"elle_spamton_shop"
	},
	
	-- List of cardareas in each shop
	shop_cardareas = {
		rebecca = {
			"elle_becca_shop_jokers",
			"elle_becca_shop_consumables",
			"elle_becca_shop_booster"
		},
		spamton = {
			"elle_spamton_shop"
		}
	},
	
	-- Copied very loosely from HotPot
	reload_areas = function()
		-- Go through areas for different shops
		for k,_ in pairs(G.GAME.elle_popup_shops) do
			load_shop_areas(k)
		end
	end,
	
	load_shop_areas = function(shop)
		-- Go through shop's areas
		for _, key in ipairs(ellejokers.popup_shop.shop_cardareas[shop]) do
			--print(G.GAME.elle_popup_shops[shop].data)
			if G.GAME.elle_popup_shops[shop].data[key] then
				--print("data found")
				G[key]:load(G.GAME.elle_popup_shops[shop].data[key])
				
				--print(#G[key].cards.." cards")
				for k, v in ipairs(G[key].cards) do
					create_shop_card_ui(v)
					v:start_materialize()
					G.GAME.used_jokers[v.config.center.key] = true
				end
				G.GAME.elle_popup_shops[shop].data[key] = nil
			end
		end
	end
}

-- Init game hook - initialize game variables
local igo_hook = Game.init_game_object
function Game:init_game_object()
	local g = igo_hook(self)
	
	-- Add shops here
	g.elle_popup_shops = {
		-- Rebecca Shop
		rebecca = {
			default_reroll = 4, -- Reroll cost when shop resets
			reroll = 4, -- Actual reroll cost
			reroll_cost = 2, -- Cost increase amount
			reset_on_open = true, -- Whether opening the shop will reroll contents
			data = {}, -- Store shop contents while shop is closed
			first_open = true -- If it's the first time opening the shop
		},
		
		-- [[BIG SHOP]]
		spamton = {
			reset_on_open = true,
			default_reroll = 5, -- You won't see these values bc the spamton shop has randomized prices
			default_reroll2 = 20,
			reroll = 5,
			reroll2 = 20,
			data = {},
			first_open = true
		}
	}
	return g
end

-- Highlight card hook, removes Buy & Use button from consumables
local hl_hook = Card.highlight
function Card:highlight(is_highlighted)
	local hl = hl_hook(self, is_highlighted)
	
	-- Check if in area that doesn't use Buy & Use button
	local remove_area = false
	for _,v in ipairs(ellejokers.popup_shop.no_use_areas) do
		remove_area = self.area == G[v] or remove_area
	end
	
	if remove_area and self.children.buy_and_use_button then
		self.children.buy_and_use_button:remove()
		self.children.buy_and_use_button = nil
		
	end
	
	return hl
end

-- Copied loosely from HotPot
local rem_hook = CardArea.remove
function CardArea:remove()
	-- Go through areas for different shops
	for k,v in pairs(ellejokers.popup_shop.shop_cardareas) do
		-- Go through shop's areas
		for _,v2 in ipairs(v) do
			if self == G[v2] then G.GAME.elle_popup_shops[k].data[v2] = self:save() end
		end
	end
	rem_hook(self)
end
--[[
local car = CardArea.remove
function CardArea:remove()
	for _, key in ipairs(becca_cardareas) do
		if self == G[key] then G.GAME.elle_rebecca.data[key] = self:save() end
	end
	car(self)
end]]

-- Update cards in shop menu
local csa_hook = Card.set_ability
function Card:set_ability(...)
	local old_center = self.config.center
	if G.GAME.elle_popup_shop_open and old_center and not next(SMODS.find_card(old_center.key, true)) then
		G.GAME.used_jokers[old_center.key] = nil
	end
	csa_hook(self, ...)
	if G.GAME.elle_popup_shop_open then 
		if self.config.center.key then
			G.GAME.used_jokers[self.config.center.key] = true
		end
	end
end

-- Update used_jokers when removing shop cards
local cr_hook = Card.remove
function Card:remove(...)
	local old_center = self.config.center
	if G.GAME.elle_popup_shop_open and old_center and not next(SMODS.find_card(old_center.key, true)) then
		G.GAME.used_jokers[old_center.key] = nil
	end
	cr_hook(self, ...)
end

-- Reset active shop when closing shop menu
local eom_hook = G.FUNCS.exit_overlay_menu
function G.FUNCS.exit_overlay_menu(...)
	eom_hook(...)
	if (G.GAME.elle_popup_shop_open) then
		G.GAME.elle_popup_shop_open = nil
	end
end