if engine.ActiveGamemode() ~= "terrortown" then return end

if SERVER then
    AddCSLuaFile()
else
    SWEP.EquipMenuData = {
        type = "item_weapon",
        name = "ttt2_spectator_deathmatch_weapon_8",
        desc = ""
    }

    SWEP.PrintName = LANG.GetTranslation("ttt2_spectator_deathmatch_weapon_8")
    SWEP.Slot = 2
    SWEP.ViewModelFlip = false
    SWEP.ViewModelFOV = 54
    SWEP.Icon = "vgui/ttt/icon_mac"
    SWEP.IconLetter = "l"
end

SWEP.Base = "weapon_ghost_base"
SWEP.HoldType = "ar2"
SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_MAC10
SWEP.Primary.Damage = 15
SWEP.Primary.Delay = 0.071
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 120
SWEP.Primary.DefaultClip = 150
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Recoil = 1.9
SWEP.Primary.Sound = Sound("Weapon_mac10.Single")
SWEP.AutoSpawnable = false
SWEP.NoAmmoEnt = "item_ammo_smg1_ttt"
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_smg_mac10.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mac10.mdl"
SWEP.IronSightsPos = Vector(-8.921, -9.528, 2.9)
SWEP.IronSightsAng = Vector(0.699, -5.301, -7)
SWEP.DeploySpeed = 3

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

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
    local att = dmginfo:GetAttacker()
    if not IsValid(att) then return 2 end
    local dist = victim:GetPos():Distance(att:GetPos())
    local d = math.max(0, dist - 150)
    -- decay from 3.2 to 1.7

    return 1.7 + math.max(0, 1.5 - 0.002 * (d ^ 1.25))
end
