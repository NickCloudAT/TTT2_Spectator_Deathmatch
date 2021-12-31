if engine.ActiveGamemode() ~= "terrortown" then return end

if SERVER then
    AddCSLuaFile()
else
    SWEP.EquipMenuData = {
        type = "item_weapon",
        name = "ttt2_spectator_deathmatch_weapon_12",
        desc = ""
    }

    SWEP.PrintName = LANG.GetTranslation("ttt2_spectator_deathmatch_weapon_12")
    SWEP.Slot = 1
    SWEP.ViewModelFOV = 54
    SWEP.ViewModelFlip = false
    SWEP.Icon = "vgui/ttt/icon_deagle"
    SWEP.IconLetter = "f"
end

SWEP.Base = "weapon_ghost_base"
SWEP.HoldType = "pistol"
SWEP.Spawnable = true
SWEP.AutoSpawnable = false
SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_DEAGLE
SWEP.Primary.Ammo = "AlyxGun" -- hijack an ammo type we don't use otherwise
SWEP.Primary.Recoil = 6
SWEP.Primary.Damage = 24
SWEP.Primary.Delay = 0.5
SWEP.Primary.Cone = 0.02
SWEP.Primary.ClipSize = 8
SWEP.Primary.ClipMax = 28
SWEP.Primary.DefaultClip = 36
SWEP.Primary.Automatic = true
SWEP.UseHands = true
SWEP.HeadshotMultiplier = 5
SWEP.Primary.Sound = Sound("Weapon_Deagle.Single")
SWEP.ViewModel = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"
SWEP.IronSightsPos = Vector(-6.361, -3.701, 2.15)
SWEP.IronSightsAng = Vector(0, 0, 0)

-- fix 2 for setzoom is nil value error in ttt2
function SWEP:SetZoom(state)
    if IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() then
        if state then
            self:GetOwner():SetFOV(20, 0.3)
        else
            self:GetOwner():SetFOV(0, 0.2)
        end
    end
end

function SWEP:PreDrop()
    self:SetZoom(false)
    self:SetIronsights(false)

    return self.BaseClass.PreDrop(self)
end

function SWEP:Reload()
    if self:Clip1() == self.Primary.ClipSize or self:GetOwner():GetAmmoCount(self.Primary.Ammo) <= 0 then return end
    self:DefaultReload(ACT_VM_RELOAD)
    self:SetIronsights(false)
    self:SetZoom(false)
end

function SWEP:Holster()
    self:SetIronsights(false)
    self:SetZoom(false)

    return true
end

function SWEP:ResetIronSights()
    self:SetIronsights(false)
    self:SetZoom(false)
end
