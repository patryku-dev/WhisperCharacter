-- Returns the friend's logged-in WoW character name, or nil if it can't be whispered directly.
local function GetCharacterTarget(contextData)
	local accountInfo = contextData.accountInfo
	if not accountInfo and contextData.bnetIDAccount then
		accountInfo = C_BattleNet.GetAccountInfoByID(contextData.bnetIDAccount)
	end

	local game = accountInfo and accountInfo.gameAccountInfo
	if not (game and game.isOnline and game.clientProgram == BNET_CLIENT_WOW) then
		return nil
	end

	-- Different WoW version or region: only a Battle.net whisper can reach them.
	if game.wowProjectID ~= WOW_PROJECT_ID or game.isInCurrentRegion == false then
		return nil
	end

	local name = game.characterName
	if not name or name == "" then
		return nil
	end
	return name
end

-- Runs after Blizzard's secure Whisper handler opened the chat, so no chat state is written from tainted code.
local function OnWhisperClick(_, contextData)
	if not contextData.bnetIDAccount or IsShiftKeyDown() then
		return
	end

	local name = GetCharacterTarget(contextData)
	local editBox = ChatFrameUtil.GetActiveWindow()
	if not (name and editBox) then
		return
	end

	editBox:SetChatType("WHISPER")
	editBox:SetTellTarget(name)
	editBox:UpdateHeader()
end

local function Install()
	hooksecurefunc(UnitPopupWhisperButtonMixin, "OnClick", OnWhisperClick)
end

if UnitPopupWhisperButtonMixin then
	Install()
else
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("ADDON_LOADED")
	frame:SetScript("OnEvent", function(self)
		if UnitPopupWhisperButtonMixin then
			self:UnregisterAllEvents()
			Install()
		end
	end)
end
