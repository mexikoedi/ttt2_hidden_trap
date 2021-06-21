include("shared.lua")
util.AddNetworkString("ttt2_hidden_trap_epop")

function ENT:Initialize()
    self:SetModel("models/props_junk/garbage_milkcarton002a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:DrawShadow(false)

    if self:GetPhysicsObject():IsValid() then
        self:GetPhysicsObject():EnableMotion(false)
    end

    self:SetUseType(SIMPLE_USE)
    self.dmg = 0
end

function ENT:Touch(toucher)
    if not IsValid(toucher) or not IsValid(self) then return end
    if not toucher:IsPlayer() then return end
    if SpecDM and (toucher.IsGhost and toucher:IsGhost()) then return end
    local dmg = DamageInfo()
    local attacker = nil

    if IsValid(self:GetOwner()) then
        attacker = self:GetOwner()
    else
        attacker = toucher
    end

    if toucher:GetTeam() == attacker:GetTeam() then return end

    if GetConVar("ttt2_hidden_trap_damage_sound"):GetBool() then
        toucher:EmitSound("hidden_trap3.wav")
    end

    if GetConVar("ttt2_hidden_trap_damage_popup"):GetBool() then
        net.Start("ttt2_hidden_trap_epop")
        net.Send(toucher)
    end

    dmg:SetAttacker(attacker)
    local inflictor = ents.Create("weapon_ttt2_hidden_trap")
    dmg:SetInflictor(inflictor)
    dmg:SetDamage(GetConVar("ttt2_hidden_trap_damage"):GetInt())
    dmg:SetDamageType(DMG_GENERIC)
    toucher:TakeDamageInfo(dmg)
    self:Remove()
end
