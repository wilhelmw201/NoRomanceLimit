
function FixAll()
    -- make everything consistent to flag values
    ClearUnusedDatingFlags()
    FixDoubleDating()
    FixPartneredDBAndFlags()
    ManageDatingEntry()
    ManageCanStartDatingEntry()
    ClearDumpDialogs()
    restoreStableRelationship()
end

function FixAfterFlagToggling()
    FixDatingDB()
    FixPartneredDBAndFlags()
    ClearUnusedDatingFlags()
    ClearDumpDialogs()
end

function FixDatingDB()
    for index = eMinthara, eLaezel do
        if GetFlag(date_flags[index], getAvatar()) ~= 0 then
            Osi.DB_ORI_Dating(Osi.DB_Players:Get(nil)[1][1], origin_uuids[index])
            Osi.DB_ORI_WasDating:Delete(Osi.DB_Players:Get(nil)[1][1], origin_uuids[index])
        end
    end
end

function FixPartneredDBAndFlags()
    local isPartnered = false
    for index = eMinthara, eLaezel do
        if GetFlag(partner_flags[index], getAvatar()) ~= 0 then
            isPartnered = true
            Osi.DB_ORI_Partnered(Osi.DB_Players:Get(nil)[1][1], origin_uuids[index])
            Osi.ClearFlag(waspartner_flags[index], getAvatar())
        end
    end
    local isPartneredHalsin = GetFlag(partner_flags[eHalsin], getAvatar()) > 0
    if isPartnered or isPartneredHalsin then
        Osi.SetFlag(isPartneredFlag, getAvatar())
        restoreStableRelationship()
        if isPartnered and isPartneredHalsin then
            Osi.SetFlag("ORI_State_PartneredWithHalsinSecondary_6af0be74-d032-4a20-876a-11bab5f86db2", getAvatar())
        end
    else
        Osi.ClearFlag(isPartneredFlag, getAvatar())
    end
end


-----------
-- fixes during each flag toggle
-----------
function ClearUnusedDatingFlags()
    StashPartneredStatus(true)
    for i, value in ipairs(origin_names) do
        if GetFlag(partner_flags[i], getAvatar()) > 0 then
            ClearFlag(date_flags[i], getAvatar())
            Osi.DB_ORI_WasDating:Delete(origin_uuids[i],nil)
            Osi.DB_ORI_WasDating:Delete(nil,origin_uuids[i])
        end
    end
end
function ClearDumpDialogs()
    ClearFlag("ORI_State_ChosePartnerOverMinthara_25202f13-55d3-4d13-c2b0-45120da9f299", getAvatar())
    ClearFlag("ORI_State_ChosePartnerOverLaezel_35c95a6d-4145-4903-73ad-73a70edf9268", getAvatar())
    ClearFlag("ORI_State_ChosePartnerOverShadowheart_3928d3fc-b2c8-44ac-0d85-69e27f170a8c", getAvatar())
    ClearFlag("ORI_State_ChosePartnerOverAstarion_529d4115-ef78-49aa-f2b1-99244e4ee375", getAvatar())
    ClearFlag("ORI_State_ChosePartnerOverKarlach_8e5ba2d7-146c-4751-2aa6-d94b8f8e9e27", getAvatar())
    ClearFlag("ORI_State_ChosePartnerOverWyll_f0b08362-76b7-4cf9-01bd-4f87d8c11cbf", getAvatar())
    ClearFlag("ORI_State_ChosePartnerOverGale_ff5cbe4e-d3a8-4cc6-fa86-36f35ef10443", getAvatar())
end
------------------------------
-- stable relationships
------------------------------

function restoreStableRelationship()
    if PersistentVars[10]  > 3 then
        SetFlag("ORI_State_StableRelationship_d904563d-2660-4b0c-c88a-8b743cbe9530", getAvatar())
        SetFlag("ORI_State_StableRelationship_d904563d-2660-4b0c-8ac8-748bbe3c3095", getAvatar())
    end
end
function stableRelationshipAdvance()
    DPrint(string.format(" stable rel @ %d => +1", PersistentVars[10]))
    -- seems isInRelationship is broken
    if GetFlag(isPartneredFlag, getAvatar()) > 0 then
        PersistentVars[10] = PersistentVars[10]  + 1
    else
        PersistentVars[10] = 0
    end
end



--------------------------
-- database fixes
--------------------------

function FixDoubleDating()
    -- once per game
    for _, person in ipairs(origin_uuids) do 
        Osi.DB_ORI_FreeDating(person)
    end
    Osi.ClearFlag("ORI_State_DoubleDating_41320aeb-8e1a-433d-a82e-3d78aff578da", getAvatar()) 
end

function Fix_Databases()
    -- Once Per Act
    ManageCanStartDatingEntry()
    ManageDatingEntry()

end

function ManageCanStartDatingEntry()
    for _, list in ipairs(Osi.DB_CampNight_Requirement_CanStartDating:Get(nil,nil)) do
        if ShouldManageCanStartDatingEntry(list) then
            Osi.DB_CampNight_Requirement_CanStartDating:Delete(list[1], list[2])
            print(string.format("NoRomanceLimit - Removing Requirement ReqCanStartDate for %s", list[1]))
        end
    end
end
function ManageDatingEntry()
    for _, list in ipairs(Osi.DB_CampNight_Requirement_Dating:Get(nil,nil)) do
        if ShouldManageDatingEntry(list) then
            Osi.DB_CampNight_Requirement_Dating:Delete(list[1], list[2])
            FixRomNightFlagCheckForNight(list[1])
            print(string.format("NoRomanceLimit - Removing Requirement ReqDating %s ", list[1]))
        end
    end
end

function FixRomNightFlagCheckForNight(night_uuid)
    -- the queueing mechanism requires that for a dating->stable scene, the 4th paramter is non null, 
    -- or it will check for other partners. Add the isDating flag to make it happy
    for _,value in ipairs(Osi.DB_CampNight_RomanceNight:Get(nil,nil,nil,nil)) do
        if value[1] == night_uuid and value[4] == "NULL_00000000-0000-0000-0000-000000000000" then
            romance_toon = value[2]
            for i, toon_uuid in ipairs(origin_uuids) do
                if toon_uuid == romance_toon then
                    Osi.DB_CampNight_RomanceNight(value[1],value[2],value[3],date_flags[i])
                end
            end
            Osi.DB_CampNight_RomanceNight:Delete(value[1],value[2],value[3],value[4])
        end
    end
end

function ShouldManageDatingEntry(entry)
    night_uuid = entry[1]
    origin_uuid = entry[2]
-- QRY
-- QRY_CampNight_MeetsRequirements_Dating((FLAG)_Var1) [KEEP0] [implicitly satisfied?]
-- AND
-- DB_CampNight_Requirement_Dating(_Var1, _Var2)
-- AND
-- DB_ORI_Dating(_Var3, _Var2) [Keep1]
-- AND NOT
-- QRY_PartneredWithOther(_Var3, _Var2)
-- AND
-- DB_InCamp(_Var3) 
-- AND NOT
-- DB_Avatars(_Var2) [Keep2]
-- AND NOT
-- QRY_PreventMPDialogue(_Var2, _Var3)
-- THEN
-- DB_NOOP(1);
    if
        -- 1
        isSublistInListOfLists({getAvatar(), origin_uuid}, Osi.DB_ORI_Dating:Get(nil,nil)) and
        -- 2
        origin_uuid ~= getAvatar()
    then
        return true
    end
    return false
end

function ShouldManageCanStartDatingEntry(entry)
    night_uuid = entry[1]
    origin_uuid = entry[2]
-- QRY
-- QRY_CampNight_MeetsRequirements_StartDating((FLAG)_Var1)
-- AND
-- DB_CampNight_Requirement_CanStartDating(_Var1, _Var2) [KEEP0] [implicitly satisfied?]
-- AND NOT
-- DB_ORI_Dating(_, _Var2) [Removed] due to origin cannot date multiple in SP
-- AND NOT
-- DB_Avatars(_Var2) [KEEP2] avatar cannot date himself
-- AND NOT
-- DB_ORI_Partnered(_Var4, _) 
-- AND
-- GetFlag(ORI_State_DoubleDating_41320aeb-8e1a-433d-a82e-3d78aff578da, _Var4, 0) 
-- AND NOT
-- DB_ORI_WasDating(_Var4, _Var2) [KEEP3]
-- AND NOT
-- QRY_PreventMPDialogue(_Var2, _Var4) [Removed for now] no MP
-- THEN
-- DB_NOOP(1);
    if
        -- 0
        -- 2
        origin_uuid ~= getAvatar() and
        -- 3
        not isSublistInListOfLists({getAvatar(), origin_uuid}, Osi.DB_ORI_WasDating:Get(nil,nil))
    then
        return true
    end
    return false
end