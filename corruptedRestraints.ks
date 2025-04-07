let KDUtilCommon = window.KDUtilCommon;
const cRestraints = {
    // Mimic
    corruptedMimicEncasement: "CorruptedMimicEncasement",
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
    corruptedCubeCuffs: "CorruptedSlimeShacklesWrists",
    corruptedCubeLeash: "CorruptedSlimeLeash",
    corruptedCubeBallGag: "CorruptedSlimeLargeBallGag",
    corruptedCubeBlindfold: "CorruptedSlimeBlindfold",
    corruptedCubeEncasement: "CorruptedCubeEncasement",
    // Maid
    corruptedMaidLeatherHeels: "CorruptedMaidLeatherHeels",
    corruptedMaidDusterGag: "CorruptedMaidDusterGag",
    corruptedMaidAnkleCuffs: "CorruptedMaidAnkleCuffs",
    corruptedMaidLegShackles: "CorruptedMaidLegShackles",
    corruptedMaidElbowShackles: "CorruptedMaidElbowShackles",
    corruptedMaidBelt: "CorruptedMaidBelt",
    corruptedMaidArmbinder: "CorruptedMaidArmbinder",
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

// ===============================================================================
//#     ____                            _           _   __  __ _           _      
//#    / ___|___  _ __ _ __ _   _ _ __ | |_ ___  __| | |  \/  (_)_ __ ___ (_) ___ 
//#   | |   / _ \| '__| '__| | | | '_ \| __/ _ \/ _` | | |\/| | | '_ ` _ \| |/ __|
//#   | |__| (_) | |  | |  | |_| | |_) | ||  __/ (_| | | |  | | | | | | | | | (__ 
//#    \____\___/|_|  |_|   \__,_| .__/ \__\___|\__,_| |_|  |_|_|_| |_| |_|_|\___|
//#                              |_|                                             
// ===============================================================================

// Thanks to Yuck (<@97465479853006848>) for slime prison cell asset (https://discord.com/channels/938203644023685181/1148672254213898280/1195668914106019901)
KinkyDungeonRestraints.push({
    removePrison: true, name: cRestraints.corruptedMimicEncasement, Asset: "SmallWoodenBox", Model: cRestraints.corruptedMimicEncasement,
    Color: ["#ba50eb"], Group: "ItemDevices", power: 3, weight: 1, immobile: true, alwaysStruggleable: true,
    DefaultLock: "Red", removeOnLeash: true,
    escapeChance: { "Struggle": -0.2, "Cut": -0.2, "Remove": 0.35, "Pick": 0.33, "Unlock": 0.7 },
    helpChance: { "Remove": 0.5, "Pick": 0.5, "Unlock": 1.0 },
    enemyTags: { "corruptedmimic": 100 }, playerTags: {}, minLevel: 0, allFloors: true, shrine: ["Furniture"], ignoreSpells: true,
    events: [
        { trigger: "tick", type: "cageDebuff", inheritLinked: true },
        { trigger: "postRemoval", type: "mimicEncasement" }
    ]
});

KDEventMapInventory.postRemoval.mimicEncasement = (e, item, data) => {
    if (data.item === item) {
        for (let inv of KinkyDungeonAllRestraint()) {
            if (inv && inv.name && inv.name === cRestraints.corruptedMimicEncasement) {
                return;
            }
        }
        DialogueCreateEnemy(KinkyDungeonPlayerEntity.x, KinkyDungeonPlayerEntity.y, "CorruptedMimic");
        KDNearbyEnemies(KinkyDungeonPlayerEntity.x, KinkyDungeonPlayerEntity.y, 3).forEach(enemy => {
            if (enemy.Enemy.name == "CorruptedMimic") {
                enemy.hp = 10;
                enemy.stun = 10;
                KinkyDungeonSendTextMessage(4, "The mimic spits you out away and now you are free!", "lightgreen", 2);
            }
        });
    }
};


// ===================================================================================================
//#     ____                            _           _      _    _      _                    _     _   
//#    / ___|___  _ __ _ __ _   _ _ __ | |_ ___  __| |    / \  | | ___| |__   ___ _ __ ___ (_)___| |_ 
//#   | |   / _ \| '__| '__| | | | '_ \| __/ _ \/ _` |   / _ \ | |/ __| '_ \ / _ \ '_ ` _ \| / __| __|
//#   | |__| (_) | |  | |  | |_| | |_) | ||  __/ (_| |  / ___ \| | (__| | | |  __/ | | | | | \__ \ |_ 
//#    \____\___/|_|  |_|   \__,_| .__/ \__\___|\__,_| /_/   \_\_|\___|_| |_|\___|_| |_| |_|_|___/\__|
//#                              |_|                                                                  
// ===================================================================================================

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

// ==========================================================================
//#     ____                            _           _   __  __       _     _ 
//#    / ___|___  _ __ _ __ _   _ _ __ | |_ ___  __| | |  \/  | __ _(_) __| |
//#   | |   / _ \| '__| '__| | | | '_ \| __/ _ \/ _` | | |\/| |/ _` | |/ _` |
//#   | |__| (_) | |  | |  | |_| | |_) | ||  __/ (_| | | |  | | (_| | | (_| |
//#    \____\___/|_|  |_|   \__,_| .__/ \__\___|\__,_| |_|  |_|\__,_|_|\__,_|
//#                              |_|                                         
// ==========================================================================

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

// ============================================================================================
//#     ____                            _           _   __  __                                 
//#    / ___|___  _ __ _ __ _   _ _ __ | |_ ___  __| | |  \/  |_   _ _ __ ___  _ __ ___  _   _ 
//#   | |   / _ \| '__| '__| | | | '_ \| __/ _ \/ _` | | |\/| | | | | '_ ` _ \| '_ ` _ \| | | |
//#   | |__| (_) | |  | |  | |_| | |_) | ||  __/ (_| | | |  | | |_| | | | | | | | | | | | |_| |
//#    \____\___/|_|  |_|   \__,_| .__/ \__\___|\__,_| |_|  |_|\__,_|_| |_| |_|_| |_| |_|\__, |
//#                              |_|                                                     |___/ 
// ============================================================================================

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
                    KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(restraintName), 0, true, "", false, undefined, undefined, "Corrupted", true);
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

// =====================================================================================================
//#     ____                            _           _   _          _               ____      _          
//#    / ___|___  _ __ _ __ _   _ _ __ | |_ ___  __| | | |    __ _| |_ _____  __  / ___|   _| |__   ___ 
//#   | |   / _ \| '__| '__| | | | '_ \| __/ _ \/ _` | | |   / _` | __/ _ \ \/ / | |  | | | | '_ \ / _ \
//#   | |__| (_) | |  | |  | |_| | |_) | ||  __/ (_| | | |__| (_| | ||  __/>  <  | |__| |_| | |_) |  __/
//#    \____\___/|_|  |_|   \__,_| .__/ \__\___|\__,_| |_____\__,_|\__\___/_/\_\  \____\__,_|_.__/ \___|
//#                              |_|                                                                    
// =====================================================================================================

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
    removePrison: true,
    name: cRestraints.corruptedCubeEncasement,
    Asset: "VacCube",
    Model: cRestraints.corruptedCubeEncasement,
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
        { trigger: "tick", type: "cageDebuff", inheritLinked: true },
        { trigger: "tick", type: "cubeEncasement" },
        { trigger: "postRemoval", type: "RequireEncasement" }
    ]
});

// Mimic
KinkyDungeonAddRestraintText(cRestraints.corruptedMimicEncasement, "Corrupted Mimic",
    "Mimic has been swallowed you..",
    "Really hard to escape from alive mimic!");

// Mummy
KinkyDungeonAddRestraintText(cRestraints.corruptedMummyCollar, "Corrupted Mummy Collar",
    "A cursed collar that binds tightly to your neck..",
    "It cannot be removed if your willpower is not enough or you staying in dark place.");

KinkyDungeonAddRestraintText(cRestraints.corruptedMummyHardSlimeFeet, "Corrupted Latex Feet",
    "This restraint pulses with a naughty energy, tightening just a little more with every breath you take :3",
    "It clings to you like a lover who won’t let go, teasing your every move~"
);

KinkyDungeonAddRestraintText(cRestraints.corruptedMummyHardSlimeBoots, "Corrupted Latex Boots",
    "A slick embrace that feels way too good, squeezing you in all the right places ;>",
    "Every step sends shivers up your spine, as if it’s whispering dirty secrets to your soul~"
);

KinkyDungeonAddRestraintText(cRestraints.corruptedMummyHardSlimeLegs, "Corrupted Latex Legs",
    "This thing wraps around you with a possessive grip, making your heart race with every squirm :3",
    "It’s like it knows your weaknesses and loves to toy with them >w<"
);

KinkyDungeonAddRestraintText(cRestraints.corruptedMummyHardSlimeArms, "Corrupted Latex Arms",
    "A tight, slippery hold that feels like it’s pulling you into a naughty dance :>",
    "Struggling only makes it cling harder, as if it’s enjoying your defiance~"
);

KinkyDungeonAddRestraintText(cRestraints.corruptedMummyHardSlimeHands, "Corrupted Latex Hands",
    "This restraint has a mind of its own, caressing you with a wicked little squeeze ;3",
    "It’s like it’s daring you to fight back, knowing you’ll just melt under its touch~"
);

KinkyDungeonAddRestraintText(cRestraints.corruptedMummyHardSlimeMouth, "Corrupted Latex Mouth",
    "A sultry seal that muffles your gasps, pressing against you with a teasing warmth :>",
    "Every word you try to speak turns into a little whimper it seems to adore~"
);

KinkyDungeonAddRestraintText(cRestraints.corruptedMummyHardSlimeHead, "Corrupted Latex Head",
    "This thing envelopes you with a dark, playful aura, clouding your thoughts with every pulse :3",
    "It’s like a naughty whisper in your mind, tempting you to give in completely~"
);

// Cube
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
KinkyDungeonAddRestraintText(cRestraints.corruptedCubeThighShackles, "Corrupted Cube Slime Thigh Shackles",
    "Your thighs are claimed by pulsating slime, glowing with dark intent.",
    "It tingles wickedly, making your legs tremble in its grasp.");
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
KinkyDungeonAddRestraintText(cRestraints.corruptedMaidLegShackles, "Corrupted Maid Leg Shackles",
    "Thigh shackles link to your wrists, trapping you in a submissive pose.",
    "Every move tugs your arms, a deliciously cruel restraint.");
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