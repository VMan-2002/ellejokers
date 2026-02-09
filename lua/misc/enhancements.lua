-- Slime Enhancement
SMODS.Enhancement {
	key = 'slime',
	atlas = 'enhancers',
	pos = { x = 0, y = 0 },
	config = { extra = { odds = 3, retriggers = 2 } },
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'elle_slime_card')
		return { vars = { numerator, denominator, card.ability.extra.retriggers } }
	end,
	calculate = function(self, card, context)
		if context.repetition and SMODS.pseudorandom_probability(card, 'elle_slime_card', 1, card.ability.extra.odds) then
			return {
				message = localize('k_again_ex'),
				repetitions = card.ability.extra.retriggers
			}
		end
	end
}

--#region Jess Cards
function ellejokers.jess_retrigger_qualify(card)
	-- Debuff check
	if card.debuff then return false end
	
	-- Heart Hairclip
	if SMODS.find_card("j_elle_jessclip")[1] and card:is_suit('Hearts', true) then return true end
	
	-- Normal check
	return SMODS.has_enhancement(card, "m_elle_jess")
end

function ellejokers.get_jess_areas()
	local areas = {G.play}
	if SMODS.find_card("j_elle_jess")[1] then areas[#areas+1] = G.hand end
	
	return areas
end

-- Jess Enhancement
SMODS.Enhancement {
	key = 'jess',
	atlas = 'enhancers',
	pos = { x = 1, y = 0 },
	config = { extra = { retrigger_count = 1, req = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.retrigger_count, card.ability.extra.req } }
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			local retriggers = 0
			for _,v in ipairs(ellejokers.get_jess_areas()) do
				for _,v2 in ipairs(v.cards) do
					if ellejokers.jess_retrigger_qualify(v2) then retriggers = retriggers + 1 end
				end
			end
			
			retriggers = math.floor(retriggers/card.ability.extra.req)
			
			if retriggers > 0 then
				return {
					message = localize('k_again_ex'),
					repetitions = retriggers * card.ability.extra.retrigger_count
				}
			end
		end
	end,
	slime_desc_icon = {
		atlas = "elle_cornericons",
		pos = {x=1,y=0}
	}
}
--#endregion

--#region Copycat cards
function ellejokers.get_copycat_target(card)
	if not (card.area and card.area.cards) then return end
	
	local pos = nil
	local target = nil

	for i, v in ipairs(card.area.cards) do
		pos = v == card and i or pos -- Find the copycat card, to only check the cards after
		if pos and not target and not SMODS.get_enhancements(v)["m_elle_copycat"] and card.highlighted == v.highlighted then target = v end -- Doesn't use has_enhancement as it's used in a hook in that func
	end
	return target, pos
end

-- Copycat Enhancement
SMODS.Enhancement {
	key = 'copycat',
	atlas = 'enhancers',
	pos = { x = 1, y = 1 },
	config = { extra = { } },
	
	replace_base_card = true,
	no_rank = true,
	no_suit = true,
	always_scores = true,
	
	loc_vars = function(self, info_queue, card)
		if next(SMODS.find_mod("allinjest")) then info_queue[#info_queue+1] = {set = "Other", key = "elle_crash_warning", specific_vars = {"All In Jest"} } end
		return {vars = { } }
	end,
	calculate = function(self, card, context)
		if (card.area and card.area.cards) then
			local target = ellejokers.get_copycat_target(card)
			
			if target then
				-- thanks to @somethingcom515 for the code
				local eval, post = eval_card(target, context)
				local ret = {}
				for k, v in pairs(eval) do
					if type(v) == 'table' and (k == 'playing_card' or k == 'enhancement' or k == 'end_of_round') then
						if not v.card or v.card == target then v.card = card end
						table.insert(ret, v)
					end
				end
				
				--if ret ~= {} then print(ret) end
				
				ret.card = card
				
				return SMODS.merge_effects(ret)
			end
		end
	end
}

local has_enhancement_hook = SMODS.has_enhancement
function SMODS.has_enhancement(card, key)
    if card.config.center.key == "m_elle_copycat" then
		local target = ellejokers.get_copycat_target(card)
		if target then return has_enhancement_hook(target) end
	end
	
	return has_enhancement_hook(card, key)
end

local is_suit_hook = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc, ...)
    if self.config.center.key == "m_elle_copycat" then
		local target = ellejokers.get_copycat_target(self)
		if target then return is_suit_hook(target, suit, bypass_debuff, flush_calc, ...) end
	end

	return is_suit_hook(self, suit, bypass_debuff, flush_calc, ...)
end

local get_id_hook = Card.get_id
function Card:get_id()
    if self.config.center.key == "m_elle_copycat" then
		local target = ellejokers.get_copycat_target(self)
		if target then return get_id_hook(target) end
	end
	
	return get_id_hook(self)
end

local is_face_hook = Card.is_face
function Card:is_face(from_boss)
    if self.config.center.key == "m_elle_copycat" then
		local target = ellejokers.get_copycat_target(self)
		if target then return is_face_hook(target,from_boss) end
	end

	return is_face_hook(self,from_boss)
end

local set_debuff_hook = Card.set_debuff
function Card:set_debuff(should_debuff)
    if self.config.center.key == "m_elle_copycat" then
		local target = ellejokers.get_copycat_target(self)
		if target then return set_debuff_hook(target,should_debuff) end
	end
	
	set_debuff_hook(self,should_debuff)
end
--#endregion
