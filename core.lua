local _ = ...
local PlexusFrame = Plexus:GetModule("PlexusFrame")
local Media = LibStub("LibSharedMedia-3.0", true)
local addonId = "PlexusIndicatorBorderTexts"
local L = Plexus.L

local strsub = string.utf8sub or string.sub

local function New(frame)
	local text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	return text
end

local function Reset(self)
	local profile = PlexusFrame.db.profile
	local font = Media:Fetch("font", profile.font) or STANDARD_TEXT_FONT

	local frame = self.__owner
	local bar = frame.indicators.bar

	self:SetParent(bar)
	self:SetFont(font, profile.fontSize - 3, profile.fontOutline)

	if profile.fontShadow then
		self:SetShadowOffset(1, -1)
	else
		self:SetShadowOffset(0, 0)
	end

	if profile.invertBarColor and profile.invertTextColor then
		self:SetShadowColor(1, 1, 1)
	else
		self:SetShadowColor(0, 0, 0)
	end

	self:ClearAllPoints()
	if self.__id == "cornertexttopleft" then
		self:SetJustifyH("LEFT")
		self:SetJustifyV("CENTER")
		self:SetPoint("TOPLEFT", 0, 0)
	elseif self.__id == "cornertexttopright" then
		self:SetJustifyH("RIGHT")
		self:SetJustifyV("CENTER")
		self:SetPoint("TOPRIGHT", 0, 0)
	elseif self.__id == "cornertextbottomleft" then
		self:SetJustifyH("LEFT")
		self:SetJustifyV("CENTER")
		self:SetPoint("BOTTOMLEFT", 0, 0)
	elseif self.__id == "cornertextbottomright" then
		self:SetJustifyH("RIGHT")
		self:SetJustifyV("CENTER")
		self:SetPoint("BOTTOMRIGHT", 0, 0)
	elseif self.__id == "sidetextbottom" then
		self:SetJustifyH("CENTER")
		self:SetJustifyV("CENTER")
		self:SetPoint("BOTTOM", 0,  0)
	elseif self.__id == "sidetexttop" then
		self:SetJustifyH("CENTER")
		self:SetJustifyV("CENTER")
		self:SetPoint("TOP", 0, 0)
	elseif self.__id == "sidetextleft" then
		self:SetJustifyH("LEFT")
		self:SetJustifyV("CENTER")
		self:SetPoint("LEFT", 0, 0)
	elseif self.__id == "sidetextright" then
		self:SetJustifyH("RIGHT")
		self:SetJustifyV("CENTER")
		self:SetPoint("RIGHT", 0, 0)
	end
end

local function SetStatus(self, color, text, value, maxValue, texture, texCoords, count, start, duration)
	local profile = PlexusFrame.db.profile
	self:SetText(strsub(text, 1, profile.textlength))

	if color then
		if profile.invertBarColor and profile.invertTextColor then
			self:SetTextColor(color.r * 0.2, color.g * 0.2, color.b * 0.2, color.a or 1)
		else
			self:SetTextColor(color.r, color.g, color.b, color.a or 1)
		end
	end
end

local function Clear(self)
	self:SetText("")
end

PlexusFrame:RegisterIndicator("cornertexttopleft", L["Corner Text Top Left"], New, Reset, SetStatus, Clear)
PlexusFrame:RegisterIndicator("cornertexttopright", L["Corner Text Top Right"], New, Reset, SetStatus, Clear)	
PlexusFrame:RegisterIndicator("cornertextbottomleft", L["Corner Text Bottom Left"], New, Reset, SetStatus, Clear)
PlexusFrame:RegisterIndicator("cornertextbottomright", L["Corner Text Bottom Right"], New, Reset, SetStatus, Clear)	
PlexusFrame:RegisterIndicator("sidetexttop", L["Side Text Top"], New, Reset, SetStatus, Clear)
PlexusFrame:RegisterIndicator("sidetextright", L["Side Text Right"], New, Reset, SetStatus, Clear)
PlexusFrame:RegisterIndicator("sidetextleft", L["Side Text Left"], New, Reset, SetStatus, Clear)
PlexusFrame:RegisterIndicator("sidetextbottom", L["Side Text Bottom"], New, Reset, SetStatus, Clear)