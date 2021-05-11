-- convars added with default values
CreateConVar("ttt2_hidden_trap_primary_sound", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Sound of the primary attack")

CreateConVar("ttt2_hidden_trap_secondary_sound", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Sound of the secondary attack")

CreateConVar("ttt2_hidden_trap_damage_sound", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Sound of the damage")

CreateConVar("ttt2_hidden_trap_damage_popup", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Popup because of the damage")

CreateConVar("ttt2_hidden_trap_damage_popup_duration", "5", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Popup duration of the damage popup")

CreateConVar("ttt2_hidden_trap_damage", "20", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Damage of the Hidden Trap")

CreateConVar("ttt2_hidden_trap_ammo", "4", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Ammo of the Hidden Trap")

CreateConVar("ttt2_hidden_trap_clipSize", "4", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Clipsize of the Hidden Trap")

if CLIENT then
    -- Use string or string.format("%.f",<steamid64>) 
    -- addon dev emblem in scoreboard
    hook.Add("TTT2FinishedLoading", "TTT2RegistermexikoediAddonDev", function()
        AddTTT2AddonDev("76561198279816989")
    end)
end

hook.Add("TTTUlxInitCustomCVar", "TTT2HiddenTrapInitRWCVar", function(name)
    ULib.replicatedWritableCvar("ttt2_hidden_trap_primary_sound", "rep_ttt2_hidden_trap_primary_sound", GetConVar("ttt2_hidden_trap_primary_sound"):GetBool(), true, false, name)
    ULib.replicatedWritableCvar("ttt2_hidden_trap_secondary_sound", "rep_ttt2_hidden_trap_secondary_sound", GetConVar("ttt2_hidden_trap_secondary_sound"):GetBool(), true, false, name)
    ULib.replicatedWritableCvar("ttt2_hidden_trap_damage_sound", "rep_ttt2_hidden_trap_damage_sound", GetConVar("ttt2_hidden_trap_damage_sound"):GetBool(), true, false, name)
    ULib.replicatedWritableCvar("ttt2_hidden_trap_damage_popup", "rep_ttt2_hidden_trap_damage_popup", GetConVar("ttt2_hidden_trap_damage_popup"):GetBool(), true, false, name)
    ULib.replicatedWritableCvar("ttt2_hidden_trap_damage_popup_duration", "rep_ttt2_hidden_trap_damage_popup_duration", GetConVar("ttt2_hidden_trap_damage_popup_duration"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt2_hidden_trap_damage", "rep_ttt2_hidden_trap_damage", GetConVar("ttt2_hidden_trap_damage"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt2_hidden_trap_ammo", "rep_ttt2_hidden_trap_ammo", GetConVar("ttt2_hidden_trap_ammo"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt2_hidden_trap_clipSize", "rep_ttt2_hidden_trap_clipSize", GetConVar("ttt2_hidden_trap_clipSize"):GetInt(), true, false, name)
end)

if CLIENT then
    hook.Add("TTTUlxModifyAddonSettings", "TTT2HiddenTrapModifySettings", function(name)
        local tttrspnl = xlib.makelistlayout{
            w = 415,
            h = 318,
            parent = xgui.null
        }

        -- Basic Settings
        local tttrsclp1 = vgui.Create("DCollapsibleCategory", tttrspnl)
        tttrsclp1:SetSize(390, 178)
        tttrsclp1:SetExpanded(1)
        tttrsclp1:SetLabel("Basic Settings")
        local tttrslst1 = vgui.Create("DPanelList", tttrsclp1)
        tttrslst1:SetPos(5, 25)
        tttrslst1:SetSize(390, 178)
        tttrslst1:SetSpacing(5)

        tttrslst1:AddItem(xlib.makecheckbox{
            label = "ttt2_hidden_trap_primary_sound (Def. 1)",
            repconvar = "rep_ttt2_hidden_trap_primary_sound",
            parent = tttrslst1
        })

        tttrslst1:AddItem(xlib.makecheckbox{
            label = "ttt2_hidden_trap_secondary_sound (Def. 1)",
            repconvar = "rep_ttt2_hidden_trap_secondary_sound",
            parent = tttrslst1
        })

        tttrslst1:AddItem(xlib.makecheckbox{
            label = "ttt2_hidden_trap_damage_sound (Def. 1)",
            repconvar = "rep_ttt2_hidden_trap_damage_sound",
            parent = tttrslst1
        })

        tttrslst1:AddItem(xlib.makecheckbox{
            label = "ttt2_hidden_trap_damage_popup (Def. 1)",
            repconvar = "rep_ttt2_hidden_trap_damage_popup",
            parent = tttrslst1
        })

        tttrslst1:AddItem(xlib.makeslider{
            label = "ttt2_hidden_trap_damage_popup_duration (Def. 5)",
            repconvar = "rep_ttt2_hidden_trap_damage_popup_duration",
            min = 0,
            max = 15,
            decimal = 0,
            parent = tttrslst1
        })

        tttrslst1:AddItem(xlib.makeslider{
            label = "ttt2_hidden_trap_damage (Def. 20)",
            repconvar = "rep_ttt2_hidden_trap_damage",
            min = 0,
            max = 200,
            decimal = 0,
            parent = tttrslst1
        })

        tttrslst1:AddItem(xlib.makeslider{
            label = "ttt2_hidden_trap_ammo (Def. 4)",
            repconvar = "rep_ttt2_hidden_trap_ammo",
            min = 0,
            max = 10,
            decimal = 0,
            parent = tttrslst1
        })

        tttrslst1:AddItem(xlib.makeslider{
            label = "ttt2_hidden_trap_clipSize (Def. 4)",
            repconvar = "rep_ttt2_hidden_trap_clipSize",
            min = 0,
            max = 10,
            decimal = 0,
            parent = tttrslst1
        })

        -- add to ULX
        xgui.hookEvent("onProcessModules", nil, tttrspnl.processModules)
        xgui.addSubModule("Hidden Trap", tttrspnl, nil, name)
    end)
end
