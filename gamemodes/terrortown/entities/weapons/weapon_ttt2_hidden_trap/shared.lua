local songs = {}
local song_path = "secondary_hidden_trap/"
if SERVER then
    AddCSLuaFile()
    resource.AddFile("materials/vgui/ttt/weapon_hidden_trap.vmt")
    resource.AddFile("sound/hidden_trap1.wav")
    resource.AddFile("sound/hidden_trap3.wav")
    local song_files = file.Find("sound/" .. song_path .. "*.wav", "GAME")
    if song_files then
        for i = 1, #song_files do
            local song = song_files[i]
            resource.AddFile("sound/" .. song_path .. song_files[i])
            songs[i] = song
        end
    end
end

SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "normal"
SWEP.Author = "mexikoedi"
SWEP.PrintName = "Hidden Trap"
SWEP.Contact = "Steam"
SWEP.Instructions = "Left click to place traps for your enemies and secondary attack to play random sounds."
SWEP.Purpose = "Create invisible traps and lure your enemies into them."
SWEP.UseHands = true
SWEP.Kind = WEAPON_EQUIP1
SWEP.AutoSpawnable = false
SWEP.Spawnable = false
SWEP.AdminOnly = false
SWEP.AdminSpawnable = false
SWEP.Slot = 7
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.AllowDrop = false
SWEP.AllowPickup = false
SWEP.InLoadoutFor = nil
SWEP.IsSilent = false
SWEP.Primary.ClipSize = GetConVar("ttt2_hidden_trap_clipSize"):GetInt()
SWEP.Primary.DefaultClip = GetConVar("ttt2_hidden_trap_ammo"):GetInt()
SWEP.Secondary.Delay = 1
SWEP.ViewModel = "models/weapons/v_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.LimitedStock = true
SWEP.Icon = "vgui/ttt/weapon_hidden_trap"
SWEP.EquipMenuData = {
    type = "item_weapon",
    name = "ttt2_hidden_trap_name",
    desc = "ttt2_hidden_trap_desc"
}

function SWEP:Initialize()
    if CLIENT then self:AddTTT2HUDHelp("ttt2_hidden_trap_help1", "ttt2_hidden_trap_help2") end
    if SERVER then
        self.Primary.ClipSize = GetConVar("ttt2_hidden_trap_clipSize"):GetInt()
        self.Primary.DefaultClip = GetConVar("ttt2_hidden_trap_ammo"):GetInt()
    end
end

if SERVER then
    function SWEP:PrimaryAttack()
        if not self:CanPrimaryAttack() then return end
        self.currentOwner = self:GetOwner()
        if not IsValid(self.currentOwner) then return end
        self.currentOwner:LagCompensation(true)
        self:SetNextPrimaryFire(CurTime() + 1)
        local tr = util.TraceLine({
            start = self.currentOwner:GetShootPos(),
            endpos = self.currentOwner:GetShootPos() + self.currentOwner:GetAimVector() * 10000,
            filter = self.currentOwner
        })

        if tr.HitWorld then
            local ent = ents.Create("ent_ttt2_hidden_trap")
            if not IsValid(ent) then
                self.currentOwner:LagCompensation(false)
                return
            end

            ent:SetPos(tr.HitPos)
            local ang = tr.HitPos:Angle()
            ang:RotateAroundAxis(ang:Right(), -90)
            ent:SetAngles(ang)
            ent:Spawn()
            if GetConVar("ttt2_hidden_trap_primary_sound"):GetBool() then self.currentOwner:EmitSound("hidden_trap1.wav") end
            ent.Owner = self.currentOwner
            ent:SetOwner(self.currentOwner)
            ent:SetPhysicsAttacker(self.currentOwner)
            ent.fingerprints = self.fingerprints
            self:TakePrimaryAmmo(1)
            if self:Clip1() <= 0 then self:Remove() end
        end

        self.currentOwner:LagCompensation(false)
    end

    SWEP.NextSecondaryAttack = 0
    function SWEP:SecondaryAttack()
        if self.NextSecondaryAttack > CurTime() then return end
        self.NextSecondaryAttack = CurTime() + self.Secondary.Delay
        self.currentOwner = self:GetOwner()
        if not IsValid(self.currentOwner) then return end
        if GetConVar("ttt2_hidden_trap_secondary_sound"):GetBool() and not self.LoopSound then
            self.LoopSound = CreateSound(self.currentOwner, Sound(song_path .. songs[math.random(#songs)]))
            if self.LoopSound then self.LoopSound:Play() end
        end
    end

    function SWEP:KillSounds()
        if self.LoopSound then
            self.LoopSound:Stop()
            self.LoopSound = nil
        end
    end

    function SWEP:OnRemove()
        if IsValid(self.currentOwner) then self:KillSounds() end
    end

    function SWEP:Holster()
        if IsValid(self.currentOwner) then self:KillSounds() end
        return true
    end

    function SWEP:OnDrop()
        if IsValid(self.currentOwner) then self:KillSounds() end
        self:Remove()
    end
end

if CLIENT then
    function SWEP:AddToSettingsMenu(parent)
        local form = vgui.CreateTTT2Form(parent, "header_equipment_additional")
        form:MakeCheckBox({
            serverConvar = "ttt2_hidden_trap_primary_sound",
            label = "label_hidden_trap_primary_sound"
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_hidden_trap_secondary_sound",
            label = "label_hidden_trap_secondary_sound"
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_hidden_trap_damage_sound",
            label = "label_hidden_trap_damage_sound"
        })

        local masterDamage = form:MakeCheckBox({
            serverConvar = "ttt2_hidden_trap_damage_popup",
            label = "label_hidden_trap_damage_popup"
        })

        form:MakeSlider({
            serverConvar = "ttt2_hidden_trap_damage_popup_duration",
            label = "label_hidden_trap_damage_popup_duration",
            min = 0,
            max = 15,
            decimal = 0,
            master = masterDamage
        })

        form:MakeSlider({
            serverConvar = "ttt2_hidden_trap_damage",
            label = "label_hidden_trap_damage",
            min = 0,
            max = 200,
            decimal = 0
        })

        form:MakeSlider({
            serverConvar = "ttt2_hidden_trap_ammo",
            label = "label_hidden_trap_ammo",
            min = 0,
            max = 10,
            decimal = 0
        })

        form:MakeSlider({
            serverConvar = "ttt2_hidden_trap_clipSize",
            label = "label_hidden_trap_clipSize",
            min = 0,
            max = 10,
            decimal = 0
        })
    end
end