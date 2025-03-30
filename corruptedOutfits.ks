// corruptedOutfits.js
AddModel({
    Name: "TransparentCatsuitCroppedLowRise",
    TopLevel: false,
    Parent: "TransparentCatsuit",
    Categories: ["Suits"],
    Folder: "Catsuit",
    Filters: {
        TorsoUpper: {"gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1, "red": 1, "green": 1, "blue": 1, "alpha": 0.53},
        TorsoLower: {"gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1, "red": 1, "green": 1, "blue": 1, "alpha": 0.53},
    },
    Layers: ToLayerMap([
        ...GetModelLayersNoOverride("CatsuitUpperCropped"),
        ...GetModelLayersNoOverride("CatsuitLowerLowRise"),
    ]),
});

KDModelDresses["AlchemistPet"] = [
    {
        Item: "TransparentCatsuitCroppedLowRise", Group: "Catsuit", Color: "#53428D", Lost: false,
        Filters: {
            TorsoUpper: {"gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.55, "red": 1.63, "green": 3.06, "blue": 3.86, "alpha": 1},
            TorsoLower: {"gamma": 1, "saturation": 1, "contrast": 1, "brightness": 1.55, "red": 1.63, "green": 3.06, "blue": 3.86, "alpha": 1}
        }
    },
    {
        Item: "KittyEars", Group: "Kitty", Color: "#53428D", Lost: false,
        Filters: {
            Ears: {"gamma": 0.616, "saturation": 1, "contrast": 1, "brightness": 0.35, "red": 1, "green": 1, "blue": 1, "alpha": 1},
            InnerEars: {"gamma": 1.76, "saturation": 1, "contrast": 2.13, "brightness": 0.21, "red": 1.63, "green": 3.06, "blue": 3.86, "alpha": 1}
        }
    },
];

KinkyDungeonOutfitsBase.push({
    name: "AlchemistPet", dress: "AlchemistPet", shop: false, rarity: 4,
    events: []
});

KDModelDresses["MaidPet"] = [
    {
        Item: "MaidCorsetFull", Group: "MaidCorsetFull", Color: "#53428D", Lost: false,
        Filters: {
            Corset: {"gamma":0.683,"saturation":0,"contrast":1.016,"brightness":0.449,"red":2.431,"green":2.352,"blue":2.64,"alpha":1},
            CorsetStraps: {"gamma":1,"saturation":0.01,"contrast":1,"brightness":1,"red":4.21,"green":0.784,"blue":2.941,"alpha":1}
        }
    },
    {
        Item: "WarriorSkirt", Group: "WarriorSkirt", Color: "#53428D", Lost: false,
        Filters: {
            Skirt: {"gamma":1,"saturation":0.01,"contrast":1,"brightness":1,"red":4.21,"green":0.784,"blue":2.941,"alpha":1}
        }
    },
    {
        Item: "MaidHairband", Group: "Hairband", Color: "#53428D", Lost: false,
    },
    {
        Item: "MaidWristBand", Group: "MaidWristBand", Color: "#53428D", Lost: false,
    },
    {
        Item: "Ribbon", Group: "Ribbon",
        Filters: {
            RibbonBelt: {"gamma":1.9,"saturation":0,"contrast":1,"brightness":1.5666666666666669,"red":1,"green":1,"blue":1.1,"alpha":1},
            RibbonBack: {"gamma":1.9,"saturation":0,"contrast":1,"brightness":1.5666666666666669,"red":1,"green":1,"blue":1.1,"alpha":1}
        }
    }
];

KinkyDungeonOutfitsBase.push({
    name: "MaidPet", dress: "MaidPet", shop: false, rarity: 4, 
    events: [{trigger: "calcEvasion", type: "AccuracyBuff", requiredTag: "mold", power: -5.0}]
});

const corruptedSlimeMetalFilter = {"gamma": 1, "saturation": 1, "contrast": 1, "brightness": 2.8, "red": 1.1666666666666667, "green": 0.9, "blue": 2.2333333333333334, "alpha": 0.6};
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

KDModelDresses.CorruptedMummy = [
    {
        "Item": "Body",
        "Group": "Body",
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
    {
        "Item": "CorruptedMummyOrb",
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
    {
        "Item": "KittyEars",
        "Group": "Face",
        "Filters": {
            "Ears": {
                "gamma": 1.0,
                "saturation": 1.0,
                "contrast": 1.50,
                "brightness": 1.0,
                "red": 0.49,
                "green": 0.61,
                "blue": 0.69,
                "alpha": 1
            },
            "InnerEars": {
                "gamma": 1.0,
                "saturation": 1.0,
                "contrast": 1,
                "brightness": 1,
                "red": 1.0,
                "green": 1.0,
                "blue": 1.0,
                "alpha": 1
            }
        },
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
    {
        "Item": "BlankEyes",
        "Group": "Eyes",
        "Filters": {
            "Eyes": {
                "gamma": 1.0,
                "saturation": 1.0,
                "contrast": 1.0,
                "brightness": 1.0,
                "red": 0.86,
                "green": 0.31,
                "blue": 1.69,
                "alpha": 1
            },
            "Eyes2": {
                "gamma": 1.0,
                "saturation": 1.0,
                "contrast": 1,
                "brightness": 1,
                "red": 0.86,
                "green": 0.31,
                "blue": 1.69,
                "alpha": 1
            }
        },
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
    {
        "Item": "Cat Brows",
        "Filters": {
            "Brows": {
                "gamma": 1.0,
                "saturation": 1.0,
                "contrast": 1.50,
                "brightness": 1.0,
                "red": 0.49,
                "green": 0.61,
                "blue": 0.69,
                "alpha": 1
            },
            "Brows2": {
                "gamma": 1.0,
                "saturation": 1.0,
                "contrast": 1.50,
                "brightness": 1.0,
                "red": 0.49,
                "green": 0.61,
                "blue": 0.69,
                "alpha": 1
            }
        },
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
    {
        "Item": "Simple Blush",
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
    {
        "Item": "Catsuit",
        "Group": "Suits",
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
    {
        "Item": "BraidCustom",
        "Filters": {
            "BraidCustom": {
                "gamma": 1.0,
                "saturation": 1.0,
                "contrast": 1.50,
                "brightness": 1.0,
                "red": 0.49,
                "green": 0.61,
                "blue": 0.69,
                "alpha": 1
            },
        },
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
    {
        "Item": "BackShort",
        "Filters": {
            "BackShort": {
                "gamma": 1.0,
                "saturation": 1.0,
                "contrast": 1.50,
                "brightness": 1.0,
                "red": 0.49,
                "green": 0.61,
                "blue": 0.69,
                "alpha": 1
            },
        },
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
    {
        "Item": "IronCollar",
        "Group": "Accessories",
        "Filters": {
            "BaseMetal": {
                "gamma": 1.0,
                "saturation": 0.7,
                "contrast": 1.0,
                "brightness": 1.0,
                "red": 0.73,
                "green": 0.27,
                "blue": 1.73,
                "alpha": 1
            },
        },
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
    {
        "Item": "ElfSkirt",
        "Filters": {
            "Skirt": {
                "gamma": 1.0,
                "saturation": 1.0,
                "contrast": 1.50,
                "brightness": 1.0,
                "red": 0.49,
                "green": 0.61,
                "blue": 0.69,
                "alpha": 1
            },
            "SkirtBand": {
                "gamma": 1.0,
                "saturation": 0.7,
                "contrast": 1.0,
                "brightness": 1.0,
                "red": 0.73,
                "green": 0.27,
                "blue": 1.73,
                "alpha": 1
            },
            "SkirtBack": {
                "gamma": 1.0,
                "saturation": 1.0,
                "contrast": 1.50,
                "brightness": 1.0,
                "red": 0.49,
                "green": 0.61,
                "blue": 0.69,
                "alpha": 1
            },
        },
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
    {
        "Item": "ElfBra",
        "Filters": {
            "Cloth": {
                "gamma": 1.0,
                "saturation": 1.0,
                "contrast": 1.50,
                "brightness": 1.0,
                "red": 0.49,
                "green": 0.61,
                "blue": 0.69,
                "alpha": 1
            },
        },
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
    {
        "Item": "ElfBands",
        "Filters": {
            "BandLeft": {
                "gamma": 1.0,
                "saturation": 0.7,
                "contrast": 1.0,
                "brightness": 1.0,
                "red": 0.73,
                "green": 0.27,
                "blue": 1.73,
                "alpha": 1
            },
            "BandRight": {
                "gamma": 1.0,
                "saturation": 0.7,
                "contrast": 1.0,
                "brightness": 1.0,
                "red": 0.73,
                "green": 0.27,
                "blue": 1.73,
                "alpha": 1
            },
        },
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
    {
        "Item": "ElfCirclet",
        "Filters": {
            "Circlet": {
                "gamma": 1.0,
                "saturation": 0.7,
                "contrast": 1.0,
                "brightness": 1.0,
                "red": 0.73,
                "green": 0.27,
                "blue": 1.73,
                "alpha": 1
            },
            "Gem": {
                "gamma": 1.0,
                "saturation": 1.0,
                "contrast": 1.0,
                "brightness": 1.0,
                "red": 0.73,
                "green": 0.27,
                "blue": 1.73,
                "alpha": 1
            },
        },
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
    {
        "Item": "MaidShoes",
        "Group": "Shoes",
        "Filters": {
            "ShoeLeft": {
                "gamma": 1.0,
                "saturation": 0.7,
                "contrast": 1.0,
                "brightness": 1.0,
                "red": 0.73,
                "green": 0.27,
                "blue": 1.73,
                "alpha": 1
            },
            "ShoeRight": {
                "gamma": 1.0,
                "saturation": 0.7,
                "contrast": 1.0,
                "brightness": 1.0,
                "red": 0.73,
                "green": 0.27,
                "blue": 1.73,
                "alpha": 1
            },
        },
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
    {
        "Item": "KittyPetTail",
        "Filters": {
            "Tail": {
                "gamma": 1.0,
                "saturation": 0.7,
                "contrast": 1.50,
                "brightness": 1.0,
                "red": 0.49,
                "green": 0.61,
                "blue": 0.69,
                "alpha": 1
            },
            "Stripe": {
                "gamma": 1.0,
                "saturation": 0.7,
                "contrast": 1.0,
                "brightness": 1.0,
                "red": 1.0,
                "green": 1.0,
                "blue": 1.0,
                "alpha": 0.0
            },
        },
        "Color": "Default",
        "Lost": false,
        "Skirt": false
    },
];

KinkyDungeonRefreshOutfitCache();