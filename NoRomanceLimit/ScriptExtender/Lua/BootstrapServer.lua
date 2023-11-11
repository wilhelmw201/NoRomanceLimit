Ext.Require("Utils.lua")
Ext.Require("Fixes.lua")
Ext.Require("FlagsFcns.lua")
Ext.Require("UserFcns.lua")
Ext.Require("ScheduleN.lua")
FullPrint = false

PersistentVars = {false, false, false, false, false, 
                  false, false, false, -- toon relationship flag
                  false, -- 9what is this? 
                  0, -- 10stable relationship counter 
                  false, -- 11Minthara dating flag,
                  false,  -- 12restore at the end/start of the next dialog.
                }

eMinthara = 1
eGale = 2
eWyll = 3
eAstarion = 4
eKarlach = 5
eShadowHeart = 6
eLaezel = 7
eHalsin = 8

isPartneredFlag = "ORI_State_Partnered_6c1a31e8-1d3d-42a5-af4f-72ef7a798f74"

listMainCompanionDialogEntry = {
    {"Minthara_InParty_13d72d55-0d47-c280-9e9c-da076d8876d8",eMinthara},
    {"Gale_InParty2_6beb1b10-845f-49fa-6d6d-f425eaa42574", eGale},
    {"Wyll_InParty_6dff0a1f-1a51-725d-6e9a-52b5742ba9e6", eWyll},
    {"Astarion_InParty_53aba16e-55bb-a0fc-a444-522e237dbe46", eAstarion},
    {"Karlach_InParty_12459660-b66e-9b0b-9963-670e0993543d", eKarlach},
    {"ShadowHeart_InParty_95ca3833-09d0-5772-b16a-c7a5e9208fe5",eShadowHeart},
    {"Laezel_InParty2_93bf58f5-5111-9730-1ee2-62dfb0b00c96",eLaezel}
}

listOfAllFirstSecondRomance = {
    "CAMP_AstarionHunger_SCO_Companion_359981f9-d660-96e2-3e94-218e92d5e479", 
    "CAMP_Shadowheart_Romance1_SD_Invitation_b33a13f6-5550-c891-a92b-4d6cf916a445", 
    "CAMP_Astarion_Romance1_SD_Invitation_d0b45fa8-138a-1939-9ce3-0fae91864feb", 
    "CAMP_BurningUpForYou_CFM_ROM_a5177ed5-add2-f4f2-18b1-18d134d8aab6", 
    "CAMP_Astarion_SD_ROM_SecondNight_693a16c6-9b9d-fee9-db37-7207ab63c913",  
    "CAMP_GalesLastNightAlive_SD_ROM_e6067557-2187-7493-c9b6-363ef6dd8334",
    "CAMP_Karlach_SD_ROM_ForgingOfTheHeart_c2fbbf85-71d0-d4aa-07df-21abbb9f303a", 
    "CAMP_Astarion_SD_ROM_BloodMerchantAftermath_30d45668-4bcf-d514-5e04-5f843d1b538b", 
    "CAMP_Wyll_CRD_HavenRomance_859821c9-666b-6f28-f59c-0394f49b0281",  
    "CAMP_Wyll_SD_HavenRomance_ROM_859821c9-666b-6f28-f59c-0394f49b0281",
    "CAMP_Laezel_Romance1_SD_Invitation_264413a4-e515-8e4d-3755-3f84c3fb1b11",
    "CAMP_Laezel_ROM_SleepingSecondNight_b1ebeae3-7a76-5d36-4506-f30d0bfdc965", 
    "CAMP_Laezel_ROM_SD_Romance2_WokenUpByLaezel_ce8ea48c-688d-7484-283f-c801c82172b3",
}

origin_names = {
    "Minthara","Gale", "Wyll", "Astarion", "Karlach", "ShadowHeart", "Laezel",  "Halsin"
}
origin_uuids = {
    "S_GOB_DrowCommander_25721313-0c15-4935-8176-9f134385451b",
    "S_Player_Gale_ad9af97d-75da-406a-ae13-7071c563f604",
    "S_Player_Wyll_c774d764-4a17-48dc-b470-32ace9ce447d",
    "S_Player_Astarion_c7c13742-bacd-460a-8f65-f864fe41f255",
    "S_Player_Karlach_2c76687d-93a2-477b-8b18-8a14b549304c",
    "S_Player_ShadowHeart_3ed74f06-3c60-42dc-83f6-f034cb47c679",
    "S_Player_Laezel_58a69333-40bf-8358-1d17-fff240d7fb12",
    "S_GLO_Halsin_7628bc0e-52b8-42a7-856a-13a6fd413323"
} 
date_flags = {
    "ORI_State_DatingMinthara_de1360cd-894b-40ea-95a7-1166d675d040",
    "ORI_State_DatingGale_75d0e041-c16c-d089-6d89-64354fa4c9d9",
    "ORI_State_DatingWithWyll_f1520748-1d36-4500-9f8a-0da4207f8dd5",
    "ORI_State_DatingAstarion_ba298c56-26b6-4918-9bd4-616668d369d8",
    "ORI_State_DatingKarlach_f24c3f3e-7287-4908-84bf-ba314921f5ee",
    "ORI_State_DatingShadowheart_e87f1e21-a758-47ae-8c0e-9e715eb289b5",
    "ORI_State_DatingLaezel_86eaa84a-350b-401b-8b43-b53eeb534579",
    ""
}
partner_flags = {
    "ORI_State_PartneredWithMinthara_39ac48fa-b440-47e6-a436-6dc9b10058d8",
    "ORI_State_PartneredWithGale_e008e20d-d642-42ed-9008-297b6273aa21",
    "ORI_State_PartneredWithWyll_5db4c1b6-3c42-43ae-aa85-1844acbf5a1d",
    "ORI_State_PartneredWithAstarion_30819c8d-b39d-42e7-acd1-2a8c2c309994",
    "ORI_State_PartneredWithKarlach_d9ff60fa-0af9-45d7-99b4-bd7c3f80ed12",
    "ORI_State_PartneredWithShadowheart_3808ae35-ad4e-465b-800b-63d32b77211e",
    "ORI_State_PartneredWithLaezel_d169a786-6e56-4f0d-a2eb-33c48d8d1160",
    "ORI_State_PartneredWithHalsin_7b53fe60-bb16-48a9-ae5c-9bce1dfac1a9",
}
waspartner_flags = {
    "ORI_State_WasPartneredWithMinthara_8d0460d6-b00a-4947-bbd0-ad0c085a530f",
    "ORI_State_WasPartneredWithGale_60e14eb3-cce6-43c3-b893-b9b687e3d88f",
    "ORI_State_WasPartneredWithWyll_2652ff35-a62d-4947-b14b-11050ccfd329",
    "ORI_State_WasPartneredWithAstarion_5a60943f-979b-4120-9b60-9e9b29529402",
    "ORI_State_WasPartneredWithKarlach_48f2a4d4-23f4-4514-b894-e225152d7a48",
    "ORI_State_WasPartneredWithShadowheart_542e6cf4-bfd1-471d-b4b5-693d630376cb",
    "ORI_State_WasPartneredWithLaezel_6d402d9b-7af9-43ea-b0eb-98e9612dde27",
    "ORI_State_WasPartneredWithHalsin_ee6b727d-243e-4189-b572-1d782ea78df8",
}


Ext.Osiris.RegisterListener("DialogStarted", 2, "before", function(dialog, instanceid)


    DPrint(string.format("DialogStarted %s, %s", dialog, instanceid))

    if isInList(dialog, listOfAllFirstSecondRomance) then
        StashPartneredStatus(true)
        ClearPartnerships()
        FixAfterFlagToggling()
    elseif dialog == 'Halsin' then
        StashPartneredStatus(true)
    else
        for _, value in ipairs(listMainCompanionDialogEntry) do
            if value[1] == dialog then
                StashPartneredStatus(true)
                ClearPartnerships({eHalsin, value[2]})
                FixAfterFlagToggling()
                break
            end
        end
    end
    
    
end)

Ext.Osiris.RegisterListener("DialogEnded", 2, "after", function(dialog, instanceid)

    DPrint(string.format("DialogEnded %s, %s", dialog, instanceid))

    MinthyFixNew() -- bug in se causes flags to be weird when set in dialog directly?
    FixPartneredDBAndFlags()


    if isInList(dialog, listOfAllFirstSecondRomance) then

        RestorePartneredStatus()
        FixAfterFlagToggling()

    elseif dialog == "CAMP_MizoraMorningAfter_CFM_ROM_69ddc432-0293-98b1-e512-baff8b160f12" then
        RestorePartneredStatus()
        FixAfterFlagToggling()

    elseif dialog == 'Halsin' then
        RestorePartneredStatus(eHalsin)
        FixAfterFlagToggling()
    else
        for _, value in ipairs(listMainCompanionDialogEntry) do
            if value[1] == dialog then
                DPrint(value[1])
                RestorePartneredStatus(value[2])
                FixAfterFlagToggling()

                DPrintAll()

                break
            end
        end
    end

    StashPartneredStatus(true)
    
    
end)

-- Ext.Osiris.RegisterListener("DialogStartRequested", 2, "before", function(target, player)
--     _D(target)
--     _D(player)
-- end)

Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function ()
    FixPersistentVars()
    FixAll()
    StashPartneredStatus(true)
    Osi.DB_Dialogs_StartDatingDialog:Delete(nil)

end)


-- this is when you start long rest
Ext.Osiris.RegisterListener("RequestEndTheDaySuccess", 0, "before", function () 
    DPrint("RequestEndTheDaySuccess")
    RestorePartneredStatus()
    restoreStableRelationship()
    Fix_Databases() -- once per game
    FixAll()
end)

-- Ext.Osiris.RegisterListener("LongRestStarted", 0, "before", function ()
--     DPrint("LongRestStarted")
--     StashPartneredStatus(true)
-- end)

Ext.Osiris.RegisterListener("FlagSet", 3, "after", function(flag, speaker, dialogInstance)
    DPrint(string.format("FlagSet %s %s %s", flag, speaker, dialogInstance))

    if flag == "ORI_State_DatingMinthara_de1360cd-894b-40ea-95a7-1166d675d040" then
        MinthyFixNew()
    end
    if #Osi.DB_Avatars:Get(nil) > 0 then
        FixPartneredDBAndFlags()
    end
end)
Ext.Osiris.RegisterListener("FlagSet", 3, "before", function(flag, speaker, dialogInstance)
    DPrint(string.format("FlagSetBB %s %s %s", flag, speaker, dialogInstance))
end)
-- Ext.Osiris.RegisterListener("FlagCleared", 3, "after", function(flag, speaker, dialogInstance)
--     DPrint(string.format("FlagCleared %s %s %s", flag, speaker, dialogInstance))
-- end)
Ext.Osiris.RegisterListener("FlagCleared", 3, "before", function(flag, speaker, dialogInstance)
    DPrint(string.format("FlagClearedBB %s %s %s", flag, speaker, dialogInstance))
end)

-- band aid for minthara, unbelievable I have to do this
-- Ext.Osiris.RegisterListener("LongRestFinished", 0, "after", function()
--     DPrint("LongRestFinished")
--     Osi.RealtimeObjectTimerLaunch(getAvatar(), "NoRomanceLimitAfterLongRest", 200)
    
-- end)

-- Ext.Osiris.RegisterListener("ObjectTimerFinished", 2, "after", function(object, timer)
--     if timer == 'NRLRestoreAllOthers' then
--         DPrint("ObjectTimerFinished/NRLRestoreAll")
--         DPrint(object)

--         RestorePartneredStatus(eMinthara)

--     elseif timer == "NoRomanceLimitAfterLongRest" then
--         DPrint("ObjectTimerFinished/NoRomanceLimitAfterLongRest")
--         DPrintAll()
--         --     FixAll()
--         RestorePartneredStatus()
--         stableRelationshipAdvance()
--         ClearUnusedDatingFlags()
--         FixPartneredDBAndFlags()
--         ClearDumpDialogs()
--         DPrintAll()
--         PersistentVars[12] = true
    
--     end
-- end)



print("NoRomanceLimit Mod V8.31 Loaded!")
print("When you upgrade this mod, do not load a save that is in the middle of a conversation.")
print("Please report unexpected behavior to nexusmods.com/baldursgate3/mods/1529?tab=posts")
