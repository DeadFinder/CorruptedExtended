"use strict";

/**------------------------------------------------------------------------
 *                           Alchemist Pet Start Perk
 *------------------------------------------------------------------------**/

const alchemistPetPerkId = "StartAlchemistPet";
const alchemistPetDressName = "AlchemistPet";

KDUtilCommon.SetStatTexts(
    alchemistPetPerkId,
    "Alchemist Pet",
    'Start as a parole alchemist pet wandering around.'
);

KDCategoriesStart.push(
    {name: "CorruptedPerks", buffs: [], debuffs: [],}
);

addTextKey("KDCategoryCorruptedPerks","Corrupted Perks");
addTextKey(`KinkyDungeonInventoryItem${alchemistPetDressName}`,"Latex Alchemist Pet Outfit");
addTextKey(`KinkyDungeonInventoryItem${alchemistPetDressName}Desc`,"A latex kitten outfit covering everything but your stomach.");
addTextKey(`KinkyDungeonInventoryItem${alchemistPetDressName}Desc2`,"This outfit does not have an effect other than admitting you love being an Alchemist Pet~");

const alchemistPetPerk = {
    startPriority: 1000, category: "CorruptedPerks", id: alchemistPetPerkId, cost: -4, block: [], tags: ["start"]
}

KinkyDungeonStatsPresets[alchemistPetPerkId] = alchemistPetPerk;

KDPerkStart[alchemistPetPerkId] = () => {
    KDGameData.PrisonerState = 'parole';
    KinkyDungeonSetDress(alchemistPetDressName);
    if (!KinkyDungeonInventoryGet(alchemistPetDressName))
    {
        const alchemistOutfit = {name: alchemistPetDressName, id: KinkyDungeonGetItemID(), type: "Outfit"};
        KinkyDungeonInventoryAdd(alchemistOutfit);
    } 

    const alchemistRestraintsNeeded = 
    [
        KDModData.corruptedRestraints.corruptedAlchemistArmbinder,
        KDModData.corruptedRestraints.corruptedAlchemistBallGag,
        KDModData.corruptedRestraints.corruptedAlchemistCollar,
        KDModData.corruptedRestraints.corruptedAlchemistHeels,
        KDModData.corruptedRestraints.corruptedAlchemistCorset,  
        KDModData.corruptedRestraints.corruptedAlchemistLeash,  
    ]

    alchemistRestraintsNeeded.forEach(res => KinkyDungeonAddRestraintIfWeaker(res));
}

KDLoadPerks();