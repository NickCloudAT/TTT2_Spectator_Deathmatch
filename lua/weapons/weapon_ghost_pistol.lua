if engine.ActiveGamemode() ~= "terrortown" then return end

if SERVER then
    AddCSLuaFile()
else
    SWEP.PrintName = "Ghost Pistol"
    SWEP.Slot = 1
    SWEP.Icon = "vgui/ttt/icon_pistol"
    SWEP.IconLetter = "u"
end

SWEP.HoldType = "pistol"
SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_PISTOL
SWEP.Base = "weapon_ghost_base"
SWEP.Primary.Recoil = 1.3
SWEP.Primary.Damage = 17
SWEP.Primary.Delay = 0.15
SWEP.Primary.Cone = 0.025
SWEP.Primary.ClipSize = 20
SWEP.Primary.Automatic = false
SWEP.Primary.DefaultClip = 80
SWEP.Primary.ClipMax = 60
SWEP.Primary.Ammo = "Pistol"
SWEP.ViewModel = "models/weapons/v_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.Primary.Sound = Sound("Weapon_FiveSeven.Single")
SWEP.IronSightsPos = Vector(4.53, -4, 3.2)

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
