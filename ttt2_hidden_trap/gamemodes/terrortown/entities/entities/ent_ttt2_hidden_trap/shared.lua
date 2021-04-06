if SERVER then
    AddCSLuaFile("cl_init.lua")
    AddCSLuaFile("init.lua")
    AddCSLuaFile("shared.lua")
end
test
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Hidden Trap"
ENT.Author = "mexikoedi"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.AutomaticFrameAdvance = true

function ENT:Think()
    self:NextThink(CurTime())

    return true
end
