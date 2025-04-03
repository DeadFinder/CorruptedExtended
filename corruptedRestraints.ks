let KDUtilCommon = window.KDUtilCommon;
const cRestraints = {
    // Mummy
    corruptedMummyHardSlimeFeet: "CorruptedHardSlimeFeet",
    corruptedMummyHardSlimeBoots: "CorruptedHardSlimeBoots",
    corruptedMummyHardSlimeLegs: "CorruptedHardSlimeLegs",
    corruptedMummyHardSlimeArms: "CorruptedHardSlimeArms",
    corruptedMummyHardSlimeHands: "CorruptedHardSlimeHands",
    corruptedMummyHardSlimeMouth: "CorruptedHardSlimeMouth",
    corruptedMummyHardSlimeHead: "CorruptedHardSlimeHead",
    corruptedMummyCollar: "CorruptedMummyCollar",
    // Cube
    corruptedCubeCollar: "CorruptedSlimeCollar",
    corruptedCubeAnkles: "CorruptedSlimeShacklesAnkle",
    corruptedCubeLegs: "CorruptedSlimeShacklesThigh",
    corruptedCubeCuffs: "CorruptedSlimeShacklesWrists",
    corruptedCubeLeash: "CorruptedSlimeLeash",
    corruptedCubeBallGag: "CorruptedSlimeLargeBallGag",
    corruptedCubeBlindfold: "CorruptedSlimeBlindfold",
    corruptedCubeWristShackles: "CorruptedCubeSlimeShacklesWrists",
    corruptedCubeThighShackles: "CorruptedCubeSlimeShacklesThigh",
    corruptedCubeAnkleShackles: "CorruptedCubeSlimeShacklesAnkle",
    corruptedCubeLargeBallGag: "CorruptedCubeSlimeLargeBallGag",
    corruptedCubeBlindfold: "CorruptedCubeSlimeBlindfold",
    corruptedCubeEncasement: "CorruptedCubeEncasement",
    // Maid
    corruptedMaidLeatherHeels: "CorruptedMaidLeatherHeels",
    corruptedMaidDusterGag: "CorruptedMaidDusterGag",
    corruptedMaidAnkleCuffs: "CorruptedMaidAnkleCuffs",
    corruptedMaidAnkleCuffs2: "CorruptedMaidAnkleCuffs2",
    corruptedMaidLegShackles: "CorruptedMaidLegShackles",
    corruptedMaidLegShackles2: "CorruptedMaidLegShackles2",
    corruptedMaidElbowShackles: "CorruptedMaidElbowShackles",
    corruptedMaidBelt: "CorruptedMaidBelt",
    corruptedMaidArmbinder: "CorruptedMaidArmbinder",
    corruptedMaidVibe: "CorruptedMaidVibe",
    corruptedMaidChastityBelt: "CorruptedMaidCBelt",
    corruptedMaidNippleWeights: "CorruptedMaidNippleWeights",
    corruptedMaidTrapBra: "CorruptedMaidTrapBra",
    corruptedMaidCollar: "CorruptedMaidCollar",
    corruptedMaidLeash: "CorruptedMaidLeash",
    // Alchemist
    corruptedAlchemistCorset: "CorruptedAlchemistPetCorset",
    corruptedAlchemistBallGag: "CorruptedAlchemistPetBallGag",
    corruptedAlchemistCollar: "CorruptedAlchemistPetCollar",
    corruptedAlchemistHeels: "CorruptedAlchemistPetHeels",
    corruptedAlchemistArmbinder: "CorruptedAlchemistPetArmbinder",
    corruptedAlchemistLeash: "CorruptedAlchemistPetLeash"
};

window.KDModData.corruptedRestraints = window.KDModData.corruptedRestraints || cRestraints;

// Corrupted Mummy Restraints
KinkyDungeonRestraints.push({
    inventory: true,
    name: cRestraints.corruptedMummyCollar,
    Asset: "LeatherCollar",
    Model: "LeatherCollar",
    Color: "#aa00cc",
    Group: "ItemNeck",
    power: 3,
    weight: 0,
    escapeChance: { "Struggle": 1.0, "Cut": 1.0, "Remove": 1.0, "Pick": 0.05 },
    maxwill: 0.25,
    Filters: {
        Collar: { "gamma": 1.0, "saturation": 0.6, "contrast": 1.0, "brightness": 0.6, "red": 1.0, "green": 0.7, "blue": 1.8, "alpha": 1 },
    },
    enemyTags: { "CorruptedMummy": 5 },
    minLevel: 0,
    allFloors: true,
    shrine: ["Ancient", "Collars", "Corrupted"],
    LinkableBy: ["HighCollars", "Collars", "Modules"],
    events: [
        { trigger: "tick", type: "corruptedMummyCollarTick" },
        { trigger: "beforeStruggleCalc", type: "corruptedMummyCollarStruggle" }
    ]
});

KDEventMapInventory.tick.corruptedMummyCollarTick = (e, item, data) => {
    if (item.name === cRestraints.corruptedMummyCollar) {
        const corruptedRestraints = [cRestraints.corruptedMummyHardSlimeFeet, cRestraints.corruptedMummyHardSlimeBoots, cRestraints.corruptedMummyHardSlimeLegs, cRestraints.corruptedMummyHardSlimeArms, cRestraints.corruptedMummyHardSlimeHands, cRestraints.corruptedMummyHardSlimeMouth, cRestraints.corruptedMummyHardSlimeHead];
        const equippedRestraints = KinkyDungeonAllRestraint().map(inv => inv.name);
        //let tile = KinkyDungeonTilesGet(`${KinkyDungeonPlayerEntity.x},${KinkyDungeonPlayerEntity.y}`);
        if (KinkyDungeonBrightnessGet(KinkyDungeonPlayerEntity.x, KinkyDungeonPlayerEntity.y) < 1.5 || KinkyDungeonStatWill < 12.5) {
            for (const restraintName of corruptedRestraints) {
                if (equippedRestraints.includes(restraintName)) {
                    continue;
                }
                let wtf = Math.min(1.0, 0.9 + (0.01 * (corruptedRestraints.indexOf(restraintName) + 1)));
                if (KDRandom() > wtf) {
                    KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(restraintName), 0, true, undefined, false, undefined, undefined, undefined, item.faction);
                    KinkyDungeonSendTextMessage(10, "The corrupted mummy collar oozes corruption onto you..", "#aa00cc", 2, true);
                }
                break;
            }
        }
    }
};


KDEventMapInventory.beforeStruggleCalc.corruptedMummyCollarStruggle = (e, item, data) => {
    if (data.restraint && data.restraint.name === cRestraints.corruptedMummyCollar) {
        if (KinkyDungeonBrightnessGet(KinkyDungeonPlayerEntity.x, KinkyDungeonPlayerEntity.y) < 1.5 || KinkyDungeonStatWill < 12.5) {
            KinkyDungeonLock(item, "Divine2", false, false, false, false);
            data.escapeChance = -1000;
            item.tightness = 10000;
        } else {
            KinkyDungeonLock(item, "", false, false, false, false);
            data.escapeChance = 1000;
            item.tightness = 0;
        }
    }
};

let KDRubberLink = ["Wrapping", "Tape", "Belts", "Masks", "Mittens"];
KinkyDungeonRestraints.push(
    {
        inventory: true, unlimited: true, removePrison: true, name: cRestraints.corruptedMummyHardSlimeBoots, debris: "Slime", linkCategory: "Slime", linkSize: 0.6, LinkableBy: [...KDRubberLink], renderWhenLinked: [...KDRubberLink], inaccessible: true, Asset: "ToeTape", Type: "Full", Color: "#332437", Group: "ItemBoots", blockfeet: true, addTag: ["FeetLinked"], power: 5, weight: 0,
        escapeChance: { "Struggle": 0, "Cut": 0.1, "Remove": 0 }, failSuffix: { "Remove": "SlimeHard" },
        affinity: { Struggle: ["Sharp",], Remove: ["Hook"], },
        Filters: { Rubber: { "gamma": 1.0, "saturation": 0.6, "contrast": 1.0, "brightness": 0.6, "red": 1.0, "green": 0.7, "blue": 1.8, "alpha": 1 } },
        Model: "RubberBoots",
        enemyTags: { "latexEncase": 100, "latexEncaseRandom": 103 }, playerTags: {},
        minLevel: 0, allFloors: true, shrine: ["Latex", "Wrapping", "SlimeHard", "Rubber"],
        events: [
            { trigger: "beforeStruggleCalc", type: "corruptedMummyHardSlimeStruggle" }
        ]
    },
    {
        inventory: true, unlimited: true, removePrison: true, name: cRestraints.corruptedMummyHardSlimeFeet, debris: "Slime", linkCategory: "Slime", linkSize: 0.6, LinkableBy: [...KDRubberLink], renderWhenLinked: [...KDRubberLink], inaccessible: true, Asset: "DuctTape", Type: "CompleteFeet", OverridePriority: 24, Color: "#332437", Group: "ItemFeet", blockfeet: true, addTag: ["FeetLinked"], power: 6, weight: -100,
        escapeChance: { "Struggle": 0.0, "Cut": 0.1, "Remove": 0 }, failSuffix: { "Remove": "SlimeHard" },
        affinity: { Struggle: ["Sharp",], Remove: ["Hook"], },
        Filters: { Rubber: { "gamma": 1.0, "saturation": 0.6, "contrast": 1.0, "brightness": 0.6, "red": 1.0, "green": 0.7, "blue": 1.8, "alpha": 1 } },
        Model: "RubberFeet",
        enemyTags: { "latexEncase": 100, "latexEncaseRandom": 103 }, playerTags: { "ItemBootsFull": 15 },
        minLevel: 0, allFloors: true, shrine: ["Latex", "Wrapping", "SlimeHard", "Rubber"]
    },
    {
        inventory: true, unlimited: true, removePrison: true, name: cRestraints.corruptedMummyHardSlimeLegs, debris: "Slime", linkCategory: "Slime", linkSize: 0.6, LinkableBy: [...KDRubberLink], renderWhenLinked: [...KDRubberLink], inaccessible: true, remove: ["ClothLower"], Asset: "SeamlessHobbleSkirt", Color: "#332437", Group: "ItemLegs", hobble: 1, addTag: ["FeetLinked"], power: 6, weight: -102,
        escapeChance: { "Struggle": 0.0, "Cut": 0.1, "Remove": 0 }, failSuffix: { "Remove": "SlimeHard" },
        affinity: { Struggle: ["Sharp",], Remove: ["Hook"], },
        Filters: { Rubber: { "gamma": 1.0, "saturation": 0.6, "contrast": 1.0, "brightness": 0.6, "red": 1.0, "green": 0.7, "blue": 1.8, "alpha": 1 } },
        Model: "RubberLegs",
        enemyTags: { "latexEncase": 100, "latexEncaseRandom": 103 }, playerTags: { "ItemFeetFull": 2, "ItemBootsFull": 2 },
        minLevel: 0, allFloors: true, shrine: ["Latex", "Hobbleskirts", "Wrapping", "SlimeHard", "Rubber"],
        events: [
            { trigger: "beforeStruggleCalc", type: "corruptedMummyHardSlimeStruggle" }
        ]
    },
    {
        inventory: true, unlimited: true, removePrison: true, name: cRestraints.corruptedMummyHardSlimeArms, debris: "Slime", linkCategory: "Slime", linkSize: 0.6, LinkableBy: [...KDRubberLink], renderWhenLinked: [...KDRubberLink], inaccessible: true, remove: ["Bra"], Asset: "StraitLeotard", Modules: [0, 0, 0, 0], Color: ["#332437", "#332437", "#332437"], Group: "ItemArms", bindarms: true, bindhands: 0.35, power: 8, weight: -102,
        escapeChance: { "Struggle": 0.0, "Cut": 0.1, "Remove": 0 }, failSuffix: { "Remove": "SlimeHard" },
        affinity: { Struggle: ["Sharp",], Remove: ["Hook"], },
        Filters: { Rubber: { "gamma": 1.0, "saturation": 0.6, "contrast": 1.0, "brightness": 0.6, "red": 1.0, "green": 0.7, "blue": 1.8, "alpha": 1 } },
        Model: "RubberArms",
        enemyTags: { "latexEncase": 100, "latexEncaseRandom": 103 }, playerTags: { "ItemFeetFull": 2, "ItemBootsFull": 2, "ItemLegsFull": 2 },
        minLevel: 0, allFloors: true, shrine: ["Latex", "SlimeHard", "Rubber", "Wrapping"],
        events: [
            { trigger: "beforeStruggleCalc", type: "corruptedMummyHardSlimeStruggle" }
        ]
    },
    {
        inventory: true, unlimited: true, removePrison: true, name: cRestraints.corruptedMummyHardSlimeHands, debris: "Slime", linkCategory: "Slime", linkSize: 0.6, LinkableBy: [...KDRubberLink], renderWhenLinked: [...KDRubberLink], inaccessible: true, Asset: "DuctTape", Color: "#332437", Group: "ItemHands", bindhands: 0.65, power: 5, weight: -102,
        escapeChance: { "Struggle": 0.0, "Cut": 0.1, "Remove": 0 }, failSuffix: { "Remove": "SlimeHard" },
        affinity: { Struggle: ["Sharp",], Remove: ["Hook"], },
        Filters: { Rubber: { "gamma": 1.0, "saturation": 0.6, "contrast": 1.0, "brightness": 0.6, "red": 1.0, "green": 0.7, "blue": 1.8, "alpha": 1 } },
        Model: "RubberHands",
        enemyTags: { "latexEncase": 100, "latexEncaseRandom": 103 }, playerTags: { "ItemFeetFull": 1, "ItemBootsFull": 1, "ItemLegsFull": 1, "ItemHeadFull": 1 },
        minLevel: 0, allFloors: true, shrine: ["Latex", "Wrapping", "SlimeHard", "Rubber"],
        events: [
            { trigger: "beforeStruggleCalc", type: "corruptedMummyHardSlimeStruggle" }
        ]
    },
    {
        inventory: true, unlimited: true, removePrison: true, name: cRestraints.corruptedMummyHardSlimeMouth, debris: "Slime", linkCategory: "Slime", linkSize: 0.6, inaccessible: true, Asset: "KittyGag", LinkableBy: [...KDRubberLink], renderWhenLinked: [...KDRubberLink], Color: ["#332437", "#332437", "#332437"], Group: "ItemMouth", AssetGroup: "ItemMouth3", gag: 0.75, power: 6, weight: -102,
        escapeChance: { "Struggle": 0.0, "Cut": 0.1, "Remove": 0 }, failSuffix: { "Remove": "SlimeHard" },
        affinity: { Struggle: ["Sharp",], Remove: ["Hook"], },
        Filters: { Rubber: { "gamma": 1.0, "saturation": 0.6, "contrast": 1.0, "brightness": 0.6, "red": 1.0, "green": 0.7, "blue": 1.8, "alpha": 1 } },
        Model: "RubberMouth",
        enemyTags: { "latexEncase": 100, "latexEncaseRandom": 103 }, playerTags: { "ItemFeetFull": 1, "ItemBootsFull": 1, "ItemLegsFull": 1, "ItemHandsFull": 1, "ItemArmsFull": 1 },
        minLevel: 0, allFloors: true, shrine: ["Latex", "Wrapping", "SlimeHard", "Rubber", "Gags", "FlatGag"],
        events: [
            { trigger: "beforeStruggleCalc", type: "corruptedMummyHardSlimeStruggle" }
        ]
    },
    {
        inventory: true, unlimited: true, removePrison: true, name: cRestraints.corruptedMummyHardSlimeHead, debris: "Slime", linkCategory: "Slime", linkSize: 0.6, LinkableBy: [...KDRubberLink], renderWhenLinked: [...KDRubberLink], inaccessible: true, Asset: "LeatherSlimMask", Color: "#332437", Group: "ItemHead", gag: 0.5, blindfold: 4, power: 6, weight: -102,
        escapeChance: { "Struggle": 0.0, "Cut": 0.1, "Remove": 0 }, failSuffix: { "Remove": "SlimeHard" },
        affinity: { Struggle: ["Sharp",], Remove: ["Hook"], },
        Filters: { Rubber: { "gamma": 1.0, "saturation": 0.6, "contrast": 1.0, "brightness": 0.6, "red": 1.0, "green": 0.7, "blue": 1.8, "alpha": 1 } },
        Model: "RubberHead",
        enemyTags: { "latexEncase": 100, "latexEncaseRandom": 103 }, playerTags: { "ItemFeetFull": 1, "ItemBootsFull": 1, "ItemLegsFull": 1, "ItemHandsFull": 1, "ItemArmsFull": 1, "ItemMouth3Full": 1, "Unmasked": -1000 },
        minLevel: 0, allFloors: true, shrine: ["Latex", "Wrapping", "Block_ItemMouth", "SlimeHard", "Rubber"],
        events: [
            { trigger: "beforeStruggleCalc", type: "corruptedMummyHardSlimeStruggle" }
        ]
    },
);

KDEventMapInventory.beforeStruggleCalc.corruptedMummyHardSlimeStruggle = (e, item, data) => {
    if (KDUtilCommon.PlayerWearsRestraint(cRestraints.corruptedMummyCollar)) {
        let breakable = [cRestraints.corruptedMummyHardSlimeHead, cRestraints.corruptedMummyHardSlimeMouth]
        if (!breakable.includes(data.restraint.name)) {
            data.escapeChance = -1000;
            KinkyDungeonSendTextMessage(10, "You feels like collar prevents you from doing this..", "#ff0000", 2, true);
        }
    }
};

// Corrupted Cube Restraints
KinkyDungeonRestraints.push({
    inventory: true,
    name: cRestraints.corruptedCubeCuffs,
    Asset: "ShacklesWrists",
    Model: "ShacklesWrists",
    Color: ["#f0b541"],
    Group: "ItemArms",
    power: 3,
    weight: 0,
    escapeChance: { "Struggle": -0.5, "Cut": -0.4, "Remove": 0.5, "Pick": 0.05 },
    maxwill: 0.25,
    Filters: {
        BaseMetal: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 2.8, "red": 1.1666666666666667, "green": 0.9, "blue": 2.2333333333333334, "alpha": 0.6 }
    },
    unlimited: true,
    enemyTags: {},
    playerTags: { "ItemArmsFull": -2 },
    minLevel: 2,
    allFloors: true,
    shrine: ["Metal", "Cuffs", "AfterLeashDone"]
}, {
    inventory: true,
    name: cRestraints.corruptedCubeLeash,
    Asset: "BasicLeash",
    Model: "BasicLeash",
    Color: "#aa00cc",
    Group: "ItemNeckRestraints",
    power: 2,
    weight: 0,
    escapeChance: { "Struggle": -0.3, "Cut": -0.2, "Remove": 0.6, "Pick": 0.1 },
    maxwill: 0.5,
    Filters: {
        Leash: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.5, "red": 1.5, "green": 0.8, "blue": 2.0, "alpha": 0.8 }
    },
    unlimited: true,
    enemyTags: { "latexEncaseRandom": 5 },
    playerTags: { "ItemNeckFull": -2 },
    minLevel: 0,
    allFloors: true,
    shrine: ["Leather", "Leash", "AfterLeashDone"]
}, {
    inventory: true,
    name: cRestraints.corruptedCubeBallGag,
    Asset: "BallGag",
    Model: "BallGag",
    Color: "#aa00cc",
    Group: "ItemMouth",
    power: 4,
    weight: 0,
    escapeChance: { "Struggle": -0.6, "Cut": -0.5, "Remove": 0.3, "Pick": 0.05 },
    maxwill: 0.2,
    Filters: {
        Ball: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.5, "red": 1.5, "green": 0.8, "blue": 2.0, "alpha": 0.8 },
        Straps: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.5, "red": 1.5, "green": 0.8, "blue": 2.0, "alpha": 0.8 }
    },
    unlimited: true,
    enemyTags: { "latexEncaseRandom": 5 },
    playerTags: { "ItemMouthFull": -2 },
    minLevel: 2,
    allFloors: true,
    shrine: ["Gags", "BallGags", "AfterLeashDone"]
}, {
    inventory: true,
    name: cRestraints.corruptedCubeBlindfold,
    Asset: "Blindfold",
    Model: "Blindfold",
    Color: "#aa00cc",
    Group: "ItemHead",
    power: 3,
    weight: 0,
    escapeChance: { "Struggle": -0.4, "Cut": -0.3, "Remove": 0.5, "Pick": 0.1 },
    maxwill: 0.3,
    Filters: {
        Blindfold: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.5, "red": 1.5, "green": 0.8, "blue": 2.0, "alpha": 0.8 }
    },
    unlimited: true,
    enemyTags: { "latexEncaseRandom": 5 },
    playerTags: { "ItemHeadFull": -2 },
    minLevel: 2,
    allFloors: true,
    shrine: ["Blindfolds", "AfterLeashDone"]
}, {
    inventory: true,
    name: cRestraints.corruptedCubeEncasement,
    Asset: "CorruptedCubeEncasement",
    Model: "CorruptedCubeEncasement",
    Color: "#aa00cc",
    Group: "ItemTorso",
    power: 10,
    weight: 0,
    escapeChance: { "Struggle": -1.0, "Cut": -0.8, "Remove": -0.5, "Pick": -0.2 },
    maxwill: 0.1,
    Filters: {
        Slime: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.5, "red": 1.5, "green": 0.8, "blue": 2.0, "alpha": 0.8 }
    },
    unlimited: true,
    enemyTags: { "latexEncaseRandom": 10 },
    playerTags: { "ItemTorsoFull": -2 },
    minLevel: 6,
    allFloors: true,
    shrine: ["Latex", "Encasement"],
    events: [
        { trigger: "tick", type: "cubeEncasement" },
        { trigger: "postRemoval", type: "RequireEncasement" }
    ]
});

// Corrupted Maid Restraints
KinkyDungeonRestraints.push({
    inventory: true,
    name: cRestraints.corruptedMaidLeatherHeels,
    Asset: "LeatherHeels",
    Model: "LeatherHeels",
    Color: "#53428D",
    Group: "ItemBoots",
    power: 2,
    weight: 0,
    escapeChance: { "Struggle": -0.3, "Cut": -0.2, "Remove": 0.6, "Pick": 0.1 },
    maxwill: 0.5,
    Filters: {
        Heel: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.2, "red": 1.3, "green": 0.8, "blue": 2.0, "alpha": 1 }
    },
    unlimited: true,
    enemyTags: { "corruptedMaid": 5 },
    playerTags: { "ItemBootsFull": -2 },
    minLevel: 0,
    allFloors: true,
    shrine: ["Leather", "Heels"]
}, {
    inventory: true,
    name: cRestraints.corruptedMaidDusterGag,
    Asset: "FeatherDuster",
    Model: "FeatherDusterGag",
    Color: "#53428D",
    Group: "ItemMouth",
    power: 3,
    weight: 0,
    escapeChance: { "Struggle": -0.5, "Cut": -0.4, "Remove": 0.4, "Pick": 0.05 },
    maxwill: 0.3,
    Filters: {
        Handle: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.2, "red": 1.3, "green": 0.8, "blue": 2.0, "alpha": 1 },
        Feathers: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.2, "red": 1.0, "green": 1.0, "blue": 1.0, "alpha": 1 }
    },
    unlimited: true,
    enemyTags: { "corruptedMaid": 5 },
    playerTags: { "ItemMouthFull": -2 },
    minLevel: 0,
    allFloors: true,
    shrine: ["Gags", "FlatGags"]
}, {
    inventory: true,
    name: cRestraints.corruptedMaidAnkleCuffs,
    Asset: "ShacklesAnkles",
    Model: "ShacklesAnkles",
    Color: "#53428D",
    Group: "ItemFeet",
    power: 3,
    weight: 0,
    escapeChance: { "Struggle": -0.5, "Cut": -0.4, "Remove": 0.5, "Pick": 0.05 },
    maxwill: 0.25,
    Filters: {
        BaseMetal: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.2, "red": 1.3, "green": 0.8, "blue": 2.0, "alpha": 1 }
    },
    unlimited: true,
    enemyTags: { "corruptedMaid": 5 },
    playerTags: { "ItemFeetFull": -2 },
    minLevel: 0,
    allFloors: true,
    shrine: ["Metal", "Cuffs"]
}, {
    inventory: true,
    name: cRestraints.corruptedMaidLegShackles,
    Asset: "ShacklesThigh",
    Model: "ShacklesThigh",
    Color: "#53428D",
    Group: "ItemLegs",
    power: 3,
    weight: 0,
    escapeChance: { "Struggle": -0.5, "Cut": -0.4, "Remove": 0.5, "Pick": 0.05 },
    maxwill: 0.25,
    Filters: {
        BaseMetal: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.2, "red": 1.3, "green": 0.8, "blue": 2.0, "alpha": 1 }
    },
    unlimited: true,
    enemyTags: { "corruptedMaid": 5 },
    playerTags: { "ItemLegsFull": -2 },
    minLevel: 0,
    allFloors: true,
    shrine: ["Metal", "Ties"]
}, {
    inventory: true,
    name: cRestraints.corruptedMaidElbowShackles,
    Asset: "ShacklesWrists",
    Model: "ShacklesWrists",
    Color: "#53428D",
    Group: "ItemArms",
    power: 4,
    weight: 0,
    escapeChance: { "Struggle": -0.6, "Cut": -0.5, "Remove": 0.4, "Pick": 0.05 },
    maxwill: 0.2,
    Filters: {
        BaseMetal: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.2, "red": 1.3, "green": 0.8, "blue": 2.0, "alpha": 1 }
    },
    unlimited: true,
    enemyTags: { "corruptedMaid": 5 },
    playerTags: { "ItemArmsFull": -2 },
    minLevel: 0,
    allFloors: true,
    shrine: ["Metal", "Cuffs"]
}, {
    inventory: true,
    name: cRestraints.corruptedMaidBelt,
    Asset: "LeatherBelt",
    Model: "LeatherBelt",
    Color: "#53428D",
    Group: "ItemTorso",
    power: 2,
    weight: 0,
    escapeChance: { "Struggle": -0.3, "Cut": -0.2, "Remove": 0.6, "Pick": 0.1 },
    maxwill: 0.5,
    Filters: {
        Belt: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.2, "red": 1.3, "green": 0.8, "blue": 2.0, "alpha": 1 }
    },
    unlimited: true,
    enemyTags: { "corruptedMaid": 5 },
    playerTags: { "ItemTorsoFull": -2 },
    minLevel: 0,
    allFloors: true,
    shrine: ["Leather", "Belts"]
}, {
    inventory: true,
    name: cRestraints.corruptedMaidArmbinder,
    Asset: "Armbinder",
    Model: "Armbinder",
    Color: "#53428D",
    Group: "ItemArms",
    power: 6,
    weight: 0,
    escapeChance: { "Struggle": -0.8, "Cut": -0.6, "Remove": 0.2, "Pick": 0.05 },
    maxwill: 0.1,
    Filters: {
        Binder: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.2, "red": 1.3, "green": 0.8, "blue": 2.0, "alpha": 1 }
    },
    unlimited: true,
    enemyTags: { "corruptedMaid": 5 },
    playerTags: { "ItemArmsFull": -2 },
    minLevel: 2,
    allFloors: true,
    shrine: ["Leather", "Armbinders"]
}, {
    inventory: true,
    name: cRestraints.corruptedMaidCollar,
    Asset: "LeatherCollar",
    Model: "LeatherCollar",
    Color: "#53428D",
    Group: "ItemNeck",
    power: 3,
    weight: 0,
    escapeChance: { "Struggle": -0.5, "Cut": -0.4, "Remove": 0.5, "Pick": 0.05 },
    maxwill: 0.25,
    Filters: {
        Collar: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.2, "red": 1.3, "green": 0.8, "blue": 2.0, "alpha": 1 }
    },
    unlimited: true,
    enemyTags: { "corruptedMaid": 5 },
    playerTags: { "ItemNeckFull": -2 },
    minLevel: 0,
    allFloors: true,
    shrine: ["Collars", "Leather"]
}, {
    inventory: true,
    debris: "Chains",
    faction: "Corrupted",
    name: cRestraints.corruptedMaidLeash,
    Asset: "BasicLeash",
    Color: "#53428D",
    Group: "ItemNeckRestraints",
    Link: cRestraints.corruptedMaidCollar,
    unLink: cRestraints.corruptedMaidCollar,
    power: 7,
    weight: 0,
    escapeChance: { "Struggle": -0.1, "Cut": 0.1, "Remove": 0.2, "Pick": -0.3 },
    enemyTags: { "corruptedMaid": 5 },
    playerTags: {},
    minLevel: 0,
    allFloors: true,
    shrine: [],
    strictness: 0.05,
    tether: 2,
    events: [
        { trigger: "tether", type: "enemyTether", msg: "The maid leash tightens!", color: "#53428D" }
    ]
});

// Corrupted Alchemist Restraints
KinkyDungeonRestraints.push({
    inventory: true,
    name: cRestraints.corruptedAlchemistCorset,
    Asset: "Corset",
    Model: "Corset",
    Color: "#8B53E9",
    Group: "ItemTorso",
    power: 4,
    weight: 0,
    escapeChance: { "Struggle": -0.6, "Cut": -0.5, "Remove": 0.4, "Pick": 0.05 },
    maxwill: 0.2,
    Filters: {
        Corset: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.5, "red": 1.5, "green": 0.8, "blue": 2.0, "alpha": 1 }
    },
    unlimited: true,
    enemyTags: { "AlchemistPet": 5 },
    playerTags: { "ItemTorsoFull": -2 },
    minLevel: 2,
    allFloors: true,
    shrine: ["Leather", "Corsets"]
}, {
    inventory: true,
    name: cRestraints.corruptedAlchemistBallGag,
    Asset: "BallGag",
    Model: "BallGag",
    Color: "#8B53E9",
    Group: "ItemMouth",
    power: 4,
    weight: 0,
    escapeChance: { "Struggle": -0.6, "Cut": -0.5, "Remove": 0.3, "Pick": 0.05 },
    maxwill: 0.2,
    Filters: {
        Ball: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.5, "red": 1.5, "green": 0.8, "blue": 2.0, "alpha": 1 },
        Straps: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.5, "red": 1.5, "green": 0.8, "blue": 2.0, "alpha": 1 }
    },
    unlimited: true,
    enemyTags: { "AlchemistPet": 5 },
    playerTags: { "ItemMouthFull": -2 },
    minLevel: 2,
    allFloors: true,
    shrine: ["Gags", "BallGags"]
}, {
    inventory: true,
    name: cRestraints.corruptedAlchemistCollar,
    Asset: "LeatherCollar",
    Model: "LeatherCollar",
    Color: "#8B53E9",
    Group: "ItemNeck",
    power: 3,
    weight: 0,
    escapeChance: { "Struggle": -0.5, "Cut": -0.4, "Remove": 0.5, "Pick": 0.05 },
    maxwill: 0.25,
    Filters: {
        Collar: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.5, "red": 1.5, "green": 0.8, "blue": 2.0, "alpha": 1 }
    },
    unlimited: true,
    enemyTags: { "AlchemistPet": 5 },
    playerTags: { "ItemNeckFull": -2 },
    minLevel: 0,
    allFloors: true,
    shrine: ["Collars", "Leather"]
}, {
    inventory: true,
    name: cRestraints.corruptedAlchemistHeels,
    Asset: "LeatherHeels",
    Model: "LeatherHeels",
    Color: "#8B53E9",
    Group: "ItemBoots",
    power: 2,
    weight: 0,
    escapeChance: { "Struggle": -0.3, "Cut": -0.2, "Remove": 0.6, "Pick": 0.1 },
    maxwill: 0.5,
    Filters: {
        Heel: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.5, "red": 1.5, "green": 0.8, "blue": 2.0, "alpha": 1 }
    },
    unlimited: true,
    enemyTags: { "AlchemistPet": 5 },
    playerTags: { "ItemBootsFull": -2 },
    minLevel: 0,
    allFloors: true,
    shrine: ["Leather", "Heels"]
}, {
    inventory: true,
    name: cRestraints.corruptedAlchemistArmbinder,
    Asset: "Armbinder",
    Model: "Armbinder",
    Color: "#8B53E9",
    Group: "ItemArms",
    power: 6,
    weight: 0,
    escapeChance: { "Struggle": -0.8, "Cut": -0.6, "Remove": 0.2, "Pick": 0.05 },
    maxwill: 0.1,
    Filters: {
        Binder: { "gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.5, "red": 1.5, "green": 0.8, "blue": 2.0, "alpha": 1 }
    },
    unlimited: true,
    enemyTags: { "AlchemistPet": 5 },
    playerTags: { "ItemArmsFull": -2 },
    minLevel: 2,
    allFloors: true,
    shrine: ["Leather", "Armbinders"]
}, {
    inventory: true,
    debris: "Chains",
    faction: "Corrupted",
    name: cRestraints.corruptedAlchemistLeash,
    Asset: "BasicLeash",
    Color: "#8B53E9",
    Group: "ItemNeckRestraints",
    Link: cRestraints.corruptedAlchemistCollar,
    unLink: cRestraints.corruptedAlchemistCollar,
    power: 7,
    weight: 0,
    escapeChance: { "Struggle": -0.1, "Cut": 0.1, "Remove": 0.2, "Pick": -0.3 },
    enemyTags: { "AlchemistPet": 5 },
    playerTags: {},
    minLevel: 0,
    allFloors: true,
    shrine: [],
    strictness: 0.05,
    tether: 2,
    events: [
        { trigger: "tether", type: "enemyTether", msg: "The alchemist leash tightens!", color: "#8B53E9" }
    ]
});
// Mummy
KinkyDungeonAddRestraintText(cRestraints.corruptedMummyCollar, "Corrupted Mummy Collar",
    "A cursed collar that binds tightly to your neck..",
    "It cannot be removed if your willpower is not enough or you staying in dark place.");

KinkyDungeonAddRestraintText(cRestraints.corruptedMummyHardSlimeFeet, "Corrupted Mummy Latex Feet",
    "This restraint pulses with a naughty energy, tightening just a little more with every breath you take :3",
    "It clings to you like a lover who won’t let go, teasing your every move~"
);

KinkyDungeonAddRestraintText(cRestraints.corruptedMummyHardSlimeBoots, "Corrupted Mummy Latex Boots",
    "A slick embrace that feels way too good, squeezing you in all the right places ;>",
    "Every step sends shivers up your spine, as if it’s whispering dirty secrets to your soul~"
);

KinkyDungeonAddRestraintText(cRestraints.corruptedMummyHardSlimeLegs, "Corrupted Mummy Latex Legs",
    "This thing wraps around you with a possessive grip, making your heart race with every squirm :3",
    "It’s like it knows your weaknesses and loves to toy with them >w<"
);

KinkyDungeonAddRestraintText(cRestraints.corruptedMummyHardSlimeArms, "Corrupted Mummy Latex Arms",
    "A tight, slippery hold that feels like it’s pulling you into a naughty dance :>",
    "Struggling only makes it cling harder, as if it’s enjoying your defiance~"
);

KinkyDungeonAddRestraintText(cRestraints.corruptedMummyHardSlimeHands, "Corrupted Mummy Latex Hands",
    "This restraint has a mind of its own, caressing you with a wicked little squeeze ;3",
    "It’s like it’s daring you to fight back, knowing you’ll just melt under its touch~"
);

KinkyDungeonAddRestraintText(cRestraints.corruptedMummyHardSlimeMouth, "Corrupted Mummy Latex Mouth",
    "A sultry seal that muffles your gasps, pressing against you with a teasing warmth :>",
    "Every word you try to speak turns into a little whimper it seems to adore~"
);

KinkyDungeonAddRestraintText(cRestraints.corruptedMummyHardSlimeHead, "Corrupted Mummy Latex Head",
    "This thing envelopes you with a dark, playful aura, clouding your thoughts with every pulse :3",
    "It’s like a naughty whisper in your mind, tempting you to give in completely~"
);

// Cube
KinkyDungeonAddRestraintText(cRestraints.corruptedCubeCollar, "Corrupted Slime Collar",
    "A tight collar of wriggling slime clings to your neck, cold and slick.",
    "It pulses against your skin, whispering naughty promises in your ear.");
KinkyDungeonAddRestraintText(cRestraints.corruptedCubeAnkles, "Corrupted Slime Ankle Shackles",
    "Slimy tendrils lock around your ankles, oozing with a sticky glow.",
    "They tighten with every step, teasing your helpless struggle.");
KinkyDungeonAddRestraintText(cRestraints.corruptedCubeLegs, "Corrupted Slime Thigh Shackles",
    "Thick slime bands squeeze your thighs, warm and embarrassingly snug.",
    "You feel them shift, caressing your skin with every squirm.");
KinkyDungeonAddRestraintText(cRestraints.corruptedCubeCuffs, "Corrupted Slime Wrist Shackles",
    "Your wrists are trapped in gooey cuffs that shimmer with a strange aura.",
    "The slime grips tighter when you resist, loving your defiance.");
KinkyDungeonAddRestraintText(cRestraints.corruptedCubeLeash, "Corrupted Slime Leash",
    "A slimy leash stretches from your collar, alive and tugging playfully.",
    "It pulls you along, a sticky reminder of who’s in charge.");
KinkyDungeonAddRestraintText(cRestraints.corruptedCubeBallGag, "Corrupted Slime Large Ball Gag",
    "A fat slime ball plugs your mouth, muffling your moans into wet gurgles.",
    "It tastes sweet and naughty, swelling with every muffled cry.");
KinkyDungeonAddRestraintText(cRestraints.corruptedCubeBlindfold, "Corrupted Slime Blindfold",
    "Opaque slime coats your eyes, blinding you with its slick embrace.",
    "You swear it’s watching you, teasing your helpless senses.");
KinkyDungeonAddRestraintText(cRestraints.corruptedCubeWristShackles, "Corrupted Cube Slime Wrist Shackles",
    "More slime shackles bind your wrists, cool and impossibly tight.",
    "They squish and reform, mocking your attempts to slip free.");
KinkyDungeonAddRestraintText(cRestraints.corruptedCubeThighShackles, "Corrupted Cube Slime Thigh Shackles",
    "Your thighs are claimed by pulsating slime, glowing with dark intent.",
    "It tingles wickedly, making your legs tremble in its grasp.");
KinkyDungeonAddRestraintText(cRestraints.corruptedCubeAnkleShackles, "Corrupted Cube Slime Ankle Shackles",
    "Slimy shackles hug your ankles, forcing tiny, shuffling steps.",
    "They squeeze harder when you fight, loving your frustration.");
KinkyDungeonAddRestraintText(cRestraints.corruptedCubeLargeBallGag, "Corrupted Cube Slime Large Ball Gag",
    "A massive slime orb fills your mouth, stretching your lips wide.",
    "It throbs inside, daring you to drool around its gooey bulk.");
KinkyDungeonAddRestraintText(cRestraints.corruptedCubeBlindfold, "Corrupted Cube Slime Blindfold",
    "This slime blindfold seals your sight, alive with eerie movements.",
    "It presses closer, as if savoring your blind submission.");
KinkyDungeonAddRestraintText(cRestraints.corruptedCubeEncasement, "Corrupted Cube Encasement",
    "A latex cube swallows you whole, encasing you in tight, slimy bliss.",
    "It tickles and squeezes, a suffocating hug you can’t escape.");

// Maid
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidLeatherHeels, "Corrupted Maid Leather Heels",
    "Shiny leather heels force your feet high, swaying your hips for all to see.",
    "Each click on the floor is a humiliating song of your servitude.");
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidDusterGag, "Corrupted Maid Duster Gag",
    "A feather duster gags your mouth, tickling your lips with every breath.",
    "It’s strapped tight, turning your pleas into a dusty whimper.");
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidAnkleCuffs, "Corrupted Maid Ankle Cuffs",
    "Leather cuffs chain your ankles, demanding dainty, obedient steps.",
    "The short chain jingles, a constant tease of your bondage.");
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidAnkleCuffs2, "Corrupted Maid Ankle Cuffs II",
    "Extra cuffs double your torment, locking your ankles even tighter.",
    "You can barely shuffle, a perfect maid on display.");
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidLegShackles, "Corrupted Maid Leg Shackles",
    "Thigh shackles link to your wrists, trapping you in a submissive pose.",
    "Every move tugs your arms, a deliciously cruel restraint.");
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidLegShackles2, "Corrupted Maid Leg Shackles II",
    "More shackles bind your legs, rendering you a helpless statue.",
    "They force you still, a maid bound for someone’s pleasure.");
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidElbowShackles, "Corrupted Maid Elbow Shackles",
    "Elbows locked behind your back, thrusting your chest out shamelessly.",
    "The leather bites, leaving your arms useless and exposed.");
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidBelt, "Corrupted Maid Belt",
    "A leather belt cinches your waist, tight enough to steal your breath.",
    "Rings dangle from it, begging for more toys to bind you.");
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidArmbinder, "Corrupted Maid Armbinder",
    "An armbinder welds your arms into a single, aching column.",
    "Your shoulders scream, but your posture is flawlessly submissive.");
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidVibe, "Corrupted Maid Vibrator",
    "A buzzing toy is strapped tight, driving you wild with no escape.",
    "It hums relentlessly, a cruel reward for your service.");
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidChastityBelt, "Corrupted Maid Chastity Belt",
    "A locked belt denies all touch, teasing your desperate need.",
    "Cold metal taunts you, keeping your desires caged.");
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidNippleWeights, "Corrupted Maid Nipple Weights",
    "Heavy weights tug your nipples, swaying with every humiliating step.",
    "The sharp pull is a constant, wicked reminder of your place.");
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidTrapBra, "Corrupted Maid Trap Bra",
    "A bra with tricks—tightening at random to squeeze your chest.",
    "It’s unpredictable, a sadistic hug you can’t control.");
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidCollar, "Corrupted Maid Collar",
    "A collar brands you ‘Property of the Maid,’ locked forever.",
    "It sits heavy, a proud mark of your servitude.");
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidLeash, "Corrupted Maid Leash",
    "A leash clips to your collar, dragging you like a naughty pet.",
    "Every tug reminds you—you’re owned, body and soul.");

// Alchemist
KinkyDungeonAddRestraintText(cRestraints.corruptedAlchemistCorset, "Corrupted Alchemist Pet Corset",
    "An enchanted corset crushes your waist, glowing with dark magic.",
    "It hums against your skin, shaping you into a perfect pet.");
KinkyDungeonAddRestraintText(cRestraints.corruptedAlchemistBallGag, "Corrupted Alchemist Pet Ball Gag",
    "A runed gag fills your mouth, silencing spells and cries alike.",
    "Its magic tingles, stealing your voice for its master.");
KinkyDungeonAddRestraintText(cRestraints.corruptedAlchemistCollar, "Corrupted Alchemist Pet Collar",
    "A collar etched with symbols saps your magic, leaving you weak.",
    "It glows faintly, a leash for an alchemist’s favorite toy.");
KinkyDungeonAddRestraintText(cRestraints.corruptedAlchemistHeels, "Corrupted Alchemist Pet Heels",
    "High heels lock your feet, forcing a pet’s dainty prance.",
    "Enchanted to stay, they mock your grounded struggles.");
KinkyDungeonAddRestraintText(cRestraints.corruptedAlchemistArmbinder, "Corrupted Alchemist Pet Armbinder",
    "An armbinder binds your arms, a magical cage for your hands.",
    "You’re a helpless pet now, arms lost to its grip.");
KinkyDungeonAddRestraintText(cRestraints.corruptedAlchemistLeash, "Corrupted Alchemist Pet Leash",
    "A glowing leash binds you, pulsing with alchemical control.",
    "It tugs your collar, forcing you to heel like a good pet.");

KinkyDungeonRefreshRestraintsCache();