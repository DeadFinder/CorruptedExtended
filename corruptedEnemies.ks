let KDUtilCommon = window.KDUtilCommon;
const cRestraints = window.KDModData.corruptedRestraints;
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
    KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedAlchemistHeels + '2'), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
    ToArrayDeepSearch(aRestraintsNeed).forEach(val => KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(val), 0, true, undefined, false, undefined, undefined, undefined, true));
    //KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedAlchemistHeels + '2'));
    KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedAlchemistHeels + '2'), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
    KinkyDungeonSetDress(petDressName, petDressName);
}

window.AddAlchemistSet = AddAlchemistSet;

const corruptedAlchemistName = "CorruptedAlchemist";
const alchemistInspectorName = "AlchemistInspector";
const alchemistInspectorText = "Alchemist Inspector";
const alchemistDommedFlag = "AlchemistDommed";
const alchemistDomFlag = "AlchemistDom";
const alchemistFactionDomFlag = "AlchemistFactionDom";
const alchemistDomRefreshFlag = "AlchemistDomRefresh";
const inspectorPlayFlag = "InspectorPlay";
const alchemistBindSpell = "AmpulePurple";
const drainStaminaCost = 20;
const petRestraintTag = "AlchemistPet";
const petRestraintWithSpellTag = "AlchemistSpell";
const petDressName = "AlchemistPet";
const perkId = "AlchemistPet";
const aRestraintsNeed = [
    cRestraints.corruptedAlchemistCorset,
    cRestraints.corruptedAlchemistBallGag,
    cRestraints.corruptedAlchemistCollar,
    cRestraints.corruptedAlchemistHeels,
    cRestraints.corruptedAlchemistArmbinder,
    cRestraints.corruptedAlchemistLeash,
];

// Corrupted Alchemist
KinkyDungeonEnemies.push({
    name: corruptedAlchemistName, faction: "Corrupted", bound: "Alchemist", playLine: "Alchemist", color: "#8B53E9",
    tags: KDMapInit(["nocapture", "nosub", "opendoors", "closedoors", "imprisonable", "human", "minor", "alchemist"]),
    armor: 5, followRange: 1, AI: "hunt",
    spells: [alchemistBindSpell, "AmpuleYellow"], spellCooldownMult: 1, spellCooldownMod: 4, projectileAttack: true,
    attackLock: "Rubber", noSpellsWhenHarmless: true,
    Resistance: {
        profile: ["alchemist"]
    },
    events: [
        { trigger: "afterDamageEnemy", type: "bleedEffectTile", kind: "LatexThin", aoe: 1.5, power: 3, chance: 1.0, duration: 20 },
        { trigger: "beforeDamage", type: alchemistDomFlag },
        { trigger: "afterEnemyTick", type: alchemistDomRefreshFlag }
    ],
    ignoreflag: [alchemistDommedFlag], failAttackflag: [alchemistDommedFlag],
    stamina: 4,
    visionRadius: 6, maxhp: 20, minLevel: 0, weight: -20, movePoints: 2, attackPoints: 3, attack: "SpellMeleeBindLock",
    attackWidth: 3, attackRange: 1, power: 1, dmgType: "grope", fullBoundBonus: 2,
    terrainTags: { "secondhalf": 5, "lastthird": 5, "miniboss": 10, "latexAnger": 6, "latexRage": 10, "latexPleased": 2, "latexFriendly": 4, "alchemist": 50 }, shrines: ["Latex"], allFloors: true,
    dropTable: [
        { name: "Gold", amountMin: 15, amountMax: 25, weight: 5 },
        { name: "BlueKey", weight: 10 },
        { name: "StaffDoll", ignoreInInventory: true, weight: 10 }
    ]
}, {
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
        { trigger: "afterDamageEnemy", type: "bleedEffectTile", kind: "LatexThin", aoe: 1.5, power: 3, chance: 1.0, duration: 20 },
        { trigger: "beforeDamage", type: alchemistFactionDomFlag },
        { trigger: "afterEnemyTick", type: alchemistDomRefreshFlag }
    ],
    attackPoints: 3, attack: "MeleeWillBindVibe", attackWidth: 1, attackRange: 1, tilesMinRange: 1, power: 0.1, dmgType: "charm",
    terrainTags: {},
    allFloors: true, shrines: ["Latex"],
    dropTable: [{ name: "Gold", amountMin: 10, amountMax: 20, weight: 10 }]
});

// Corrupted Maid
const corruptedMaidName = "CorruptedMaid";
const corruptedMaidText = "Corrupted Maid";
const corruptedMaidDomFlag = "CorruptedMaidDom";
const dressingUpRestraint = "RopeSnakeHogtieWrist";
let restraintsToAddMaid = [
    "CorruptedMaidLeatherHeels",
    "DusterGag",
    "MaidAnkleCuffs",
    "MaidAnkleCuffs2",
    "LegShackles",
    "LegShackles2",
    "CorruptedMaidElbowShackles",
    "MaidBelt",
    "CorruptedMaidArmbinder",
    "MaidVibe",
    "MaidCBelt",
    "CorruptedMaidNippleWeights",
    "TrapBra",
    "CorruptedMaidCollar",
    "CorruptedMaidLeash",
];

KDUtilCommon.KinkyDungeonCloneEnemy("Maidforce", corruptedMaidName, {
    playLine: "DomMaid", AI: "hunt", maxhp: 15,
    faction: "Corrupted",
    stealth: 2, failAttackFlag: [corruptedMaidDomFlag], ignoreFlag: [corruptedMaidDomFlag],
    dropTable: [
        { name: "Duster", weight: 5, ignoreInInventory: true },
        { name: "Gold", amountMin: 15, amountMax: 25, weight: 10 }
    ],
    weight: -20,
    events: [
        { trigger: "beforeDamage", type: "corruptedMaid" },
    ],
    tags: KDMapInit(["nocapture", "nosub", "leashing", "tickleweakness", "imprisonable", "opendoors", "human", "melee", "corruptedMaid", "maid", "minor", "search"])
});

// Corrupted Mummy
const corruptedMummyName = "CorruptedMummy";
const corruptedMummyText = "Corrupted Mummy";

KinkyDungeonEnemies.push({
    name: corruptedMummyName,
    tags: KDMapInit(["nocapture", "nosub", "leashing", "notalk", "imprisonable", "opendoors", "human", "ranged", "search"]),
    spells: ["WitchSlimeBall", "WitchSlime", "LatexSpray"], spellCooldownMult: 1, spellCooldownMod: 0, castWhileMoving: true, stealth: 2,
    faction: "Corrupted", outfit: "CorruptedMummy", style: "Nothing",
    maxhp: 30, armor: 15, followRange: 1, kite: 3, AI: "hunt", dontKiteWhenDisabled: true,
    minLevel: 0, weight: -13, movePoints: 4, attackPoints: 3, attack: "SpellMeleeBind", attackWidth: 2, attackRange: 1, power: 3, dmgType: "crush", fullBoundBonus: 1,
    visionRadius: 7, blindSight: 10,
    stamina: 6, preferDodge: true, maxblock: 1, maxdodge: 3,
    terrainTags: {}, allFloors: true,
    events: [
        { trigger: "beforeDamage", type: "corruptedMummy" },
    ],
    Defeat: {
        furnitureTags: [
            { tags: ["shadowLatexRestraints"], count: 5 },
            { tags: ["shadowBall"], count: 1 },
        ],
    },
    effect: {
        effect: { name: "ShadowEncase" },
    },
    dropTable: [
        { name: "Duster", weight: 5, ignoreInInventory: true },
        { name: "Gold", amountMin: 15, amountMax: 25, weight: 10 },
        { name: "SlimeRaw", amount: 3, weight: 10 },
        { name: "EnchKnife", ignoreInInventory: true, weight: 1 }
    ],
});

// Corrupted Latex Cube
const engulfFlag = "CubeEngulfed";
const corruptedCube = "CorruptedLatexCube";

KinkyDungeonEnemies.push({
    name: corruptedCube, faction: "Latex", color: "#aa00cc",
    tags: KDMapInit(["nocapture", "unstoppable", "slime", "latex", "latexTrap", "elite", "slashweakness", "melee", "chainimmune", "glueresist", "coldweakness", "electricresist", "pierceweakness", "acidweakness", "latexRestraints", "latexEncaseRandom"]),
    Animations: ["squishyAmbush"],
    GFX: {
        AmbushSprite: "LatexCubeHidden",
    },
    RestraintFilter: {
        unlimitedRestraints: true,
    },
    Sound: {
        baseAmount: 0,
        moveAmount: 3,
    },
    ignoreflag: [engulfFlag], failAttackflag: [engulfFlag],
    stamina: 3,
    squeeze: true, evasion: -1, followRange: 1, AI: "ambush",
    visionRadius: 10.0, blindSight: 2.5, maxhp: 20, minLevel: 6, weight: 1, movePoints: 4, attackPoints: 2, attack: "MeleeBind", attackWidth: 2, attackRange: 1, power: 4, dmgType: "glue", fullBoundBonus: 2, disarm: 0.7,
    terrainTags: { "tmb": 3, "slime": 2.5, "plant": 2, "passage": 20, "open": -10, "slimeOptOut": -0.9, "slimePref": 1 }, allFloors: true, shrines: ["Latex"],
    events: [
        { trigger: "afterDamageEnemy", type: "bleedEffectTile", kind: "Slime", aoe: 1.5, power: 3, chance: 1.0, duration: 20 },
        { trigger: "afterEnemyTick", type: "createEffectTile", kind: "LatexThin", time: 25, power: 2, chance: 0.5, aoe: 0.5 },
        { trigger: "beforeDamage", type: "cubeEngulf", power: 0, color: "#880044" },
    ],
    dropTable: [{ name: "Gold", amountMin: 30, amountMax: 50, weight: 1 }]
});

// Events
KinkyDungeonSpellListEnemies.push({
    enemySpell: true, name: alchemistBindSpell, sfx: "Miss", manacost: 5,
    specialCD: 15, components: ["Arms"], level: 1, type: "bolt",
    projectileTargeting: true, onhit: "", power: 4, delay: 0, range: 50, damage: "glue",
    speed: 1, playerEffect: { name: "Bind", damage: "glue", power: 4, count: 1, tag: petRestraintWithSpellTag }
});

KDEventMapEnemy.beforeDamage[alchemistDomFlag] = (e, enemy, data) => {
    const totalPetRestraints = KDUtilCommon.RestraintWithEnemyTagCount(petRestraintTag);
    let hasAlchemistLeash = !!KinkyDungeonInventoryGet(cRestraints.corruptedAlchemistLeash);
    let hasAlchemistCollar = KDUtilCommon.PlayerWearsRestraint(cRestraints.corruptedAlchemistCollar);
    let hasAlchemistGag = KDUtilCommon.PlayerWearsRestraint(cRestraints.corruptedAlchemistBallGag);
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
            KinkyDungeonSendTextMessage(1, `"Corrupted Alchemist" removes your leash!`, "white", 3);
            selectedRestraint = "";
        }

        if (hasCollar && !hasAlchemistCollar && selectedRestraint !== "") {
            KinkyDungeonRemoveRestraintsWithShrine("Collars");
            KinkyDungeonSendTextMessage(1, `"Corrupted Alchemist" removes your collar!`, "white", 3);
            selectedRestraint = "";
        }

        if (hasGag && !hasAlchemistGag && selectedRestraint === "") {
            KinkyDungeonRemoveRestraintsWithShrine("Gags");
            KinkyDungeonSendTextMessage(1, `"Corrupted Alchemist" removes your gag!`, "white", 3);
            selectedRestraint = "";
        }

        if (selectedRestraint !== "") {
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(selectedRestraint), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
        }

        if (totalPetRestraints > 5 && hasAlchemistLeash && !KinkyDungeonFlags.get(alchemistDommedFlag)) {
            if (KDGameData.PrisonerState !== 'parole') {
                KDGameData.PrisonerState = 'parole';
                KinkyDungeonPassOut(true);
                KinkyDungeonSetDress(petDressName, petDressName);
                if (!KinkyDungeonInventoryGet(petDressName)) {
                    let outfit = { name: petDressName, id: KinkyDungeonGetItemID(), type: "Outfit" };
                    KinkyDungeonInventoryAdd(outfit);
                }
            }

            KDBreakTether(KinkyDungeonPlayerEntity);
            KinkyDungeonAttachTetherToEntity(2, enemy);

            KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, {
                id: alchemistDommedFlag, type: "Flag", duration: 20, power: 1, maxCount: 1, currentCount: 1, tags: ["attack", "cast"],
                events: [
                    { type: alchemistDommedFlag, trigger: "tickAfter" }
                ]
            });

            if (!enemy.Enemy.summonEnemy) {
                const nearbyPoint = KinkyDungeonGetNearbyPoint(enemy.x, enemy.y, true, null, true, true);
                if (nearbyPoint) {
                    const inspectorEnemy = DialogueCreateEnemy(nearbyPoint.x, nearbyPoint.y, alchemistInspectorName);
                    enemy.Enemy.summonEnemy = true;
                    KinkyDungeonSendTextMessage(1, `"Corrupted Alchemist" summons ${alchemistInspectorText}!`, "white", 3);
                }
            }
        }
    }
};

KDEventMapEnemy.beforeDamage[alchemistFactionDomFlag] = (e, enemy, data) => {
    const totalPetRestraints = KDUtilCommon.RestraintWithEnemyTagCount(petRestraintTag);
    let hasAlchemistLeash = !!KinkyDungeonInventoryGet(cRestraints.corruptedAlchemistLeash);
    if (data.enemy === enemy && data.target === KinkyDungeonPlayerEntity && totalPetRestraints > 5 && hasAlchemistLeash && !KinkyDungeonFlags.get(alchemistDommedFlag)) {
        KDBreakTether(KinkyDungeonPlayerEntity);
        KinkyDungeonAttachTetherToEntity(2, enemy);

        KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, {
            id: alchemistDommedFlag, type: "Flag", duration: 20, power: 1, maxCount: 1, currentCount: 1, tags: ["attack", "cast"],
            events: [
                { type: alchemistDommedFlag, trigger: "tickAfter" }
            ]
        });
    }
};

KDEventMapEnemy.afterEnemyTick[alchemistDomRefreshFlag] = (e, enemy, data) => {
    if (KinkyDungeonFlags.get(alchemistDommedFlag)) {
        let duration = 2;
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

KDEventMapEnemy.beforeDamage.corruptedMaid = (e, enemy, data) => {
    if (data.enemy === enemy && data.target === KinkyDungeonPlayerEntity && !data.restrainsAdded) {
        if (KinkyDungeonFlags.get(corruptedMaidDomFlag)) return;
        let restraintAdded = false;
        for (const restraintName of restraintsToAddMaid) {
            if (KDUtilCommon.PlayerWearsRestraint(restraintName)) continue;

            const restraint = KinkyDungeonGetRestraintByName(restraintName);
            if (!restraint) {
                console.log("Corrupted maid couldn't find the restraint with name: ", restraintName);
                continue;
            }
            if (KinkyDungeonAddRestraintIfWeaker(restraint, 0, true, undefined, false, undefined, undefined, undefined, true)) {
                restraintAdded = true;
                break;
            }
        }
        if (!restraintAdded) {
            KinkyDungeonAttachTetherToEntity(1, enemy);

            let flagBuff = {
                id: corruptedMaidDomFlag, type: "Flag", duration: 10, power: 1, maxCount: 1, currentCount: 1, tags: ["attack", "cast"],
                events: [
                    { type: corruptedMaidDomFlag, trigger: "tickAfter" },
                ]
            };

            if (KinkyDungeonCurrentDress !== petDressName) {
                KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(dressingUpRestraint), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
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
        if (!KinkyDungeonInventoryGet("CorruptedMaidCollar")) {
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
            let outfit = { name: petDressName, id: KinkyDungeonGetItemID(), type: "Outfit" };
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
                { type: corruptedMaidDomFlag, trigger: "tickAfter" },
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

KDEventMapEnemy.beforeDamage.corruptedMummy = (e, enemy, data) => {
    if (data.enemy === enemy && data.target === KinkyDungeonPlayerEntity && !data.restrainsAdded) {
        if (!KDUtilCommon.PlayerWearsRestraint("CorruptedMummyCollar")) {
            const restraint = KinkyDungeonGetRestraintByName("CorruptedMummyCollar");
            if (KDRandom() >= 0.7) {
                KinkyDungeonAddRestraintIfWeaker(restraint, 0, true, "Divine2", false, undefined, undefined, "Corrupted", true);
            }
        }
    }
};

KDEventMapEnemy.beforeDamage.cubeEngulf = (e, enemy, data) => {
    const totalSlimeRestraints = KDUtilCommon.RestraintWithEnemyTagCount("latexEncaseRandom");
    if (data.enemy === enemy && data.target === KinkyDungeonPlayerEntity && data.restraintsAdded && data.restraintsAdded.length === 0 && totalSlimeRestraints > 3 && !KinkyDungeonFlags.get(engulfFlag)) {
        KDTripleBuffKill("CubeEngulf", KinkyDungeonPlayerEntity, 9, (tt) => {
            KinkyDungeonSetDress("SlimeDress", "SlimeDress");
            KDBreakTether(KinkyDungeonPlayerEntity);

            enemy.hp = 0;
            KinkyDungeonRemoveRestraintsWithShrine("Slime");
            KinkyDungeonRemoveRestraintsWithShrine("SlimeHard");
            KinkyDungeonRemoveRestraintsWithShrine("Latex");

            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeEncasement), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeCuffs), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeCollar), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeAnkles), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeLegs), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeGag), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeBlindfold), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
        }, "Blindness");
    }
};

KDEventMapInventory.postRemoval.RequireEncasement = (e, item, data) => {
    if (data.item === item) {
        for (let inv of KinkyDungeonAllRestraint()) {
            if (inv.name === cRestraints.corruptedCubeEncasement) {
                return;
            }
        }
        KinkyDungeonExpireBuff(KinkyDungeonPlayerEntity, engulfFlag);
        KinkyDungeonSendTextMessage(4, "The cube melts away and you break free!", "lightgreen", 2);
    }
};

KDEventMapInventory.tick.cubeEncasement = (e, item, data) => {
    if (!KinkyDungeonHasBuff(KinkyDungeonPlayerBuffs, engulfFlag)) {
        KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, {
            id: engulfFlag, type: "Flag", duration: 55, power: 1, maxCount: 1, currentCount: 1, tags: ["attack", "cast"],
            events: [
                { type: engulfFlag, trigger: "tickAfter" }
            ]
        });
    }
};

let cBuffOptions = {
    id: engulfFlag,
    aura: "#000000",
    type: engulfFlag,
    power: 1,
    player: true,
    enemies: false,
    tags: ["CubeEngulfBuff"],
    duration: 55
};

KDBuffSprites[engulfFlag] = true;

KDEventMapBuff.tickAfter[engulfFlag] = (e, buff, entity, data) => {
    if (buff.duration > 0) {
        if (entity.player) {
            if (buff.duration < 45 && KDRandom() < 0.35) {
                KinkyDungeonSendTextMessage(5, "Corrupted slime moves around with you!", "#9074ab", 10);
                let nearbyPoint = KinkyDungeonGetNearbyPoint(entity.x, entity.y, true, null, true, true);
                if (nearbyPoint) {
                    KinkyDungeonMoveTo(nearbyPoint.x, nearbyPoint.y, false, false, true, false);
                }
            }
        }
    } else {
        KinkyDungeonSendTextMessage(5, "The slime melted out and you break free.", "#9074ab", 10);
        KinkyDungeonRemoveRestraintsWithName(cRestraints.corruptedCubeEncasement);
        KinkyDungeonUnlockRestraintsWithShrine("AfterLeashDone");
    }
};

// Text
KDUtilCommon.SetSpellText(alchemistBindSpell, "Bind", "The latex bottle forms a restraint on you!");
KDUtilCommon.SetSpellText(alchemistBindSpell, "Damage", "The latex bottle splashes on you!");
KDUtilCommon.SetEnemyNameText(corruptedAlchemistName, "Corrupted Alchemist");
KDUtilCommon.SetEnemyAttackText(corruptedAlchemistName, `"Corrupted Alchemist" gropes your body! (DamageTaken)`);
KDUtilCommon.SetEnemyAttackWithBindText(corruptedAlchemistName, `"Corrupted Alchemist" binds you! (+RestraintAdded)`);
KDUtilCommon.SetEnemyLockText(corruptedAlchemistName, `"Corrupted Alchemist" locks your restraint!`);
KDUtilCommon.SetEnemyNameText(alchemistInspectorName, alchemistInspectorText);
KDUtilCommon.SetEnemyAttackText(alchemistInspectorName, `${alchemistInspectorText} plays with your body! (DamageTaken)`);
KDUtilCommon.SetStatTexts(perkId, "Alchemist Pet", 'Start as an alchemist pet wandering around.');
KDUtilCommon.SetBuffText("staminaDrain", "Stamina Locked: Your stamina won't regen. (Pet Arm Belts)");
KDUtilCommon.SetEnemyNameText(corruptedMaidName, corruptedMaidText);
KDUtilCommon.SetEnemyAttackText(corruptedMaidName, `${corruptedMaidText} tickles your body...`);
KDUtilCommon.SetEnemyAttackWithBindText(corruptedMaidName, `${corruptedMaidText} binds you with (+RestraintAdded)!`);
KDUtilCommon.SetEnemyLockText(corruptedMaidName, `${corruptedMaidText} seals some locks your restraint!`);
KDUtilCommon.SetEnemyNameText(corruptedMummyName, corruptedMummyText);
KDUtilCommon.SetEnemyAttackText(corruptedMummyName, `${corruptedMummyText} tickles your body...`);
KDUtilCommon.SetEnemyAttackWithBindText(corruptedMummyName, `${corruptedMummyText} binds you with (+RestraintAdded)!`);
KDUtilCommon.SetEnemyLockText(corruptedMummyName, `${corruptedMummyText} seals some locks your restraint!`);
KDUtilCommon.SetEnemyNameText(corruptedCube, "Corrupted Latex Cube");
KDUtilCommon.SetEnemyAttackText(corruptedCube, "Corrupted Latex Cube gropes around your body...");
KDUtilCommon.SetEnemyAttackWithBindText(corruptedCube, "Corrupted Latex Cube spits some slime on you!");
KDUtilCommon.SetEnemyKillText(corruptedCube, "Corrupted Latex Cube melts away.");
KDUtilCommon.SetBuffText(engulfFlag, "Encasement: The HP left of this encasement.");
KDUtilCommon.SetTripleBuffTexts("CubeEngulf", [
    "The slime starts engulfing you!",
    "Your body starts going numb...",
    "The Slime engulfed you in its body!"
]);