let KDUtilCommon = window.KDUtilCommon;
const cRestraints={corruptedMimicEncasement:"CorruptedMimicEncasement",corruptedCursedEpicenterEncasement:"CorruptedCursedEpicenterEncasement",corruptedMummyHardSlimeFeet:"CorruptedHardSlimeFeet",corruptedMummyHardSlimeBoots:"CorruptedHardSlimeBoots",corruptedMummyHardSlimeLegs:"CorruptedHardSlimeLegs",corruptedMummyHardSlimeArms:"CorruptedHardSlimeArms",corruptedMummyHardSlimeHands:"CorruptedHardSlimeHands",corruptedMummyHardSlimeMouth:"CorruptedHardSlimeMouth",corruptedMummyHardSlimeHead:"CorruptedHardSlimeHead",corruptedMummyCollar:"CorruptedMummyCollar",corruptedCubeCuffs:"CorruptedSlimeShacklesWrists",corruptedCubeLeash:"CorruptedSlimeLeash",corruptedCubeBallGag:"CorruptedSlimeLargeBallGag",corruptedCubeBlindfold:"CorruptedSlimeBlindfold",corruptedCubeEncasement:"CorruptedCubeEncasement",corruptedMaidLeatherHeels:"CorruptedMaidLeatherHeels",corruptedMaidDusterGag:"CorruptedMaidDusterGag",corruptedMaidAnkleCuffs:"CorruptedMaidAnkleCuffs",corruptedMaidLegShackles:"CorruptedMaidLegShackles",corruptedMaidElbowShackles:"CorruptedMaidElbowShackles",corruptedMaidBelt:"CorruptedMaidBelt",corruptedMaidArmbinder:"CorruptedMaidArmbinder",corruptedMaidCollar:"CorruptedMaidCollar",corruptedMaidLeash:"CorruptedMaidLeash",corruptedAlchemistCorset:"CorruptedAlchemistPetCorset",corruptedAlchemistBallGag:"CorruptedAlchemistPetBallGag",corruptedAlchemistCollar:"CorruptedAlchemistPetCollar",corruptedAlchemistHeels:"CorruptedAlchemistPetHeels",corruptedAlchemistArmbinder:"CorruptedAlchemistPetArmbinder",corruptedAlchemistLeash:"CorruptedAlchemistPetLeash"};

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
KinkyDungeonRestraints.push({removePrison:!0,name:cRestraints.corruptedMimicEncasement,Asset:"SmallWoodenBox",Model:cRestraints.corruptedMimicEncasement,Color:["#ba50eb"],Group:"ItemDevices",power:3,weight:1,immobile:!0,alwaysStruggleable:!0,DefaultLock:"Red",removeOnLeash:!0,escapeChance:{Struggle:-.2,Cut:-.2,Remove:.35,Pick:.33,Unlock:.7},helpChance:{Remove:.5,Pick:.5,Unlock:1},enemyTags:{corruptedmimic:100},playerTags:{},minLevel:0,allFloors:!0,shrine:["Furniture"],ignoreSpells:!0,events:[{trigger:"tick",type:"cageDebuff",inheritLinked:!0},{trigger:"tick",type:"PeriodicTeasing",power:1,time:12,edgeOnly:!1,cooldown:{normal:120,tease:50},chance:.02},{trigger:"tick",type:"PeriodicDenial",power:1,time:28,edgeOnly:!1,cooldown:{normal:120,tease:50},chance:.02},{trigger:"postRemoval",type:"mimicEncasement"}]});
KDEventMapInventory.postRemoval.mimicEncasement=(e,n,i)=>{if(i.item===n){for(let e of KinkyDungeonAllRestraint())if(e&&e.name&&e.name===cRestraints.corruptedMimicEncasement)return;DialogueCreateEnemy(KinkyDungeonPlayerEntity.x,KinkyDungeonPlayerEntity.y,"CorruptedMimic"),KDNearbyEnemies(KinkyDungeonPlayerEntity.x,KinkyDungeonPlayerEntity.y,3).forEach((e=>{"CorruptedMimic"==e.Enemy.name&&(e.hp=e.Enemy.maxhp/2,e.stun=10,KinkyDungeonSendTextMessage(4,"The mimic spits you out away and now you are free!","lightgreen",2))}))}};

// ===============================================================================
//#    _____       _                _               ____                        _ 
//#   | ____|_ __ (_) ___ ___ _ __ | |_ ___ _ __   / ___|   _ _ __ ___  ___  __| |
//#   |  _| | '_ \| |/ __/ _ \ '_ \| __/ _ \ '__| | |  | | | | '__/ __|/ _ \/ _` |
//#   | |___| |_) | | (_|  __/ | | | ||  __/ |    | |__| |_| | |  \__ \  __/ (_| |
//#   |_____| .__/|_|\___\___|_| |_|\__\___|_|     \____\__,_|_|  |___/\___|\__,_|
//#         |_|                                                                   
// ===============================================================================

KinkyDungeonRestraints.push({removePrison:!0,name:cRestraints.corruptedCursedEpicenterEncasement,Asset:"SmallWoodenBox",Model:cRestraints.corruptedCursedEpicenterEncasement,Color:["#ba50eb"],Group:"ItemDevices",power:3,weight:1,immobile:!0,alwaysStruggleable:!0,DefaultLock:"Red",removeOnLeash:!1,escapeChance:{Struggle:-.5,Cut:-.5,Remove:.35,Pick:-1,Unlock:-1},helpChance:{Remove:.5,Pick:.5,Unlock:1},enemyTags:{},playerTags:{},minLevel:0,allFloors:!0,shrine:["Furniture","Cursed","Shadow"],ignoreSpells:!0,events:[{trigger:"tick",type:"PeriodicTeasing",power:1,time:12,edgeOnly:!1,cooldown:{normal:60,tease:20},chance:.02},{trigger:"tick",type:"PeriodicDenial",power:1,time:36,edgeOnly:!1,cooldown:{normal:60,tease:20},chance:.02},{trigger:"tick",type:"PeriodicTeasing",power:3,time:16,edgeOnly:!1,cooldown:{normal:60,tease:20},chance:.02},{trigger:"tick",type:"cageDebuff",inheritLinked:!0},{trigger:"tick",type:"corruptedEpicenterCursedEncasement"},{trigger:"postRemoval",type:"corruptedEpicenterCursedRequireEncasement"}]});

KDEventMapInventory.postRemoval.corruptedEpicenterCursedRequireEncasement=(e,n,t)=>{if(t.item===n){for(let e of KinkyDungeonAllRestraint())if(e&&e.name&&e.name===cRestraints.corruptedCursedEpicenterEncasement)return;KinkyDungeonExpireBuff(KinkyDungeonPlayerEntity,"EpicenterEngulfed")}};

KDEventMapInventory.tick.corruptedEpicenterCursedEncasement=(e,n,t)=>{KinkyDungeonHasBuff(KinkyDungeonPlayerBuffs,"EpicenterEngulfed")||KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity,{id:"EpicenterEngulfed",type:"Flag",duration:55,power:1,maxCount:1,currentCount:1,tags:["attack","cast"],events:[{type:"EpicenterEngulfed",trigger:"tickAfter"}]})};

KDBuffSprites["EpicenterEngulfed"] = true;

KDEventMapBuff.tickAfter.EpicenterEngulfed=(e,n,t,i)=>{if(t.player)if(n.duration>0){if(n.duration<45){KinkyDungeonSendTextMessage(5,"Cursed Epicenter moves around with you!","#9074ab",10);let e=KinkyDungeonGetNearbyPoint(t.x,t.y,!0,null,!0,!0);e&&KinkyDungeonMoveTo(e.x,e.y,!1,!1,!0,!1)}}else KDRandom()<.5?(KinkyDungeonExpireBuff(KinkyDungeonPlayerEntity,"EpicenterEngulfed"),DialogueCreateEnemy(KinkyDungeonPlayerEntity.x,KinkyDungeonPlayerEntity.y,"EpicenterCursed"),KDNearbyEnemies(KinkyDungeonPlayerEntity.x,KinkyDungeonPlayerEntity.y,3).forEach((e=>{"EpicenterCursed"==e.Enemy.name&&(e.hp=e.Enemy.maxhp/2,e.stun=10)})),KinkyDungeonSendTextMessage(4,"The epicenter cursed released you for now..","lightgreen",2),KinkyDungeonRemoveRestraintsWithName(cRestraints.corruptedCursedEpicenterEncasement),KinkyDungeonUnlockRestraintsWithShrine("AfterLeashDone")):(n.duration=40,KinkyDungeonSendTextMessage(4,"The epicenter cursed not wanted to release you..","#9074ab",2))};


// ===================================================================================================
//#     ____                            _           _      _    _      _                    _     _   
//#    / ___|___  _ __ _ __ _   _ _ __ | |_ ___  __| |    / \  | | ___| |__   ___ _ __ ___ (_)___| |_ 
//#   | |   / _ \| '__| '__| | | | '_ \| __/ _ \/ _` |   / _ \ | |/ __| '_ \ / _ \ '_ ` _ \| / __| __|
//#   | |__| (_) | |  | |  | |_| | |_) | ||  __/ (_| |  / ___ \| | (__| | | |  __/ | | | | | \__ \ |_ 
//#    \____\___/|_|  |_|   \__,_| .__/ \__\___|\__,_| /_/   \_\_|\___|_| |_|\___|_| |_| |_|_|___/\__|
//#                              |_|                                                                  
// ===================================================================================================

KinkyDungeonRestraints.push({inventory:!0,name:cRestraints.corruptedAlchemistCorset,Asset:"Corset",Model:"Corset",Color:"#8B53E9",Group:"ItemTorso",power:4,weight:0,escapeChance:{Struggle:-.6,Cut:-.5,Remove:.4,Pick:.05},maxwill:.2,Filters:{Corset:{gamma:1,saturation:1,contrast:1,brightness:1.5,red:1.5,green:.8,blue:2,alpha:1}},unlimited:!0,enemyTags:{AlchemistPet:5},playerTags:{ItemTorsoFull:-2},minLevel:2,allFloors:!0,shrine:["Leather","Corsets"]},{inventory:!0,name:cRestraints.corruptedAlchemistBallGag,Asset:"BallGag",Model:"BallGag",Color:"#8B53E9",Group:"ItemMouth",power:4,weight:0,escapeChance:{Struggle:-.6,Cut:-.5,Remove:.3,Pick:.05},maxwill:.2,Filters:{Ball:{gamma:1,saturation:1,contrast:1,brightness:1.5,red:1.5,green:.8,blue:2,alpha:1},Straps:{gamma:1,saturation:1,contrast:1,brightness:1.5,red:1.5,green:.8,blue:2,alpha:1}},unlimited:!0,enemyTags:{AlchemistPet:5},playerTags:{ItemMouthFull:-2},minLevel:2,allFloors:!0,shrine:["Gags","BallGags"]},{inventory:!0,name:cRestraints.corruptedAlchemistCollar,Asset:"LeatherCollar",Model:"LeatherCollar",Color:"#8B53E9",Group:"ItemNeck",power:3,weight:0,escapeChance:{Struggle:-.5,Cut:-.4,Remove:.5,Pick:.05},maxwill:.25,Filters:{Collar:{gamma:1,saturation:1,contrast:1,brightness:1.5,red:1.5,green:.8,blue:2,alpha:1}},unlimited:!0,enemyTags:{AlchemistPet:5},playerTags:{ItemNeckFull:-2},minLevel:0,allFloors:!0,shrine:["Collars","Leather"]},{inventory:!0,name:cRestraints.corruptedAlchemistHeels,Asset:"LeatherHeels",Model:"LeatherHeels",Color:"#8B53E9",Group:"ItemBoots",power:2,weight:0,escapeChance:{Struggle:-.3,Cut:-.2,Remove:.6,Pick:.1},maxwill:.5,Filters:{Heel:{gamma:1,saturation:1,contrast:1,brightness:1.5,red:1.5,green:.8,blue:2,alpha:1}},unlimited:!0,enemyTags:{AlchemistPet:5},playerTags:{ItemBootsFull:-2},minLevel:0,allFloors:!0,shrine:["Leather","Heels"]},{inventory:!0,name:cRestraints.corruptedAlchemistArmbinder,Asset:"Armbinder",Model:"Armbinder",Color:"#8B53E9",Group:"ItemArms",power:6,weight:0,escapeChance:{Struggle:-.8,Cut:-.6,Remove:.2,Pick:.05},maxwill:.1,Filters:{Binder:{gamma:1,saturation:1,contrast:1,brightness:1.5,red:1.5,green:.8,blue:2,alpha:1}},unlimited:!0,enemyTags:{AlchemistPet:5},playerTags:{ItemArmsFull:-2},minLevel:2,allFloors:!0,shrine:["Leather","Armbinders"]},{inventory:!0,debris:"Chains",faction:"Corrupted",name:cRestraints.corruptedAlchemistLeash,Asset:"BasicLeash",Color:"#8B53E9",Group:"ItemNeckRestraints",Link:cRestraints.corruptedAlchemistCollar,unLink:cRestraints.corruptedAlchemistCollar,power:7,weight:0,escapeChance:{Struggle:-.1,Cut:.1,Remove:.2,Pick:-.3},enemyTags:{AlchemistPet:5},playerTags:{},minLevel:0,allFloors:!0,shrine:[],strictness:.05,tether:2,events:[{trigger:"tether",type:"enemyTether",msg:"The alchemist leash tightens!",color:"#8B53E9"}]});

// ==========================================================================
//#     ____                            _           _   __  __       _     _ 
//#    / ___|___  _ __ _ __ _   _ _ __ | |_ ___  __| | |  \/  | __ _(_) __| |
//#   | |   / _ \| '__| '__| | | | '_ \| __/ _ \/ _` | | |\/| |/ _` | |/ _` |
//#   | |__| (_) | |  | |  | |_| | |_) | ||  __/ (_| | | |  | | (_| | | (_| |
//#    \____\___/|_|  |_|   \__,_| .__/ \__\___|\__,_| |_|  |_|\__,_|_|\__,_|
//#                              |_|                                         
// ==========================================================================

KinkyDungeonRestraints.push({inventory:!0,name:cRestraints.corruptedMaidLeatherHeels,Asset:"LeatherHeels",Model:"LeatherHeels",Color:"#53428D",Group:"ItemBoots",power:2,weight:0,escapeChance:{Struggle:-.3,Cut:-.2,Remove:.6,Pick:.1},maxwill:.5,Filters:{Heel:{gamma:1,saturation:1,contrast:1,brightness:1.2,red:1.3,green:.8,blue:2,alpha:1}},unlimited:!0,enemyTags:{corruptedMaid:5},playerTags:{ItemBootsFull:-2},minLevel:0,allFloors:!0,shrine:["Leather","Heels"]},{inventory:!0,name:cRestraints.corruptedMaidDusterGag,Asset:"FeatherDuster",Model:"FeatherDusterGag",Color:"#53428D",Group:"ItemMouth",power:3,weight:0,escapeChance:{Struggle:-.5,Cut:-.4,Remove:.4,Pick:.05},maxwill:.3,Filters:{Handle:{gamma:1,saturation:1,contrast:1,brightness:1.2,red:1.3,green:.8,blue:2,alpha:1},Feathers:{gamma:1,saturation:1,contrast:1,brightness:1.2,red:1,green:1,blue:1,alpha:1}},unlimited:!0,enemyTags:{corruptedMaid:5},playerTags:{ItemMouthFull:-2},minLevel:0,allFloors:!0,shrine:["Gags","FlatGags"]},{inventory:!0,name:cRestraints.corruptedMaidAnkleCuffs,Asset:"ShacklesAnkles",Model:"ShacklesAnkles",Color:"#53428D",Group:"ItemFeet",power:3,weight:0,escapeChance:{Struggle:-.5,Cut:-.4,Remove:.5,Pick:.05},maxwill:.25,Filters:{BaseMetal:{gamma:1,saturation:1,contrast:1,brightness:1.2,red:1.3,green:.8,blue:2,alpha:1}},unlimited:!0,enemyTags:{corruptedMaid:5},playerTags:{ItemFeetFull:-2},minLevel:0,allFloors:!0,shrine:["Metal","Cuffs"]},{inventory:!0,name:cRestraints.corruptedMaidLegShackles,Asset:"ShacklesThigh",Model:"ShacklesThigh",Color:"#53428D",Group:"ItemLegs",power:3,weight:0,escapeChance:{Struggle:-.5,Cut:-.4,Remove:.5,Pick:.05},maxwill:.25,Filters:{BaseMetal:{gamma:1,saturation:1,contrast:1,brightness:1.2,red:1.3,green:.8,blue:2,alpha:1}},unlimited:!0,enemyTags:{corruptedMaid:5},playerTags:{ItemLegsFull:-2},minLevel:0,allFloors:!0,shrine:["Metal","Ties"]},{inventory:!0,name:cRestraints.corruptedMaidElbowShackles,Asset:"ShacklesWrists",Model:"ShacklesWrists",Color:"#53428D",Group:"ItemArms",power:4,weight:0,escapeChance:{Struggle:-.6,Cut:-.5,Remove:.4,Pick:.05},maxwill:.2,Filters:{BaseMetal:{gamma:1,saturation:1,contrast:1,brightness:1.2,red:1.3,green:.8,blue:2,alpha:1}},unlimited:!0,enemyTags:{corruptedMaid:5},playerTags:{ItemArmsFull:-2},minLevel:0,allFloors:!0,shrine:["Metal","Cuffs"]},{inventory:!0,name:cRestraints.corruptedMaidBelt,Asset:"LeatherBelt",Model:"LeatherBelt",Color:"#53428D",Group:"ItemTorso",power:2,weight:0,escapeChance:{Struggle:-.3,Cut:-.2,Remove:.6,Pick:.1},maxwill:.5,Filters:{Belt:{gamma:1,saturation:1,contrast:1,brightness:1.2,red:1.3,green:.8,blue:2,alpha:1}},unlimited:!0,enemyTags:{corruptedMaid:5},playerTags:{ItemTorsoFull:-2},minLevel:0,allFloors:!0,shrine:["Leather","Belts"]},{inventory:!0,name:cRestraints.corruptedMaidArmbinder,Asset:"Armbinder",Model:"Armbinder",Color:"#53428D",Group:"ItemArms",power:6,weight:0,escapeChance:{Struggle:-.8,Cut:-.6,Remove:.2,Pick:.05},maxwill:.1,Filters:{Binder:{gamma:1,saturation:1,contrast:1,brightness:1.2,red:1.3,green:.8,blue:2,alpha:1}},unlimited:!0,enemyTags:{corruptedMaid:5},playerTags:{ItemArmsFull:-2},minLevel:2,allFloors:!0,shrine:["Leather","Armbinders"]},{inventory:!0,name:cRestraints.corruptedMaidCollar,Asset:"LeatherCollar",Model:"LeatherCollar",Color:"#53428D",Group:"ItemNeck",power:3,weight:0,escapeChance:{Struggle:-.5,Cut:-.4,Remove:.5,Pick:.05},maxwill:.25,Filters:{Collar:{gamma:1,saturation:1,contrast:1,brightness:1.2,red:1.3,green:.8,blue:2,alpha:1}},unlimited:!0,enemyTags:{corruptedMaid:5},playerTags:{ItemNeckFull:-2},minLevel:0,allFloors:!0,shrine:["Collars","Leather"]},{inventory:!0,debris:"Chains",faction:"Corrupted",name:cRestraints.corruptedMaidLeash,Asset:"BasicLeash",Color:"#53428D",Group:"ItemNeckRestraints",Link:cRestraints.corruptedMaidCollar,unLink:cRestraints.corruptedMaidCollar,power:7,weight:0,escapeChance:{Struggle:-.1,Cut:.1,Remove:.2,Pick:-.3},enemyTags:{corruptedMaid:5},playerTags:{},minLevel:0,allFloors:!0,shrine:[],strictness:.05,tether:2,events:[{trigger:"tether",type:"enemyTether",msg:"The maid leash tightens!",color:"#53428D"}]});

// ============================================================================================
//#     ____                            _           _   __  __                                 
//#    / ___|___  _ __ _ __ _   _ _ __ | |_ ___  __| | |  \/  |_   _ _ __ ___  _ __ ___  _   _ 
//#   | |   / _ \| '__| '__| | | | '_ \| __/ _ \/ _` | | |\/| | | | | '_ ` _ \| '_ ` _ \| | | |
//#   | |__| (_) | |  | |  | |_| | |_) | ||  __/ (_| | | |  | | |_| | | | | | | | | | | | |_| |
//#    \____\___/|_|  |_|   \__,_| .__/ \__\___|\__,_| |_|  |_|\__,_|_| |_| |_|_| |_| |_|\__, |
//#                              |_|                                                     |___/ 
// ============================================================================================

KinkyDungeonRestraints.push({inventory:!0,name:cRestraints.corruptedMummyCollar,Asset:"LeatherCollar",Model:"LeatherCollar",Color:"#aa00cc",Group:"ItemNeck",power:3,weight:0,escapeChance:{Struggle:1,Cut:1,Remove:1,Pick:.05},maxwill:.25,Filters:{Collar:{gamma:1,saturation:.6,contrast:1,brightness:.6,red:1,green:.7,blue:1.8,alpha:1}},enemyTags:{CorruptedMummy:5},minLevel:0,allFloors:!0,shrine:["Ancient","Collars","Corrupted"],LinkableBy:["HighCollars","Collars","Modules"],events:[{trigger:"tick",type:"corruptedMummyCollarTick"},{trigger:"beforeStruggleCalc",type:"corruptedMummyCollarStruggle"}]});

KDEventMapInventory.tick.corruptedMummyCollarTick=(e,t,n)=>{if(t.name===cRestraints.corruptedMummyCollar){const e=[cRestraints.corruptedMummyHardSlimeFeet,cRestraints.corruptedMummyHardSlimeBoots,cRestraints.corruptedMummyHardSlimeLegs,cRestraints.corruptedMummyHardSlimeArms,cRestraints.corruptedMummyHardSlimeHands,cRestraints.corruptedMummyHardSlimeMouth,cRestraints.corruptedMummyHardSlimeHead],t=KinkyDungeonAllRestraint().map((e=>e.name));if(KinkyDungeonBrightnessGet(KinkyDungeonPlayerEntity.x,KinkyDungeonPlayerEntity.y)<1.5||KinkyDungeonStatWill<12.5)for(const n of e){if(t.includes(n))continue;let r=Math.min(1,.9+.01*(e.indexOf(n)+1));KDRandom()>r&&(KinkyDungeonAddRestraintIfWeaker(KinkyDungeonGetRestraintByName(n),0,!0,"",!1,void 0,void 0,"Corrupted",!0),KinkyDungeonSendTextMessage(10,"The corrupted mummy collar oozes corruption onto you..","#aa00cc",2,!0));break}}};


KDEventMapInventory.beforeStruggleCalc.corruptedMummyCollarStruggle=(e,n,t)=>{t.restraint&&t.restraint.name===cRestraints.corruptedMummyCollar&&(KinkyDungeonBrightnessGet(KinkyDungeonPlayerEntity.x,KinkyDungeonPlayerEntity.y)<1.5||KinkyDungeonStatWill<12.5?(KinkyDungeonLock(n,"Divine2",!1,!1,!1,!1),t.escapeChance=-1e3,n.tightness=1e4):(KinkyDungeonLock(n,"",!1,!1,!1,!1),t.escapeChance=1e3,n.tightness=0))};

let KDRubberLink = ["Wrapping", "Tape", "Belts", "Masks", "Mittens"];
KinkyDungeonRestraints.push({inventory:!0,unlimited:!0,removePrison:!0,name:cRestraints.corruptedMummyHardSlimeBoots,debris:"Slime",linkCategory:"Slime",linkSize:.6,LinkableBy:[...KDRubberLink],renderWhenLinked:[...KDRubberLink],inaccessible:!0,Asset:"ToeTape",Type:"Full",Color:"#332437",Group:"ItemBoots",blockfeet:!0,addTag:["FeetLinked"],power:5,weight:0,escapeChance:{Struggle:0,Cut:.1,Remove:0},failSuffix:{Remove:"SlimeHard"},affinity:{Struggle:["Sharp"],Remove:["Hook"]},Filters:{Rubber:{gamma:1,saturation:.6,contrast:1,brightness:.6,red:1,green:.7,blue:1.8,alpha:1}},Model:"RubberBoots",enemyTags:{latexEncase:100,latexEncaseRandom:103},playerTags:{},minLevel:0,allFloors:!0,shrine:["Latex","Wrapping","SlimeHard","Rubber"],events:[{trigger:"beforeStruggleCalc",type:"corruptedMummyHardSlimeStruggle"}]},{inventory:!0,unlimited:!0,removePrison:!0,name:cRestraints.corruptedMummyHardSlimeFeet,debris:"Slime",linkCategory:"Slime",linkSize:.6,LinkableBy:[...KDRubberLink],renderWhenLinked:[...KDRubberLink],inaccessible:!0,Asset:"DuctTape",Type:"CompleteFeet",OverridePriority:24,Color:"#332437",Group:"ItemFeet",blockfeet:!0,addTag:["FeetLinked"],power:6,weight:-100,escapeChance:{Struggle:0,Cut:.1,Remove:0},failSuffix:{Remove:"SlimeHard"},affinity:{Struggle:["Sharp"],Remove:["Hook"]},Filters:{Rubber:{gamma:1,saturation:.6,contrast:1,brightness:.6,red:1,green:.7,blue:1.8,alpha:1}},Model:"RubberFeet",enemyTags:{latexEncase:100,latexEncaseRandom:103},playerTags:{ItemBootsFull:15},minLevel:0,allFloors:!0,shrine:["Latex","Wrapping","SlimeHard","Rubber"]},{inventory:!0,unlimited:!0,removePrison:!0,name:cRestraints.corruptedMummyHardSlimeLegs,debris:"Slime",linkCategory:"Slime",linkSize:.6,LinkableBy:[...KDRubberLink],renderWhenLinked:[...KDRubberLink],inaccessible:!0,remove:["ClothLower"],Asset:"SeamlessHobbleSkirt",Color:"#332437",Group:"ItemLegs",hobble:1,addTag:["FeetLinked"],power:6,weight:-102,escapeChance:{Struggle:0,Cut:.1,Remove:0},failSuffix:{Remove:"SlimeHard"},affinity:{Struggle:["Sharp"],Remove:["Hook"]},Filters:{Rubber:{gamma:1,saturation:.6,contrast:1,brightness:.6,red:1,green:.7,blue:1.8,alpha:1}},Model:"RubberLegs",enemyTags:{latexEncase:100,latexEncaseRandom:103},playerTags:{ItemFeetFull:2,ItemBootsFull:2},minLevel:0,allFloors:!0,shrine:["Latex","Hobbleskirts","Wrapping","SlimeHard","Rubber"],events:[{trigger:"beforeStruggleCalc",type:"corruptedMummyHardSlimeStruggle"}]},{inventory:!0,unlimited:!0,removePrison:!0,name:cRestraints.corruptedMummyHardSlimeArms,debris:"Slime",linkCategory:"Slime",linkSize:.6,LinkableBy:[...KDRubberLink],renderWhenLinked:[...KDRubberLink],inaccessible:!0,remove:["Bra"],Asset:"StraitLeotard",Modules:[0,0,0,0],Color:["#332437","#332437","#332437"],Group:"ItemArms",bindarms:!0,bindhands:.35,power:8,weight:-102,escapeChance:{Struggle:0,Cut:.1,Remove:0},failSuffix:{Remove:"SlimeHard"},affinity:{Struggle:["Sharp"],Remove:["Hook"]},Filters:{Rubber:{gamma:1,saturation:.6,contrast:1,brightness:.6,red:1,green:.7,blue:1.8,alpha:1}},Model:"RubberArms",enemyTags:{latexEncase:100,latexEncaseRandom:103},playerTags:{ItemFeetFull:2,ItemBootsFull:2,ItemLegsFull:2},minLevel:0,allFloors:!0,shrine:["Latex","SlimeHard","Rubber","Wrapping"],events:[{trigger:"beforeStruggleCalc",type:"corruptedMummyHardSlimeStruggle"}]},{inventory:!0,unlimited:!0,removePrison:!0,name:cRestraints.corruptedMummyHardSlimeHands,debris:"Slime",linkCategory:"Slime",linkSize:.6,LinkableBy:[...KDRubberLink],renderWhenLinked:[...KDRubberLink],inaccessible:!0,Asset:"DuctTape",Color:"#332437",Group:"ItemHands",bindhands:.65,power:5,weight:-102,escapeChance:{Struggle:0,Cut:.1,Remove:0},failSuffix:{Remove:"SlimeHard"},affinity:{Struggle:["Sharp"],Remove:["Hook"]},Filters:{Rubber:{gamma:1,saturation:.6,contrast:1,brightness:.6,red:1,green:.7,blue:1.8,alpha:1}},Model:"RubberHands",enemyTags:{latexEncase:100,latexEncaseRandom:103},playerTags:{ItemFeetFull:1,ItemBootsFull:1,ItemLegsFull:1,ItemHeadFull:1},minLevel:0,allFloors:!0,shrine:["Latex","Wrapping","SlimeHard","Rubber"],events:[{trigger:"beforeStruggleCalc",type:"corruptedMummyHardSlimeStruggle"}]},{inventory:!0,unlimited:!0,removePrison:!0,name:cRestraints.corruptedMummyHardSlimeMouth,debris:"Slime",linkCategory:"Slime",linkSize:.6,inaccessible:!0,Asset:"KittyGag",LinkableBy:[...KDRubberLink],renderWhenLinked:[...KDRubberLink],Color:["#332437","#332437","#332437"],Group:"ItemMouth",AssetGroup:"ItemMouth3",gag:.75,power:6,weight:-102,escapeChance:{Struggle:0,Cut:.1,Remove:0},failSuffix:{Remove:"SlimeHard"},affinity:{Struggle:["Sharp"],Remove:["Hook"]},Filters:{Rubber:{gamma:1,saturation:.6,contrast:1,brightness:.6,red:1,green:.7,blue:1.8,alpha:1}},Model:"RubberMouth",enemyTags:{latexEncase:100,latexEncaseRandom:103},playerTags:{ItemFeetFull:1,ItemBootsFull:1,ItemLegsFull:1,ItemHandsFull:1,ItemArmsFull:1},minLevel:0,allFloors:!0,shrine:["Latex","Wrapping","SlimeHard","Rubber","Gags","FlatGag"],events:[{trigger:"beforeStruggleCalc",type:"corruptedMummyHardSlimeStruggle"}]},{inventory:!0,unlimited:!0,removePrison:!0,name:cRestraints.corruptedMummyHardSlimeHead,debris:"Slime",linkCategory:"Slime",linkSize:.6,LinkableBy:[...KDRubberLink],renderWhenLinked:[...KDRubberLink],inaccessible:!0,Asset:"LeatherSlimMask",Color:"#332437",Group:"ItemHead",gag:.5,blindfold:4,power:6,weight:-102,escapeChance:{Struggle:0,Cut:.1,Remove:0},failSuffix:{Remove:"SlimeHard"},affinity:{Struggle:["Sharp"],Remove:["Hook"]},Filters:{Rubber:{gamma:1,saturation:.6,contrast:1,brightness:.6,red:1,green:.7,blue:1.8,alpha:1}},Model:"RubberHead",enemyTags:{latexEncase:100,latexEncaseRandom:103},playerTags:{ItemFeetFull:1,ItemBootsFull:1,ItemLegsFull:1,ItemHandsFull:1,ItemArmsFull:1,ItemMouth3Full:1,Unmasked:-1e3},minLevel:0,allFloors:!0,shrine:["Latex","Wrapping","Block_ItemMouth","SlimeHard","Rubber"],events:[{trigger:"beforeStruggleCalc",type:"corruptedMummyHardSlimeStruggle"}]});

KDEventMapInventory.beforeStruggleCalc.corruptedMummyHardSlimeStruggle=(e,r,t)=>{if(KDUtilCommon.PlayerWearsRestraint(cRestraints.corruptedMummyCollar)){[cRestraints.corruptedMummyHardSlimeHead,cRestraints.corruptedMummyHardSlimeMouth].includes(t.restraint.name)||(t.escapeChance=-1e3,KinkyDungeonSendTextMessage(10,"You feels like collar prevents you from doing this..","#ff0000",2,!0))}};

// =====================================================================================================
//#     ____                            _           _   _          _               ____      _          
//#    / ___|___  _ __ _ __ _   _ _ __ | |_ ___  __| | | |    __ _| |_ _____  __  / ___|   _| |__   ___ 
//#   | |   / _ \| '__| '__| | | | '_ \| __/ _ \/ _` | | |   / _` | __/ _ \ \/ / | |  | | | | '_ \ / _ \
//#   | |__| (_) | |  | |  | |_| | |_) | ||  __/ (_| | | |__| (_| | ||  __/>  <  | |__| |_| | |_) |  __/
//#    \____\___/|_|  |_|   \__,_| .__/ \__\___|\__,_| |_____\__,_|\__\___/_/\_\  \____\__,_|_.__/ \___|
//#                              |_|                                                                    
// =====================================================================================================

KinkyDungeonRestraints.push({inventory:!0,name:cRestraints.corruptedCubeCuffs,Asset:"ShacklesWrists",Model:"ShacklesWrists",Color:["#f0b541"],Group:"ItemArms",power:3,weight:0,escapeChance:{Struggle:-.5,Cut:-.4,Remove:.5,Pick:.05},maxwill:.25,Filters:{BaseMetal:{gamma:1,saturation:1,contrast:1,brightness:2.8,red:1.1666666666666667,green:.9,blue:2.2333333333333334,alpha:.6}},unlimited:!0,enemyTags:{},playerTags:{ItemArmsFull:-2},minLevel:2,allFloors:!0,shrine:["Metal","Cuffs","AfterLeashDone"]},{inventory:!0,name:cRestraints.corruptedCubeLeash,Asset:"BasicLeash",Model:"BasicLeash",Color:"#aa00cc",Group:"ItemNeckRestraints",power:2,weight:0,escapeChance:{Struggle:-.3,Cut:-.2,Remove:.6,Pick:.1},maxwill:.5,Filters:{Leash:{gamma:1,saturation:1,contrast:1,brightness:1.5,red:1.5,green:.8,blue:2,alpha:.8}},unlimited:!0,enemyTags:{latexEncaseRandom:5},playerTags:{ItemNeckFull:-2},minLevel:0,allFloors:!0,shrine:["Leather","Leash","AfterLeashDone"]},{inventory:!0,name:cRestraints.corruptedCubeBallGag,Asset:"BallGag",Model:"BallGag",Color:"#aa00cc",Group:"ItemMouth",power:4,weight:0,escapeChance:{Struggle:-.6,Cut:-.5,Remove:.3,Pick:.05},maxwill:.2,Filters:{Ball:{gamma:1,saturation:1,contrast:1,brightness:1.5,red:1.5,green:.8,blue:2,alpha:.8},Straps:{gamma:1,saturation:1,contrast:1,brightness:1.5,red:1.5,green:.8,blue:2,alpha:.8}},unlimited:!0,enemyTags:{latexEncaseRandom:5},playerTags:{ItemMouthFull:-2},minLevel:2,allFloors:!0,shrine:["Gags","BallGags","AfterLeashDone"]},{inventory:!0,name:cRestraints.corruptedCubeBlindfold,Asset:"Blindfold",Model:"Blindfold",Color:"#aa00cc",Group:"ItemHead",power:3,weight:0,escapeChance:{Struggle:-.4,Cut:-.3,Remove:.5,Pick:.1},maxwill:.3,Filters:{Blindfold:{gamma:1,saturation:1,contrast:1,brightness:1.5,red:1.5,green:.8,blue:2,alpha:.8}},unlimited:!0,enemyTags:{latexEncaseRandom:5},playerTags:{ItemHeadFull:-2},minLevel:2,allFloors:!0,shrine:["Blindfolds","AfterLeashDone"]},{removePrison:!0,name:cRestraints.corruptedCubeEncasement,Asset:"VacCube",Model:cRestraints.corruptedCubeEncasement,Color:"#aa00cc",Group:"ItemTorso",power:10,weight:0,escapeChance:{Struggle:-1,Cut:-.8,Remove:-.5,Pick:-.2},maxwill:.1,Filters:{Slime:{gamma:1,saturation:1,contrast:1,brightness:1.5,red:1.5,green:.8,blue:2,alpha:.8}},unlimited:!0,enemyTags:{latexEncaseRandom:10},playerTags:{ItemTorsoFull:-2},minLevel:6,allFloors:!0,shrine:["Latex","Encasement"],events:[{trigger:"tick",type:"cageDebuff",inheritLinked:!0},{trigger:"tick",type:"cubeEncasement"},{trigger:"postRemoval",type:"corruptedCubeRequireEncasement"}]});

KDEventMapInventory.postRemoval.corruptedCubeRequireEncasement=(e,n,t)=>{if(t.item===n){for(let e of KinkyDungeonAllRestraint())if(e&&e.name&&e.name===cRestraints.corruptedCubeEncasement)return;KinkyDungeonExpireBuff(KinkyDungeonPlayerEntity,"CubeEngulfed")}};

KDEventMapInventory.tick.cubeEncasement=(n,e,t)=>{KinkyDungeonHasBuff(KinkyDungeonPlayerBuffs,"CubeEngulfed")||KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity,{id:"CubeEngulfed",type:"Flag",duration:55,power:1,maxCount:1,currentCount:1,tags:["attack","cast"],events:[{type:"CubeEngulfed",trigger:"tickAfter"}]})};

KDBuffSprites["CubeEngulfed"] = true;

KDEventMapBuff.tickAfter.CubeEngulfed=(e,n,t,i)=>{if(t.player)if(n.duration>0){if(n.duration<45&&KDRandom()<.35){KinkyDungeonSendTextMessage(5,"Corrupted slime moves around with you!","#9074ab",10);let e=KinkyDungeonGetNearbyPoint(t.x,t.y,!0,null,!0,!0);e&&KinkyDungeonMoveTo(e.x,e.y,!1,!1,!0,!1)}}else KinkyDungeonExpireBuff(KinkyDungeonPlayerEntity,"CubeEngulfed"),DialogueCreateEnemy(KinkyDungeonPlayerEntity.x,KinkyDungeonPlayerEntity.y,corruptedCube),KDNearbyEnemies(KinkyDungeonPlayerEntity.x,KinkyDungeonPlayerEntity.y,3).forEach((e=>{e.Enemy.name==corruptedCube&&(e.hp=10,e.stun=5)})),KinkyDungeonSendTextMessage(4,"The cube not interested in you more and you are free for now..","lightgreen",2),KinkyDungeonRemoveRestraintsWithName(cRestraints.corruptedCubeEncasement),KinkyDungeonUnlockRestraintsWithShrine("AfterLeashDone")};

// =====================================================================
//#    ____           _             _       _     _____         _       
//#   |  _ \ ___  ___| |_ _ __ __ _(_)_ __ | |_  |_   _|____  _| |_ ___ 
//#   | |_) / _ \/ __| __| '__/ _` | | '_ \| __|   | |/ _ \ \/ / __/ __|
//#   |  _ <  __/\__ \ |_| | | (_| | | | | | |_    | |  __/>  <| |_\__ \
//#   |_| \_\___||___/\__|_|  \__,_|_|_| |_|\__|   |_|\___/_/\_\\__|___/
//#   
// =====================================================================       
                                     
// Mimic
KinkyDungeonAddRestraintText(cRestraints.corruptedMimicEncasement, "Corrupted Mimic",
    "Mimic has been swallowed you..",
    "Really hard to escape from alive mimic!");

// Epicenter Cursed
KinkyDungeonAddRestraintText(cRestraints.corruptedCursedEpicenterEncasement, "Epicenter Cursed",
    "Epicenter engulfed you..",
    "Now you are just a toy flying around..\nMaybe after some time it will release you?",);

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