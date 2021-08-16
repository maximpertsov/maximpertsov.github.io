module Page.SinOfMana.Character exposing (Character, viewAll)

import Css exposing (..)
import Debug
import Html.Styled as H
import Html.Styled.Attributes as At
import Page.SinOfMana.Spell as Spell exposing (Spell)



-- MODEL


type alias Character =
    { name : String
    , notes : List String
    }


type Class
    = Class
        { name : String
        , character : Character
        , maxStats : String
        , item : Maybe String
        , predecessor : Maybe Class
        , notes : List String
        }


type alias Skill =
    { class : Class
    , spell : Spell
    , learnedAt : LearnedAt
    , target : Target
    , replace : Maybe Spell
    }


type LearnedAt
    = LevelStat Int Stat
    | Automatic


type alias Capstone =
    { character : Character
    , stat : Stat
    , description : String
    }


type Target
    = One
    | OneOrAll
    | All
    | Self


type Stat
    = STR
    | AGL
    | VIT
    | INT
    | PIE
    | LUK



-- QUERIES


capstonesByCharacter : Character -> List Capstone
capstonesByCharacter character =
    List.filter ((==) character << .character) capstones


skillsByStat : Maybe Stat -> List Skill -> List Skill
skillsByStat maybeStat skills_ =
    skills_
        |> List.filter
            (\skill ->
                case maybeStat of
                    Nothing ->
                        skill.learnedAt == Automatic

                    Just stat ->
                        case skill.learnedAt of
                            Automatic ->
                                False

                            LevelStat _ stat_ ->
                                stat == stat_
            )


characterClasses : Character -> List Class
characterClasses character =
    List.filter
        (\class ->
            case class of
                Class class_ ->
                    class_.character == character
        )
        classes


classSkills : Class -> List Skill
classSkills class =
    List.filterMap
        (\skill ->
            case skill of
                Err _ ->
                    Nothing

                Ok skill_ ->
                    if skill_.class == class then
                        Just skill_

                    else
                        Nothing
        )
        skills



-- Characters


characters : List Character
characters =
    [ duran
    , kevin
    , hawk
    , angela
    , carlie
    , lise
    ]


duran =
    Character
        "Duran"
        [ "can equip shields to draw aggro" ]


kevin =
    Character
        "Kevin"
        [ "dual attacks"
        , "wolf form increases attack by (3% + VIT)"
        ]


hawk =
    Character
        "Hawk"
        [ "dual attacks" ]


angela =
    Character
        "Angela"
        [ "Fireball is learnable with light spirit but still a fire elemental spell"
        , "Ice Smash is learnable with earth spirit but still an ice elemental spell"
        ]


carlie =
    Character
        "Carlie"
        [ "Ghoul'n'Ghost can be learned early with the air spirit but still keep their respective elements" ]


lise =
    Character
        "Lise"
        [ "can equip shields to draw aggro (only Red Heat, Thunder God and Gold)" ]



-- Classes


classes =
    [ fighter
    , knight
    , gladiator
    , paladin
    , lord
    , swordmaster
    , duelist
    , grappler
    , monk
    , bashkar
    , godHand
    ]


fighter : Class
fighter =
    Class
        { name = "Fighter"
        , character = duran
        , maxStats = "12/11/10/8/8/8"
        , item = Nothing
        , predecessor = Nothing
        , notes = []
        }


knight : Class
knight =
    Class
        { name = "Knight"
        , character = duran
        , maxStats = "17/15/17/13/14/14"
        , item = Nothing
        , predecessor = Just fighter
        , notes = []
        }


gladiator : Class
gladiator =
    Class
        { name = "Gladiator"
        , character = duran
        , maxStats = "18/16/17/14/13/13"
        , item = Nothing
        , predecessor = Just fighter
        , notes = []
        }


paladin : Class
paladin =
    Class
        { name = "Paladin"
        , character = duran
        , maxStats = "31/29/32/28/29/29"
        , item = Just "Paladin's Proof"
        , predecessor = Just knight
        , notes = []
        }


lord : Class
lord =
    Class
        { name = "Lord"
        , character = duran
        , maxStats = "32/28/31/29/28/30"
        , item = Just "Lord's Proof"
        , predecessor = Just knight
        , notes = []
        }


swordmaster : Class
swordmaster =
    Class
        { name = "Lord"
        , character = duran
        , maxStats = "32/29/31/29/28/29"
        , item = Just "Master's Proof"
        , predecessor = Just gladiator
        , notes = []
        }


duelist : Class
duelist =
    Class
        { name = "Duelist"
        , character = duran
        , maxStats = "33/30/30/30/27/28"
        , item = Just "Duelist's Proof"
        , predecessor = Just gladiator
        , notes = [ "Lv3 tech has increased base damage" ]
        }


grappler : Class
grappler =
    Class
        { name = "Grappler"
        , character = kevin
        , maxStats = "10/9/10/8/8/8"
        , item = Nothing
        , predecessor = Nothing
        , notes = []
        }


monk : Class
monk =
    Class
        { name = "Monk"
        , character = kevin
        , maxStats = "15/14/18/13/14/14"
        , item = Nothing
        , predecessor = Just grappler
        , notes = []
        }


bashkar : Class
bashkar =
    Class
        { name = "Bashkar"
        , character = kevin
        , maxStats = "16/15/18/14/13/13"
        , item = Nothing
        , predecessor = Just grappler
        , notes = []
        }


godHand : Class
godHand =
    Class
        { name = "God Hand"
        , character = kevin
        , maxStats = "29/29/32/28/29/29"
        , item = Just "Gold Wolf Soul"
        , predecessor = Just monk
        , notes = []
        }



-- Warrior Monk:\t28/30/31/29/28/30
-- class change item: Silver Wolf Soul
-- spell list:
-- Transshape (15 PIE), Water Jutsu (18 PIE), Heal Light* (22 PIE)
-- Leaf Saber^ (16 INT), Power Up* (21 INT), Mind Down (26 INT)
-- Body Change (16 AGL), Energy Ball^ (20 AGL), Power Down (25 AGL)
-- Speed Down (15 LUCK), Fire Ball (19 LUCK), Analyse (23 LUCK)
--
-- Dervish:\t29/30/33/29/28/29
-- class change item: Demon Wolf Soul
-- stronger wolf form
-- spell list:
-- Fire Breath (15 PIE), Power Down (18 PIE), Anti-Magic (22 PIE)
-- Moon Saber (16 INT), Protect Down (21 INT), Half Vanish (26 INT)
-- Poison Breath (16 AGL), Energy Ball (20 AGL), Power Up^ (25 AGL)
-- Speed Down (15 LUCK), Rockfall (19 LUCK), Analyse (23 LUCK)
--
-- Death Hand:\t30/31/32/30/27/28
-- class change item: Death Wolf Soul
-- spell list:
-- Rockfall (15 PIE), Leaf Saber (18 PIE), Dark Force* (22 PIE)
-- Flame Saber (16 INT), Diamond Saber^ (20 INT), Aura Wave (25 INT)
-- Body Change* (16 AGL), Thunder Jutsu (20 AGL), Lunatic# (25 AGL)
-- Speed Up* (15 LUCK), Dark Saber* (19 LUCK), Demon Breath# (23 LUCK)
--
-- capstones
-- STR - enemies spawn with -15 p.def&m.def
-- AGL - when a weapon attack can inflict a status effect (even if immune) subtract another 30 HP or 40 HP on critical
-- VIT - draw aggro
-- INT - sword magic +atk gives 20% instead of 10% (party)
-- PIE - Heal Light also gives +1 TP
-- LUK - party takes less damage from critical hits
-- Skills


toSkill : Class -> String -> Target -> LearnedAt -> Maybe Spell -> Result String Skill
toSkill class spellName target learnedAt replace =
    case Spell.find spellName of
        Nothing ->
            Err "Spell not found"

        Just spell ->
            Ok
                { class = class
                , spell = spell
                , learnedAt = learnedAt
                , target = target

                -- TODO: disallow case where replace has value but cannot find spell
                , replace = replace
                }


skills : List (Result String Skill)
skills =
    [ toSkill knight "Heal Light" One (LevelStat 9 PIE) Nothing
    , toSkill knight "Protect Up" One (LevelStat 10 INT) Nothing
    , toSkill gladiator "Diamond Saber" One (LevelStat 9 INT) Nothing
    , toSkill gladiator "Thunder Saber" One (LevelStat 11 INT) Nothing
    , toSkill gladiator "Dark Saber" One (LevelStat 13 INT) Nothing
    , toSkill paladin "Diamond Missile" One (LevelStat 14 INT) Nothing
    , toSkill paladin "Sleep Flower" One (LevelStat 17 INT) Nothing
    , toSkill paladin "Anti-Magic" One (LevelStat 23 INT) Nothing
    , toSkill paladin "Holy Ball" One (LevelStat 16 PIE) Nothing
    , toSkill paladin "Heal Light" OneOrAll (LevelStat 20 PIE) Nothing
    , toSkill paladin "Exorcise" All (LevelStat 24 PIE) Nothing
    , toSkill paladin "Magic Shield" One (LevelStat 18 VIT) Nothing
    , toSkill paladin "Saint Saber" One (LevelStat 21 VIT) Nothing
    , toSkill paladin "Protect Up" OneOrAll (LevelStat 24 VIT) Nothing
    , toSkill paladin "Tinkle Rain" One (LevelStat 16 AGL) Nothing
    , toSkill paladin "Ice Smash" One (LevelStat 19 AGL) Nothing
    , toSkill paladin "Speed Up" OneOrAll (LevelStat 22 AGL) Nothing
    , toSkill lord "Heal Light" OneOrAll (LevelStat 15 PIE) Nothing
    , toSkill lord "Tinkle Rain" OneOrAll (LevelStat 18 PIE) Nothing
    , toSkill lord "Speed Down" OneOrAll (LevelStat 22 PIE) Nothing
    , toSkill lord "Speed Up" OneOrAll (LevelStat 17 AGL) Nothing
    , toSkill lord "Life Booster" One (LevelStat 20 AGL) Nothing
    , toSkill lord "Power Up" One (LevelStat 23 AGL) Nothing
    , toSkill lord "Ice Saber" One (LevelStat 15 INT) Nothing
    , toSkill lord "Protect Up" OneOrAll (LevelStat 19 INT) Nothing
    , toSkill lord "Energy Ball" One (LevelStat 22 INT) Nothing
    , toSkill lord "Arrows" One (LevelStat 16 LUK) Nothing
    , toSkill lord "Diamond Saber" One (LevelStat 20 LUK) Nothing
    , toSkill lord "Analyse" One (LevelStat 23 LUK) Nothing
    , toSkill swordmaster "Ice Saber" OneOrAll (LevelStat 15 LUK) Nothing
    , toSkill swordmaster "Dark Saber" OneOrAll (LevelStat 18 LUK) Nothing
    , toSkill swordmaster "Energy Ball" One (LevelStat 22 LUK) Nothing
    , toSkill swordmaster "Thunder Saber" OneOrAll (LevelStat 16 INT) Nothing
    , toSkill swordmaster "Analyse" One (LevelStat 19 INT) Nothing
    , toSkill swordmaster "Saint Saber" One (LevelStat 24 INT) Nothing
    , toSkill swordmaster "Leaf Saber" One (LevelStat 20 STR) Nothing
    , toSkill swordmaster "Diamond Saber" OneOrAll (LevelStat 23 STR) Nothing
    , toSkill swordmaster "Power Up" Self (LevelStat 26 STR) Nothing
    , toSkill swordmaster "Speed Up" Self (LevelStat 18 AGL) Nothing
    , toSkill swordmaster "Flame Saber" OneOrAll (LevelStat 21 AGL) Nothing
    , toSkill swordmaster "Moon Saber" One (LevelStat 25 AGL) Nothing
    , toSkill duelist "Diamond Saber" One Automatic Nothing
    , toSkill duelist "Thunder Saber" One Automatic Nothing
    , toSkill duelist "Dark Saber" One Automatic Nothing
    , toSkill duelist "Ice Saber" One (LevelStat 20 STR) Nothing
    , toSkill duelist "Mind Down" One (LevelStat 22 STR) Nothing
    , toSkill duelist "Anti-Magic" One (LevelStat 25 STR) Nothing
    , toSkill duelist "Life Booster" One (LevelStat 18 VIT) Nothing
    , toSkill duelist "Leaf Saber" One (LevelStat 20 VIT) Nothing
    , toSkill duelist "Protect Down" One (LevelStat 23 VIT) Nothing
    , toSkill duelist "Flame Saber" One (LevelStat 16 INT) Nothing
    , toSkill duelist "Transshape" Self (LevelStat 19 INT) Nothing
    , toSkill duelist "Aura Wave" One (LevelStat 22 INT) Nothing
    , toSkill monk "Heal Light" One (LevelStat 11 PIE) Nothing
    , toSkill godHand "Heal Light" One (LevelStat 15 PIE) Nothing
    , toSkill godHand "Moon Saber" One (LevelStat 18 PIE) Nothing
    , toSkill godHand "Triple Spell" All (LevelStat 22 PIE) Nothing
    , toSkill godHand "Ice Saber" One (LevelStat 16 INT) Nothing
    , toSkill godHand "Thunder Saber" Self (LevelStat 20 INT) Nothing
    , toSkill godHand "Aura Wave" Self (LevelStat 25 INT) Nothing
    , toSkill godHand "Tinkle Rain" OneOrAll (LevelStat 16 AGL) Nothing
    , toSkill godHand "Power Up" OneOrAll (LevelStat 20 AGL) Nothing
    , toSkill godHand "Life Booster" One (LevelStat 25 AGL) Nothing
    , toSkill godHand "Protect Down" One (LevelStat 15 LUK) Nothing
    , toSkill godHand "Saint Saber" Self (LevelStat 19 LUK) Nothing
    , toSkill godHand "Magic Shield" One (LevelStat 23 LUK) Nothing
    ]


capstones =
    [ Capstone duran STR "enemies spawn with -15 p.def&m.def"
    , Capstone duran AGL "sword magic +atk gives 20% instead of 10% (party)"
    , Capstone duran VIT "MP regen tick also restores 15 HP"
    , Capstone duran INT "gain 7 p.def&m.def and +20 HP per cursed acc. equipped"
    , Capstone duran PIE "10 maxMP"
    , Capstone duran LUK "increases crit rate resistance of party by 15%"
    ]



-- VIEW


viewAll : String -> H.Html msg
viewAll search =
    H.div
        [ At.css
            [ property "display" "grid"
            , property "grid-template-columns" "repeat(auto-fit, minmax(500px, 1fr))"
            , property "justify-items" "center"
            ]
        ]
        (characters
            |> List.filter
                (\character ->
                    case String.split " " search of
                        [] ->
                            True

                        searches ->
                            let
                                toKey =
                                    String.replace "-" ""
                                        << String.replace " " ""
                                        << String.toLower
                                        << String.trim
                            in
                            List.any (\search_ -> String.contains (toKey search_) (toKey character.name)) searches
                )
            |> List.map view
        )


view : Character -> H.Html msg
view character =
    H.div
        [ At.css
            [ border3 (px 1) solid (hex "#000")
            , width (pct 90)
            , margin2 (px 5) (px 0)
            , padding2 (px 0) (px 10)
            ]
        ]
        [ H.div [] [ H.h3 [] [ H.text character.name ] ]
        , H.ul [] <| List.map (\note -> H.li [] [ H.text note ]) character.notes
        , viewCapstones character
        , H.div [] <| List.map viewClass <| characterClasses character
        ]


viewCapstones : Character -> H.Html msg
viewCapstones character =
    H.div
        []
    <|
        List.concat
            [ [ H.h4 [] [ H.text "Capstones" ] ]
            , List.map viewCapstone <| capstonesByCharacter character
            ]


viewCapstone : Capstone -> H.Html msg
viewCapstone capstone =
    H.div
        [ At.css
            [ displayFlex
            , flexDirection row
            , alignItems center
            ]
        ]
        [ H.div [ At.css [ margin (px 5) ] ] [ H.text <| Debug.toString capstone.stat ]
        , H.div [] [ H.text capstone.description ]
        ]


viewClass : Class -> H.Html msg
viewClass (Class class) =
    H.div
        []
    <|
        List.concat
            [ [ H.div [] [ H.h4 [] [ H.text class.name ] ]
              , H.div [] [ H.text class.maxStats ]
              , H.ul [] <| List.map (\note -> H.li [] [ H.text note ]) class.notes
              ]
            , List.filter
                (not << List.isEmpty)
                [ skillsByStat Nothing <| classSkills <| Class class
                , skillsByStat (Just STR) <| classSkills <| Class class
                , skillsByStat (Just AGL) <| classSkills <| Class class
                , skillsByStat (Just VIT) <| classSkills <| Class class
                , skillsByStat (Just INT) <| classSkills <| Class class
                , skillsByStat (Just PIE) <| classSkills <| Class class
                , skillsByStat (Just LUK) <| classSkills <| Class class
                ]
                |> List.map viewSkills
            ]


viewSkills : List Skill -> H.Html msg
viewSkills skills_ =
    H.div
        [ At.css
            [ margin (px 5)

            -- , property "display" "grid"
            -- , property "grid-template-columns" "repeat(4, 200px)"
            , displayFlex
            , flexDirection row
            ]
        ]
        (skills_
            |> List.map viewSkill
            |> List.intersperse
                (H.div
                    [ At.css
                        [ margin2 (px 0) (px 10) ]
                    ]
                    [ H.text "→" ]
                )
        )


viewSkill : Skill -> H.Html msg
viewSkill skill =
    let
        targetSuffix =
            case skill.target of
                One ->
                    ""

                OneOrAll ->
                    "*"

                All ->
                    "#"

                Self ->
                    "^"

        learnedAt =
            case skill.learnedAt of
                Automatic ->
                    ""

                LevelStat level stat ->
                    String.concat
                        [ " ("
                        , String.fromInt level
                        , " "
                        , Debug.toString stat
                        , ")"
                        ]
    in
    H.div
        []
        [ H.text <| skill.spell.name ++ targetSuffix ++ learnedAt ]



-- DATA


raw =
    """
The listed order of spells may not reflect the exact order in which spells are learned.
A character may only know 10 spells at once; final classes offer 12 spells and certain items may teach new spells as well.
Once the 10 spell limit is reached it is no longer possible to learn new spells or spell upgrades by level up.

Kevin




Hawk
-dual attacks

base:\t\t9/12/9/9/9/12
spell list:
no spells

Ranger:\t\t14/17/15/14/15/18
spell list:
Arrows (13 LUCK), Spikes (14 LUCK)
Body Change (10 INT), Sleep Flower (11 INT)

Ninja:\t\t15/18/15/15/14/17
spell list:
Shuriken (13 AGL), Earth Jutsu (14 AGL), Thunder Jutsu (15 AGL), Water Jutsu (16 AGL), Fire Jutsu (17 AGL)

Wanderer:\t27/31/30/29/30/32
class change item: Good Luck Die
spell list:
Arrows, Sleep Flower* (16 PIE), Body Change* (17 PIE)
Poison Bubble (15 INT), Lunatic (18 INT), Anti-Magic (21 INT, replaces Spikes)
Transshape (19 LUCK), Life Booster (21 LUCK), Energy Ball (23 LUCK)
Half Vanish (18 AGL), Magic Shield (20 AGL), Aura Wave (22 AGL)

Rogue:\t\t28/32/29/28/29/33
class change item: Bad Luck Die
spell list:
Sleep Flower* (16 PIE), Body Change* (17 PIE), Speed Up^ (20 PIE)
Rock Fall (16 INT), Cresent (18 INT), Silver Dart (21 INT)
Cutter Missile (18 AGL), Land Mine (20 AGL), Deadly Weapon (22 AGL)
Rocket Launcher (19 LUCK, replaces Spikes), Axe Bomber (21 LUCK, replaces Arrows), Grenade Bomb (23 LUCK)

Ninja Master:\t28/33/30/30/28/32
class change item: Bullseye Die
spell list:
Sleep Flower (20 STR), Thunder Jutsu* (24 STR)
Shuriken* (19 AGL), Earth Jutsu* (26 AGL)
Water Jutsu* (18 VIT), Thunder Saber (25 VIT)
Fire Jutsu* (17 INT), Poison Bubble (24 INT)
Ice Saber (16 PIE), Transshape (23 PIE)
Crescent (18 LUCK), Analyse (25 LUCK)

Night Blade:\t29/32/31/29/29/31
class change item: Nighteye Die
spell list:
Fire Jutsu, Water Jutsu, Earth Jutsu* (25 PIE), Thunder Jutsu* (28 PIE)
Poison Breath (19 AGL), Blow Needles (21 AGL), Black Rain# (23 AGL)
Fire Breath (18 INT), Deadly Weapon (21 INT), Shuriken* (28 INT)
Silver Dart (20 LUCK), Grenade Bomb (23 LUCK)

capstones
STR - enemies spawn with -20 evade
AGL - +40% counter damage (party)
VIT - 20 evade
INT - when a weapon attack can inflict a status effect (even if immune) subtract another 30 HP or 40 HP on critical
PIE - using a Lv2/3 tech spreads the current saber element to the party and makes pseudo saber real unless resisted
LUK - ignore monster type specific crit resistance; critical damage +20%



Angela
-Fireball is learnable with light spirit but still a fire elemental spell
-Ice Smash is learnable with earth spirit but still an ice elemental spell

base:\t\t8/8/8/12/11/10
spell list:
Fireball (7 INT), Diamond Missile (9 INT), Airblast (11 INT), Ice Smash (12 INT)

Sorceress:\t14/14/14/17/17/16
spell list:
Airblast* (13 INT), Ice Smash* (14 INT), Fireball* (15 INT), Diamond Missile* (16 INT)
Evil Gate (12 PIE), Holy Ball (14 PIE)

Delvar:\t\t13/13/14/18/16/15
spell list:
Thunderstorm (13 INT, replaces Airblast), Mega Splash (14 INT, replaces Ice Smash)
Explode (15 INT, replaces Fireball), Earth Quake (16 INT, replaces Diamond Missile)

Grand Divina:\t30/29/28/32/32/30
class change item: Arcane Book
spell list:
Fireball*, Diamond Missile*, Airblast*, Ice Smash*
Holy Ball* (18 PIE), Tinkle Rain (20 PIE), Heal Light (21 PIE)
Speed Up (17 LUCK), Evil Gate* (18 LUCK), Sleep Flower (20 LUCK)
Transshape (18 INT), Triple Spell# (20 INT)

Arch Mage:\t29/30/29/31/31/31
class change item: Book of Secrets
spell list:
Earth Quake* (18 INT, replaces Diamond Missile), Thunderstorm* (19 INT, replaces Airblast)
Mega Splash* (20 INT, replaces Ice Smash), Explode* (21 INT, replaces Fireball)
Saint Beam* (19 PIE, replaces Holy Ball), Dark Force* (20 PIE, replaces Evil Gate), Mind Down (22 PIE)
Body Change (17 LUCK), Aura Wave (20 LUCK)
Power Down (15 AGL), Anti-Magic (17 AGL), Rainbow Dust# (20 AGL)

Rune Master:\t28/28/30/32/30/30
class change item: Book of Runes
spell list:
Thunderstorm* (15 AGL, replaces Airblast), Stun Wind (18 AGL), Thunder Saber* (21 AGL)
Earth Quake* (16 LUCK, replaces Diamond Missile), Diamond Saber* (19 LUCK), Stone Cloud (22 LUCK)
Mega Splash* (17 PIE, replaces Ice Smash), Ice Saber* (20 PIE), Cold Blaze (23 PIE)
Explode* (19 INT, replaces Fireball), Blaze Wall (22 INT), Flame Saber* (25 INT)

Magus:\t\t29/29/29/33/29/29
class change item: Forbidden Book
spell list:
Earth Quake* (19 INT, replaces Diamond Missile), Thunderstorm* (20 INT, replaces Airblast)
Mega Splash* (21 INT, replaces Ice Smash), Explode* (22 INT, replaces Fireball), Rainbow Dust# (24 INT)
Dark Force* (17 PIE), Lunatic (19 PIE), Annihilator (22 PIE)
Power Up (16 LUCK), Mind Up^ (18 LUCK), Poison Bubble (20 LUCK), Ancient# (22 LUCK)

capstones
STR - add fraction of weapon damage to spell damage
AGL - party casts 20% faster
VIT - primary elemental (fire, ice, wind, earth) spells heal party by 50 HP
INT - pierce 35 m.def
PIE - gain 7 p.def&m.def and +20 HP per cursed acc. equipped
LUK - weapons use LUK instead of their regular stat



Charlie
-Ghoul'n'Ghost can be learned early with the air spirit but still keep their respective elements

base:\t\t8/8/8/11/12/11
spell list:
Holy Ball (6 PIE), Tinkle Rain (7 PIE)

Priestess:\t13/14/14/16/18/16
spell list:
Holy Ball* (13 PIE), Heal Light (14 PIE), Tinkle Rain (15 PIE)
Diamond Saber (9 AGL), Thunder Saber (11 AGL)

Enchantress:\t13/14/13/17/17/17
spell list:
Holy Ball* (13 PIE), Tinkle Rain (15 PIE)
Machine Golem (12 INT), Unicorn Head (14 INT), Ghost (15 INT), Ghoul (16 INT)

Bishop:\t\t29/31/28/29/32/31
class change item: Holy Water Vial
spell list:
Heal Light* (15 AGL), Tinkle Rain* (17 AGL), Magic Shield (20 AGL)
Saint Beam* (19 PIE, replaces Holy Ball), Saint Saber (22 PIE), Exorcise# (24 PIE)
Thunder Saber* (14 STR), Power Up* (16 STR), Diamond Saber* (18 STR)
Flame Saber* (17 LUCK), Energy Ball (19 LUCK), Ice Saber* (21 LUCK)

Sage:\t\t28/30/29/30/33/30
class change item: Bottle of Salt
spell list:
Heal Light* (15 AGL), Tinkle Rain* (17 AGL), Thunder Saber (18 AGL)
Saint Beam* (19 PIE, replaces Holy Ball), Leaf Saber (20 PIE), Dark Force* (22 PIE)
Life Booster (17 INT), Mind Up* (19 INT), Rainbow Dust# (21 INT)
Diamond Saber, Ice Saber (15 VIT), Flame Saber (16 VIT)

Necromancer:\t29/29/27/31/32/32
class change item: Bottle of Ashes
spell list:
Holy Ball*, Tinkle Rain
Machine Golem, Unicorn Head, Ghost, Ghoul
Black Curse (20 LUCK)
Great Demon (20 INT)
Dark Saber (18 PIE), Gremlin (20 PIE)
Black Rain# (17 AGL), Half Vanish (20 AGL)

Evil Shaman:\t30/30/28/30/31/31
class change item: Bottle of Blood
spell list:
Holy Ball*, Tinkle Rain
Unicorn Head, Machine Golem, Ghoul, Ghost Road# (20 INT, replaces Ghost)
Demon Breath* (19 PIE)
Transshape (16 AGL)
Protect Up (17 VIT)
Sleep Flower* (15 STR)
Lunatic (19 LUCK), Anti-Magic (22 LUCK)

capstones
STR - Lv2/3 techs inflict "wood coat" effect unless fire saber is active
AGL - enemies spawn with -20 evade
VIT - 50 maxHP, 10 p.def&m.def
INT - light&dark elemental spells deal more damage
PIE - Tinkle Rain also heals by 25% maxHP of caster if it heals a status
LUK - spells cost 20% MP less, min 1 (party); does not change displayed cost



Lise
-can equip shields to draw aggro (only Red Heat, Thunder God and Gold)

base:\t\t11/11/10/10/10/9
spell list:
no spells

Valkyrie:\t17/16/16/15/16/14
spell list:
Protect Up (11 PIE), Speed Up (13 PIE)
Airblast (12 INT)

Rune Maiden:\t16/17/16/16/15/15
spell list:
Speed Down (11 PIE), Protect Down (13 PIE)
Unicorn Head (12 INT)

Vanadise:\t31/31/31/29/31/29
class change item: Briesingamen
spell list:
Protect Up, Speed Up* (22 AGL)
Flame Saber (18 STR), Power Up (20 STR)
Freya# (18 PIE), Tinkle Rain (19 PIE), Heal Light (21 PIE)
Body Change (16 INT), Thunderstorm (19 INT, replaces Airblast), Mind Up (22 INT)
Holy Ball (16 LUCK), Thunder Saber (20 LUCK)

Starlancer:\t32/30/30/30/30/30
class change item: Morning Star Chain
spell list:
Dark Saber (18 STR), Saint Saber (20 STR), Power Up* (23 STR)
Energy Ball (17 AGL), Ice Smash* (18 AGL), Speed Up* (20 AGL)
Airblast* (17 INT), Fireball* (19 INT), Mind Up* (22 INT)
Marduke# (18 PIE), Aura Wave (20 PIE), Protect Up* (23 PIE)

DragonMaster:\t30/31/32/30/30/31
class change item: Knight Dragon Chain
spell list:
Unicorn Head
Jormungand# (18 PIE), Speed Down* (19 PIE), Protect Down* (21 PIE)
Ghoul (17 INT), Ghost (18 INT), Lunatic (20 INT), Mind Down* (23 INT)
Sleep Flower* (18 AGL), Gremlin (19 AGL), Anti-Magic (21 AGL), Power Down* (23 AGL)

FenrirKnight:\t31/32/31/31/29/30
class change item: Gleipnir
spell list:
Unicorn Head
Leaf Saber (17 INT), Transshape (20 INT), Poison Bubble (22 INT)
Moon Saber (19 AGL), Black Rain# (21 AGL), Speed Down* (23 AGL)
Ghost Road# (17 LUCK), Mind Down* (20 LUCK)
Lamia Naga# (18 PIE), Protect Down* (20 PIE), Power Down* (23 PIE)

capstones
STR - 20% more attack, non-critical regular attacks deal half damage
AGL - weapon cooldown -7 (party)
VIT - enemies spawn with -15 attack
INT - can equip any weapon and armor (even class locked ones)
PIE - Heal Light also gives +1 TP
LUK - party takes 1/8 less damage from spells
"""
