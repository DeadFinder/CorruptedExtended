KinkyDungeonFactionColors.Corrupted = ["#8B53E9", "#9e2e60", "#8B53E9"];

KinkyDungeonHiddenFactions.set("Corrupted", true);
addTextKey("KinkyDungeonFactionCorrupted", "Corrupted");

KinkyDungeonFactionRelationsBase["Corrupted"] = {
    Player: -1.0,
    Slime: 1.0,
    Latex: 1.0,
    Demon: 1.0,
    Witch: 1.0,
    Bountyhunter: -1.0,
    Nevermere: -1.0,
    Maidforce: -1.0,
    Elf: -1.0,
};
KinkyDungeonFactionRelationsBase["Player"]["Corrupted"] = -1.0;

KDInitFactions();

KDEventMapGeneric.postMapgen.corruptedSpawn = (e, data) => {
    if (KDGameData.RoomType === "" && KDMapData.Entities && KDMapData.Entities.length > 10) {
        let totalMaidCount = 0;
        let totalAlchemistCount = 0;

        for (const entity of KDMapData.Entities) {
            if (entity.Enemy?.tags?.maid) {
                totalMaidCount++;
            }
            if (entity.Enemy?.tags?.alchemist) {
                totalAlchemistCount++;
            }
        }

        if (totalMaidCount > 0 && totalMaidCount < 10) {
            for (let i = 0; i < Math.floor(KDRandom()) + 1; i++) {
                tryCreateEnemy("CorruptedMaid");
            }
        }
        if (totalAlchemistCount > 0 && totalAlchemistCount < 10) {
            tryCreateEnemy("CorruptedAlchemist");
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
            console.log("Corrupted faction: Created an enemy of type", enemyName);
        }
    }
};