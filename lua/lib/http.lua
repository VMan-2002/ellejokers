-- I copied a lot of this from the Cryptid code lmao
ellejokers.bsky_count = 100 -- fallback amount
local succ, https = pcall(require, "SMODS.https")
local last_update_time = 0
local initial = true
ellejokers.bsky_did = "did:plc:56kaelt4plcrtrztlqa3hfal" -- bsky did/handle to check
if not succ then
	sendErrorMessage("HTTP module could not be loaded. " .. tostring(https), "ellejokers.")
end

local function apply_follower_count(code, body, headers)
	if body then
		local count = string.match(body, '"followersCount"%s*:%s*(%d+)')
		ellejokers.bsky_count = count or ellejokers.bsky_count
	end
end
function ellejokers.update_follower_count()
	if https and https.asyncRequest then
		if (os.time() - last_update_time >= 60) or initial then
			initial = false
			last_update_time = os.time()
			https.asyncRequest(
				"https://public.api.bsky.app/xrpc/app.bsky.actor.getProfile?actor=" .. ellejokers.bsky_did,
				apply_follower_count
			)
		end
	end
end
ellejokers.update_follower_count()

function ellejokers.reset_game_globals.http(run_start)
    if run_start then
        ellejokers.update_follower_count()
    end
end