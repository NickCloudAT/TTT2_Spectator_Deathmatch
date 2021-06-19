if SERVER then
    AddCSLuaFile()

    if SpecDM.LoadoutEnabled then
        resource.AddFile("materials/vgui/spec_dm/icon_sdm_revolver.vmt")
    end
else
    SWEP.PrintName = "Ghost Magnum"
    SWEP.Slot = 1
    SWEP.ViewModelFlip = false
    SWEP.ViewModelFOV = 54
    SWEP.Icon = "vgui/spec_dm/icon_sdm_revolver"
end

SWEP.HoldType = "pistol"
SWEP.Tracer = "AR2Tracer"
SWEP.Base = "weapon_ghost_base"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_MAGNUM
SWEP.Primary.Delay = 0.9
SWEP.Primary.ClipSize = 6
SWEP.Primary.Recoil = 6.5
SWEP.Primary.DefaultClip = 36
SWEP.Primary.Cone = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "AlyxGun" -- hijack an ammo type we don't use otherwise
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Sound = Sound("weapon_357.Single")
SWEP.Primary.Damage = 50
SWEP.Spread = 0.02
SWEP.Primary.NumShots = 1
SWEP.Delay = 0.6
SWEP.Primary.ClipMax = 36
SWEP.HeadshotMultiplier = 4
SWEP.AutoSpawnable = false
SWEP.NoAmmoEnt = "item_ammo_revolver_ttt"
SWEP.Primary.Sound = Sound("weapon_357.Single")
SWEP.ViewModel = Model("models/weapons/v_357.mdl")
SWEP.WorldModel = Model("models/weapons/w_357.mdl")
SWEP.IronSightsPos = Vector(-5.6917, -3.2203, 2.3961)
SWEP.IronSightsAng = Vector(0.6991, -0.1484, 0.8356)

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
