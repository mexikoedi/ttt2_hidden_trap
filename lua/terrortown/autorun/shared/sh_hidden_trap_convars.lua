-- convars added with default values
CreateConVar("ttt2_hidden_trap_primary_sound", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Sound of the primary attack")
CreateConVar("ttt2_hidden_trap_secondary_sound", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Sound of the secondary attack")
CreateConVar("ttt2_hidden_trap_damage_sound", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Sound of the damage")
CreateConVar("ttt2_hidden_trap_damage_popup", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Popup because of the damage")
CreateConVar("ttt2_hidden_trap_damage_popup_duration", "5", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Popup duration of the damage popup")
CreateConVar("ttt2_hidden_trap_damage", "20", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Damage of the hidden trap")
CreateConVar("ttt2_hidden_trap_ammo", "4", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Ammo of the hidden trap")
CreateConVar("ttt2_hidden_trap_clipSize", "4", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Clipsize of the hidden trap")
if CLIENT then
    -- Use string or string.format("%.f",<steamid64>) 
    -- addon dev emblem in scoreboard
    hook.Add("TTT2FinishedLoading", "TTT2RegistermexikoediAddonDev", function() AddTTT2AddonDev("76561198279816989") end)
end