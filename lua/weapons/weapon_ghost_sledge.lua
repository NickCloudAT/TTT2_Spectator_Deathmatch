if engine.ActiveGamemode() ~= "terrortown" then return end

if SERVER then
    AddCSLuaFile()
else
    SWEP.PrintName = "Ghost H.U.G.E-249"
    SWEP.Slot = 2
    SWEP.Icon = "vgui/ttt/icon_m249"
    SWEP.ViewModelFlip = false
    SWEP.IconLetter = "z"
end

SWEP.HoldType = "crossbow"
SWEP.Base = "weapon_ghost_base"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AutoSpawnable = false
SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_M249
SWEP.Primary.Damage = 13
SWEP.Primary.Delay = 0.05
SWEP.Primary.Cone = 0.09
SWEP.Primary.ClipSize = 150
SWEP.Primary.ClipMax = 150
SWEP.Primary.DefaultClip = 300
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "AirboatGun"
SWEP.Primary.Recoil = 1.9
SWEP.Primary.Sound = Sound("Weapon_m249.Single")
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"
SWEP.HeadshotMultiplier = 2.2
SWEP.IronSightsPos = Vector(-5.96, -5.119, 2.349)
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
