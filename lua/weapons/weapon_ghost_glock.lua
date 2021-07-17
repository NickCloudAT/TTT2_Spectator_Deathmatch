if engine.ActiveGamemode() ~= "terrortown" then return end

if SERVER then
    AddCSLuaFile()
else
    SWEP.PrintName = "Ghost Glock"
    SWEP.Slot = 1
    SWEP.Icon = "vgui/ttt/icon_glock"
    SWEP.IconLetter = "c"
end

SWEP.HoldType = "pistol"
SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_GLOCK
SWEP.Base = "weapon_ghost_base"
SWEP.Primary.Recoil = 0.7
SWEP.Primary.Damage = 21
SWEP.Primary.Delay = 0.15
SWEP.Primary.Cone = 0.028
SWEP.Primary.ClipSize = 20
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = 120
SWEP.Primary.ClipMax = 100
SWEP.Primary.Ammo = "Pistol"
SWEP.AutoSpawnable = false
SWEP.ViewModel = "models/weapons/v_pist_glock18.mdl"
SWEP.WorldModel = "models/weapons/w_pist_glock18.mdl"
SWEP.Primary.Sound = Sound("Weapon_Glock.Single")
SWEP.IronSightsPos = Vector(4.33, -4.0, 2.9)
SWEP.HeadshotMultiplier = 1.75

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
