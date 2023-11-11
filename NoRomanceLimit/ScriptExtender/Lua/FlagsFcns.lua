
function MinthyFixNew()
    if GetFlag("ORI_State_DatingMinthara_de1360cd-894b-40ea-95a7-1166d675d040", getAvatar()) > 0 then
        print("NoRomanceLimit: Replacing Minthy Dating flag with Partnered flag.")
        ClearFlag("ORI_State_DatingMinthara_de1360cd-894b-40ea-95a7-1166d675d040", getAvatar())
        SetFlag("ORI_State_PartneredWithMinthara_39ac48fa-b440-47e6-a436-6dc9b10058d8", getAvatar())
        PersistentVars[1] = true
        RestorePartneredStatus()
        FixAfterFlagToggling()
    end
end
function ClearPartnerships(exceptions)
    DPrint(" ClearPartnerships:")
    DPrint(exceptions)
    
    if exceptions == nil then
        exceptions = {}
    end
    for i, flag in pairs(partner_flags) do
        if isInList(i, exceptions) then
            goto continue
        end
        ClearFlag(flag, getAvatar())
        ::continue::
    end
    local shouldClearPartnered = true
    for i, toon in pairs(exceptions) do
        if GetFlag(partner_flags[toon], getAvatar()) > 0 then
            shouldClearPartnered = false
        end
    end
    if shouldClearPartnered then
        ClearFlag(isPartneredFlag, getAvatar())        
    end
end

function StashPartneredStatus(keepUnsetFlags)
    DPrint(" StashPartneredStatus:")
    if GetFlag(date_flags[eMinthara], getAvatar()) > 0 then
        PersistentVars[11] = true
    end
    for index, partner_flag in ipairs(partner_flags) do
        if GetFlag(partner_flag, getAvatar()) ~= 0 then
            PersistentVars[index] = true
        elseif not keepUnsetFlags then
            PersistentVars[index] = false
        end
    end
end

function RestorePartneredStatus(skip_enum)
    DPrint(" StashPartneredStatus:")
    DPrint(skip_enum)
    if skip_enum == nil then
        skip_enum = 9999
    end
    -- for index, stash_result in ipairs(PersistentVars) do
    for index = eMinthara, eLaezel do
        DPrint(index)
        if PersistentVars[index] and (skip_enum ~= index) and (GetFlag(partner_flags[index], getAvatar()) == 0) then
            DPrint(string.format("NoRomanceLimit: Restoring stable relationship with %s", origin_names[index]))
            DTraceback()
            
            ClearFlag(waspartner_flags[index], getAvatar())
            SetFlag(partner_flags[index], getAvatar())
        end
    end
    DPrint("RestorePartneredStatus Done")
    DPrintAll()
end

