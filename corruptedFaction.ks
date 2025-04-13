KinkyDungeonFactionColors.Corrupted = ["#8B53E9", "#9e2e60", "#8B53E9"];
KinkyDungeonFactionColors.CorruptedHidden = ["#8B53E9", "#9e2e60", "#8B53E9"];

KinkyDungeonHiddenFactions.set("Corrupted", true);
KinkyDungeonHiddenFactions.set("CorruptedHidden", true);
addTextKey("KinkyDungeonFactionCorrupted", "Corrupted");
addTextKey("KinkyDungeonFactionCorruptedHidden", " ");

KinkyDungeonFactionRelationsBase["Corrupted"] = {
    Player: -1.0,
    Bountyhunter: -1.0,
    Nevermere: -1.0,
    Maidforce: -1.0,
    Elf: -1.0,
    Bandit: -1.0,
};
KinkyDungeonFactionRelationsBase["CorruptedHidden"] = {
    Player: -1.0,
};
KinkyDungeonFactionRelationsBase["Player"]["Corrupted"] = -1.0;
KinkyDungeonFactionRelationsBase["Player"]["CorruptedHidden"] = -1.0;

KDInitFactions();

let CorruptedEnemiesEnabled = window.KDCorruptedExtendedSettings;

KDEventMapGeneric.postMapgen.corruptedSpawn = (e, data) => {
    if (KDGameData.RoomType === "" && KDMapData.Entities && KDMapData.Entities.length > 10) {
        if (CorruptedEnemiesEnabled["CorruptedMaid"]) { let totalMaidCount = 0;}
        if (CorruptedEnemiesEnabled["CorruptedAlchemist"]) { let totalAlchemistCount = 0;}
        if (CorruptedEnemiesEnabled["CorruptedMummy"]) { let totalMummyCount = 0;}

        for (const entity of KDMapData.Entities) {
            if (CorruptedEnemiesEnabled["CorruptedMaid"] && entity.Enemy?.tags?.maid) {
                totalMaidCount++;
            }
            if (CorruptedEnemiesEnabled["CorruptedAlchemist"] && entity.Enemy?.tags?.alchemist) {
                totalAlchemistCount++;
            }
            if (CorruptedEnemiesEnabled["CorruptedMummy"] && entity.Enemy?.tags?.mummy) {
                totalMummyCount++;
            }
        }

        if (CorruptedEnemiesEnabled["CorruptedMaid"] && totalMaidCount > 0 && totalMaidCount < 10) {
            for (let i = 0; i < Math.floor(KDRandom()) + 1; i++) {
                tryCreateEnemy("CorruptedMaid");
            }
        }
        if (CorruptedEnemiesEnabled["CorruptedAlchemist"] && totalAlchemistCount > 0 && totalAlchemistCount < 10) {
            tryCreateEnemy("CorruptedAlchemist");
        }
        if (CorruptedEnemiesEnabled["CorruptedMummy"] && totalMummyCount > 0 && totalMummyCount < 10) {
            tryCreateEnemy("CorruptedMummy");
        }
    }

    function tryCreateEnemy(enemyName) {
        let iters = 0;
        const pathablePoints = Object.values(KDMapData.RandomPathablePoints);
        if (pathablePoints.length === 0) return;

        let randomPointIndex = Math.floor(KDRandom() * pathablePoints.length);
        let randomPoint = pathablePoints[randomPointIndex];

        while (iters < 50 && KinkyDungeonEnemyAt(randomPoint.x, randomPoint.y) !== null) {
            iters++;
            randomPointIndex = Math.floor(KDRandom() * pathablePoints.length);
            randomPoint = pathablePoints[randomPointIndex];
        }

        if (iters < 50) {
            DialogueCreateEnemy(randomPoint.x, randomPoint.y, enemyName);
            //console.log("Corrupted faction: Created an enemy of type", enemyName);
        }
    }
};

KDEventMapGeneric.postMapgen.corruptedMimic = (e, data) => {
    if (CorruptedEnemiesEnabled["CorruptedMimic"] && KDGameData.RoomType === "" && KDMapData.Entities && KDMapData.Entities.length > 10) {
        if (!KDMapData.Tiles || Object.keys(KDMapData.Tiles).length === 0) {
            //console.log("CorruptedDebugMimic: No tiles on map.");
            return;
        }

        const chestTiles = Object.entries(KDMapData.Tiles).filter(([coord, tile]) => tile.Loot && typeof tile.Loot === "string" && tile.Loot == "chest" && !tile.Faction);

        if (chestTiles.length === 0) {
            //console.log("CorruptedMimic: No chests on map.");
            return;
        }

        if (KDRandom() < 0.9) {
            //console.log("CorruptedMimic: Chance is too low.");
            return;
        }

        const randomChestIndex = Math.floor(KDRandom() * chestTiles.length);
        const [chestCoord, chestTile] = chestTiles[randomChestIndex];

        if (!chestCoord) return;
        const [x, y] = chestCoord.split(",").map(Number);

        //delete KDMapData.Tiles[chestCoord];
        KinkyDungeonMapSet(x, y, '0');
        //console.log(`CorruptedMimic: Deleted chest of type "${chestTile.Loot}" at coordinates (${x}, ${y})`);

        DialogueCreateEnemy(x, y, "CorruptedMimic");
        //console.log(`CorruptedMimic: Created enemy (${x}, ${y})`);
    }
};