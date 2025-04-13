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

KinkyDungeonEnemies.push({name:corruptedMimicName,faction:"CorruptedHidden",blockVisionWhileStationary:!0,tags:KDMapInit(["removeDoorSpawn","ignoreharmless","blindresist","construct","nosignal","poisonresist","soulresist","minor","melee","crushweakness","meleeresist","fireweakness","electricresist","chainweakness"]),evasion:-.5,ignorechance:1,armor:1,followRange:1,AI:"ambush",bypass:!0,difficulty:.15,guardChance:0,nonDirectional:!0,GFX:{lighting:!0},maxblock:1,maxdodge:0,Sound:{baseAmount:0,alertAmount:0,moveAmount:10},events:[{trigger:"beforeDamage",type:"corruptedMimic"}],stamina:10,visionRadius:50,ambushRadius:1.9,blindSight:50,maxhp:10,minLevel:2,weight:-1,movePoints:1.5,attackPoints:2,attack:"MeleeBind",attackWidth:1,attackRange:1,power:3,dmgType:"tickle",fullBoundBonus:1,terrainTags:{rubble:100,adjChest:15,passage:14,illusionRage:2,illusionAnger:2},allFloors:!0,shrines:["Illusion"],dropTable:[{name:"RedKey",weight:1},{name:"Gold",amountMin:10,amountMax:40,weight:6},{name:"ScrollArms",weight:1},{name:"ScrollVerbal",weight:1},{name:"ScrollLegs",weight:1}]});

KDEventMapEnemy.beforeDamage.corruptedMimic=(e,t,n)=>{if(n.enemy===t&&n.target===KinkyDungeonPlayerEntity&&!n.restrainsAdded){const e=[cRestraints.corruptedMummyHardSlimeFeet,cRestraints.corruptedMummyHardSlimeBoots,cRestraints.corruptedMummyHardSlimeLegs,cRestraints.corruptedMummyHardSlimeArms,cRestraints.corruptedMummyHardSlimeHands,cRestraints.corruptedMummyHardSlimeMouth,cRestraints.corruptedMummyHardSlimeHead],n=KinkyDungeonAllRestraint().map((e=>e.name));if(KDRandom()>=.9){if(t.hp<=10)return;KDBreakTether(KinkyDungeonPlayerEntity),KDRemoveEntity(t),KinkyDungeonPassOut(),KinkyDungeonAddRestraintIfWeaker(cRestraints.corruptedMimicEncasement,0,!0,"Red",!1,void 0,void 0,"Corrupted",!0);for(const t of e)KDUtilCommon.PlayerWearsRestraint(t)||KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(t),0,!0,"",!1,void 0,void 0,"Corrupted",!0)}else for(const t of e){if(n.includes(t))continue;let r=Math.min(1,.7+.01*(e.indexOf(t)+1));KDRandom()>r&&(KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(t),0,!0,"",!1,void 0,void 0,"Corrupted",!0),KinkyDungeonSendTextMessage(10,`${corruptedMimicText} binds you with ${t}!`,"#cc0000",2,!0));break}}};

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

    KinkyDungeonEnemies.push({name:"EpicenterCursed",faction:"Curse",color:"#880044",tags:KDMapInit(["opendoors","epicenterCursed","epicenter","curseTrap","ghost","cursed","soulimmune","melee","fireweakness","shadowimmune","glueimmune","chainimmune","shadowHands","poisonimmune","meleeresist","flying"]),ignorechance:0,armor:0,followRange:1,AI:"huntshadow",noAlert:!0,hitsfx:"Evil",ethereal:!0,spells:["ManyShadowHands","ManyObsidianBolts","CorruptedCursingCircle"],spellCooldownMult:1.1,spellCooldownMod:0,castWhileMoving:!0,visionRadius:15,blindSight:8,evasion:-2,maxhp:61.7,minLevel:0,weight:0,movePoints:4,attackPoints:2,attack:"Spell",attackWidth:1,attackRange:1,power:1,dmgType:"cold",fullBoundBonus:4,regen:.02,maxblock:0,maxdodge:0,stamina:2,events:[{trigger:"addEntity",type:"EpicenterAssignHP"},{trigger:"beforeDamage",type:"epicenterCursed"}],terrainTags:{curseTrap:10},shrines:[],allFloors:!0,dropTable:[{name:"ManaOrb",weight:1}]},{name:"EpicenterCursed2",faction:"Curse",color:"#a4affa",tags:KDMapInit(["opendoors","epicenterCursed","epicenter","curseTrap","ghost","cursed","soulimmune","melee","fireweakness","shadowimmune","glueimmune","chainimmune","shadowHands","poisonimmune","meleeresist","flying"]),ignorechance:0,armor:0,followRange:1,AI:"huntshadow",noAlert:!0,hitsfx:"Evil",ethereal:!0,spells:["ManyShadowHands","ManyMithrilBolts","CorruptedCursingCircle"],spellCooldownMult:1.1,spellCooldownMod:0,castWhileMoving:!0,visionRadius:15,blindSight:8,evasion:-2,maxhp:61.7,minLevel:0,weight:0,movePoints:4,attackPoints:2,attack:"Spell",attackWidth:1,attackRange:1,power:1,dmgType:"cold",fullBoundBonus:4,regen:.02,maxblock:0,maxdodge:0,stamina:2,events:[{trigger:"addEntity",type:"EpicenterAssignHP"},{trigger:"beforeDamage",type:"epicenterCursed"}],terrainTags:{curseTrap:10},shrines:[],allFloors:!0,dropTable:[{name:"ManaOrb",weight:1}]});

    KinkyDungeonSpellListEnemies.push({enemySpell:!0,name:"CorruptedCursingCircle",color:KDBaseRed,minRange:0,sfx:"Fwoosh",bulletSpin:.1,specialCD:12,selfcast:!0,noTerrainHit:!0,manacost:4,components:["Verbal"],level:1,type:"inert",onhit:"aoe",time:4,delay:3,power:4,range:7,size:5,aoe:2.5,lifetime:1,damage:"soul",events:[{trigger:"bulletTick",type:"CorruptedCursingCircle",aoe:2.5,power:.01}]});

    KDEventMapBullet.bulletTick.CorruptedCursingCircle=(e,n,r)=>{if(!(KDUtilCommon.PlayerWearsRestraint(cRestraints.corruptedCursedEpicenterEncasement)||KDUtilCommon.AmountRestraintWithShrine("Shadow")<5||n.time>1)&&KDistChebyshev(KinkyDungeonPlayerEntity.x-n.x,KinkyDungeonPlayerEntity.y-n.y)<=e.aoe){let n=KDNearbyEnemies(KinkyDungeonPlayerEntity.x,KinkyDungeonPlayerEntity.y,e.aoe);const r=KinkyDungeonAllRestraint();KDBreakTether(KinkyDungeonPlayerEntity),KinkyDungeonPassOut(!0),KinkyDungeonAddRestraintIfWeaker(cRestraints.corruptedCursedEpicenterEncasement,0,!0,"Red",!1,void 0,void 0,"Corrupted",!0);for(const e of n){if("EpicenterCursed"===e.Enemy.name){KinkyDungeonAddRestraintIfWeaker("CursedCollar",15,!0,"Red",!1,void 0,void 0,"Corrupted",!0),KDRemoveEntity(e);break}if("EpicenterCursed2"===e.Enemy.name){KinkyDungeonAddRestraintIfWeaker("CursedCollar2",15,!0,"Red",!1,void 0,void 0,"Corrupted",!0),KDRemoveEntity(e);break}}for(const e of r)if(e){if(e.name&&("CursedCollar"===e.name||"CursedCollar2"===e.name||e.name===cRestraints.corruptedCursedEpicenterEncasement))continue;if(e.curse&&"CursedDamage"===e.curse)continue;if(KDRandom()>.8){if(e.curse="CursedDamage",KDRandom()>.7)continue;break}}}};
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
const aRestraintsNeed=[cRestraints.corruptedAlchemistCorset,cRestraints.corruptedAlchemistBallGag,cRestraints.corruptedAlchemistCollar,cRestraints.corruptedAlchemistHeels,cRestraints.corruptedAlchemistArmbinder,cRestraints.corruptedAlchemistLeash];

KinkyDungeonEnemies.push({name:corruptedAlchemistName,faction:"Corrupted",bound:"Alchemist",playLine:"Alchemist",color:"#8B53E9",tags:KDMapInit(["nocapture","nosub","opendoors","closedoors","imprisonable","human","minor","alchemist"]),armor:5,followRange:1,AI:"hunt",spells:[alchemistBindSpell,"AmpuleYellow"],spellCooldownMult:1,spellCooldownMod:4,projectileAttack:!0,attackLock:"Rubber",noSpellsWhenHarmless:!0,Resistance:{profile:["alchemist"]},events:[{trigger:"afterDamageEnemy",type:"bleedEffectTile",kind:"LatexThin",aoe:1.5,power:3,chance:1,duration:20},{trigger:"beforeDamage",type:alchemistDomFlag},{trigger:"afterEnemyTick",type:alchemistDomRefreshFlag}],ignoreflag:[alchemistDommedFlag],failAttackflag:[alchemistDommedFlag],stamina:4,visionRadius:6,maxhp:20,minLevel:0,weight:-20,movePoints:2,attackPoints:3,attack:"SpellMeleeBindLock",attackWidth:3,attackRange:1,power:1,dmgType:"grope",fullBoundBonus:2,terrainTags:{secondhalf:5,lastthird:5,miniboss:10,latexAnger:6,latexRage:10,latexPleased:2,latexFriendly:4,alchemist:50},shrines:["Latex"],allFloors:!0,dropTable:[{name:"Gold",amountMin:15,amountMax:25,weight:5},{name:"BlueKey",weight:10},{name:"StaffDoll",ignoreInInventory:!0,weight:10}]},{name:alchemistInspectorName,faction:"Corrupted",clusterWith:"alchemist",bound:"Alchemist",color:"#5353e9",playLine:"Gagged",tags:KDMapInit(["human","search","inspectorToys"]),followRange:1,attackPoints:5,stamina:5,AI:"hunt",visionRadius:10,maxhp:12,minLevel:0,weight:-25,movePoints:3,evasion:.2,ignorechance:0,Resistance:{profile:["alchemist"]},RemoteControl:{remote:5,remoteAmount:5},events:[{trigger:"afterDamageEnemy",type:"bleedEffectTile",kind:"LatexThin",aoe:1.5,power:3,chance:1,duration:20},{trigger:"beforeDamage",type:alchemistFactionDomFlag},{trigger:"afterEnemyTick",type:alchemistDomRefreshFlag}],attackPoints:3,attack:"MeleeWillBindVibe",attackWidth:1,attackRange:1,tilesMinRange:1,power:.1,dmgType:"charm",terrainTags:{},allFloors:!0,shrines:["Latex"],dropTable:[{name:"Gold",amountMin:10,amountMax:20,weight:10}]});

KinkyDungeonSpellListEnemies.push({enemySpell:!0,name:alchemistBindSpell,sfx:"Miss",manacost:5,specialCD:15,components:["Arms"],level:1,type:"bolt",projectileTargeting:!0,onhit:"",power:4,delay:0,range:50,damage:"glue",speed:1,playerEffect:{name:"Bind",damage:"glue",power:4,count:1,tag:petRestraintWithSpellTag}});

KDEventMapEnemy.beforeDamage[alchemistDomFlag]=(e,t,n)=>{const a=KDUtilCommon.RestraintWithEnemyTagCount(petRestraintTag);let i=!!KinkyDungeonInventoryGet(cRestraints.corruptedAlchemistLeash),s=KDUtilCommon.PlayerWearsRestraint(cRestraints.corruptedAlchemistCollar),o=KDUtilCommon.PlayerWearsRestraint(cRestraints.corruptedAlchemistBallGag);const r=KinkyDungeonIsWearingLeash(),m=KDUtilCommon.HasRestraintWithShrines("Collars"),y=KDUtilCommon.HasRestraintWithShrines("Gags","FlatGags","BallGags");if(n.enemy===t&&n.target===KinkyDungeonPlayerEntity){let e="";if(n.restraintsAdded&&0===n.restraintsAdded.length)for(const t of aRestraintsNeed)if(!KDUtilCommon.PlayerWearsRestraint(t)){e=t;break}if(r&&!i&&(KinkyDungeonRemoveRestraintsWithName("BasicLeash"),KinkyDungeonRemoveRestraintsWithName("WolfLeash"),KinkyDungeonRemoveRestraintsWithName("CorruptedSlimeLeash"),KinkyDungeonSendTextMessage(1,'"Corrupted Alchemist" removes your leash!',"white",3),e=""),m&&!s&&""!==e&&(KinkyDungeonRemoveRestraintsWithShrine("Collars"),KinkyDungeonSendTextMessage(1,'"Corrupted Alchemist" removes your collar!',"white",3),e=""),y&&!o&&""===e&&(KinkyDungeonRemoveRestraintsWithShrine("Gags"),KinkyDungeonSendTextMessage(1,'"Corrupted Alchemist" removes your gag!',"white",3),e=""),""!==e&&KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(e),0,!0,void 0,!1,void 0,void 0,"Corrupted",!0),a>5&&i&&!KinkyDungeonFlags.get(alchemistDommedFlag)){if("parole"!==KDGameData.PrisonerState&&(KDGameData.PrisonerState="parole",KinkyDungeonPassOut(!0),KinkyDungeonSetDress(petDressName,petDressName),!KinkyDungeonInventoryGet(petDressName))){let e={name:petDressName,id:KinkyDungeonGetItemID(),type:"Outfit"};KinkyDungeonInventoryAdd(e)}if(KDBreakTether(KinkyDungeonPlayerEntity),KinkyDungeonAttachTetherToEntity(2,t),KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity,{id:alchemistDommedFlag,type:"Flag",duration:20,power:1,maxCount:1,currentCount:1,tags:["attack","cast"],events:[{type:alchemistDommedFlag,trigger:"tickAfter"}]}),!t.Enemy.summonEnemy){const e=KinkyDungeonGetNearbyPoint(t.x,t.y,!0,null,!0,!0);if(e){DialogueCreateEnemy(e.x,e.y,alchemistInspectorName);t.Enemy.summonEnemy=!0,KinkyDungeonSendTextMessage(1,`"Corrupted Alchemist" summons ${alchemistInspectorText}!`,"white",3)}}}}};

KDEventMapEnemy.beforeDamage[alchemistFactionDomFlag]=(t,e,n)=>{const a=KDUtilCommon.RestraintWithEnemyTagCount(petRestraintTag);let i=!!KinkyDungeonInventoryGet(cRestraints.corruptedAlchemistLeash);n.enemy===e&&n.target===KinkyDungeonPlayerEntity&&a>5&&i&&!KinkyDungeonFlags.get(alchemistDommedFlag)&&(KDBreakTether(KinkyDungeonPlayerEntity),KinkyDungeonAttachTetherToEntity(2,e),KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity,{id:alchemistDommedFlag,type:"Flag",duration:20,power:1,maxCount:1,currentCount:1,tags:["attack","cast"],events:[{type:alchemistDommedFlag,trigger:"tickAfter"}]}))};

KDEventMapEnemy.afterEnemyTick[alchemistDomRefreshFlag]=(e,n,t)=>{if(KinkyDungeonFlags.get(alchemistDommedFlag)){let e=2;KinkyDungeonSetFlag("TempLeash",e),KinkyDungeonSetFlag("TempLeashCD",2*e),KinkyDungeonSetFlag("noResetIntent",12),n.playWithPlayerCD=e,n.IntentAction="TempLeash"}};

KDEventMapBuff.tickAfter[alchemistDommedFlag]=(e,t,n,a)=>{t.duration>0&&n.player&&(KinkyDungeonInventoryGet("AlchemistPetLeash")||(KDBreakTether(n),KinkyDungeonExpireBuff(n,alchemistDommedFlag)))};

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

const corruptedMaidName = "CorruptedMaid";
const corruptedMaidText = "Corrupted Maid";
const corruptedMaidDomFlag = "CorruptedMaidDom";
const dressingUpRestraint = "RopeSnakeHogtieWrist";
let restraintsToAddMaid=["CorruptedMaidLeatherHeels","CorruptedMaidDusterGag","CorruptedMaidAnkleCuffs","CorruptedMaidLegShackles","CorruptedMaidElbowShackles","CorruptedMaidBelt","CorruptedMaidArmbinder","CorruptedMaidCollar","CorruptedMaidLeash"];

KDUtilCommon.KinkyDungeonCloneEnemy("Maidforce",corruptedMaidName,{playLine:"DomMaid",AI:"hunt",maxhp:15,faction:"Corrupted",stealth:2,failAttackFlag:[corruptedMaidDomFlag],ignoreFlag:[corruptedMaidDomFlag],dropTable:[{name:"Duster",weight:5,ignoreInInventory:!0},{name:"Gold",amountMin:15,amountMax:25,weight:10}],weight:-20,events:[{trigger:"beforeDamage",type:"corruptedMaid"}],tags:KDMapInit(["nocapture","nosub","leashing","tickleweakness","imprisonable","opendoors","human","melee","corruptedMaid","maid","minor","search"])});

KDEventMapEnemy.beforeDamage.corruptedMaid=(e,n,t)=>{if(t.enemy===n&&t.target===KinkyDungeonPlayerEntity&&!t.restrainsAdded){if(KinkyDungeonFlags.get(corruptedMaidDomFlag))return;let e=!1;for(const n of restraintsToAddMaid){if(KDUtilCommon.PlayerWearsRestraint(n))continue;const t=KinkyDungeonGetRestraintByName(n);if(t){if(KinkyDungeonAddRestraintIfWeaker(t,0,!0,void 0,!1,void 0,void 0,void 0,!0)){e=!0;break}}else console.log("Corrupted maid couldn't find the restraint with name: ",n)}if(!e){KinkyDungeonAttachTetherToEntity(1,n);let e={id:corruptedMaidDomFlag,type:"Flag",duration:10,power:1,maxCount:1,currentCount:1,tags:["attack","cast"],events:[{type:corruptedMaidDomFlag,trigger:"tickAfter"}]};KinkyDungeonCurrentDress!==petDressName&&(KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(dressingUpRestraint),0,!0,void 0,!1,void 0,void 0,"Corrupted",!0),KinkyDungeonSendTextMessage(1,`${corruptedMaidText} pushes you to ground and begins changing your outfit!`,"white",3),e.enemy=n),KinkyDungeonSetFlag("PlayerDommed",10),KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity,e)}}};

KDEventMapBuff.tickAfter[corruptedMaidDomFlag]=(e,n,t,i)=>{if(n.duration>0&&t.player){if(!KinkyDungeonInventoryGet("CorruptedMaidCollar"))return KDBreakTether(t),void KinkyDungeonExpireBuff(t,corruptedMaidDomFlag);n.enemy&&5===n.duration&&(KinkyDungeonSetDress("None","None"),KinkyDungeonSendTextMessage(1,`${corruptedMaidText} snapped your current outfit into void.`,"white",3)),KinkyDungeonSetFlag("PlayerDommed",2)}else if(n.enemy){if(KDBreakTether(t),KinkyDungeonSetDress(petDressName,petDressName),!KinkyDungeonInventoryGet(petDressName)){let e={name:petDressName,id:KinkyDungeonGetItemID(),type:"Outfit"};KinkyDungeonInventoryAdd(e)}KinkyDungeonMapParams[KinkyDungeonMapIndex[MiniGameKinkyDungeonCheckpoint]].defeat_outfit=petDressName,KinkyDungeonRemoveRestraintsWithName("RopeSnakeHogtieWrist"),KinkyDungeonSendTextMessage(1,`${corruptedMaidText} has transformed your outfit! +(Corrupted Maid Pet Outfit)`,"white",3),KinkyDungeonAttachTetherToEntity(2,n.enemy);const e=20;KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity,{id:corruptedMaidDomFlag,type:"Flag",duration:e,power:1,maxCount:1,currentCount:1,tags:["attack","cast"],events:[{type:corruptedMaidDomFlag,trigger:"tickAfter"}]}),KinkyDungeonSetFlag("TempLeash",e),KinkyDungeonSetFlag("TempLeashCD",2*e),KinkyDungeonSetFlag("noResetIntent",12),n.enemy.playWithPlayerCD=e,n.enemy.IntentAction="TempLeash"}else KDBreakTether(t),KinkyDungeonExpireBuff(t,corruptedMaidDomFlag)};

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

KinkyDungeonEnemies.push({name:corruptedMummyName,tags:KDMapInit(["nocapture","nosub","leashing","notalk","imprisonable","opendoors","human","ranged","search"]),spells:["WitchSlimeBall","WitchSlime","LatexSpray"],spellCooldownMult:1,spellCooldownMod:0,castWhileMoving:!0,stealth:2,faction:"Corrupted",outfit:"CorruptedMummy",style:"Nothing",maxhp:30,armor:15,followRange:1,kite:3,AI:"hunt",dontKiteWhenDisabled:!0,minLevel:0,weight:-13,movePoints:4,attackPoints:3,attack:"SpellMeleeBind",attackWidth:2,attackRange:1,power:3,dmgType:"crush",fullBoundBonus:1,visionRadius:7,blindSight:10,stamina:6,preferDodge:!0,maxblock:1,maxdodge:3,terrainTags:{},allFloors:!0,events:[{trigger:"beforeDamage",type:"corruptedMummy"}],Defeat:{furnitureTags:[{tags:["shadowLatexRestraints"],count:5},{tags:["shadowBall"],count:1}]},effect:{effect:{name:"ShadowEncase"}},dropTable:[{name:"Duster",weight:5,ignoreInInventory:!0},{name:"Gold",amountMin:15,amountMax:25,weight:10},{name:"SlimeRaw",amount:3,weight:10},{name:"EnchKnife",ignoreInInventory:!0,weight:1}]});

KDEventMapEnemy.beforeDamage.corruptedMummy=(e,n,r)=>{if(r.enemy===n&&r.target===KinkyDungeonPlayerEntity&&!r.restrainsAdded&&!KDUtilCommon.PlayerWearsRestraint("CorruptedMummyCollar")){const e=KinkyDungeonGetRestraintByName("CorruptedMummyCollar");KDRandom()>=.7&&KinkyDungeonAddRestraintIfWeaker(e,0,!0,"Divine2",!1,void 0,void 0,"Corrupted",!0)}};

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

KinkyDungeonEnemies.push({name:corruptedCube,faction:"Latex",color:"#aa00cc",tags:KDMapInit(["nocapture","unstoppable","slime","latex","latexTrap","elite","slashweakness","melee","chainimmune","glueresist","coldweakness","electricresist","pierceweakness","acidweakness","latexRestraints","latexEncaseRandom"]),Animations:["squishyAmbush"],GFX:{AmbushSprite:"LatexCubeHidden"},RestraintFilter:{unlimitedRestraints:!0},Sound:{baseAmount:0,moveAmount:3},ignoreflag:[engulfFlag],failAttackflag:[engulfFlag],stamina:3,squeeze:!0,evasion:-1,followRange:1,AI:"ambush",visionRadius:10,blindSight:2.5,maxhp:20,minLevel:6,weight:1,movePoints:4,attackPoints:2,attack:"MeleeBind",attackWidth:2,attackRange:1,power:4,dmgType:"glue",fullBoundBonus:2,disarm:.7,terrainTags:{tmb:3,slime:2.5,plant:2,passage:20,open:-10,slimeOptOut:-.9,slimePref:1},allFloors:!0,shrines:["Latex"],events:[{trigger:"afterDamageEnemy",type:"bleedEffectTile",kind:"Slime",aoe:1.5,power:3,chance:1,duration:20},{trigger:"afterEnemyTick",type:"createEffectTile",kind:"LatexThin",time:25,power:2,chance:.5,aoe:.5},{trigger:"beforeDamage",type:"cubeEngulf",power:0,color:"#880044"}],dropTable:[{name:"Gold",amountMin:30,amountMax:50,weight:1}]});

KDEventMapEnemy.beforeDamage.cubeEngulf=(e,n,t)=>{const i=KDUtilCommon.RestraintWithEnemyTagCount("latexEncaseRandom");t.enemy===n&&t.target===KinkyDungeonPlayerEntity&&i>3&&!KinkyDungeonFlags.get(engulfFlag)&&KDTripleBuffKill("CubeEngulf",KinkyDungeonPlayerEntity,9,(e=>{KinkyDungeonSetDress("SlimeDress","SlimeDress"),KDBreakTether(KinkyDungeonPlayerEntity),KDRemoveEntity(n),KinkyDungeonRemoveRestraintsWithShrine("Slime"),KinkyDungeonRemoveRestraintsWithShrine("SlimeHard"),KinkyDungeonRemoveRestraintsWithShrine("Latex"),KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeEncasement),0,!0,void 0,!1,void 0,void 0,"Corrupted",!0),KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeCuffs),0,!0,void 0,!1,void 0,void 0,"Corrupted",!0),KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeBallGag),0,!0,void 0,!1,void 0,void 0,"Corrupted",!0),KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeLeash),0,!0,void 0,!1,void 0,void 0,"Corrupted",!0),KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(cRestraints.corruptedCubeBlindfold),0,!0,void 0,!1,void 0,void 0,"Corrupted",!0)}),"Blindness")};

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
