
------------------------------


function CheckNight(name)
    if string.sub(name, 1, 5) ~= "NIGHT" then
        print("Warning: The name of the night should start with NIGHT.")
    end

    still_in_db = false
    for _, value in ipairs(Osi.DB_CampNight:Get(nil,nil)) do
        if value[1] == name then
            still_in_db = true
        end
    end
    if still_in_db == false then
        print("This event is not queued. Either you have not entered the act in which this scene belongs, or it will not be available in this playthrough anymore.")
        return
    end


    
    local allowedSites = ""
    for _, value in ipairs(Osi.DB_CampNight_Camp:Get(nil,nil)) do
        if value[1] == name then
            allowedSites = allowedSites .. value[2] .. ","
        end
    end
    print(string.format("Allowed campsites of the event: %s", allowedSites))
    print(string.format("Your current campsite is: %s.", Osi.DB_ActiveCamp:Get(nil)[1][1]))

    for _, value in ipairs(Osi.DB_CampNight_Requirement_Approval:Get(nil,nil,nil)) do
        if value[1] == name then
            print(string.format("This event requires at least %s approval with %s.", value[3], stripUUID(value[2])))    
        end
    end
    
    local all_flagsets = {}
    all_flagsets = mergeLists(all_flagsets, filterFlagSet(name, Osi.DB_CampNight_Requirement:Get(nil,nil)))
    all_flagsets = mergeLists(all_flagsets, filterFlagSet(name, Osi.DB_CampNight_Requirement:Get(nil,nil,nil)))
    all_flagsets = mergeLists(all_flagsets, filterFlagSet(name, Osi.DB_CampNight_Requirement:Get(nil,nil,nil,nil)))
    all_flagsets = mergeLists(all_flagsets, filterFlagSet(name, Osi.DB_CampNight_Requirement:Get(nil,nil,nil,nil,nil)))
    all_flagsets = mergeLists(all_flagsets, filterFlagSet(name, Osi.DB_CampNight_Requirement:Get(nil,nil,nil,nil,nil,nil)))
    all_flagsets = mergeLists(all_flagsets, filterFlagSet(name, Osi.DB_CampNight_Requirement:Get(nil,nil,nil,nil,nil,nil,nil)))
    all_flagsets = mergeLists(all_flagsets, filterFlagSet(name, Osi.DB_CampNight_Requirement:Get(nil,nil,nil,nil,nil,nil,nil,nil)))

    for _, value in ipairs(Osi.DB_CampNight_Requirement_Partner:Get(nil,nil)) do
        if value[1] == name then
            print(string.format("This event requires partnered with %s.", stripUUID(value[2])))
        end
    end
    for _, value in ipairs(Osi.DB_CampNight_Requirement_Dating:Get(nil,nil)) do
        if value[1] == name then
            print(string.format("This event requires dating %s.", stripUUID(value[2])))
        end
    end

    local romanceNightEntry = Osi.DB_CampNight_RomanceNight:Get(name, nil,nil,nil)
    if #romanceNightEntry > 0 then
        print(string.format("This event requires this flag to be true: True is indicated as [O]; False [X]."))
        local flagname = romanceNightEntry[0][4]
        local satisfied
        if Osi.GetFlag(flag, getAvatar()) > 0 then
            satisfied = '[O]'
        else
            satisfied = '[X]'
        end
        print(string.format("%s %s", flagname, satisfied))
    end

    if #all_flagsets > 0 then
        print("The event requires one of the following flagsets to be all true. True is indicated as [O]; False [X].")
        print(" -- ")
        for _, flagset in ipairs(all_flagsets) do
            local allSatisfied = true
            for _, flag in ipairs(flagset) do
                local satisfied
                if Osi.GetFlag(flag, getAvatar()) > 0 then
                    satisfied = '[O]'
                else
                    satisfied = '[X]'
                    allSatisfied = false
                end
                print(string.format("%s %s", satisfied, flag))
            end
            if allSatisfied then
                print(" (All True!)")
            end
            print(" -- ")
        end
    end


end

function filterFlagSet(name, flagsets)
    local results = {}
    for _, value in ipairs(flagsets) do
        if value[1] ~= name then
            goto continue
        end
        local result = {}
        for i, valueCond in ipairs(value) do
            if i ~= 1 then
                table.insert(result, valueCond)                
            end
        end
        table.insert(results, result)
        ::continue::
    end
    return results
end

function SetPartneredMinthara()
    StashPartneredStatus()
    SetFlag("ORI_State_PartneredWithMinthara_39ac48fa-b440-47e6-a436-6dc9b10058d8", getAvatar())
    RestorePartneredStatus()
    restoreStableRelationship()
    FixAll()
    PrintAll()
end
function SetDatingMinthara()
    print("Do not set dating minthara flag, this flag is evil!")
end
