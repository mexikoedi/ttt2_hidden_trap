include("shared.lua")

function ENT:Draw()
end

net.Receive("ttt2_hidden_trap_epop", function()
    hidden_trap_duration1 = net.ReadInt(32)

    EPOP:AddMessage({
        text = LANG.GetTranslation("ttt2_hidden_trap_popuptitle"),
        color = Color(255, 204, 203, 255)
    }, "", hidden_trap_duration1)
end)