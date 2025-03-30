/**============================================
 *               Color Constants
 *=============================================**/

const corsetStrapColor = {"gamma":1,"saturation":0.01,"contrast":1,"brightness":1,"red":4.21,"green":0.784,"blue":2.941,"alpha":1}
const corsetColor = {"gamma":0.683,"saturation":0,"contrast":1.016,"brightness":0.449,"red":2.431,"green":2.352,"blue":2.64,"alpha":1}
const shoeColor = {"gamma":1,"saturation":1,"contrast":1.25,"brightness":1.40,"red":1,"green":1,"blue":1,"alpha":1}
const bandColor = {"gamma":1,"saturation":0.01,"contrast":1,"brightness":1,"red":1,"green":1,"blue":1,"alpha":1}

/**============================================
 *                  Constants
 *=============================================**/

const petDressName = "MaidPet"
const corruptedMaidName = "CorruptedMaid"
const corruptedMaidText = "Corrupted Maid"

const corruptedMaidDomFlag = "CorruptedMaidDom"
const dressingUpRestraint = "RopeSnakeHogtieWrist"

let mRestraints = {
    heels: "LeatherHeels",
    armbinder: "CorruptedMaidArmbinder",
    nippleWeights: "MaidNippleWeights",
    collar: "CorruptedMaidCollar",
    leash: "CorruptedMaidLeash",
    elbowShackles: "ElbowShackles"
}

let restraintsToAdd = [
    mRestraints.heels,
    "DusterGag",
    "MaidAnkleCuffs",
    "MaidAnkleCuffs2",
    "LegShackles",
    "LegShackles2",
    mRestraints.elbowShackles,
    "MaidBelt",
    mRestraints.armbinder,
    "MaidVibe",
    "MaidCBelt",
    mRestraints.nippleWeights,
    "TrapBra",
    mRestraints.collar,
    mRestraints.leash
]

/**======================
 *    Maid Pet Dress
 *========================**/

KDModelDresses[petDressName] = [
    {
        Item: "MaidCorsetFull", Group: "MaidCorsetFull", Color: "#53428D", Lost: false,
        Filters: {
            Corset: corsetColor,
            CorsetStraps: corsetStrapColor
        }
    },
    {
        Item: "WarriorSkirt", Group: "WarriorSkirt", Color: "#53428D", Lost: false,
        Filters: {
            Skirt: corsetStrapColor
        }
    },
    {
        Item: "MaidHairband", Group: "Hairband", Color: "#53428D", Lost: false,
    },
    {
        Item: "MaidWristBand", Group: "MaidWristBand", Color: "#53428D", Lost: false,
    },
    {
        Item: "Ribbon", Group: "Ribbon",
        Filters: {
            RibbonBelt: {"gamma":1.9,"saturation":0,"contrast":1,"brightness":1.5666666666666669,"red":1,"green":1,"blue":1.1,"alpha":1},
            RibbonBack: {"gamma":1.9,"saturation":0,"contrast":1,"brightness":1.5666666666666669,"red":1,"green":1,"blue":1.1,"alpha":1}
        }
    }
]

KinkyDungeonOutfitsBase.push({
    name: petDressName, dress: petDressName, shop: false, rarity: 4, 
    events: [{trigger: "calcEvasion", type: "AccuracyBuff", requiredTag: "mold", power: -5.0}]
})

KinkyDungeonRefreshOutfitCache()

/**============================================
 *                  Events
 *=============================================**/

KDEventMapEnemy.beforeDamage.corruptedMaid = (e, enemy, data) => {
    if (data.enemy === enemy && data.target === KinkyDungeonPlayerEntity && !data.restrainsAdded) {
        if (KinkyDungeonFlags.get(corruptedMaidDomFlag)) return;
        let restraintAdded = false;
        for (const restraintName of restraintsToAdd) {
            if (KDUtilCommon.PlayerWearsRestraint(restraintName)) continue;

            const restraint = KinkyDungeonGetRestraintByName(restraintName);
            if (!restraint) {
                console.log("Corrupted maid couldn't find the restraint with name: ", restraintName);
                continue;
            }
            if (KinkyDungeonAddRestraint(restraint)) {
                restraintAdded = true;
                break;
            }
        }
        if (!restraintAdded) {
            KinkyDungeonAttachTetherToEntity(1, enemy);

            let flagBuff = {
                id: corruptedMaidDomFlag, type: "Flag", duration: 10, power: 1, maxCount: 1, currentCount: 1, tags: ["attack", "cast"],
                events: [
                    {type: corruptedMaidDomFlag, trigger: "tickAfter"},
                ]
            };

            if (KinkyDungeonCurrentDress !== petDressName) {
                KinkyDungeonAddRestraint(KinkyDungeonGetRestraintByName(dressingUpRestraint));
                KinkyDungeonSendTextMessage(1, `${corruptedMaidText} pushes you to ground and begins changing your outfit!`, "white", 3);
                flagBuff.enemy = enemy;
            }
            KinkyDungeonSetFlag("PlayerDommed", 10);
            KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, flagBuff);
        }
    }
};

KDEventMapBuff.tickAfter[corruptedMaidDomFlag] = (e, buff, entity, data) => {
    if (buff.duration > 0 && entity.player) {
        if (!KinkyDungeonInventoryGet(mRestraints.collar)) {
            KDBreakTether(entity);
            KinkyDungeonExpireBuff(entity, corruptedMaidDomFlag);
            return;
        }
        if (buff.enemy && buff.duration === 5) {
            KinkyDungeonSetDress("None", "None");
            KinkyDungeonSendTextMessage(1, `${corruptedMaidText} snapped your current outfit into void.`, "white", 3);
        }
        KinkyDungeonSetFlag("PlayerDommed", 2);
    } else if (buff.enemy) {
        KDBreakTether(entity);
        KinkyDungeonSetDress(petDressName, petDressName);
        if (!KinkyDungeonInventoryGet(petDressName)) {
            let outfit = {name: petDressName, id: KinkyDungeonGetItemID(), type: "Outfit"};
            KinkyDungeonInventoryAdd(outfit);
        }
        KinkyDungeonMapParams[KinkyDungeonMapIndex[MiniGameKinkyDungeonCheckpoint]].defeat_outfit = petDressName;
        KinkyDungeonRemoveRestraintsWithName("RopeSnakeHogtieWrist");
        KinkyDungeonSendTextMessage(1, `${corruptedMaidText} has transformed your outfit! +(Corrupted Maid Pet Outfit)`, "white", 3);
        KinkyDungeonAttachTetherToEntity(2, buff.enemy);
        const tempLeashDuration = 20;
        KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, {
            id: corruptedMaidDomFlag, type: "Flag", duration: tempLeashDuration, power: 1, maxCount: 1, currentCount: 1, tags: ["attack", "cast"],
            events: [
                {type: corruptedMaidDomFlag, trigger: "tickAfter"},
            ]
        });
        KinkyDungeonSetFlag("TempLeash", tempLeashDuration);
        KinkyDungeonSetFlag("TempLeashCD", tempLeashDuration * 2);
        KinkyDungeonSetFlag("noResetIntent", 12);

        buff.enemy.playWithPlayerCD = tempLeashDuration;
        buff.enemy.IntentAction = "TempLeash";
    } else {
        KDBreakTether(entity);
        KinkyDungeonExpireBuff(entity, corruptedMaidDomFlag);
    }
};

/**============================================
 *               Enemies
 *=============================================**/

KDUtilCommon.KinkyDungeonCloneEnemy("Maidforce", corruptedMaidName, {
    playLine: "DomMaid", AI: "hunt", maxhp: 15,
    faction: "Corrupted",
    stealth: 2, bypass: true, failAttackFlag: [corruptedMaidDomFlag], ignoreFlag: [corruptedMaidDomFlag],
    dropTable: [
        {name: "Duster", weight: 5, ignoreInInventory: true},
        {name: "Gold", amountMin: 15, amountMax: 25, weight: 10}
    ],
    weight: -20,
    events: [
        {trigger: "beforeDamage", type: "corruptedMaid"},
    ],
    tags: KDMapInit(["nosub", "leashing", "tickleweakness", "imprisonable", "opendoors", "human", "melee", "corruptedMaid", "maid", "minor", "search"])
});

/**============================================
 *      Restraint Offers by Corrupted Maid
 *=============================================**/

const offerCorruptedMaidRestraint = "OfferCorruptedMaidRestraint";
const offerCorruptedMaid = "OfferCorruptedMaid";

KDDialogueTriggers[offerCorruptedMaidRestraint] = KDDialogueTriggerOffer(
    offerCorruptedMaidRestraint, ["Illusion"], ["corruptedMaid"],
    ["parole", ""], ["Sub", "Brat"],
    ["maid"], undefined, undefined, ["zombie", "skeleton", "robot"],
    undefined, undefined
);

KDDialogue[offerCorruptedMaidRestraint] = KDYesNoBasic(
    offerCorruptedMaidRestraint, ["Illusion"], ["Ghost"], ["corruptedMaid"], [55, 0, 75, 0], [-25, 0, 40, 15], 1, 2
);

KDDialogue[offerCorruptedMaid] = KDRecruitDialogue(
    offerCorruptedMaid, "Corrupted", petDressName, "Illusion", ["maidVibeRestraints", "corruptedMaid"], 5, ["maidVibeRestraints", "corruptedMaid"], 13, ["corruptedMaid"], undefined, ["submissive"], 0.5
);

/**============================================
 *                  Models
 *=============================================**/

KDUtilCommon.CloneModel("LeatherGloveLeft", "MaidBandLeft", {
    Filters: {
        "RimLeft": {"gamma":1,"saturation":1,"contrast":1,"brightness":3.18,"red":1,"green":1,"blue":1,"alpha":1},
        "BandLeft": {"gamma":1,"saturation":1,"contrast":1,"brightness":0.25,"red":1,"green":1,"blue":1,"alpha":1}
    },
    Layers: ToLayerMap([
        { Name: "RimGloveLeft", Layer: "GloveLeft", Pri: 8.1,
            Poses: ToMap([...ARMPOSES]),
            InheritColor: "RimLeft",
            NoOverride: true,
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
        },
        { Name: "RimForeGloveLeft", Layer: "ForeGloveLeft", Pri: 8.1,
            Poses: ToMap([...FOREARMPOSES]),
            InheritColor: "RimLeft",
            NoOverride: true,
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
            SwapLayerPose: {Crossed: "CrossGloveLeft"},
        },
        { Name: "BandGloveLeft", Layer: "GloveLeft", Pri: 8.1,
            Poses: ToMap([...ARMPOSES]),
            InheritColor: "BandLeft",
            NoOverride: true,
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
        },
        { Name: "BandForeGloveLeft", Layer: "ForeGloveLeft", Pri: 8.1,
            Poses: ToMap([...FOREARMPOSES]),
            InheritColor: "BandLeft",
            NoOverride: true,
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
            SwapLayerPose: {Crossed: "CrossGloveLeft"},
        },
    ])
});

KDUtilCommon.CloneModel("LeatherGloveRight", "MaidBandRight", {
    Filters: {
        "RimRight": {"gamma":1,"saturation":1,"contrast":1,"brightness":3.18,"red":1,"green":1,"blue":1,"alpha":1},
        "BandRight": {"gamma":1,"saturation":1,"contrast":1,"brightness":0.25,"red":1,"green":1,"blue":1,"alpha":1}
    },
    Layers: ToLayerMap([
        { Name: "RimGloveRight", Layer: "GloveRight", Pri: 8.1,
            Poses: ToMapSubtract([...ARMPOSES], ["Wristtie"]),
            InheritColor: "RimRight",
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
        },
        { Name: "RimForeGloveRight", Layer: "ForeGloveRight", Pri: 8.1,
            Poses: ToMap([...FOREARMPOSES]),
            InheritColor: "RimRight",
            NoOverride: true,
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
            SwapLayerPose: {Crossed: "CrossGloveRight"},
        },
        { Name: "BandGloveRight", Layer: "GloveRight", Pri: 8.1,
            Poses: ToMapSubtract([...ARMPOSES], ["Wristtie"]),
            InheritColor: "BandRight",
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
        },
        { Name: "BandForeGloveRight", Layer: "ForeGloveRight", Pri: 8.1,
            Poses: ToMap([...FOREARMPOSES]),
            InheritColor: "BandRight",
            NoOverride: true,
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
            SwapLayerPose: {Crossed: "CrossGloveRight"},
        },
    ])
});

KDUtilCommon.CloneModel("LeatherGloves", "MaidWristBand", {
    Categories: ["Accessories"],
    Filters: {
        "RimLeft": {"gamma":1,"saturation":1,"contrast":1,"brightness":3.18,"red":1,"green":1,"blue":1,"alpha":1},
        "BandLeft": {"gamma":1,"saturation":1,"contrast":1,"brightness":0.25,"red":1,"green":1,"blue":1,"alpha":1},
        "RimRight": {"gamma":1,"saturation":1,"contrast":1,"brightness":3.18,"red":1,"green":1,"blue":1,"alpha":1},
        "BandRight": {"gamma":1,"saturation":1,"contrast":1,"brightness":0.25,"red":1,"green":1,"blue":1,"alpha":1}
    },
    Layers: ToLayerMap([
        ...GetModelLayers("MaidBandLeft"),
        ...GetModelLayers("MaidBandRight"),
    ])
});

/**============================================
 *                Restraints
 *=============================================**/

KinkyDungeonCloneRestraint("NippleClamps2", mRestraints.nippleWeights, {
    Model: "NippleWeights",
    enemyTags: {"corruptedMaid": 1, "maidVibeRestraints": 0}
});

KinkyDungeonCloneRestraint("LatexBoots", mRestraints.heels, {
    Model: "LeatherHeels",
    Filters: {
        Shoe: shoeColor,
    },
    hobble: 0.8,
    enemyTags: {"leatherHeels": 10, "corruptedMaid": 15, "leatherRestraints": 1},
    shrine: ["Leather", "Illusion"]
});

KinkyDungeonCloneRestraint("MaidDress", mRestraints.armbinder, {
    forceOutfit: "",
    forceOutfitPriority: 0,
    alwaysDressModel: [],
    Model: "Jacket",
    addPose: ["PreferWristtie"],
    enemyTags: {"corruptedMaid": 1},
});

KinkyDungeonCloneRestraint("MaidCollar", mRestraints.collar, {
    Filters: { // Исправлено "Filter" на "Filters" для соответствия новому синтаксису
        Bow: corsetStrapColor,
        Band: bandColor,
        Bell: bandColor
    },
    enemyTags: {"corruptedMaid": 10},
    events: [
        {trigger: "tick", type: "checkForDress", power: -0.025, inheritLinked: true}
    ]
});

KinkyDungeonCloneRestraint("BasicLeash", mRestraints.leash, {
    Filters: {
        Leash: corsetStrapColor,
    },
    enemyTags: {"corruptedMaid": 5},
});

KinkyDungeonRestraints.push({
    inventory: true, name: mRestraints.elbowShackles, debris: "Chains", Asset: "LeatherElbowCuffs",
    LinkableBy: [...KDBindable, ...KDDevices], sfxGroup: "Handcuffs", Model: "ShacklesElbows",
    Group: "ItemArms", Type: "Chained", Color: ["Default", "#888888", "#AAAAAA"], power: 3,
    escapeChance: {"Struggle": -0.1, "Cut": -0.3, "Remove": 10, "Pick": 5},
    enemyTags: {"shackleRestraints": 2}, enemyTagsMult: {handcuffer: 0.2, Unchained: 0.1},
    weight: 2, playerTags: {"ItemArmsFull": -2, "ItemArmsEmpty": 5},
    playerTagsMult: {Metal: 2}, playerTagsMissing: {Metal: -5}, playerTagsMissingMult: {Metal: 0.2},
    minLevel: 0, allFloors: true, shrine: ["Metal", "Cuffs"]
});

window.SetMaidDress = () => {
    KinkyDungeonSetDress(petDressName, petDressName);
    for (const restraintName of restraintsToAdd) {
        const restraint = KinkyDungeonGetRestraintByName(restraintName);
        if (!restraint) {
            console.log(restraintName, "not found");
            continue;
        }
        KinkyDungeonAddRestraint(restraint);
    }
};

/**============================================
 *               Outfit Texts
 *=============================================**/

addTextKey("KinkyDungeonInventoryItemMaidPet", "Corrupted Pet Maid Uniform");
addTextKey("KinkyDungeonInventoryItemMaidPetDesc", "A skippy dress meant to denote a pet maid's status.");
addTextKey("KinkyDungeonInventoryItemMaidPetDesc2", "Massively decreases accuracy against slime mold, but also decreases all slime mold's accuracy.");

/**============================================
 *               Offer Texts
 *=============================================**/

addTextKey("rOfferCorruptedMaid", "Wear this up and don't you dare complain.");
addTextKey("rOfferCorruptedMaidYes", "Just put the pretties. Its simple, right?");
addTextKey("rOfferCorruptedMaidNo", "Whatever.");
addTextKey("rOfferCorruptedMaidYes_No", "Wasting my time eh?");
addTextKey("rOfferCorruptedMaidYes_Yes", "Now your talking!");

addTextKey("rOfferCorruptedMaidRestraint", "Wear this up and don't you dare complain.");
addTextKey("rOfferCorruptedMaidRestraintForceYes", "But i think this will perfectly fit on you!");
addTextKey("rOfferCorruptedMaidRestraintForce_Yes", "Enjoy your time!");
addTextKey("rOfferCorruptedMaidRestraintForceNo", "Ehh.. not that time.");
addTextKey("rOfferCorruptedMaidRestraintForce_No", "Ehh.. not that time.");
addTextKey("rOfferCorruptedMaidRestraint_Yes", "Just put the pretties. Its simple, right?");
addTextKey("rOfferCorruptedMaidRestraint_No", "Whatever.");
addTextKey("rOfferCorruptedMaidRestraintYes_No", "Wasting my time eh?");
addTextKey("rOfferCorruptedMaidRestraintYes_Yes", "Now your talking!");

addTextKey("dOfferCorruptedMaidRestraint_Yes", "(Think) Hmm... What could happen...");
addTextKey("dOfferCorruptedMaidRestraint_YesGag", "(Moan and nod)");
addTextKey("dOfferCorruptedMaidRestraint_No", "I\'ll pass.");
addTextKey("dOfferCorruptedMaidRestraint_NoGag", "(Shake your head and frown)");
addTextKey("dOfferCorruptedMaidRestraintForce_Yes", "(Think) Hmm... I don\'t think that something bad can happen..");
addTextKey("dOfferCorruptedMaidRestraintForce_No", "No!");
addTextKey("dOfferCorruptedMaidRestraintForce_YesGag", "(Moan and nod)");
addTextKey("dOfferCorruptedMaidRestraintForce_NoGag", "(Panickly shake your head)");

addTextKey("dOfferCorruptedMaidYes_Yes", "Sign me up!");
addTextKey("dOfferCorruptedMaidYes_YesGag", "(Accept the contract)");
addTextKey("dOfferCorruptedMaidYes_No", "W-where did you get that uniform? (Refuse)");
addTextKey("dOfferCorruptedMaidYes_NoGag", "(Refuse the contract)");

/**============================================
 *               Common Texts
 *=============================================**/

KDUtilCommon.SetEnemyNameText(corruptedMaidName, corruptedMaidText);
KDUtilCommon.SetEnemyAttackText(corruptedMaidName, `${corruptedMaidText} tickles your body...`);
KDUtilCommon.SetEnemyAttackWithBindText(corruptedMaidName, `${corruptedMaidText} binds you with (+RestraintAdded)!`);
KDUtilCommon.SetEnemyLockText(corruptedMaidName, `${corruptedMaidText} seals some locks your restraint!`);

KinkyDungeonAddRestraintText(
    mRestraints.nippleWeights, "Maid Nipple Weights",
    "Nipple weights crafted by some secret maid labs.",
    "Wait... Your telling me this wasn't a thing before?"
);

KinkyDungeonAddRestraintText(
    mRestraints.heels, "Leather Heels",
    "Long heels made of leather.",
    "These make you some hobble."
);

KinkyDungeonAddRestraintText(
    mRestraints.armbinder, "Corrupted Maid Armbinder",
    "Tight and secure as a maid servant.",
    "To give you a some sense of duty."
);

KinkyDungeonAddRestraintText(
    mRestraints.elbowShackles, "Elbow Shackles",
    "Metal shackles covering your elbows.",
    "Hard and chunky stuff keeping you secure."
);

KinkyDungeonAddRestraintText(
    mRestraints.collar, "Corrupted Maid Pet Collar",
    "A leather collar to mark serving maid pets.",
    "Its actually not bad to serve as a maid."
);

KinkyDungeonAddRestraintText(
    mRestraints.leash, "Corrupted Maid Leash",
    "A leash to keep you controlled.",
    "They can anchor on this to keep you on spot."
);