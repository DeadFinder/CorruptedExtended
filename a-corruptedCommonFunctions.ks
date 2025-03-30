// @ts-nocheck

function SetStatTexts(statId, statName, statDesc) {
    addTextKey('KinkyDungeonStat' + statId, statName);
    addTextKey('KinkyDungeonStatDesc' + statId, statDesc);
}

/**
 * 
 * @param name 
 * @param {string} type - Can be "Bind" or "Damage"
 * @param {string} text
 */
function SetSpellText(name, type, text) {
    addTextKey(`KinkyDungeonSpell${name}${type}`, text);
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

/**
 * Sets an enemy name.
 * @param name The name of enemy
 * @param text Text to set on enemy
 */
function SetEnemyNameText(name, text) {
    addTextKey(`Name${name}`, text);
}

/**
 * Sets a buff text.
 * @param {string} buffId Buff's name
 * @param {string} text The buff text
 */
function SetBuffText(buffId, text) {
    addTextKey(`KinkyDungeonBuff${buffId}`, text);
}

/**
 * Sets the text of triple buff kills.
 * @param {string} name name of the three buff kill spell
 * @param {string[]} texts the buff texts to write in, usually 3 provided
 */
function SetTripleBuffTexts(name, texts) { // Изменено название на SetTripleBuffTexts для консистентности
    for (let i = 0; i < 3; i++) {
        addTextKey(`KinkyDungeon${name}${i + 1}`, texts[i]);
    }
}

/**
 * Looks for specific restraints with the enemy tag and returns the count (including dynamic links)
 * @param {string} tag enemyTag to search in
 * @returns total restraint count with enemyTag
 */
function RestraintWithEnemyTagCount(tag) {
    let restraintWithTagCount = 0;
    for (const r of KinkyDungeonAllRestraint()) {
        let rest = KDRestraint(r);
        if (rest.enemyTags && Object.keys(rest.enemyTags).includes(tag)) { // Упрощено условие
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

/**
 * Looks for specific restraints with any of the provided shrines and returns true if exists.
 * @param {...string} shrines shrines to search
 * @returns true if shrine exists in any restraint in provided shrines
 */
function HasRestraintWithShrines(...shrines) {
    for (const r of KinkyDungeonAllRestraint()) {
        let rest = KDRestraint(r);
        if (rest.shrine && rest.shrine.some(key => shrines.includes(key))) { // Упрощено условие
            return true;
        }
        let dynamicLink = r.dynamicLink;
        let loop = 0;
        while (dynamicLink && loop < 12) {
            rest = KDRestraint(dynamicLink);
            if (rest.shrine && rest.shrine.some(key => shrines.includes(key))) {
                return true;
            }
            dynamicLink = dynamicLink.dynamicLink;
            loop++;
        }
    }
    return false; // Возвращаем false, если ничего не найдено
}

/**
 * Checks if player wears the restraint with name, including dynamic links.
 * @param {string} restraintName the name of restraint
 * @returns true - if restraint is being worn
 */
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

/**
 * Clone an enemy to assign properties.
 * @param enemyName the enemy name to clone
 * @param newEnemyName new enemy name to assign
 * @param props new properties of the enemy
 * @returns 
 */
function KinkyDungeonCloneEnemy(enemyName, newEnemyName, props) {
    const existingEnemy = KinkyDungeonEnemies.find(enemy => enemy.name === enemyName);

    if (!existingEnemy) {
        throw new Error(`No enemy named ${enemyName}.`);
    }

    const newEnemy = {
        ...JSON.parse(JSON.stringify(existingEnemy)), // Более современный способ глубокого копирования
        name: newEnemyName
    };

    Object.assign(newEnemy, props);

    KinkyDungeonEnemies.push(newEnemy);

    return newEnemy;
}

/**
 * Clone a model to assign properties.
 * @param modelName model name to clone
 * @param newModelName new model name of cloned model
 * @param newModel new properties of the model
 */
function CloneModel(modelName, newModelName, modelProps) {
    const oldModel = ModelDefs[modelName];
    if (!oldModel) {
        console.warn(`Cannot find model ${modelName} to clone.`);
        return;
    }
    const clonedModel = { ...oldModel, Name: newModelName, ...modelProps }; // Используем spread для копирования
    ModelDefs[newModelName] = clonedModel;
}

/**
 * Gets player distance to point.
 * @param x point x
 * @param y point y
 * @returns player grid distance based on x,y pos
 */
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
    const newRestraintProps = { name: restraintName, ...restraintProps }; // Используем spread
    KinkyDungeonRestraints.push(newRestraintProps);

    KinkyDungeonRefreshRestraintsCache(); // refresh cache
}

const KDUtilCommon = {
    SetStatTexts,
    SetSpellText,
    SetLinkText,
    SetUnlinkText,
    SetEnemyLockText,
    SetEnemyAttackText,
    SetEnemyAttackWithBindText,
    SetEnemyKillText,
    SetEnemyNameText,
    SetBuffText,
    SetTripleBuffTexts, // Обновлено имя
    RestraintWithEnemyTagCount,
    HasRestraintWithShrines,
    PlayerWearsRestraint,
    KinkyDungeonCloneEnemy,
    CloneModel,
    GetPlayerDist,
    TryCloneRestraint,
    CreateRestraintIfNotExist
};

window.KDUtilCommon = KDUtilCommon;

dispatchEvent(new Event("kd:utilsReady"));