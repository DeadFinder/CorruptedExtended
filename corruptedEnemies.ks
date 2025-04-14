let KDUtilCommon = window.KDUtilCommon;
const cRestraints = window.KDModData.corruptedRestraints;
let CorruptedEnemiesEnabled = window.KDCorruptedExtendedSettings;

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

// ================================================================================
//#     ____                            _           _   __  __ _           _      
//#    / ___|___  _ __ _ __ _   _ _ __ | |_ ___  __| | |  \/  (_)_ __ ___ (_) ___ 
//#   | |   / _ \| '__| '__| | | | '_ \| __/ _ \/ _` | | |\/| | | '_ ` _ \| |/ __|
//#   | |__| (_) | |  | |  | |_| | |_) | ||  __/ (_| | | |  | | | | | | | | | (__ 
//#    \____\___/|_|  |_|   \__,_| .__/ \__\___|\__,_| |_|  |_|_|_| |_| |_|_|\___|
//#                              |_|                                             
// ================================================================================
const corruptedMimicName = "CorruptedMimic";
const corruptedMimicText = "Corrupted Mimic";

KinkyDungeonEnemies.push({
    name: corruptedMimicName, faction: "CorruptedHidden", blockVisionWhileStationary: true, tags: KDMapInit(["removeDoorSpawn", "ignoreharmless", "blindresist", "construct", "nosignal", "poisonresist", "soulresist", "minor", "melee", "crushweakness", "meleeresist", "fireweakness", "electricresist", "chainweakness"]),
    evasion: -0.5, ignorechance: 1.0, armor: 1, followRange: 1, AI: "ambush", bypass: true, difficulty: 0.15, guardChance: 0,
    nonDirectional: true,
    //useLock: "White",
    GFX: {
        lighting: true,
    },
    maxblock: 1,
    maxdodge: 0,
    Sound: {
        baseAmount: 0,
        alertAmount: 0,
        moveAmount: 10,
    },
    events: [
        { trigger: "beforeDamage", type: "corruptedMimic" },
    ],
    stamina: 10,
    visionRadius: 50, ambushRadius: 1.9, blindSight: 50, maxhp: 10, minLevel: 2, weight: -1, movePoints: 1.5, attackPoints: 2, attack: "MeleeBind", attackWidth: 1, attackRange: 1, power: 3, dmgType: "tickle", fullBoundBonus: 1,
    terrainTags: { "rubble": 100, "adjChest": 15, "passage": 14, "illusionRage": 2, "illusionAnger": 2 }, allFloors: true, shrines: ["Illusion"],
    dropTable: [{ name: "RedKey", weight: 1 }, { name: "Gold", amountMin: 10, amountMax: 40, weight: 6 }, { name: "ScrollArms", weight: 1 }, { name: "ScrollVerbal", weight: 1 }, { name: "ScrollLegs", weight: 1 }]
});

KDEventMapEnemy.beforeDamage.corruptedMimic = (e, enemy, data) => {
    if (data.enemy === enemy && data.target === KinkyDungeonPlayerEntity && !data.restrainsAdded) {
        const corruptedRestraints = [cRestraints.corruptedMummyHardSlimeFeet, cRestraints.corruptedMummyHardSlimeBoots, cRestraints.corruptedMummyHardSlimeLegs, cRestraints.corruptedMummyHardSlimeArms, cRestraints.corruptedMummyHardSlimeHands, cRestraints.corruptedMummyHardSlimeMouth, cRestraints.corruptedMummyHardSlimeHead];
        const equippedRestraints = KinkyDungeonAllRestraint().map(inv => inv.name);
        if (KDRandom() >= 0.9) {
            if (enemy.hp <= 10) {
                return;
            }
            KDBreakTether(KinkyDungeonPlayerEntity);
            KDRemoveEntity(enemy);
            KinkyDungeonPassOut();
            KinkyDungeonAddRestraintIfWeaker(cRestraints.corruptedMimicEncasement, 0, true, "Red", false, undefined, undefined, "Corrupted", true);
            for (const res of corruptedRestraints) {
                if (!KDUtilCommon.PlayerWearsRestraint(res)) {
                    KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(res), 0, true, "", false, undefined, undefined, "Corrupted", true);
                }
            }
        } else {
            for (const restraintName of corruptedRestraints) {
                if (equippedRestraints.includes(restraintName)) {
                    continue;
                }
                let wtf = Math.min(1.0, 0.7 + (0.01 * (corruptedRestraints.indexOf(restraintName) + 1)));
                if (KDRandom() > wtf) {
                    KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(restraintName), 0, true, "", false, undefined, undefined, "Corrupted", true);
                    KinkyDungeonSendTextMessage(10, `${corruptedMimicText} binds you with ${restraintName}!`, "#cc0000", 2, true);
                }
                break;
            }
        }
    }
};

KDUtilCommon.SetEnemyNameText(corruptedMimicName, " ");
KDUtilCommon.SetEnemyAttackText(corruptedMimicName, `${corruptedMimicText} tickles your body...`);
KDUtilCommon.SetEnemyAttackWithBindText(corruptedMimicName, `${corruptedMimicText} binds you with (+RestraintAdded)!`);
KDUtilCommon.SetEnemyLockText(corruptedMimicName, `${corruptedMimicText} seals some locks your restraint!`);

// ===============================================================================
//#    _____       _                _               ____                        _ 
//#   | ____|_ __ (_) ___ ___ _ __ | |_ ___ _ __   / ___|   _ _ __ ___  ___  __| |
//#   |  _| | '_ \| |/ __/ _ \ '_ \| __/ _ \ '__| | |  | | | | '__/ __|/ _ \/ _` |
//#   | |___| |_) | | (_|  __/ | | | ||  __/ |    | |__| |_| | |  \__ \  __/ (_| |
//#   |_____| .__/|_|\___\___|_| |_|\__\___|_|     \____\__,_|_|  |___/\___|\__,_|
//#         |_|                                                                   
// ===============================================================================
if (CorruptedEnemiesEnabled["CorruptedEpicenterCursed"]) {
    {
    const index = KinkyDungeonEnemies.findIndex(enemy => enemy.name === "EpicenterCursed");
    if (index !== -1) KinkyDungeonEnemies.splice(index, 1);
    const index2 = KinkyDungeonEnemies.findIndex(enemy => enemy.name === "EpicenterCursed2");
    if (index2 !== -1) KinkyDungeonEnemies.splice(index2, 1);
    }

    KinkyDungeonEnemies.push({
            name: "EpicenterCursed", faction: "Curse", color: "#880044",
            tags: KDMapInit(["opendoors", "epicenterCursed", "epicenter", "curseTrap", "ghost", "cursed", "soulimmune", "melee", "fireweakness", "shadowimmune", "glueimmune", "chainimmune", "shadowHands", "poisonimmune", "meleeresist", "flying"]),
            ignorechance: 0, armor: 0, followRange: 1, AI: "huntshadow", noAlert: true, hitsfx: "Evil",
            ethereal: true,
            spells: ["ManyShadowHands", "ManyObsidianBolts", "CorruptedCursingCircle"/*"CursingCircle", "CursingCircle"*/], spellCooldownMult: 1.1, spellCooldownMod: 0, castWhileMoving: true,
            visionRadius: 15, blindSight: 8, evasion: -2, maxhp: 61.7, minLevel: 0, weight: 0,
            movePoints: 4, attackPoints: 2, attack: "Spell",
            attackWidth: 1, attackRange: 1, power: 1.0, dmgType: "cold", fullBoundBonus: 4,
            regen: 0.02,
            maxblock: 0,
            maxdodge: 0,
            stamina: 2,
            events: [
                { trigger: "addEntity", type: "EpicenterAssignHP" },
                { trigger: "beforeDamage", type: "epicenterCursed" },
            ],
            terrainTags: { "curseTrap": 10 }, shrines: [], allFloors: true,
            dropTable: [{ name: "ManaOrb", weight: 1 }],
        },
        {
            name: "EpicenterCursed2", faction: "Curse", color: "#a4affa",
            tags: KDMapInit(["opendoors", "epicenterCursed", "epicenter", "curseTrap", "ghost", "cursed", "soulimmune", "melee", "fireweakness", "shadowimmune", "glueimmune", "chainimmune", "shadowHands", "poisonimmune", "meleeresist", "flying"]),
            ignorechance: 0, armor: 0, followRange: 1, AI: "huntshadow", noAlert: true, hitsfx: "Evil",
            ethereal: true,
            spells: ["ManyShadowHands", "ManyMithrilBolts", "CorruptedCursingCircle"/*"CursingCircle2", "CursingCircle2"*/], spellCooldownMult: 1.1, spellCooldownMod: 0, castWhileMoving: true,
            visionRadius: 15, blindSight: 8, evasion: -2, maxhp: 61.7, minLevel: 0, weight: 0,
            movePoints: 4, attackPoints: 2, attack: "Spell",
            attackWidth: 1, attackRange: 1, power: 1.0, dmgType: "cold", fullBoundBonus: 4,
            regen: 0.02,
            maxblock: 0,
            maxdodge: 0,
            stamina: 2,
            events: [
                { trigger: "addEntity", type: "EpicenterAssignHP" },
                { trigger: "beforeDamage", type: "epicenterCursed" },
            ],
            terrainTags: { "curseTrap": 10 }, shrines: [], allFloors: true,
            dropTable: [{ name: "ManaOrb", weight: 1 }],
        },
    );

    KinkyDungeonSpellListEnemies.push(
        {
            enemySpell: true, name: "CorruptedCursingCircle", color: KDBaseRed, minRange: 0, sfx: "Fwoosh", bulletSpin: 0.1, specialCD: 12,
            selfcast: true, noTerrainHit: true,
            manacost: 4, components: ["Verbal"], level: 1, type: "inert", onhit: "aoe", time: 4, delay: 3, power: 4, range: 7, size: 5, aoe: 2.5, lifetime: 1, damage: "soul",
            //playerEffect: {name: "CursingCircle", count: 1, kind: "cursedCollar", power: 3.5, damage: "soul", time: 40},
            events: [
                { trigger: "bulletTick", type: "CorruptedCursingCircle", aoe: 2.5, power: 0.01 },
            ],
        },
    );

    KDEventMapBullet.bulletTick.CorruptedCursingCircle = (e, b, data) => {
        if (KDUtilCommon.PlayerWearsRestraint(cRestraints.corruptedCursedEpicenterEncasement) || KDUtilCommon.AmountRestraintWithShrine("Shadow") < 5 || b.time > 1) return;
        if (KDistChebyshev(KinkyDungeonPlayerEntity.x - b.x, KinkyDungeonPlayerEntity.y - b.y) <= e.aoe) {
            let enemies = KDNearbyEnemies(KinkyDungeonPlayerEntity.x, KinkyDungeonPlayerEntity.y, e.aoe);
            const equippedRestraints = KinkyDungeonAllRestraint();

            KDBreakTether(KinkyDungeonPlayerEntity);
            KinkyDungeonPassOut(true);
            KinkyDungeonAddRestraintIfWeaker(cRestraints.corruptedCursedEpicenterEncasement, 0, true, "Red", false, undefined, undefined, "Corrupted", true);

            for (const enemy of enemies) {
                if (enemy.Enemy.name === "EpicenterCursed") {
                    KinkyDungeonAddRestraintIfWeaker("CursedCollar", 15, true, "Red", false, undefined, undefined, "Corrupted", true);
                    KDRemoveEntity(enemy);
                    break;
                } else if (enemy.Enemy.name === "EpicenterCursed2") {
                    KinkyDungeonAddRestraintIfWeaker("CursedCollar2", 15, true, "Red", false, undefined, undefined, "Corrupted", true);
                    KDRemoveEntity(enemy);
                    break;
                }
            }

            for (const restraint of equippedRestraints) {
                if (restraint) {
                    if (restraint.name && (restraint.name === "CursedCollar" || restraint.name === "CursedCollar2" || restraint.name === cRestraints.corruptedCursedEpicenterEncasement)) continue;
                    if (restraint.curse && restraint.curse === "CursedDamage") continue;
                    if (KDRandom() > 0.8) {
                        restraint.curse = "CursedDamage";
                        if (KDRandom() > 0.7) {
                            continue;
                        }
                        break;
                    }
                }
            }
        }
    }
    KDUtilCommon.SetSpellCastText("CorruptedCursingCircle", "Epicenter Cursed casts the circle of curse!");
}
// ===================================================================================================
//#     ____                            _           _      _    _      _                    _     _   
//#    / ___|___  _ __ _ __ _   _ _ __ | |_ ___  __| |    / \  | | ___| |__   ___ _ __ ___ (_)___| |_ 
//#   | |   / _ \| '__| '__| | | | '_ \| __/ _ \/ _` |   / _ \ | |/ __| '_ \ / _ \ '_ ` _ \| / __| __|
//#   | |__| (_) | |  | |  | |_| | |_) | ||  __/ (_| |  / ___ \| | (__| | | |  __/ | | | | | \__ \ |_ 
//#    \____\___/|_|  |_|   \__,_| .__/ \__\___|\__,_| /_/   \_\_|\___|_| |_|\___|_| |_| |_|_|___/\__|
//#                              |_|                                                                  
// ===================================================================================================

function AddAlchemistSet() {
    KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedAlchemistHeels + '2'), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
    ToArrayDeepSearch(aRestraintsNeed).forEach(val => KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(val), 0, true, undefined, false, undefined, undefined, undefined, true));
    //KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedAlchemistHeels + '2'));
    KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedAlchemistHeels + '2'), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
    KinkyDungeonSetDress(CorruptedAlchemistPetDress, CorruptedAlchemistPetDress);
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
const CorruptedAlchemistPetDress = "AlchemistPet";
const perkId = "AlchemistPet";
const aRestraintsNeed = [
    cRestraints.corruptedAlchemistCorset,
    cRestraints.corruptedAlchemistBallGag,
    cRestraints.corruptedAlchemistCollar,
    cRestraints.corruptedAlchemistHeels,
    cRestraints.corruptedAlchemistArmbinder,
    cRestraints.corruptedAlchemistLeash,
];

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
                KinkyDungeonSetDress(CorruptedAlchemistPetDress, CorruptedAlchemistPetDress);
                if (!KinkyDungeonInventoryGet(CorruptedAlchemistPetDress)) {
                    let outfit = { name: CorruptedAlchemistPetDress, id: KinkyDungeonGetItemID(), type: "Outfit" };
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
        if (!KinkyDungeonInventoryGet(cRestraints.corruptedAlchemistLeash)) {
            KDBreakTether(entity);
            KinkyDungeonExpireBuff(entity, alchemistDommedFlag);
        }
    }
};

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

// ==========================================================================
//#     ____                            _           _   __  __       _     _ 
//#    / ___|___  _ __ _ __ _   _ _ __ | |_ ___  __| | |  \/  | __ _(_) __| |
//#   | |   / _ \| '__| '__| | | | '_ \| __/ _ \/ _` | | |\/| |/ _` | |/ _` |
//#   | |__| (_) | |  | |  | |_| | |_) | ||  __/ (_| | | |  | | (_| | | (_| |
//#    \____\___/|_|  |_|   \__,_| .__/ \__\___|\__,_| |_|  |_|\__,_|_|\__,_|
//#                              |_|                                         
// ==========================================================================

const corruptedMaidPetDress = "MaidPet";
const corruptedMaidName = "CorruptedMaid";
const corruptedMaidText = "Corrupted Maid";
const corruptedMaidDomFlag = "CorruptedMaidDom";
const dressingUpRestraint = "RopeSnakeHogtieWrist";
let restraintsToAddMaid = [
    "CorruptedMaidLeatherHeels",
    "DusterGag",
    "CorruptedMaidAnkleCuffs",
    "CorruptedMaidLegShackles",
    "CorruptedMaidElbowShackles",
    "CorruptedMaidBelt",
    "CorruptedMaidArmbinder",
    "CorruptedMaidCollar"
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

KDEventMapEnemy.beforeDamage.corruptedMaid = (e, enemy, data) => {
    if (data.enemy === enemy && data.target === KinkyDungeonPlayerEntity && !data.restrainsAdded) {
        if (KinkyDungeonFlags.get(corruptedMaidDomFlag)) return;
        let restraintAdded = false;
        for (const restraintName of restraintsToAddMaid) {
            if (KDUtilCommon.PlayerWearsRestraint(restraintName)) continue;

            const restraint = KinkyDungeonGetRestraintByName(restraintName);
            if (!restraint || !restraint.name) {
                console.log("Corrupted maid couldn't find the restraint with name: ", restraintName);
                continue;
            }
            if (KinkyDungeonAddRestraintIfWeaker(restraintName, 0, true, undefined, false, undefined, undefined, undefined, true)) {
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

            if (KinkyDungeonCurrentDress !== corruptedMaidPetDress) {
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
        KinkyDungeonSetDress(corruptedMaidPetDress, corruptedMaidPetDress);
        if (!KinkyDungeonInventoryGet(corruptedMaidPetDress)) {
            let outfit = { name: corruptedMaidPetDress, id: KinkyDungeonGetItemID(), type: "Outfit" };
            KinkyDungeonInventoryAdd(outfit);
        }
        KinkyDungeonMapParams[KinkyDungeonMapIndex[MiniGameKinkyDungeonCheckpoint]].defeat_outfit = corruptedMaidPetDress;
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

KDUtilCommon.SetEnemyNameText(corruptedMaidName, corruptedMaidText);
KDUtilCommon.SetEnemyAttackText(corruptedMaidName, `${corruptedMaidText} tickles your body...`);
KDUtilCommon.SetEnemyAttackWithBindText(corruptedMaidName, `${corruptedMaidText} binds you with (+RestraintAdded)!`);
KDUtilCommon.SetEnemyLockText(corruptedMaidName, `${corruptedMaidText} seals some locks your restraint!`);

// ============================================================================================
//#     ____                            _           _   __  __                                 
//#    / ___|___  _ __ _ __ _   _ _ __ | |_ ___  __| | |  \/  |_   _ _ __ ___  _ __ ___  _   _ 
//#   | |   / _ \| '__| '__| | | | '_ \| __/ _ \/ _` | | |\/| | | | | '_ ` _ \| '_ ` _ \| | | |
//#   | |__| (_) | |  | |  | |_| | |_) | ||  __/ (_| | | |  | | |_| | | | | | | | | | | | |_| |
//#    \____\___/|_|  |_|   \__,_| .__/ \__\___|\__,_| |_|  |_|\__,_|_| |_| |_|_| |_| |_|\__, |
//#                              |_|                                                     |___/ 
// ============================================================================================

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

KDUtilCommon.SetEnemyNameText(corruptedMummyName, corruptedMummyText);
KDUtilCommon.SetEnemyAttackText(corruptedMummyName, `${corruptedMummyText} tickles your body...`);
KDUtilCommon.SetEnemyAttackWithBindText(corruptedMummyName, `${corruptedMummyText} binds you with (+RestraintAdded)!`);
KDUtilCommon.SetEnemyLockText(corruptedMummyName, `${corruptedMummyText} seals some locks your restraint!`);

// =====================================================================================================
//#     ____                            _           _   _          _               ____      _          
//#    / ___|___  _ __ _ __ _   _ _ __ | |_ ___  __| | | |    __ _| |_ _____  __  / ___|   _| |__   ___ 
//#   | |   / _ \| '__| '__| | | | '_ \| __/ _ \/ _` | | |   / _` | __/ _ \ \/ / | |  | | | | '_ \ / _ \
//#   | |__| (_) | |  | |  | |_| | |_) | ||  __/ (_| | | |__| (_| | ||  __/>  <  | |__| |_| | |_) |  __/
//#    \____\___/|_|  |_|   \__,_| .__/ \__\___|\__,_| |_____\__,_|\__\___/_/\_\  \____\__,_|_.__/ \___|
//#                              |_|                                                                    
// =====================================================================================================

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

KDEventMapEnemy.beforeDamage.cubeEngulf = (e, enemy, data) => {
    const totalSlimeRestraints = KDUtilCommon.RestraintWithEnemyTagCount("latexEncaseRandom");
    if (data.enemy === enemy && data.target === KinkyDungeonPlayerEntity && /*data.restraintsAdded && data.restraintsAdded.length === 0 &&*/ totalSlimeRestraints > 3 && !KinkyDungeonFlags.get(engulfFlag)) {
        KDTripleBuffKill("CubeEngulf", KinkyDungeonPlayerEntity, 9, (tt) => {
            KinkyDungeonSetDress("SlimeDress", "SlimeDress");
            KDBreakTether(KinkyDungeonPlayerEntity);
            KDRemoveEntity(enemy);

            KinkyDungeonRemoveRestraintsWithShrine("Slime");
            KinkyDungeonRemoveRestraintsWithShrine("SlimeHard");
            KinkyDungeonRemoveRestraintsWithShrine("Latex");

            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeEncasement), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeCuffs), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeBallGag), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeLeash), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeBlindfold), 0, true, undefined, false, undefined, undefined, "Corrupted", true);
        }, "Blindness");
    }
};

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
