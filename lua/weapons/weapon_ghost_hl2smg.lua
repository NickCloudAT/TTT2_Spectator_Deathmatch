if engine.ActiveGamemode() ~= "terrortown" then return end

if SERVER then
    AddCSLuaFile()

    if SpecDM.LoadoutEnabled then
        resource.AddFile("materials/vgui/spec_dm/icon_sdm_smg.vmt")
    end
else
    SWEP.PrintName = "Ghost SMG"
    SWEP.Slot = 2
    SWEP.ViewModelFlip = false
    SWEP.ViewModelFOV = 60
    SWEP.Icon = "vgui/spec_dm/icon_sdm_smg"
end

SWEP.Base = "weapon_ghost_base"
SWEP.HoldType = "ar2"
SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_MAC10
SWEP.Primary.Damage = 12
SWEP.Primary.Delay = 0.065
SWEP.Primary.Cone = 0.03
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 90
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Recoil = 1.15
SWEP.Primary.Sound = Sound("Weapon_SMG1.Single")
SWEP.AutoSpawnable = false
SWEP.ViewModel = "models/weapons/v_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.IronSightsPos = Vector(-6.4318, -2.0031, 2.5371)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset = Vector(9.071, 0, 1.6418)
SWEP.RunArmAngle = Vector(-12.9765, 26.8708, 0)

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

-- Add some zoom to ironsights for this gun
function SWEP:SecondaryAttack()
    if not self.IronSightsPos then return end
    if self:GetNextSecondaryFire() > CurTime() then return end
    local bIronsights = not self:GetIronsights()
    self:SetIronsights(bIronsights)
    self:SetNextSecondaryFire(CurTime() + 0.3)
end

function SWEP:PreDrop()
    self:SetIronsights(false)

    return self.BaseClass.PreDrop(self)
end

function SWEP:Holster()
    self:SetIronsights(false)

    return true
end

function SWEP:ResetIronSights()
    self:SetIronsights(false)
    self:SetZoom(false)
end

function SWEP:Reload()
    if self:Clip1() >= self:Ammo1() or self:Clip1() >= self.Primary.ClipSize or self:Ammo1() < 0 or self:Clip1() < 0 then return end
    self:DefaultReload(ACT_VM_RELOAD)
    self:SetIronsights(false)

    if CLIENT and LocalPlayer() == self:GetOwner() then
        self:EmitSound("Weapon_SMG1.Reload")
    else
        local filter = RecipientFilter()

        for _, v in ipairs(player.GetHumans()) do
            if v ~= self:GetOwner() and v:IsGhost() then
                filter:AddPlayer(v)
            end
        end

        net.Start("SpecDM_BulletGhost")
        net.WriteString("Weapon_SMG1.Reload")
        net.WriteVector(self:GetPos())
        net.WriteUInt(45, 19)
        net.Send(filter)
    end
end
