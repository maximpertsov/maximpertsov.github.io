module Page.SinOfMana.Spell exposing (all, raw)

import Csv.Decode as CsvD


all : Result CsvD.Error (List Spell1)
all =
    CsvD.decodeCustom
        { fieldSeparator = '\t' }
        CsvD.FieldNamesFromFirstRow
        decodeSpells
        (String.trim raw)



-- MODEL


type alias Spell =
    { name : String
    , element : List String
    , mpCost : Int
    , castTime : Int
    , effect : String
    , special : Maybe String
    , upgrades : List String
    }


type alias Spell1 =
    { name : String
    }



-- DECODE


decodeSpells : CsvD.Decoder Spell1
decodeSpells =
    CsvD.into
        Spell1
        |> CsvD.pipeline (CsvD.field "Spell" CsvD.string)


raw =
    """
Spell\tElement\tMP Cost\tCast Time\tEffect\tSpecial\tPossible Upgrades
Diamond Missile\tEarth\t4\t70\tLv1 magic damage based on INT\t\tmulti-target
Earth Quake\tEarth\t6\t95\tLv2 magic damage based on INT\t\t
Stone Cloud\tEarth\t9\t150\tLv3 magic damage based on INT + petrify\t\t
Protect up\tEarth\t7\t80\tincrease physical defense\t\tmulti-target, sudden, auto-buff
Speed Down\tEarth\t7\t80\treduce accuracy, evasion and cast speed\t\tmulti-target, sudden, auto-debuff
Diamond Saber\tEarth\t9\t96\tAttack +10%, weapon attacks gain earth property; boost damage of earth spells\t\tmulti-target, sudden
Airblast\tAir\t4\t60\tLv1 magic damage based on INT\t\tmulti-target
Thunderstorm\tAir\t6\t85\tLv2 magic damage based on INT\t\t
Stun Wind\tAir\t9\t115\tLv3 magic damage based on INT + silence\t\t
Speed Up\tAir\t7\t80\tincrease accuracy, evasion and cast speed\t\tmulti-target, sudden, auto-buff
Protect Down\tAir\t7\t80\treduce physical defense\t\tmulti-target, sudden, auto-debuff
Thunder Saber\tAir\t9\t96\tAttack +10%, weapon attacks gain air property; boost damage of air spells\t\tmulti-target, sudden
Ice Smash\tIce\t4\t65\tLv1 magic damage based on INT\tcan be learned with the earth spirit\tmulti-target
Mega Splash\tIce\t6\t90\tLv2 magic damage based on INT\t\t
Cold Blaze\tIce\t9\t120\tLv3 magic damage based on INT + snowman\t\t
Mind Up\tIce\t7\t80\tincrease magic attack, magic defense and healing power\t\tmulti-target, sudden, auto-buff
Power Down\tIce\t7\t80\treduce physical attack\t\tmulti-target, sudden, auto-debuff
Ice Saber\tIce\t9\t96\tAttack +10%, weapon attacks gain ice property; boost damage of ice spells\t\tmulti-target, sudden
Fireball\tFire\t4\t70\tLv1 magic damage based on INT\tcan be learned with the light spirit\tmulti-target
Explode\tFire\t6\t95\tLv2 magic damage based on INT\t\t
Blaze Wall\tFire\t9\t125\tLv3 magic damage based on INT + poison\t\t
Power Up\tFire\t7\t80\tincrease physical attack\t\tmulti-target, sudden, auto-buff
Mind Down\tFire\t7\t80\treduce magic attack, magic defense and healing power\t\tmulti-target, sudden, auto-debuff
Flame Saber\tFire\t9\t96\tAttack +10%, weapon attacks gain fire property; boost damage of fire spells\t\tmulti-target, sudden
Evil Gate\tShadow\t4\t65\tLv1 magic damage based on PIE\t\tmulti-target, curse
Dark Force\tShadow\t6\t90\tLv2 magic damage based on PIE\t\tcurse
Annihilator\tShadow\t20\t160\tvs mobs: Lv4 damage based on PIE; vs player: 999 damage unless the target is immune to death\t\t
Anti-Magic\tShadow\t12\t70\tremoves buffs and debuffs, empties tech bar and weakens physical and elemental immunities to regular resistances\t\t
Black Curse\tShadow\t15\t150\tcombined effect of Power Down + Defense Down + Speed Down + Mind Down\t\tauto-debuff
Dark Saber\tShadow\t9\t96\tAttack +10%, weapon attacks gain shadow property; boost damage of shadow spells\t\tmulti-target, sudden
Holy Ball\tLight\t4\t75\tLv1 magic damage based on PIE\t\tmulti-target, pressure
Saint Beam\tLight\t6\t105\tLv2 magic damage based on PIE\t\tpressure
Heal Light\tLight\t10\t132\trestore HP based on PIE (Lv2), hurts undead\t\tmulti-target
Magic Shield\tLight\t10\t50\tincrease physical defense, magic defense, maximum MP, MP regenation and healing power\t\tsudden, auto-buff (except MP up)
Tinkle Rain\tLight\t5\t12\tremove status ailments and grant 85% chance to resist status ailments from physical attacks\tcast extremely fast\tmulti-target, sudden
Saint Saber\tLight\t9\t96\tAttack +10%, weapon attacks gain light property; boost damage of light spells\t\tmulti-target, sudden
Lunatic \tMoon\t12\t85\treduce maximum HP\t\t
Half Vanish\tMoon\t8\t110\tdamages target for M-BM-= its remaining health; reduced to 1/32 against bosses. Cap at 320 (400 with day bonus)\t\t
Body Change\tMoon\t10\t60\ttransform non-bosses into chibikko enemies\tcan be learned with the dark spirit\tmulti-target, sudden
Life Booster\tMoon\t8\t127\tincrease maximum HP\t\tsudden
Energy Ball\tMoon\t9\t66\tincrease chance to land critical hits\t\tsudden, auto-buff
Moon Saber\tMoon\t9\t96\tAttack +10%, weapon attacks gain moon property and restore HP\t\tmulti-target, sudden
Sleep Flower\tLeaf\t8\t41\tinflict sleep status ailment\tcan be learned with the air spirit\tmulti-target, sudden
Poison Bubble\tLeaf\t8\t80\tLv1 physical damage based on INT + inflict poison + restore MP\t\tleaf coat
Trans-Shape\tLeaf\t7\t36\tnegate non-tech weapon attacks for a short time\t\tsudden
Aura Wave\tLeaf\t19\t45\tfill tech bar by 4 and gain +1 tech point with normal hits\t\tsudden
Resistance\tLeaf\t9\t28\tremove weaknesses\t\tsudden
Leaf Saber\tLeaf\t9\t96\tAttack +10%, weapon attacks gain leaf property and restore MP; boost damage of leaf spells\t\tmulti-target, sudden
Triple Spell\tNone\t12\t136\tLv2.5 magic damage based on INT\t\t
Rainbow Dust\tEarth, Air, Ice, Fire\t11\t125\tLv3 magic damage based on INT\t\t
Ancient\tNone\t15\t165\tLv3 magic damage based on INT\t\t
Exorcise\tNone\t17\t130\t999 damage but only against Undead\t\t
Demon Breath\tAir, Fire, Shadow\t12\t90\tLv1.5 magic damage based on PIE, reduce magic attack, magic defense and healing power\t\t
Unicorn Head\tAir\t7\t85\tLv2 magic damage based on INT\t\t
Machine Golem \tEarth\t7\t100\tLv2 magic damage based on INT\t\t
Ghoul \tFire\t7\t95\tLv2 magic damage based on INT\tcan be learned with the air spirit\t
Ghost \tIce\t7\t90\tLv2 magic damage based on INT\tcan be learned with the air spirit\t
Ghost Road\tIce\t10\t122\tLv1.5 magic damage based on INT + Power Down Effect\t\t
Gremlin \tShadow\t7\t103\tLv2 magic damage based on PIE\t\tcurse
Great Demon\tNone\t12\t143\tLv3 magic damage based on PIE + chibikko\t\t
Freya\tNone\t12\t150\tLv2.5 magic damage based on INT + chibikko\t\t
Marduke  \tNone\t12\t150\tLv2.5 magic damage based on INT + silence\t\t
Jormungand\tNone\t12\t150\tLv2.5 magic damage based on INT + poison\t\t
Lamian Naga\tNone\t12\t150\tLv2.5 magic damage based on INT + sleep\t\t
Arrow\tPhysical\t8\t45\tLv1.5 physical damage based on LUCK\t\t
Axe Bomber\tPhysical\t10\t63\tLv2 physical damage based on LUCK\t\t
Spike\tEarth\t8\t49\tLv1 physical damage based on LUCK\t\t
Rock Fall\tEarth\t11\t61\tLv2 physical damage based on LUCK\t\t
Landmine\tFire\t10\t56\tLv1 physical damage based on LUCK + Speed Down Effect\t\t
Rocket Launcher\tFire\t12\t58\tLv2 physical damage based on LUCK\t\t
Silver Dart\tLight\t10\t70\tLv1.5 physical damage based on LUCK\t\tpressure
Cresent \tShadow\t10\t57\tLv2 physical damage based on LUCK\t\tcurse
Grenade Bomb\tLeaf\t11\t64\tLv1 physical damage based on LUCK + restore MP\t\tleaf coat
Cutter Missile\tNone\t12\t61\tLv1 physical damage based on LUCK + Protect Down Effect\t\t
Shuriken\tPhysical\t8\t49\tLv1 physical damage based on AGL, reduce accuracy\t\tmulti-target
Earth Jutsu \tEarth\t9\t52\tLv1 physical damage based on INT + Speed Down effect\t\t
Thunder Jutsu\tAir\t9\t46\tLv1 physical damage based on INT + Protect Down effect\t\t
Water Jutsu\tIce\t9\t48\tLv1 physical damage based on INT + Power Down effect\t\t
Fire Jutsu\tFire\t9\t50\tLv1 physical damage based on INT + Mind Down effect\t\t
Poison Breath\tNone\t8\t42\tLv1 physical damage based on INT + poison\t\tleaf coat
Flame Breath\tFire\t11\t58\tLv2 physical damage based on INT\t\t
Blow Needles\tShadow\t10\t81\tLv1.5 physical damage based on LUCK + silence\t\tcurse
Deadly Weapon\tNone\t14\t118\tLv2 physical damage based on LUCK + max HP down\t\t
Black Rain\tShadow\t13\t114\tLv1.5 physical damage based on AGL\t\tcurse
Analyze\tNone\t9\t23\treduce resistance to critical hits (rate & damage)\t\tauto-debuff
Regeneration\tNone\t8\t110\trestore HP based on PIE (Lv1) and add HP regeneration effect, hurts undead\t\tauto-buff
"""
