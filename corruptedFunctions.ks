// ==============================================================
//#    __  __           _   ____       _   _   _                 
//#   |  \/  | ___   __| | / ___|  ___| |_| |_(_)_ __   __ _ ___ 
//#   | |\/| |/ _ \ / _` | \___ \ / _ \ __| __| | '_ \ / _` / __|
//#   | |  | | (_) | (_| |  ___) |  __/ |_| |_| | | | | (_| \__ \
//#   |_|  |_|\___/ \__,_| |____/ \___|\__|\__|_|_| |_|\__, |___/
//#                                                    |___/     
// ==============================================================
// Thanks again Ilyasnow for he's code in UsefulTooltips
let ModName = "CorruptedExtended";
addTextKey("KDModButton"+ModName, "Corrupted Extended");
addTextKey("KDModButton"+ModName+"ExplanationText", "Select what enemies you want or don't want to appear.\nMaybe requires game restart.\nAlready exists enemies on map will not be removed.");
addTextKey("KDModButton"+ModName+"CorruptedMimic", "Corrupted Mimic");
addTextKey("KDModButton"+ModName+"CorruptedEpicenterCursed", "Reworked Epicenter Cursed");
addTextKey("KDModButton"+ModName+"CorruptedAlchemist", "Corrupted Alchemist");
addTextKey("KDModButton"+ModName+"CorruptedMaid", "Corrupted Maid");
addTextKey("KDModButton"+ModName+"CorruptedMummy", "Corrupted Mummy");
addTextKey("KDModButton"+ModName+"CorruptedLatexCube", "Corrupted Latex Cube");

if (KDEventMapGeneric['afterModSettingsLoad'] != undefined) {
  KDEventMapGeneric['afterModSettingsLoad'][ModName] = (e, data) => {
	if (KDModSettings == null) { 
	  KDModSettings = {} 
	};
	if (KDModConfigs != undefined) {
	  KDModConfigs[ModName] = [
		{
			type: "text",
			refvar: ModName+"ExplanationText",
		},
		{
			type: "boolean",
			refvar: ModName+"CorruptedMimic",
			default: true,
		},
        {
			type: "boolean",
			refvar: ModName+"CorruptedEpicenterCursed",
			default: true,
		},
        {
			type: "boolean",
			refvar: ModName+"CorruptedAlchemist",
			default: true,
		},
        {
			type: "boolean",
			refvar: ModName+"CorruptedMaid",
			default: true,
		},
        {
			type: "boolean",
			refvar: ModName+"CorruptedMummy",
			default: true,
		},
        {
			type: "boolean",
			refvar: ModName+"CorruptedLatexCube",
			default: true,
		},
	  ]
	}
	let settingsobject = (KDModSettings.hasOwnProperty(ModName) == false) ? {} : Object.assign({}, KDModSettings[ModName]);
	KDModConfigs[ModName].forEach((option) => {
	  if (settingsobject[option.refvar] == undefined) {
		settingsobject[option.refvar] = option.default
	  }
	})
	KDModSettings[ModName] = settingsobject;
	AfterModLoad();
  }
}

if (KDEventMapGeneric['afterModConfig'] != undefined) {
  KDEventMapGeneric['afterModConfig'][ModName] = (e, data) => {
	AfterModLoad();
  }
}

function AfterModLoad() {
	//console.log("Corrupted Extended - Enemies enabled:");
	for (let entry of KDModConfigs[ModName]) {
		if (entry.type == "boolean") {
            let name = entry.refvar;
            if (name.startsWith(ModName))
                name = name.substring(ModName.length);
            CorruptedEnemiesEnabled[name] = KDModSettings[ModName][entry.refvar];
			//console.log(`${name} = ${CorruptedEnemiesEnabled[name]}`);
        }
	}
}

let CorruptedEnemiesEnabled = {};
window.KDCorruptedExtendedSettings = CorruptedEnemiesEnabled;
// ====================================================
//#     ___                      _     _ _             
//#    / _ \__   _____ _ __ _ __(_) __| (_)_ __   __ _ 
//#   | | | \ \ / / _ \ '__| '__| |/ _` | | '_ \ / _` |
//#   | |_| |\ V /  __/ |  | |  | | (_| | | | | | (_| |
//#    \___/  \_/ \___|_|  |_|  |_|\__,_|_|_| |_|\__, |
//#                                              |___/ 
// ====================================================
// thanks to Ilyasnow
let KDDrawTooltipOriginal = KDDrawTooltip;
KDDrawTooltip = function KDDrawTooltip(TooltipList, ...args) {
    let enemy = KDCurrentEnemyTooltip;
    if (enemy && KDCanSeeEnemy(enemy) && enemy.idle && (enemy.Enemy?.name == "CorruptedMimic" || enemy.Enemy?.name == "Mimic")) {
        TooltipList = [];
    }
    return KDDrawTooltipOriginal(TooltipList, ...args);
}

// ================================================
//#    _____                 _   _                 
//#   |  ___|   _ _ __   ___| |_(_) ___  _ __  ___ 
//#   | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
//#   |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
//#   |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
//#                                                
// ================================================
function SetStatTexts(statId, statName, statDesc) {
    addTextKey('KinkyDungeonStat' + statId, statName);
    addTextKey('KinkyDungeonStatDesc' + statId, statDesc);
}

function SetSpellText(name, type, text) {
    addTextKey(`KinkyDungeonSpell${name}${type}`, text);
}

function SetSpellCastText(name, text) {
    addTextKey(`KinkyDungeonSpellCast${name}`, text);
}

function SetLinkText(name, text) {
    addTextKey(`KinkyDungeonLink${name}`, text);
}

function SetUnlinkText(name, text) {
    addTextKey(`KinkyDungeonUnLink${name}`, text);
}

function SetEnemyLockText(name, text) {
    SetEnemyAttackText(name + "Lock", text);
}

function SetEnemyAttackText(name, text) {
    addTextKey(`Attack${name}`, text);
}

function SetEnemyAttackWithBindText(name, text) {
    addTextKey(`Attack${name}Bind`, text);
}

function SetEnemyKillText(name, text) {
    addTextKey(`Kill${name}`, text);
}

function SetEnemyNameText(name, text) {
    addTextKey(`Name${name}`, text);
}

function SetBuffText(buffId, text) {
    addTextKey(`KinkyDungeonBuff${buffId}`, text);
}

function SetTripleBuffTexts(name, texts) {
    for (let i = 0; i < 3; i++) {
        addTextKey(`KinkyDungeon${name}${i + 1}`, texts[i]);
    }
}

function RestraintWithEnemyTagCount(tag) {
    let restraintWithTagCount = 0;
    for (const r of KinkyDungeonAllRestraint()) {
        let rest = KDRestraint(r);
        if (rest.enemyTags && Object.keys(rest.enemyTags).includes(tag)) {
            restraintWithTagCount++;
        }
        let dynamicLink = r.dynamicLink;
        let loop = 0;
        while (dynamicLink && loop < 12) {
            rest = KDRestraint(dynamicLink);
            if (rest.enemyTags && Object.keys(rest.enemyTags).includes(tag)) {
                restraintWithTagCount++;
            }
            dynamicLink = dynamicLink.dynamicLink;
            loop++;
        }
    }
    return restraintWithTagCount;
}

function HasRestraintWithShrines(...shrines) {
    for (const r of KinkyDungeonAllRestraint()) {
        let rest = KDRestraint(r);
        if (rest.shrine && rest.shrine.some(key => shrines.key)) {
            return true;
        }
        let dynamicLink = r.dynamicLink;
        let loop = 0;
        while (dynamicLink && loop < 12) {
            rest = KDRestraint(dynamicLink);
            if (rest.shrine && rest.shrine.some(key => shrines.key)) {
                return true;
            }
            dynamicLink = dynamicLink.dynamicLink;
            loop++;
        }
    }
    return false;
}

function AmountRestraintWithShrine(shrine) {
    let restraintWithShrineCount = 0;
    for (const r of KinkyDungeonAllRestraint()) {
        let rest = KDRestraint(r);
        if (rest?.shrine && rest?.shrine.includes(shrine)) {
            restraintWithShrineCount += 1;
            continue;
        }
        let dynamicLink = r.dynamicLink;
        let loop = 0;
        while (dynamicLink && loop < 12) {
            rest = KDRestraint(dynamicLink);
            if (rest?.shrine && rest?.shrine.includes(shrine)) {
                restraintWithShrineCount += 1;
                continue;
            }
            dynamicLink = dynamicLink.dynamicLink;
            loop++;
        }
    }
    return restraintWithShrineCount;
}

function PlayerWearsRestraint(restraintName) {
    for (const r of KinkyDungeonAllRestraint()) {
        if (r.name === restraintName) {
            return true;
        }
        let dynamicLink = r.dynamicLink;
        let loop = 0;
        while (dynamicLink && loop < 12) {
            if (dynamicLink.name === restraintName) {
                return true;
            }
            dynamicLink = dynamicLink.dynamicLink;
            loop++;
        }
    }
    return false;
}

function KinkyDungeonCloneEnemy(enemyName, newEnemyName, props) {
    const existingEnemy = KinkyDungeonEnemies.find(enemy => enemy.name === enemyName);

    if (!existingEnemy) {
        throw new Error(`No enemy named ${enemyName}.`);
    }

    const newEnemy = {
        ...JSON.parse(JSON.stringify(existingEnemy)),
        name: newEnemyName
    };

    Object.assign(newEnemy, props);

    KinkyDungeonEnemies.push(newEnemy);

    return newEnemy;
}

function CloneModel(modelName, newModelName, modelProps) {
    const oldModel = ModelDefs[modelName];
    if (!oldModel) {
        console.warn(`Cannot find model ${modelName} to clone.`);
        return;
    }
    const clonedModel = { ...oldModel, Name: newModelName, ...modelProps };
    ModelDefs[newModelName] = clonedModel;
}

function GetPlayerDist(x, y) {
    return KDistChebyshev(x - KinkyDungeonPlayerEntity.x, y - KinkyDungeonPlayerEntity.y);
}

function LogWarning(message) {
    console.warn(`Corrupted Mod Warning: ${message}`);
}

function TryCloneRestraint(restraintName, newRestraintName, restraintProps) {
    if (!KinkyDungeonGetRestraintByName(restraintName)) {
        LogWarning(`Cannot find the restraint to clone, named ${restraintName}! Please report this...`);
        return;
    }

    try {
        KinkyDungeonCloneRestraint(restraintName, newRestraintName, restraintProps);
    } catch (ex) {
        LogWarning("There is an error occurred while trying to clone a restraint.");
        console.error(ex);
    }
}

function CreateRestraintIfNotExist(restraintName, restraintProps) {
    if (KinkyDungeonGetRestraintByName(restraintName)) return;
    const newRestraintProps = { name: restraintName, ...restraintProps };
    KinkyDungeonRestraints.push(newRestraintProps);

    KinkyDungeonRefreshRestraintsCache();
}

function GetNearestEnemy(enemyName) {
    const playerX = KinkyDungeonPlayerEntity.x;
    const playerY = KinkyDungeonPlayerEntity.y;
    const radius = 3;

    for (const enemy of KDMapData.Entities) {
        if (enemy.Enemy.name === enemyName) {
            const distance = Math.abs(enemy.x - playerX) + Math.abs(enemy.y - playerY);
            if (distance <= radius) {
                return enemy;
            }
        }
    }
    return null;
}

const KDUtilCommon = {
    SetStatTexts,
    SetSpellText,
    SetSpellCastText,
    SetLinkText,
    SetUnlinkText,
    SetEnemyLockText,
    SetEnemyAttackText,
    SetEnemyAttackWithBindText,
    SetEnemyKillText,
    SetEnemyNameText,
    SetBuffText,
    SetTripleBuffTexts,
    RestraintWithEnemyTagCount,
    HasRestraintWithShrines,
    AmountRestraintWithShrine,
    PlayerWearsRestraint,
    KinkyDungeonCloneEnemy,
    CloneModel,
    GetPlayerDist,
    TryCloneRestraint,
    CreateRestraintIfNotExist,
    GetNearestEnemy
};

window.KDModData = window.KDModData || {};
window.KDUtilCommon = KDUtilCommon;

dispatchEvent(new Event("kd:utilsReady"));