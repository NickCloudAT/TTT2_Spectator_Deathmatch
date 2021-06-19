if SERVER then
    AddCSLuaFile()

    if SpecDM.LoadoutEnabled then
        resource.AddFile("materials/vgui/spec_dm/icon_sdm_galil.vmt")
    end
else
    SWEP.PrintName = "Ghost Galil"
    SWEP.Slot = 2
    SWEP.ViewModelFlip = false
    SWEP.ViewModelFOV = 72
    SWEP.Icon = "vgui/spec_dm/icon_sdm_galil"
    SWEP.IconLetter = "v"
end

SWEP.Base = "weapon_ghost_base"
SWEP.HoldType = "ar2"
SWEP.Primary.Delay = 0.10
SWEP.Primary.Recoil = 0.79
SWEP.Primary.Automatic = true
SWEP.Primary.Damage = 17
SWEP.Primary.Cone = 0.025
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.ClipSize = 20
SWEP.Primary.ClipMax = 100
SWEP.Primary.DefaultClip = 120
SWEP.Primary.Sound = Sound("Weapon_GALIL.Single")
SWEP.IronSightsPos = Vector(-5.1337, -3.9115, 2.1624)
SWEP.IronSightsAng = Vector(0.0873, 0.0006, 0)
SWEP.IronsightsFOV = 60
SWEP.ViewModel = "models/weapons/v_rif_galil.mdl"
SWEP.WorldModel = "models/weapons/w_rif_galil.mdl"
SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = false

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
