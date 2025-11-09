-- Use button on jokers, copied and modified from the lobcorp mod
local use_and_sell_buttonsref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    local t = use_and_sell_buttonsref(card)
	
	-- Use Button
    if t and t.nodes[1] and t.nodes[1].nodes[2] and card.config.center.elle_active and type(card.config.center.elle_active) == "table" then
        table.insert(t.nodes[1].nodes[2].nodes, 
            {n=G.UIT.C, config={align = "cr"}, nodes={
                {n=G.UIT.C, config={ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'elle_active_ability', func = 'elle_can_use_active'}, nodes={
                    {n=G.UIT.B, config = {w=0.1,h=0.6}},
                    {n=G.UIT.T, config={text = card.config.center.elle_active.name and card.config.center.elle_active:name(card) or localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
                }}
            }}
        )
    end
	
	-- Upgrade Button
	local upgr_node = card.config.center.elle_active and card.config.center.elle_upgrade and 3 or 2
    if t and t.nodes[1] and card.config.center.elle_upgrade and type(card.config.center.elle_upgrade) == "table" then
		
		-- Make 3rd node for Upgrade Button
        if (card.config.center.elle_active) then
			table.insert(t.nodes[1].nodes,{
				nodes = {},
				n = 4,
				config = {
					align= "cl",
			}})
		end
		
		table.insert(t.nodes[1].nodes[upgr_node].nodes, 
            {n=G.UIT.C, config={align = "cr"}, nodes={
                {n=G.UIT.C, config={ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = 0.4, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'elle_active_upgrade', func = 'elle_can_upgrade'}, nodes={
                    {n=G.UIT.B, config = {w=0.1,h=0.4}},
                    {n=G.UIT.T, config={text = "UPGRADE",colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
                }}
            }}
        )
		
		-- Make Use button thinner if Upgrade button also exists
		if (card.config.center.elle_active) then
			t.nodes[1].nodes[2].nodes[1].nodes[1].config.minh = 0.4
			t.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].config.h = 0.4
		end
    end
	
    return t
end

-- Use Button Functions
--[[	- Use button table format -
	elle_active {
		calculate(self, card)		- Actual active ability
		can_use(self, card)			- Whether you can use the ability
		should_close(self, card)	- Whether to un-highlight the card upon using the ability (Recommended for value changes)
		name(card)	- (Optional) Different button name, instead of localized "Use"
	}
]]
G.FUNCS.elle_can_use_active = function(e)
    local card = e.config.ref_table
    local can_use = 
    not (not skip_check and ((G.play and #G.play.cards > 0) or
    (G.CONTROLLER.locked) or
    (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))) and
    G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT and
    card.area == G.jokers and not card.debuff and
	card.config.center.elle_active and
    (not card.config.center.elle_active.can_use or card.config.center.elle_active:can_use(card))
    if can_use then 
        e.config.colour = G.C.RED
        e.config.button = 'elle_active_ability'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.elle_active_ability = function(e, mute, nosave)
    local card = e.config.ref_table

    G.E_MANAGER:add_event(Event({func = function()
        e.disable_button = nil
        e.config.button = 'elle_active_ability'
    return true end }))

	if card.children.use_button then card.children.use_button:remove(); card.children.use_button = nil end
	if card.children.sell_button then card.children.sell_button:remove(); card.children.sell_button = nil end
	
    card.config.center.elle_active:calculate(card)
	card.area:remove_from_highlighted(card)
	
	if (card.config.center.elle_active.should_close and not card.config.center.elle_active:should_close(card)) then card.area:add_to_highlighted(card) end
end

-- Upgrade Button Functions
--[[	- Upgrade button table format -
	elle_upgrade {
		card				- key of card it turns into
		values(self, card)	- values to carry over
			return{
				<target_value> = value,
				<target_value> = value
			}
			
			eg:
			xmult = 1 + card.ability.extra.mult * 0.1
		}
		calculate(self, card)	- What to do when upgrading, usually to fulfil the upgrade conditions
		can_use(self, card)	- Whether you can upgrade the card
	}
]]
G.FUNCS.elle_can_upgrade = function(e)
    local card = e.config.ref_table
    local can_use = 
    not (not skip_check and ((G.play and #G.play.cards > 0) or
    (G.CONTROLLER.locked) or
    (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))) and
    G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT and
    card.area == G.jokers and not card.debuff and
	card.config.center.elle_upgrade and
    (not card.config.center.elle_upgrade.can_use or card.config.center.elle_upgrade:can_use(card))
    if can_use then 
        e.config.colour = loc_colour("elle")
        e.config.button = 'elle_active_upgrade'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.elle_active_upgrade = function(e, mute, nosave)
    local card = e.config.ref_table

    G.E_MANAGER:add_event(Event({func = function()
        e.disable_button = nil
        e.config.button = 'elle_active_upgrade'
    return true end }))

	if card.children.use_button then card.children.use_button:remove(); card.children.use_button = nil end
	if card.children.sell_button then card.children.sell_button:remove(); card.children.sell_button = nil end
	
	local values = card.config.center.elle_upgrade.values and card.config.center.elle_upgrade:values(card) or {}
	
	if (card.config.center.elle_upgrade.calculate) then card.config.center.elle_upgrade:calculate(card) end
	
	card.area:remove_from_highlighted(card)
	
	transform_joker(
		card,
		card.config.center.elle_upgrade.card,
		values,
		false
	)
end

-- Upgrade preview text hook
-- (putting this here since it felt like it made sense)
-- ...is this even gonna work? i'm just getting ui tables
--[[local loc_ref = localize
function localize(args, misc_cat)
	local loc = loc_ref(args, misc_cat)
	--print(args)
	return loc
end]]