include("shared.lua")

function ENT:Draw()
end

net.Receive("ttt2_hidden_trap_epop", function()
    EPOP:AddMessage({
        text = LANG.GetTranslation("ttt2_hidden_trap_popuptitle"),
        color = Color(255, 204, 203, 255)
    }, "", GetConVar("ttt2_hidden_trap_damage_popup_duration"):GetInt())
end)
