local PLUGIN = PLUGIN

PLUGIN.name = "S.T.A.L.K.E.R. User Interface"
PLUGIN.author = "From Purin & DrodA with love"
PLUGIN.desc = ""
PLUGIN.version = 1

local IncludeFiles = {"cl_hooks.lua", "sh_config.lua"}
for k, v in ipairs(IncludeFiles) do nut.util.include(v) end