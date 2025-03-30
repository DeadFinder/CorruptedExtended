const engulfFlag = "CubeEngulfed";
const corruptedCube = "CorruptedLatexCube";

KinkyDungeonEnemies.push({
    name: corruptedCube, faction: "Latex", color: "#aa00cc",
    tags: KDMapInit(["unstoppable", "slime", "latex", "latexTrap", "elite", "slashweakness", "melee", "chainimmune", "glueresist", "coldweakness", "electricresist", "pierceweakness", "acidweakness", "latexRestraints", "latexEncaseRandom"]),
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
    terrainTags: {"tmb": 3, "slime": 2.5, "plant": 2, "passage": 20, "open": -10, "slimeOptOut": -0.9, "slimePref": 1}, allFloors: true, shrines: ["Latex"],
    events: [
        {trigger: "afterDamageEnemy", type: "bleedEffectTile", kind: "Slime", aoe: 1.5, power: 3, chance: 1.0, duration: 20},
        {trigger: "afterEnemyTick", type: "createEffectTile", kind: "LatexThin", time: 25, power: 2, chance: 0.5, aoe: 0.5},
        {trigger: "beforeDamage", type: "cubeEngulf", power: 0, color: "#880044"},
    ],
    dropTable: [{name: "Gold", amountMin: 30, amountMax: 50, weight: 1}],
});

const corruptedSlimeMetalFilter = {"gamma": 1, "saturation": 1, "contrast": 1, "brightness": 2.8, "red": 1.1666666666666667, "green": 0.9, "blue": 2.2333333333333334, "alpha": 0.6};

const cRestraints = {
    collar: "CorruptedSlimeCollar",
    ankles: "CorruptedSlimeShacklesAnkle",
    legs: "CorruptedSlimeShacklesThigh",
    cuffs: "CorruptedSlimeShacklesWrists",
    leash: "CorruptedSlimeLeash",
    gag: "CorruptedSlimeLargeBallGag",
    blindfold: "CorruptedSlimeBlindfold",
    encasement: "CorruptedCubeEncasement"
};

const cOutfitColorDefault = {"gamma": 1.33, "saturation": 0.91, "contrast": 0.85, "brightness": 2.8, "red": 1.46, "green": 1, "blue": 1.85, "alpha": 0.70};
const cOutfitBikiniColor = {"gamma": 1.33, "saturation": 0.91, "contrast": 0.85, "brightness": 1.2, "red": 1.3, "green": 1.03, "blue": 3.63, "alpha": 0.41};

KDModelDresses.SlimeDress = [
    {
        Item: "VBikini", Group: "Panties", Color: "#53428D", Lost: false,
        Filters: {
            VBikini: cOutfitBikiniColor
        }
    },
    {
        Item: "LatexBra", Group: "Bra", Color: "#53428D", Lost: false,
        Filters: {
            Bra: cOutfitColorDefault
        }
    },
    {
        Item: "LatexBraStraps", Group: "LatexBra", Color: "#53428D", Lost: false,
        Filters: {
            Straps: cOutfitColorDefault
        }
    },
];

KinkyDungeonRestraints.push(
    {
        inventory: true, name: cRestraints.collar, linkCategory: "BasicCollar", accessible: true, Asset: "ElfCollar", Model: "ElfCollar", Color: ["Default"], Group: "ItemNeck", LinkableBy: [...KDCollarLink], power: 3, weight: 0, 
        escapeChance: {"Struggle": -0.5, "Cut": -0.4, "Remove": 0.5, "Pick": 0.05},
        maxwill: 0.25,
        Filters: {
            Collar: {"gamma": 1, "saturation": 1.0166666666666666, "contrast": 0.8666666666666667, "brightness": 0.9666666666666667, "red": 1.0833333333333335, "green": 1.0333333333333332, "blue": 4.183333333333334, "alpha": 0.6}
        },
        unlimited: true, enemyTags: {}, playerTags: {"ItemNeckFull": -2, "Unchained": -1, "Damsel": 1}, minLevel: 2, allFloors: true, shrine: ["Collars", "Metal", "AfterLeashDone"]
    },
    {
        inventory: true, name: cRestraints.ankles, accessible: true, Asset: "ShacklesAnkles", Model: "ShacklesAnkles", Color: ["#f0b541"], Group: "ItemFeet", LinkableBy: [...KDBindable, ...KDDevices], power: 3, weight: 0, 
        escapeChance: {"Struggle": -0.5, "Cut": -0.4, "Remove": 0.5, "Pick": 0.05},
        maxwill: 0.25,
        Filters: {
            BaseMetal: corruptedSlimeMetalFilter
        },
        unlimited: true, enemyTags: {}, playerTags: {"ItemFeetFull": -2}, minLevel: 2, allFloors: true, shrine: ["Metal", "Cuffs", "AfterLeashDone"]
    },
    {
        inventory: true, name: cRestraints.legs, Asset: "ShacklesThigh", Model: "ShacklesThigh", Color: ["#f0b541"], Group: "ItemLegs", LinkableBy: [...KDLegRopesBind], power: 3, weight: 0, 
        escapeChance: {"Struggle": -0.5, "Cut": -0.4, "Remove": 0.5, "Pick": 0.05},
        maxwill: 0.25,
        Filters: {
            BaseMetal: corruptedSlimeMetalFilter
        },
        unlimited: true, enemyTags: {}, playerTags: {"ItemLegsFull": -2}, minLevel: 2, allFloors: true, shrine: ["Metal", "Ties", "AfterLeashDone"]
    },
    {
        inventory: true, name: cRestraints.cuffs, Asset: "ShacklesWrists", Model: "ShacklesWrists", Color: ["#f0b541"], Group: "ItemArms", LinkableBy: [...KDElbowBind, ...KDBoxBind, ...KDBindable], power: 3, weight: 0, 
        escapeChance: {"Struggle": -0.5, "Cut": -0.4, "Remove": 0.5, "Pick": 0.05},
        maxwill: 0.25,
        Filters: {
            BaseMetal: corruptedSlimeMetalFilter
        },
        unlimited: true, enemyTags: {}, playerTags: {"ItemLegsFull": -2}, minLevel: 2, allFloors: true, shrine: ["Metal", "Ties", "AfterLeashDone"]
    },
    {
        inventory: true, removePrison: true, name: cRestraints.leash, tether: 2.9, Asset: "Leash", Color: "#edb3ff", Group: "ItemNeckRestraints", leash: true, power: 1, weight: -99, harness: true,
        unlimited: true,
        events: [
            {trigger: "postRemoval", type: "RequireCollar"}
        ],
        Filters: {
            Leash: {"gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1, "red": 1.2166666666666668, "green": 1, "blue": 2.45, "alpha": 1}
        },
        escapeChance: {"Struggle": -0.1, "Cut": 0.2, "Remove": 0.5, "Pick": 1.25}, enemyTags: {}, playerTags: {"ItemNeckRestraintsFull": -2, "ItemNeckFull": 99}, minLevel: 0, allFloors: true, shrine: ["AfterLeashDone"]
    },
    {
        removePrison: true, name: cRestraints.encasement, Asset: "VacCube", Model: cRestraints.encasement,
        Filters: {
            Slime: {"gamma": 1, "saturation": 1, "contrast": 1, "brightness": 0.65, "red": 0.9333333333333333, "green": 0.8833333333333333, "blue": 1.8166666666666667, "alpha": 0.7833333333333334}
        },
        Color: ["#ba50eb"], Group: "ItemDevices", power: 3, weight: 1, immobile: true, alwaysStruggleable: true,
        DefaultLock: "Red", removeOnLeash: true,
        escapeChance: {"Struggle": -0.2, "Cut": -0.2, "Remove": 0.35, "Pick": 0.33, "Unlock": 0.7},
        helpChance: {"Remove": 0.5, "Pick": 0.5, "Unlock": 1.0},
        enemyTags: {"latexcube": 100}, playerTags: {}, minLevel: 0, allFloors: true, shrine: ["Furniture"], ignoreSpells: true,
        events: [
            {trigger: "tick", type: "cageDebuff", inheritLinked: true},
            {trigger: "tick", type: "cubeEncasement"},
            {trigger: "postRemoval", type: "RequireEncasement"}
        ]
    },
    {
        inventory: true, name: cRestraints.blindfold, Model: "BlindfoldBasic",
        Filters: {
            Blindfold: {"gamma": 1.1, "saturation": 1, "contrast": 0.8, "brightness": 1.45, "red": 1.2, "green": 1, "blue": 1.9833333333333334, "alpha": 0.9},
            Rim: {"gamma": 1.05, "saturation": 1, "contrast": 0.43333333333333335, "brightness": 1.7833333333333334, "red": 1.3333333333333333, "green": 1, "blue": 1.7666666666666666, "alpha": 1}
        },
        debris: "Slime", inaccessible: true, linkCategory: "Slime", linkSize: 0.4, Asset: "LeatherSlimMask", Color: "#9B49BD", Group: "ItemHead", blindfold: 3, power: 4, weight: -103,
        power: 0.1, weight: 2, escapeChance: {"Struggle": 0.22, "Cut": 0, "Remove": 0}, 
        events: [
            {trigger: "beforeStruggleCalc", type: "boostWater", power: 0.1}
        ], 
        failSuffix: {"Remove": "Slime"}, affinity: {Struggle: ["Edge"], Remove: ["Edge"]},
        factionColor: [[], [0]], enemyTags: {}, playerTags: {}, minLevel: 0, allFloors: true, shrine: ["Latex", "Wrapping", "Slime"], addTag: ["slime"]
    },
    {
        inventory: true, name: cRestraints.gag, linkCategory: "Slime", linkSize: 0.2, factionColor: [[], [0]], Asset: "BallGag", weight: -103,
        gag: 0.75, Color: ["#9B49BD", "#9B49BD"], Type: "Tight", Group: "ItemMouth", power: 4, 
        escapeChance: {"Struggle": 0.22, "Cut": 0, "Remove": 0}, 
        events: [
            {trigger: "beforeStruggleCalc", type: "boostWater", power: 0.1}
        ], 
        failSuffix: {"Remove": "Slime"}, affinity: {Struggle: ["Edge"], Remove: ["Edge"]},
        Model: "SmoothLargeBallGag",
        Filters: {
            Ball: {"gamma": 1, "saturation": 0.18333333333333335, "contrast": 0.13333333333333333, "brightness": 1.4166666666666665, "red": 1.1833333333333333, "green": 0.7666666666666666, "blue": 2, "alpha": 0.6},
            Strap: {"gamma": 1, "saturation": 0.18333333333333335, "contrast": 0.13333333333333333, "brightness": 1.4166666666666665, "red": 1.1833333333333333, "green": 0.7666666666666666, "blue": 2, "alpha": 0.6}
        },
        maxwill: 0.8, enemyTags: {}, playerTags: {}, minLevel: 0, allFloors: true, shrine: ["Latex", "Gags", "Slime"], addTag: ["slime"]
    }
);

AddModel({
    Name: cRestraints.encasement,
    Folder: "Furniture",
    TopLevel: true,
    Group: "Devices",
    Restraint: true,
    Categories: ["Restraints", "Furniture", "Latex"],
    AddPose: ["UprightHogtie", "ForceKneel"],
    Layers: ToLayerMap([
        { Name: "LatexCube", Layer: "FurnitureFront", Pri: -40, Invariant: true, InheritColor: "Slime" },
        { Name: "LatexCubeBack", Layer: "FurnitureBack", Pri: 40, Invariant: true, InheritColor: "Slime" },
    ])
});

KDEventMapEnemy.beforeDamage.cubeEngulf = (e, enemy, data) => {
    const totalSlimeRestraints = KDUtilCommon.RestraintWithEnemyTagCount("latexEncaseRandom");
    if (data.enemy === enemy && data.target === KinkyDungeonPlayerEntity && data.restraintsAdded && data.restraintsAdded.length === 0 && totalSlimeRestraints > 3 && !KinkyDungeonFlags.get(engulfFlag)) {
        KDTripleBuffKill("CubeEngulf", KinkyDungeonPlayerEntity, 9, (tt) => {
            KinkyDungeonSetDress("SlimeDress", "SlimeDress"); // Добавлен второй аргумент для соответствия новому синтаксису
            KDBreakTether(KinkyDungeonPlayerEntity);

            enemy.hp = 0;
            KinkyDungeonRemoveRestraintsWithShrine("Slime");
            KinkyDungeonRemoveRestraintsWithShrine("SlimeHard");
            KinkyDungeonRemoveRestraintsWithShrine("Latex");

            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.encasement), 0, true, "Red");
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.cuffs), 0, true, "Rubber");
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.collar), 0, true, "Rubber");
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.ankles), 0, true, "Rubber");
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.legs), 0, true, "Rubber");
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.gag), 0, true, "Rubber");
            KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.blindfold), 0, true, "Rubber");
        }, "Blindness");
    }
};

KDEventMapInventory.postRemoval.RequireEncasement = (e, item, data) => {
    if (data.item === item) {
        for (let inv of KinkyDungeonAllRestraint()) {
            if (inv.name === cRestraints.encasement) {
                return; // Прерываем цикл, если encasement всё ещё есть
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
                {type: engulfFlag, trigger: "tickAfter"}
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

KDUtilCommon.SetBuffText(engulfFlag, "Encasement: The HP left of this encasement.");

KDEventMapBuff.tickAfter[engulfFlag] = (e, buff, entity, data) => {
    if (buff.duration > 0) {
        if (entity.player) {
            if (buff.duration < 45 && KDRandom() < 0.35) {
                KinkyDungeonSendTextMessage(5, "Corrupted slime moves around with you!", "#9074ab", 10);
                let nearbyPoint = KinkyDungeonGetNearbyPoint(entity.x, entity.y, true, null, true, true);
                if (nearbyPoint) { // Добавлена проверка на существование точки
                    KinkyDungeonMoveTo(nearbyPoint.x, nearbyPoint.y, false, false, true, false);
                }
            }
        }
    } else {
        KinkyDungeonSendTextMessage(5, "The slime melted out and you break free.", "#9074ab", 10);
        KinkyDungeonRemoveRestraintsWithName(cRestraints.encasement);
        KinkyDungeonUnlockRestraintsWithShrine("AfterLeashDone");
    }
};

KDUtilCommon.SetEnemyNameText(corruptedCube, "Corrupted Latex Cube");
KDUtilCommon.SetEnemyAttackText(corruptedCube, "Corrupted Latex Cube gropes around your body...");
KDUtilCommon.SetEnemyAttackWithBindText(corruptedCube, "Corrupted Latex Cube spits some slime on you!");
KDUtilCommon.SetEnemyKillText(corruptedCube, "Corrupted Latex Cube melts away.");

KinkyDungeonAddRestraintText(cRestraints.encasement, "Corrupted Cube Encasement", "A latex cube formed in square shape.", "You feel ticklish when you're inside this.");
KinkyDungeonAddRestraintText(cRestraints.collar, "Shining Collar", "A collar created by a magical slime.", "Maybe this slime actually stole some items around...");
KinkyDungeonAddRestraintText(cRestraints.ankles, "Corrupted Slime Ankles", "Sturdy ankle metal cuffs corrupted with slime goo.", "It's a bit transparent and glows with some sort of aura.");
KinkyDungeonAddRestraintText(cRestraints.blindfold, "Corrupted Slime Blindfold", "Some slime substance covering your eyes.", "You can a bit see through this transparent material.");
KinkyDungeonAddRestraintText(cRestraints.cuffs, "Corrupted Slime Cuffs", "Sturdy wrist metal cuffs corrupted with slime goo.", "It's a bit transparent and glows with some sort of aura.");
KinkyDungeonAddRestraintText(cRestraints.legs, "Corrupted Slime Thigh Cuffs", "Sturdy wrist metal thigh cuffs corrupted with slime goo.", "It's a bit transparent and glows with some sort of aura.");
KinkyDungeonAddRestraintText(cRestraints.gag, "Corrupted Slime Gag", "Glurg... Mpph?", "Covers your lips with a large slime ball goo, effectively silencing you.");
KinkyDungeonAddRestraintText(cRestraints.leash, "Slime Leash", "A leash made of sticky goo.", "It's actually a part of this slime's body...");

KDUtilCommon.SetTripleBuffTexts("CubeEngulf", [
    "The slime starts engulfing you!",
    "Your body starts going numb...",
    "The Slime engulfed you in its body!"
]);