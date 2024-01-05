if SERVER then
    AddCSLuaFile("cl_init.lua")
    AddCSLuaFile("init.lua")
    AddCSLuaFile("shared.lua")
end

ENT.Base = "base_anim"
ENT.Type = "anim"
ENT.PrintName = "Hidden Trap"
ENT.Author = "mexikoedi"
ENT.Contact = "Steam"
ENT.Instructions = "Is only used for the hidden trap weapon."
ENT.Purpose = "Hidden trap entity for the hidden trap."
ENT.AdminOnly = false
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.AutomaticFrameAdvance = true
function ENT:Think()
    self:NextThink(CurTime())
    return true
end