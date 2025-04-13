const KDUtilCommon = window.KDUtilCommon;
AddModel({
    Name: "CorruptedMummyOrb",
    Folder: "Weapon",
    TopLevel: true,
    Protected: false,
    Categories: ["Weapon"],
    Layers: ToLayerMap([{
        Name: "CorruptedMummyOrb",
        Layer: "Wings",
        Pri: 0,
        NoOverride: true,
    }]),
});

KDUtilCommon.CloneModel("LeatherGloveLeft", "MaidBandLeft", {
    Filters: {
        "RimLeft": {"gamma":1,"saturation":1,"contrast":1,"brightness":3.18,"red":1,"green":1,"blue":1,"alpha":1},
        "BandLeft": {"gamma":1,"saturation":1,"contrast":1,"brightness":0.25,"red":1,"green":1,"blue":1,"alpha":1}
    },
    Layers: ToLayerMap([
        { Name: "RimGloveLeft", Layer: "GloveLeft", Pri: 8.1,
            Poses: ToMap([...ARMPOSES]),
            InheritColor: "RimLeft",
            NoOverride: true,
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
        },
        { Name: "RimForeGloveLeft", Layer: "ForeGloveLeft", Pri: 8.1,
            Poses: ToMap([...FOREARMPOSES]),
            InheritColor: "RimLeft",
            NoOverride: true,
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
            SwapLayerPose: {Crossed: "CrossGloveLeft"},
        },
        { Name: "BandGloveLeft", Layer: "GloveLeft", Pri: 8.1,
            Poses: ToMap([...ARMPOSES]),
            InheritColor: "BandLeft",
            NoOverride: true,
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
        },
        { Name: "BandForeGloveLeft", Layer: "ForeGloveLeft", Pri: 8.1,
            Poses: ToMap([...FOREARMPOSES]),
            InheritColor: "BandLeft",
            NoOverride: true,
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
            SwapLayerPose: {Crossed: "CrossGloveLeft"},
        },
    ])
});

KDUtilCommon.CloneModel("LeatherGloveRight", "MaidBandRight", {
    Filters: {
        "RimRight": {"gamma":1,"saturation":1,"contrast":1,"brightness":3.18,"red":1,"green":1,"blue":1,"alpha":1},
        "BandRight": {"gamma":1,"saturation":1,"contrast":1,"brightness":0.25,"red":1,"green":1,"blue":1,"alpha":1}
    },
    Layers: ToLayerMap([
        { Name: "RimGloveRight", Layer: "GloveRight", Pri: 8.1,
            Poses: ToMapSubtract([...ARMPOSES], ["Wristtie"]),
            InheritColor: "RimRight",
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
        },
        { Name: "RimForeGloveRight", Layer: "ForeGloveRight", Pri: 8.1,
            Poses: ToMap([...FOREARMPOSES]),
            InheritColor: "RimRight",
            NoOverride: true,
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
            SwapLayerPose: {Crossed: "CrossGloveRight"},
        },
        { Name: "BandGloveRight", Layer: "GloveRight", Pri: 8.1,
            Poses: ToMapSubtract([...ARMPOSES], ["Wristtie"]),
            InheritColor: "BandRight",
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
        },
        { Name: "BandForeGloveRight", Layer: "ForeGloveRight", Pri: 8.1,
            Poses: ToMap([...FOREARMPOSES]),
            InheritColor: "BandRight",
            NoOverride: true,
            GlobalDefaultOverride: ToMap(["Front", "Crossed"]),
            SwapLayerPose: {Crossed: "CrossGloveRight"},
        },
    ])
});

KDUtilCommon.CloneModel("LeatherGloves", "MaidWristBand", {
    Categories: ["Accessories"],
    Filters: {
        "RimLeft": {"gamma":1,"saturation":1,"contrast":1,"brightness":3.18,"red":1,"green":1,"blue":1,"alpha":1},
        "BandLeft": {"gamma":1,"saturation":1,"contrast":1,"brightness":0.25,"red":1,"green":1,"blue":1,"alpha":1},
        "RimRight": {"gamma":1,"saturation":1,"contrast":1,"brightness":3.18,"red":1,"green":1,"blue":1,"alpha":1},
        "BandRight": {"gamma":1,"saturation":1,"contrast":1,"brightness":0.25,"red":1,"green":1,"blue":1,"alpha":1}
    },
    Layers: ToLayerMap([
        ...GetModelLayers("MaidBandLeft"),
        ...GetModelLayers("MaidBandRight"),
    ])
});

AddModel({
    Name: "CorruptedCubeEncasement",
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

AddModel({
    Name: "CorruptedMimicEncasement",
    Folder: "Furniture",
    TopLevel: true,
    Group: "Devices",
    Restraint: true,
    Categories: ["Furniture"],
    AddPose: ["HandsBehind", "FeetLinked"],
    Layers: ToLayerMap([
        { Name: "CorruptedMimicEncasement1", Layer: "FurnitureFront", Pri: -40, Invariant: true },
        { Name: "CorruptedMimicEncasement2", Layer: "FurnitureBack", Pri: 40, Invariant: true },
    ])
});

AddModel({
    Name: "CorruptedCursedEpicenterEncasement",
    Folder: "Furniture",
    TopLevel: true,
    Group: "Devices",
    Restraint: true,
    Categories: ["Furniture"],
    AddPose: ["UprightHogtie", "ForceKneel"],
    Layers: ToLayerMap([
        { Name: "CorruptedEpicenterEncasement1", Layer: "FurnitureFront", Pri: -40, Invariant: true },
        { Name: "CorruptedEpicenterEncasement2", Layer: "FurnitureBack", Pri: 40, Invariant: true },
    ])
});