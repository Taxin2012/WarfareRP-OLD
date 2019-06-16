--[[
    NutScript is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    NutScript is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with NutScript.  If not, see <http://www.gnu.org/licenses/>.
--]]

ITEM.name = "Снаряд РПГ-7"
ITEM.ammo = "grenate" // type of the ammo
ITEM.ammoAmount = 1 // amount of the ammo
ITEM.desc = "Осколочно-фугасная противопехотная граната. При помощи пусковой установки РПГ-7у позволяет поражать укрывшегося противника на расстоянии, превышающем дальность броска ручной гранаты. \n\nХАРАКТЕРИСТИКИ: \n-повреждение тканей: очень сильное"
ITEM.category = "Ammunition"
ITEM.flag = "v"
ITEM.price = 3140
ITEM.model = "models/stalker/ammo/rpg7.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 12
}
ITEM.exRender = true