// Mod by: Matsuo
// commonFunctions.ks required to use KDCommonUtils functions!

function ToArrayDeepSearch(startObj, arr = []) {
    for (const key of Object.keys(startObj)) {
        const val = startObj[key];
        if (typeof val !== "object") {
            arr.push(val);
        } else {
            ToArrayDeepSearch(val, arr);
        }
    }
    return arr;
}

function AddAlchemistSet() {
    ToArrayDeepSearch(aRestraints).forEach(val => KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(val))); // Уточнён вызов
    KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(aRestraints.heels + '2')); // add heels2
    KinkyDungeonSetDress(petDressName, petDressName); // Добавлен второй аргумент
}

window.AddAlchemistSet = AddAlchemistSet;

// #region Constants

const aRestraints = {
    corset: "AlchemistPetCorset",
    harness: "AlchemistPetHarness",
    gags: {
        ballGag: "AlchemistPetBallGag",
        panelGag: "AlchemistPetPanelGag",
        harnessPanelGag: "AlchemistPetHarnessPanelGag"
    },
    collar: "AlchemistPetCollar",
    leash: "AlchemistPetLeash",
    heels: "AlchemistPetHeels",
    armbinder: "AlchemistPetArmbinder",
    armBelts: "AlchemistPetArmBelts"
};

const iRestraints = {
    plug: "InspectorPlug"
};

let restraintNameTexts = {};

restraintNameTexts[aRestraints.corset] = "Latex Pet Corset";
restraintNameTexts[aRestraints.harness] = "Alchemist Pet Harness";
restraintNameTexts[aRestraints.gags.ballGag] = "Latex Pet Ball Gag";
restraintNameTexts[aRestraints.gags.panelGag] = "Latex Pet Panel Gag";
restraintNameTexts[aRestraints.gags.harnessPanelGag] = "Alchemist Pet Harness Panel Gag";
restraintNameTexts[aRestraints.collar] = "Alchemist Pet Collar";
restraintNameTexts[aRestraints.leash] = "Alchemist Pet Leash";
restraintNameTexts[aRestraints.heels] = "Alchemist Pet Heels";
restraintNameTexts[aRestraints.armbinder] = "Latex Pet Armbinder";
restraintNameTexts[aRestraints.armBelts] = "Alchemist Pet Arm Belts";
restraintNameTexts[iRestraints.plug] = "Alchemist Plug";

const aRestraintsNeed = [
    aRestraints.corset,
    aRestraints.gags.ballGag,
    aRestraints.collar,
    aRestraints.heels,
    aRestraints.armbinder,
    aRestraints.leash,
];

const corruptedAlchemistName = "CorruptedAlchemist";
const alchemistInspectorName = "AlchemistInspector";

const corruptedAlchemistText = "Corrupted Alchemist";
const alchemistInspectorText = "Alchemist Inspector";

const alchemistDommedFlag = "AlchemistDommed";
const alchemistDomFlag = "AlchemistDom";
const alchemistFactionDomFlag = "AlchemistFactionDom";
const alchemistDomRefreshFlag = "AlchemistDomRefresh";
const inspectorPlayFlag = "InspectorPlay";

const alchemistBindSpell = "AmpulePurple";

const linkItemEvent = "linkItemCustom";
const drainStaminaEvent = "drainStamina";
const drainStaminaCost = 20;
const linkItemEventParent = "hit";
const drainStaminaEventParent = "tick";

const petRestraintTag = "AlchemistPet";
const petRestraintWithSpellTag = "AlchemistSpell";
const petDressName = "AlchemistPet";

const perkId = "AlchemistPet";

// #region Colors

const alchemistLatexCatsuitColor = {"gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.55, "red": 1.63, "green": 3.06, "blue": 3.86, "alpha": 1};
const alchemistLatexCorsetColor = {"gamma": 1, "saturation": 0.25, "contrast": 1, "brightness": 2.31, "red": 1, "green": 1.68, "blue": 2.06, "alpha": 1};
const heelShoeColor = {"gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.25, "red": 1, "green": 1, "blue": 1, "alpha": 1};
const heelSoleColor = {"gamma": 1, "saturation": 0.25, "contrast": 1, "brightness": 2.28, "red": 0.53, "green": 0.85, "blue": 1.3, "alpha": 1};
const collarColor = {"gamma": 1, "saturation": 0.016666666666666666, "contrast": 1, "brightness": 2.28, "red": 0.53, "green": 0.85, "blue": 1.3, "alpha": 1};

// #region Models

AddModel({
    Name: "TransparentCatsuitCroppedLowRise",
    TopLevel: false,
    Parent: "TransparentCatsuit",
    Categories: ["Suits"],
    Folder: "Catsuit",
    Filters: {
        TorsoUpper: {"gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1, "red": 1, "green": 1, "blue": 1, "alpha": 0.53},
        TorsoLower: {"gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1, "red": 1, "green": 1, "blue": 1, "alpha": 0.53},
    },
    Layers: ToLayerMap([
        ...GetModelLayersNoOverride("CatsuitUpperCropped"),
        ...GetModelLayersNoOverride("CatsuitLowerLowRise"),
    ]),
});

KDModelDresses[petDressName] = [
    {
        Item: "TransparentCatsuitCroppedLowRise", Group: "Catsuit", Color: "#53428D", Lost: false,
        Filters: {
            TorsoUpper: alchemistLatexCatsuitColor,
            TorsoLower: alchemistLatexCatsuitColor
        }
    },
    {
        Item: "KittyEars", Group: "Kitty", Color: "#53428D", Lost: false,
        Filters: {
            Ears: {"gamma": 0.616, "saturation": 1, "contrast": 1, "brightness": 0.35, "red": 1, "green": 1, "blue": 1, "alpha": 1},
            InnerEars: {"gamma": 1.76, "saturation": 1, "contrast": 2.13, "brightness": 0.21, "red": 1.63, "green": 3.06, "blue": 3.86, "alpha": 1}
        }
    },
];

KinkyDungeonOutfitsBase.push({
    name: petDressName, dress: petDressName, shop: false, rarity: 4,
    events: []
});

KinkyDungeonRefreshOutfitCache(); // Добавлено для обновления кэша

// #region Restraints

KDUtilCommon.CreateRestraintIfNotExist("WolfAnkleCuffs2", {
    debris: "Chains", accessible: true, Asset: "FuturisticAnkleCuffs", UnLink: "WolfAnkleCuffs", LinkableBy: ["AnkleCuffsBase", ...KDBindable], Type: "Closed",
    Color: ['#4F91DE', '#4F91DE', '#3F6945', '#000000'], Group: "ItemFeet", blockfeet: true, addTag: ["FeetLinked"], power: 8, weight: 0,
    Model: "AnkleLink", alwaysRender: true, linkSize: 0.6, linkCategory: "AnkleLink",
    escapeChance: {"Struggle": -0.5, "Cut": -0.5, "Remove": 0.4, "Pick": 0.15},
    enemyTags: {}, playerTags: {}, minLevel: 0, allFloors: true, shrine: ["Metal", "Cuffs"],
    events: [
        {trigger: "postUnlock", type: "RequireLocked", inheritLinked: true},
        {trigger: "remove", type: "unlinkItem"},
        {trigger: "postRemoval", type: "RequireBaseAnkleCuffs"}
    ]
});

KDUtilCommon.TryCloneRestraint("LatexCorset", aRestraints.corset, {
    Filters: {
        Corset: alchemistLatexCorsetColor,
        Bra: alchemistLatexCorsetColor
    },
    inaccessible: false, deepAccessible: false,
    Link: aRestraints.harness,
    LinkableBy: ["AlchemistPetHarness"],
    linkSize: 0.4,
    enemyTags: {"AlchemistPet": 20, "AlchemistSpell": 20},
    alwaysRender: true,
    events: [
        {trigger: linkItemEventParent, type: linkItemEvent, chance: 0.1, subMult: 0.5, tags: ["lowwill"]}
    ]
});

KDUtilCommon.TryCloneRestraint("TrapHarness", aRestraints.harness, {
    LinkableBy: [...KDHarnessLink, "inspectorToys"],
    linkSize: 0.4, debris: "", shrine: ["AlchemistPet", "AlchemistPetHarness", "Leather", "Harnesses"], trappable: false
});

KDUtilCommon.TryCloneRestraint("TrapBoots", aRestraints.heels, {
    Model: "ShinyBalletHeels",
    Filters: {
        Shoe: heelShoeColor,
        Sole: heelSoleColor
    },
    linkSize: 0.4,
    Link: `${aRestraints.heels}2`,
    enemyTags: {"AlchemistPet": 10}, debris: "", shrine: ["AlchemistPet", "PetHeelsBase", "Metal"], trappable: false,
    events: [
        {trigger: linkItemEventParent, type: linkItemEvent, sfx: "LightJingle", chance: 0.1, subMult: 0.5, tags: ["lowwill"]}
    ]
});

KDUtilCommon.TryCloneRestraint("WolfAnkleCuffs2", `${aRestraints.heels}2`, {
    UnLink: aRestraints.heels,
    LinkableBy: ["PetHeelsBase"],
    enemyTags: {},
    events: [
        {trigger: "remove", type: "unlinkItem"}
    ],
    shrine: ["Metal"]
});

KDUtilCommon.TryCloneRestraint("BasicCollar", aRestraints.collar, {
    Filters: {
        Band: collarColor
    },
    enemyTags: {"AlchemistPet": 20, "AlchemistSpell": 20}
});

KDUtilCommon.TryCloneRestraint("BasicLeash", aRestraints.leash, {
    Filters: {
        Leash: collarColor
    },
    enemyTags: {"AlchemistPet": 20, "AlchemistSpell": 20}
});

KDUtilCommon.TryCloneRestraint("LatexBallGag", aRestraints.gags.ballGag, {
    enemyTags: {"AlchemistPet": 20, "AlchemistSpell": 20}, linkSize: 0.25, Link: aRestraints.gags.panelGag,
    events: [
        {trigger: linkItemEventParent, type: linkItemEvent, chance: 0.1, subMult: 0.5, tags: ["lowwill"]}
    ],
    playerTags: {}
});

KDUtilCommon.TryCloneRestraint("PanelGag", aRestraints.gags.panelGag, {
    UnLink: aRestraints.gags.ballGag, Link: aRestraints.gags.harnessPanelGag, linkSize: 0.25,
    enemyTags: {},
    Filters: {
        Panel: alchemistLatexCatsuitColor
    },
    events: [
        {trigger: linkItemEventParent, type: linkItemEvent, chance: 0.1, subMult: 0.5, tags: ["lowwill"]},
        {trigger: "remove", type: "unlinkItem"}
    ]
});

KDUtilCommon.TryCloneRestraint("HarnessPanelGag", aRestraints.gags.harnessPanelGag, {
    UnLink: aRestraints.gags.panelGag, linkSize: 0.25,
    Filters: {
        Panel: alchemistLatexCatsuitColor
    },
    enemyTags: {},
    events: [
        {trigger: "remove", type: "unlinkItem"}
    ],
    shrine: ["Harnesses", "Gags"]
});

KDUtilCommon.TryCloneRestraint("LatexArmbinder", aRestraints.armbinder, {
    enemyTags: {"AlchemistPet": 10}, Link: aRestraints.armBelts, linkSize: 0.4,
    events: [
        {trigger: linkItemEventParent, type: linkItemEvent, chance: 0.1, subMult: 0.5, tags: ["lowwill"]},
        {trigger: "beforePlayerDamage", type: linkItemEvent, chance: 0.1, subMult: 0.5, tags: ["lowwill"]}
    ]
});

KDUtilCommon.TryCloneRestraint("SturdyLeatherBeltsArms", aRestraints.armBelts, {
    enemyTags: {}, UnLink: aRestraints.armbinder, linkSize: 0.4,
    events: [
        {trigger: "remove", type: "unlinkItem"},
        {trigger: drainStaminaEventParent, type: drainStaminaEvent},
        {trigger: "remove", type: "clearStaminaEvent"}
    ],
    shrine: ["Leather"]
});

KDUtilCommon.TryCloneRestraint("TrapPlug", iRestraints.plug, {
    alwaysRender: true,
    enemyTags: {"inspectorToys": 100}, vibeLocation: "ItemVulva", power: 3, playerTags: {},
    events: [
        {trigger: "beforeStruggleCalc", type: "vibeStruggle", inheritLinked: true},
        {trigger: "remoteVibe", type: "RemoteActivatedVibe", power: 2, time: 20, edgeOnly: true},
        {trigger: "tick", type: "PeriodicTeasing", power: 1, time: 48, edgeOnly: true, cooldown: {"normal": 120, "tease": 20}, chance: 0.02}
    ]
});

// #region Enemies

KinkyDungeonEnemies.push(
    {
        name: corruptedAlchemistName, faction: "Corrupted", bound: "Alchemist", playLine: "Alchemist", color: "#8B53E9",
        tags: KDMapInit(["nosub", "opendoors", "closedoors", "imprisonable", "human", "minor", "alchemist"]),
        armor: 5, followRange: 1, AI: "hunt",
        spells: [alchemistBindSpell, "AmpuleYellow"], spellCooldownMult: 1, spellCooldownMod: 4, projectileAttack: true,
        attackLock: "Rubber", noSpellsWhenHarmless: true,
        Resistance: {
            profile: ["alchemist"]
        },
        events: [
            {trigger: "afterDamageEnemy", type: "bleedEffectTile", kind: "LatexThin", aoe: 1.5, power: 3, chance: 1.0, duration: 20},
            {trigger: "beforeDamage", type: alchemistDomFlag},
            {trigger: "afterEnemyTick", type: alchemistDomRefreshFlag}
        ],
        ignoreflag: [alchemistDommedFlag], failAttackflag: [alchemistDommedFlag],
        stamina: 4,
        visionRadius: 6, maxhp: 20, minLevel: 0, weight: -20, movePoints: 2, attackPoints: 3, attack: "SpellMeleeBindLock",
        attackWidth: 3, attackRange: 1, power: 1, dmgType: "grope", fullBoundBonus: 2,
        terrainTags: {"secondhalf": 5, "lastthird": 5, "miniboss": 10, "latexAnger": 6, "latexRage": 10, "latexPleased": 2, "latexFriendly": 4, "alchemist": 50}, shrines: ["Latex"], allFloors: true,
        dropTable: [
            {name: "Gold", amountMin: 15, amountMax: 25, weight: 5},
            {name: "BlueKey", weight: 10},
            {name: "StaffDoll", ignoreInInventory: true, weight: 10}
        ]
    },
    {
        name: alchemistInspectorName, faction: "Corrupted", clusterWith: "alchemist", bound: "Alchemist", color: "#5353e9", playLine: "Gagged",
        tags: KDMapInit(["human", "search", "inspectorToys"]),
        followRange: 1, attackPoints: 5,
        stamina: 5,
        AI: "hunt", visionRadius: 10, maxhp: 12, minLevel: 0, weight: -25, movePoints: 3, evasion: 0.2, ignorechance: 0,
        Resistance: {
            profile: ["alchemist"]
        },
        RemoteControl: {
            remote: 5,
            remoteAmount: 5
        },
        events: [
            {trigger: "afterDamageEnemy", type: "bleedEffectTile", kind: "LatexThin", aoe: 1.5, power: 3, chance: 1.0, duration: 20},
            {trigger: "beforeDamage", type: alchemistFactionDomFlag},
            {trigger: "afterEnemyTick", type: alchemistDomRefreshFlag}
        ],
        attackPoints: 3, attack: "MeleeWillBindVibe", attackWidth: 1, attackRange: 1, tilesMinRange: 1, power: 0.1, dmgType: "charm",
        terrainTags: {},
        allFloors: true, shrines: ["Latex"],
        dropTable: [{name: "Gold", amountMin: 10, amountMax: 20, weight: 10}]
    }
);

// #region Spells

KinkyDungeonSpellListEnemies.push({
    enemySpell: true, name: alchemistBindSpell, sfx: "Miss", manacost: 5,
    specialCD: 15, components: ["Arms"], level: 1, type: "bolt",
    projectileTargeting: true, onhit: "", power: 4, delay: 0, range: 50, damage: "glue",
    speed: 1, playerEffect: {name: "Bind", damage: "glue", power: 4, count: 1, tag: petRestraintWithSpellTag}
});

KDEventMapEnemy.beforeDamage[alchemistDomFlag] = (e, enemy, data) => {
    const totalPetRestraints = KDUtilCommon.RestraintWithEnemyTagCount(petRestraintTag);
    let hasAlchemistLeash = !!KinkyDungeonInventoryGet(aRestraints.leash);
    let hasAlchemistCollar = KDUtilCommon.PlayerWearsRestraint(aRestraints.collar);
    let hasAlchemistGag = KDUtilCommon.PlayerWearsRestraint(aRestraints.gags.ballGag);
    const hasLeash = KinkyDungeonIsWearingLeash();
    const hasCollar = KDUtilCommon.HasRestraintWithShrines("Collars");
    const hasGag = KDUtilCommon.HasRestraintWithShrines("Gags", "FlatGags", "BallGags");

    if (data.enemy === enemy && data.target === KinkyDungeonPlayerEntity) {
        let selectedRestraint = "";
        if (data.restraintsAdded && data.restraintsAdded.length === 0) {
            for (const res of aRestraintsNeed) {
                if (!KDUtilCommon.PlayerWearsRestraint(res)) {
                    selectedRestraint = res;
                    break;
                }
            }
        }

        if (hasLeash && !hasAlchemistLeash) {
            KinkyDungeonRemoveRestraintsWithName("BasicLeash");
            KinkyDungeonRemoveRestraintsWithName("WolfLeash");
            KinkyDungeonRemoveRestraintsWithName("CorruptedSlimeLeash");
            KinkyDungeonSendTextMessage(1, `${corruptedAlchemistText} removes your leash!`, "white", 3);
            selectedRestraint = "";
        }

        if (hasCollar && !hasAlchemistCollar && selectedRestraint !== "") {
            KinkyDungeonRemoveRestraintsWithShrine("Collars");
            KinkyDungeonSendTextMessage(1, `${corruptedAlchemistText} removes your collar!`, "white", 3);
            selectedRestraint = "";
        }

        if (hasGag && !hasAlchemistGag && selectedRestraint === "") {
            KinkyDungeonRemoveRestraintsWithShrine("Gags");
            KinkyDungeonSendTextMessage(1, `${corruptedAlchemistText} removes your gag!`, "white", 3);
            selectedRestraint = "";
        }

        if (selectedRestraint !== "") {
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(selectedRestraint)); // Уточнён вызов
        }

        if (totalPetRestraints > 5 && hasAlchemistLeash && !KinkyDungeonFlags.get(alchemistDommedFlag)) {
            if (KDGameData.PrisonerState !== 'parole') {
                KDGameData.PrisonerState = 'parole';
                KinkyDungeonPassOut(true);
                KinkyDungeonSetDress(petDressName, petDressName); // Добавлен второй аргумент
                if (!KinkyDungeonInventoryGet(petDressName)) {
                    let outfit = {name: petDressName, id: KinkyDungeonGetItemID(), type: "Outfit"}; // Обновлено на строку "Outfit"
                    KinkyDungeonInventoryAdd(outfit);
                }
            }

            KDBreakTether(KinkyDungeonPlayerEntity);
            KinkyDungeonAttachTetherToEntity(2, enemy);

            KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, {
                id: alchemistDommedFlag, type: "Flag", duration: 20, power: 1, maxCount: 1, currentCount: 1, tags: ["attack", "cast"],
                events: [
                    {type: alchemistDommedFlag, trigger: "tickAfter"}
                ]
            });

            if (!enemy.Enemy.summonEnemy) {
                const nearbyPoint = KinkyDungeonGetNearbyPoint(enemy.x, enemy.y, true, null, true, true);
                if (nearbyPoint) { // Добавлена проверка
                    const inspectorEnemy = DialogueCreateEnemy(nearbyPoint.x, nearbyPoint.y, alchemistInspectorName);
                    enemy.Enemy.summonEnemy = true;
                    KinkyDungeonSendTextMessage(1, `${corruptedAlchemistText} summons ${alchemistInspectorText}!`, "white", 3);
                }
            }
        }
    }
};

KDEventMapEnemy.beforeDamage[alchemistFactionDomFlag] = (e, enemy, data) => {
    const totalPetRestraints = KDUtilCommon.RestraintWithEnemyTagCount(petRestraintTag);
    let hasAlchemistLeash = !!KinkyDungeonInventoryGet(aRestraints.leash);
    if (data.enemy === enemy && data.target === KinkyDungeonPlayerEntity && totalPetRestraints > 5 && hasAlchemistLeash && !KinkyDungeonFlags.get(alchemistDommedFlag)) {
        KDBreakTether(KinkyDungeonPlayerEntity);
        KinkyDungeonAttachTetherToEntity(2, enemy);

        KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, {
            id: alchemistDommedFlag, type: "Flag", duration: 20, power: 1, maxCount: 1, currentCount: 1, tags: ["attack", "cast"],
            events: [
                {type: alchemistDommedFlag, trigger: "tickAfter"}
            ]
        });
    }
};

KDEventMapEnemy.afterEnemyTick[alchemistDomRefreshFlag] = (e, enemy, data) => {
    if (KinkyDungeonFlags.get(alchemistDommedFlag)) {
        let duration = 2; // just to keep it going
        KinkyDungeonSetFlag("TempLeash", duration);
        KinkyDungeonSetFlag("TempLeashCD", duration * 2);
        KinkyDungeonSetFlag("noResetIntent", 12);
        enemy.playWithPlayerCD = duration;
        enemy.IntentAction = 'TempLeash';
    }
};

KDEventMapBuff.tickAfter[alchemistDommedFlag] = (e, buff, entity, data) => {
    if (buff.duration > 0 && entity.player) {
        if (!KinkyDungeonInventoryGet("AlchemistPetLeash")) {
            KDBreakTether(entity);
            KinkyDungeonExpireBuff(entity, alchemistDommedFlag);
        }
    }
};

KDEventMapInventory[linkItemEventParent][linkItemEvent] = (e, item, data) => {
    if ((data.attack && data.attack.includes("Bind") && (!data.enemy || data.enemy.Enemy.bound) && !data.attack.includes("Suicide"))) {
        let added = false;
        if (data.restraintsAdded) {
            for (let r of data.restraintsAdded) {
                if (r.r.name === item.name) {
                    added = true;
                    break;
                }
            }
            if (data.restraintsAdded.length !== 0) {
                added = true;
            }
        }
        if (!added) {
            let subMult = 1;
            let chance = e.chance ? e.chance : 1.0;
            if (e.subMult !== undefined) {
                let rep = (KinkyDungeonGoddessRep.Ghost + 50) / 100;
                subMult = 1.0 + e.subMult * rep;
            }
            if (e.tags?.lowwill && KinkyDungeonStatWill < 0.1) chance = 1.0;
            if (item && KDRestraint(item).Link && (KDRandom() < chance * subMult) && (!e.noLeash || KDGameData.KinkyDungeonLeashedPlayer < 1)) {
                let newRestraint = KinkyDungeonGetRestraintByName(KDRestraint(item).Link);
                if (KinkyDungeonAddRestraintIfWeaker(newRestraint, item.tightness, true, "", false, undefined, undefined, item.faction, true)) {
                    if (KDToggles.Sound && e.sfx) KinkyDungeonPlaySound(KinkyDungeonRootDirectory + "Audio/" + e.sfx + ".ogg");
                }
            }
        }
    }
};

KDEventMapInventory[drainStaminaEventParent][drainStaminaEvent] = (e, item, data) => {
    KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, showInfoBuff, {duration: 2});
    if (KinkyDungeonStatStamina > 0) {
        KinkyDungeonChangeStamina(-(drainStaminaCost / 100), false, 2); // stop regenerating stamina
        KinkyDungeonSendTextMessage(1, "The belts drain your stamina!", "lightblue", 2, true);
    } else {
        KDGameData.KneelTurns = 2; // make player kneel once it runs out of stamina
    }
};

KDEventMapInventory.remove.clearStaminaEvent = (e, item, data) => {
    KDGameData.StaminaPause = 0; // reset stamina pause, allow regen stamina
};

// #region buffs
const buffId = "staminaDrain";
let showInfoBuff = {id: buffId, aura: "#ffff90", noAuraColor: true, type: buffId, power: 1, player: true, enemies: false, duration: 2, tags: [buffId]};

KDBuffSprites[buffId] = true;

// #region Set texts

KinkyDungeonAddRestraintText(aRestraints.corset, restraintNameTexts[aRestraints.corset], `A latex corset made by ${corruptedAlchemistText}.`, 'The latex firmly holds onto your hips.');
KinkyDungeonAddRestraintText(aRestraints.harness, restraintNameTexts[aRestraints.harness], `Leather harness altered by ${corruptedAlchemistText} holding onto your body.`, 'For making pets struggle harder~');
KinkyDungeonAddRestraintText(aRestraints.gags.ballGag, restraintNameTexts[aRestraints.gags.ballGag], 'A latex ball gag, nothing more.', 'The gag is a bit small, you can still utter a few words...');
KinkyDungeonAddRestraintText(aRestraints.gags.panelGag, restraintNameTexts[aRestraints.gags.panelGag], 'A latex ball within latex panel covering your whole mouth.', 'They can still hear your moans.');
KinkyDungeonAddRestraintText(aRestraints.gags.harnessPanelGag, restraintNameTexts[aRestraints.gags.harnessPanelGag], 'The latex ball attached to latex panel covering your whole mouth, with extra security.', 'They can still hear your moans.');
KinkyDungeonAddRestraintText(aRestraints.collar, restraintNameTexts[aRestraints.collar], 'A leather collar attached to your neck.', 'Marks your neck for the alchemist faction as their play toy~');
KinkyDungeonAddRestraintText(aRestraints.leash, restraintNameTexts[aRestraints.leash], 'A leash attached to your collar.', 'Provides a leashing point for your best alchemist "friends".');
KinkyDungeonAddRestraintText(aRestraints.heels, restraintNameTexts[aRestraints.heels], `A pair of shiny ballet heels made by ${corruptedAlchemistText}.`, 'It comes with the sign "Especially made for alchemist pets."');
KinkyDungeonAddRestraintText(aRestraints.heels + '2', restraintNameTexts[aRestraints.heels] + ' Link', `Metal chains attached between your heels.`, 'Keeps your legs closed, heavily restricting your movements.');
KinkyDungeonAddRestraintText(aRestraints.armbinder, restraintNameTexts[aRestraints.armbinder], 'A secure latex armbinder totally making your arms useless.', 'It\'s made of very tight latex material holding onto your arms.');
KinkyDungeonAddRestraintText(aRestraints.armBelts, restraintNameTexts[aRestraints.armBelts], `Leather belts altered by ${corruptedAlchemistText} squeezing your arms.`, 'It\'s enchanted to keep pets docile!');
KinkyDungeonAddRestraintText(iRestraints.plug, restraintNameTexts[iRestraints.plug], `A vibe attached to your vulva.`, 'An alchemist toy reminding you of your place as a pet!');

KDUtilCommon.SetSpellText(alchemistBindSpell, "Bind", "The latex bottle forms a restraint on you!");
KDUtilCommon.SetSpellText(alchemistBindSpell, "Damage", "The latex bottle splashes on you!");

KDUtilCommon.SetLinkText(aRestraints.armbinder, `The enemy links your ${restraintNameTexts[aRestraints.armbinder]} with ${restraintNameTexts[aRestraints.armBelts]}!`);
KDUtilCommon.SetLinkText(aRestraints.corset, `The enemy links your ${restraintNameTexts[aRestraints.corset]} with ${restraintNameTexts[aRestraints.harness]}!`);
KDUtilCommon.SetLinkText(aRestraints.gags.ballGag, `The enemy links your ${restraintNameTexts[aRestraints.gags.ballGag]} with ${restraintNameTexts[aRestraints.gags.panelGag]}!`);
KDUtilCommon.SetLinkText(aRestraints.gags.panelGag, `The enemy links your ${restraintNameTexts[aRestraints.gags.panelGag]} with ${restraintNameTexts[aRestraints.gags.harnessPanelGag]}!`);
KDUtilCommon.SetUnlinkText(aRestraints.armBelts, `The enemy removes your ${restraintNameTexts[aRestraints.armBelts]}!`);
KDUtilCommon.SetUnlinkText(aRestraints.harness, `The enemy removes your ${restraintNameTexts[aRestraints.harness]}!`);
KDUtilCommon.SetUnlinkText(aRestraints.gags.panelGag, `The enemy removes your ${restraintNameTexts[aRestraints.gags.panelGag]}!`);
KDUtilCommon.SetUnlinkText(aRestraints.gags.harnessPanelGag, `The enemy removes your ${restraintNameTexts[aRestraints.gags.harnessPanelGag]}!`);

KDUtilCommon.SetEnemyNameText(corruptedAlchemistName, corruptedAlchemistText);
KDUtilCommon.SetEnemyAttackText(corruptedAlchemistName, `${corruptedAlchemistText} gropes your body! (DamageTaken)`);
KDUtilCommon.SetEnemyAttackWithBindText(corruptedAlchemistName, `${corruptedAlchemistText} binds you! (+RestraintAdded)`);
KDUtilCommon.SetEnemyLockText(corruptedAlchemistName, `${corruptedAlchemistText} locks your restraint!`);

KDUtilCommon.SetEnemyNameText(alchemistInspectorName, alchemistInspectorText);
KDUtilCommon.SetEnemyAttackText(alchemistInspectorName, `${alchemistInspectorText} plays with your body! (DamageTaken)`);

KDUtilCommon.SetStatTexts(perkId, "Alchemist Pet", 'Start as an alchemist pet wandering around.');

KDUtilCommon.SetBuffText(buffId, "Stamina Locked: Your stamina won't regen. (Pet Arm Belts)");

// #region Perks - Adds an alchemist pet perk scenario!

addTextKey("KinkyDungeonInventoryItemAlchemistPet", "Latex Alchemist Pet Outfit");
addTextKey("KinkyDungeonInventoryItemAlchemistPetDesc", "A latex kitten outfit covering everything but your stomach.");
addTextKey("KinkyDungeonInventoryItemAlchemistPetDesc2", "This outfit does not have an effect other than admitting you love being an Alchemist Pet~");

const perk = {
    startPriority: 1000, category: "Start", id: perkId, cost: -4, block: [], tags: ["start"]
};

KinkyDungeonStatsPresets[perkId] = perk;

KDPerkStart[perkId] = () => {
    KDGameData.PrisonerState = 'parole';
    KinkyDungeonSetDress(petDressName, petDressName); // Добавлен второй аргумент
    if (!KinkyDungeonInventoryGet(petDressName)) {
        let outfit = {name: petDressName, id: KinkyDungeonGetItemID(), type: "Outfit"}; // Обновлено на строку "Outfit"
        KinkyDungeonInventoryAdd(outfit);
    }
    for (const res of aRestraintsNeed) {
        if (res !== aRestraints.leash) {
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(res)); // Уточнён вызов
        }
    }
};

KDLoadPerks();

// add these keys because they were bugged
addTextKey("KinkyDungeonJailerLeashEndNow", "Good girl, stay where you are~");