module Page.SinOfMana.Enemy exposing (Enemy, viewAll)

import Css exposing (..)
import Csv.Decode as CsvD
import Html.Styled as H
import Html.Styled.Attributes as At



-- VIEW


viewAll : H.Html msg
viewAll =
    case all of
        Nothing ->
            H.div [] [ H.text "Problem loading enemies" ]

        Just enemies ->
            H.div
                [ At.css
                    [ property "display" "grid"
                    , property "grid-template-columns" "repeat(auto-fit, minmax(300px, 1fr))"
                    , property "justify-items" "center"
                    ]
                ]
            <|
                List.map view enemies


view : Enemy -> H.Html msg
view enemy =
    H.div
        [ At.css
            [ border3 (px 1) solid (hex "#000")
            , width (px 300)
            , margin2 (px 5) (px 0)
            ]
        ]
        [ H.div [] [ H.text enemy.name ]
        , H.div [] [ H.text <| "Repel: " ++ String.join "," enemy.repel ]
        , H.div [] [ H.text <| "Drain: " ++ String.join "," enemy.drain ]
        , H.div [] [ H.text <| "Void: " ++ String.join "," enemy.void ]
        , H.div [] [ H.text <| "Half: " ++ String.join "," enemy.half ]
        , H.div [] [ H.text <| "Weak: " ++ String.join "," enemy.weak ]
        , H.div [] [ H.text <| "Resist status: " ++ String.join "," enemy.statusResistances ]
        , H.div [] [ H.text <| "Inflict status: " ++ String.join "," enemy.statusInfliction ]
        , H.div [] [ H.text <| "Common Drop: " ++ String.join "," enemy.commonItem ]
        , H.div []
            [ H.text <|
                "Common Drop (Lv 45+): "
                    ++ String.join ","
                        (case enemy.commonItem45 of
                            Nothing ->
                                []

                            Just item ->
                                [ item ]
                        )
            ]
        , H.div [] [ H.text <| "Rare Drop: " ++ String.join "," enemy.commonItem ]
        , H.div [] [ H.text <| "Rare Drop (Lv 28+): " ++ String.join "," enemy.rareItem28 ]
        , H.div [] [ H.text <| "Rare Drop (Lv 60+): " ++ String.join "," enemy.rareItem60 ]
        ]



-- MODEL


type alias Enemy =
    { name : String
    , repel : List String
    , drain : List String
    , void : List String
    , half : List String
    , weak : List String
    , statusResistances : List String
    , statusInfliction : List String
    , commonItem : List String
    , commonItem45 : Maybe String
    , rareItem : List String
    , rareItem28 : List String
    , rareItem60 : List String
    }


all : Maybe (List Enemy)
all =
    Result.toMaybe <|
        CsvD.decodeCustom
            { fieldSeparator = '\t' }
            CsvD.FieldNamesFromFirstRow
            decodeEnemy
            (String.trim raw)



-- DECODE


decodeEnemy : CsvD.Decoder Enemy
decodeEnemy =
    CsvD.into
        Enemy
        |> CsvD.pipeline (CsvD.field "Name" CsvD.string)
        |> CsvD.pipeline (CsvD.field "Repel" decodeCommaSeparatedStrings)
        |> CsvD.pipeline (CsvD.field "Drain" decodeCommaSeparatedStrings)
        |> CsvD.pipeline (CsvD.field "Void" decodeCommaSeparatedStrings)
        |> CsvD.pipeline (CsvD.field "Half" decodeCommaSeparatedStrings)
        |> CsvD.pipeline (CsvD.field "Weak" decodeCommaSeparatedStrings)
        |> CsvD.pipeline (CsvD.field "Status Resistances" decodeCommaSeparatedStrings)
        |> CsvD.pipeline (CsvD.field "Status Infliction" decodeCommaSeparatedStrings)
        |> CsvD.pipeline (decode2Fields "Common1" "Common2")
        |> CsvD.pipeline (CsvD.field "Common3 (Lv 45+)" <| CsvD.blank CsvD.string)
        |> CsvD.pipeline (decode2Fields "Rare1" "Rare2")
        |> CsvD.pipeline (decode2Fields "Rare3 (Lv28+)" "Rare4 (Lv28+)")
        |> CsvD.pipeline (decode2Fields "Rare5 (Lv60+)" "Rare6 (Lv60+)")


decodeCommaSeparatedStrings : CsvD.Decoder (List String)
decodeCommaSeparatedStrings =
    CsvD.map
        (\value ->
            value
                |> String.split ","
                |> List.map String.trim
        )
        CsvD.string


decode2Fields : String -> String -> CsvD.Decoder (List String)
decode2Fields fieldName1 fieldName2 =
    CsvD.map2
        (\field1 field2 -> [ field1, field2 ])
        (CsvD.field fieldName1 CsvD.string)
        (CsvD.field fieldName2 CsvD.string)


raw =
    """
Name\tRepel\tDrain\tVoid\tHalf\tWeak\tStatus Resistances\tStatus Infliction\tLocations\tRare1\tRare2\tRare3 (Lv28+)\tRare4 (Lv28+)\tRare5 (Lv60+)\tRare6 (Lv60+)\tCommon1\tCommon2\tCommon3 (Lv 45+)\tW/A Seed
Armor Knight\t\t\t\tleaf, moon\tair, counter\tMoogle, Chibikko, Sleep, Petrify\t\t\tMolebear's Claw\tItem seed\tAngel's Grail\tDemon's Claw\tBulette's Scale\tHand Axe\tDreamsee Herb\tRound Drop\tPakkun Chocolate\t0
Assassin Bug\t\t\t\t\tphysical, moon, earth\tMoogle, Poison\tpoison\t\tMysterious seed\tMyconid's Eye\tAssassin Bug Eye\tHoney Drink\tGrell Oil\tMatango Oil\tPuipui Grass\tRound Drop\tItem seed\t0
Basilisk\t\tearth\t\tfire\twater\tMoogle, Petrify, Poison, Chibikko\tpetrified\tRuins of Light\tEarth Coin\tMolebear's Claw\t??? seed\t??? seed\tHoney Drink\tBasilisk's Fang\tPuipui Grass\tMysterious seed\tMagic Walnut\t0
Battum\t\t\tdark\t\tholy\tMoogle\t\t\tBird's Scale\tMatango Oil\tBattum's Eye\tNeedlion's Eye\tAssassin Bug Eye\tSpecter's Eye\tDreamsee Herb\tStar Dust Herb\tRound Drop\t0
Beast Master\tearth\tearth\t\t\tair\tMoogle, Petrify, Silence\t\tMoonreading Tower\tBulette's Scale\tMolebear's Claw\t??? seed\tSlime's Eye\tBattum's Eye\tNeedlion's Eye\tItem seed\tPuipui Grass\tMagic seed\t0
Black Fang\t\t\tdark\tmoon, physical\tholy\tMoogle, Chibikko, Silence\t\tMoonlight Forest\tDarkness Coin\tDrake's Scale\t??? seed\tShade Statue\tAngel's Grail\tWolf Devil Oil\tRound Drop\tItem seed\tPakkun Chocolate\t0
Bloody Wolf\t\t\tmoon, physical\t\tleaf\tMoogle, Chibikko, Silence\t\tMoonreading Tower\tMoon Coin\tDemon's Claw\tShade Statue\tWolf Devil Oil\tW/A Seed\tGhost's Eye\tRound Drop\tFly Item seed\tPakkun Chocolate\t1
Boulder\t\t\tmoon, physical\t\tearth\tMoogle, Chibikko, Sleep\tsilence\tMoonlight Forest\tMama Poto Oil \tSpecter's Eye\t??? seed\t??? seed\tPakkun Oil\tPoto Oil\tPuipui Grass\tMagical Rope\tPakkun Chocolate\t0
Bound Wolf\t\t\t\t\tphysical, leaf\tMoogle, Chibikko, Snowman\t\tMoonlight Forest\tItem seed\tKerberos' Claw\tPorobin Oil\tMagic seed\tMoon Coin\tBattum's Eye\tRound Drop\tPuipui Grass\tPakkun Chocolate\t0
Bulette\t\t\tearth\tmoon, physical\tair\tMoogle, Petrify, Snowman\t\tMoonlight Forest\tBulette's Scale\tMolebear's Claw\tGnome Statue\t??? seed\tAngel's Grail\tDrake's Scale\tPuipui Grass\tDreamsee Herb\tPakkun Chocolate\t0
Carmilla\t\tdark\tmoon, physical\t\tfire\tMoogle, Poison, Sleep\tpoison\tMoonlight Forest\tBird's Scale\tLuna Statue\tCarmilla's Claw\tSpecter's Eye\tHoney Drink\tWolf Devil Oil\tPuipui Grass\tStar Dust Herb\tMysterious seed\t0
Carmilla Queen\t\tdark\tmoon, physical\t\tfire\tMoogle, Poison, Sleep\tpoison\tMoonreading Tower\tSpecter's Eye\tCarmilla's Claw\t??? seed\t??? seed\tHoney Drink\tShadow Zero's Eye\tMagical Rope\tPuipui Grass\tMagic seed\t0
Chibi-Devil\t\tdark\t\tphysical, moon\tholy\tMoogle, Chibikko, Sleep, Snowman\t\t\tDarkness Coin\tBird's Scale\tChibi Devil's Eye\t??? seed\tPorobin Oil\tCarmilla's Claw\tPuipui Grass\tItem seed\tMagic Walnut\t0
Cocka-trice\t\t\tearth\t\twater\tMoogle, Petrify\tpetrified\t\tEarth Coin\tBird's Scale\tGnome Statue\t??? seed\tNeedlion's Eye\tBasilisk's Fang\tFly Item seed\tStar Dust Herb\tMagic seed\t0
Cockabird\t\t\tair, earth\t\tholy\tMoogle, Snowman, Petrify, Sleep\tpetrified\tRuins of Light\tEarth Coin\tBird's Scale\tGnome Statue\t??? seed\tNeedlion's Eye\tBasilisk's Fang\tFly Item seed\tStar Dust Herb\tMagic seed\t0
Dark Battum\t\tdark\t\tphysical, moon, leaf\tholy\tMoogle\tchibikko\tMoonlight Forest\tMyconid's Eye\tMatango Oil\t??? seed\tBattum's Eye\tNeedlion's Eye\tChibi Devil's Eye\tDreamsee Herb\tPuipui Grass\tMagic seed\t0
Dark Lord\t\tdark\t\tphysical, moon, leaf\tholy, counter\tMoogle, Chibikko, Sleep, Petrify\t\t\tDemon's Claw\tRare\t??? seed\t??? seed\tSpecter's Eye\tDemon's Claw\tPuipui Grass\tStar Dust Herb\tMagic Walnut\t0
Dark Priest\t\t\tholy\t\tdark\tMoogle, Snowman\t\tMoonlight Forest\tPakkun Chocolate\tDarkness Coin\tAngel's Grail\tLight Coin\tMoon Coin\tPoto Oil\tItem seed\tStar Dust Herb\tPakkun Chocolate\t0
Darth Matango\t\t\t\tleaf\tmoon, fire\tMoogle, Sleep, Poison\tsilence\t\tMyconid's Eye\tMatango Oil\t??? seed\tMagic seed\tW/A Seed\tGrell Oil\tStar Dust Herb\tDreamsee Herb\tMysterious seed\t1
Death Machine\twater, fire\twater, fire\t\tearth\tair\tall\tsilence\t\tSahagin's Scale\tDrake's Scale\tSalamando Statue\tUndine Statue\tW/A Seed\tW/A Seed\tDreamsee Herb\tFly Item seed\tShuriken\t2
Dragon Zombie\t\tdark\t\tall except holy and dark\t\tMoogle, Chibikko, Poison, Snowman, Silence\tpoison\t\tFlame Coin\tBattum's Eye\tSalamando Statue\tAngel's Grail\tW/A Seed\tFire Lizard Fang\tPuipui Grass\tDreamsee Herb\tStar Dust Herb\t1
Duck General\t\t\t\twater, holy\tfire, physical, leaf\tMoogle, Silence\t\t\tFly Item seed\tMagic Walnut\tPumpkin Bomb\t??? seed\tSalamando Statue\tHoney Drink\tItem seed\tDreamsee Herb\tStar Dust Herb\t0
Duck Soldier\t\t\t\twater, holy\tfire, physical, leaf\tMoogle, Silence\t\t\tMysterious seed\tFlame Coin\tPumpkin Bomb\tBattum's Eye\tMama Poto Oil \tPakkun Chocolate\tRound Drop\tItem seed\tMagical Rope\t0
Element Sword\t\t\t\tearth, air, fire, water\tcounter\tMoogle, Chibikko, Poison\t\t\tPapa Poto's Claw\tDemon's Claw\tCarmilla's Claw\tCrawler's Claw\tW/A Seed\tW/A Seed\tStar Dust Herb\tDart\tDreamsee Herb\t2
Evil Shaman\t\tholy, dark\t\t\tearth, air, fire, water\tMoogle, Snowman\tchibikko\t\tMagic seed\tMyconid's Eye\tSpecter's Eye\t??? seed\tPoto Oil\tAngel's Grail\tStar Dust Herb\tRound Drop\tPakkun Chocolate\t0
Evil Sword\t\t\tair\t\tearth, counter\tMoogle, Chibikko, Poison\t\t\tMolebear's Claw\tSiren's Claw\tPoseidon's Claw \tKerberos' Claw\tBird's Scale\tNeedlion's Eye\tPuipui Grass\tMysterious seed\tStorm Coin\t0
Firedrake\t\tfire\t\t\twater\tMoogle, Sleep, Poison, Chibikko\tmoogled\t\tDrake's Scale\tFlame Coin\t??? seed\tSalamando Statue\tFire Lizard Fang\tAngel's Grail\tRound Drop\tItem seed\tMagic Walnut\t0
Frost Dragon\t\twater\t\tearth, air\tphysical, moon, fire\tMoogle, Chibikko, Poison, Snowman, Petrify\tsnowman\t\tPoseidon's Claw \tIce Coin\tUndine Statue\tSahagin's Scale\tW/A Seed\tWhite Dragon Fang\tFly Item seed\tPuipui Grass\tMagic seed\t1
Gal Bee\t\t\t\tearth\tfire\tMoogle, Poison, Chibikko\tpoison\t\tMysterious seed\tMama Poto Oil \tBee's Eye \tMagic seed\tSahagin's Scale\tAssassin Bug Eye\tItem seed\tPuipui Grass\tFly Item seed\t0
Ghost\t\tdark\t\tphysical, moon, leaf\tholy\tMoogle, Chibikko, Petrify, Poison, Snowman\tchibikko\t\tDarkness Coin\tIce Coin\t??? seed\t??? seed\tGhost's Eye\tShadow Zero's Eye\tFly Item seed\tPuipui Grass\tMagic Walnut\t0
Ghoul\t\tdark\t\tphysical, moon, leaf\tholy\tMoogle, Poison\tpoison\t\tMama Poto Oil \tMyconid's Eye\t??? seed\tCarmilla's Claw\tDryad Statue\tDryad Statue\tRound Drop\tItem seed\tFly Item seed\t0
Giga Crawler\tleaf\t\tphysical\t\tfire\tMoogle, Sleep, Poison\tpoison\t\tCrawler's Claw\tShuriken\t??? seed\tAssassin Bug Eye\tW/A Seed\tAngel's Grail\tPuipui Grass\tDart\tHand Axe\t1
Goblin\t\t\t\tearth\tair\tMoogle, Petrify, Silence\t\t\tHand Axe\tMama Poto Oil \tFly Item seed\tEarth Coin\tGnome Statue\tPakkun Chocolate\tRound Drop\tItem seed\tHand Axe\t0
Goblin Lord\t\t\tearth\t\tair\tMoogle, Petrify, Silence\t\t\tMatango Oil\tEarth Coin\tBattum's Eye\tNeedlion's Eye\tMoon Coin\tW/A Seed\tDreamsee Herb\tMagical Rope\tMysterious seed\t1
Gold Bulette\tearth\t\t\tmoon, physical\tair\tMoogle, Petrify, Snowman\t\t\tPoto Oil\tBulette's Scale\tAngel's Grail\tHoney Drink\tShadow Zero's Eye\tGhost's Eye\tMysterious seed\tStar Dust Herb\tPakkun Chocolate\t0
Gold Unicorn\t\t\tair\tphysical, moon, leaf\tearth\tMoogle, Chibikko, Sleep\t\t\tStorm Coin\tDrake's Scale\tNeedlion's Eye\tJinn Statue\tW/A Seed\tW/A Seed\tRound Drop\tItem seed\tMagic seed\t2
Great Demon\tearth\tfire, dark\t\t\tholy\tMoogle, Chibikko, Petrify, Snowman, Silence\tchibikko\t\tShuriken\tMoon Coin\tDryad Statue\tLuna Statue\tW/A Seed\tW/A Seed\tMagical Rope\tRound Drop\tMagic Walnut\t2
Great Rabite\t\tearth\t\t\tair\tMoogle, Silence\t\t\tMolebear's Claw\tSiren's Claw\tGnome Statue\tHoney Drink\tW/A Seed\tW/A Seed\tStar Dust Herb\tFly Item seed\tMagic seed\t2
Grell\t\t\t\tholy\tdark\tMoogle, Chibikko, Sleep\tchibikko\t\tIce Coin\tPoseidon's Claw \tGrell Oil\tSlime's Eye\tUndine Statue\tPakkun Oil\tItem seed\tPuipui Grass\tMagic Walnut\t0
Grell Mage\t\tholy\t\tearth, air, fire, water\tdark\tMoogle, Chibikko, Sleep\tmoogled\tRuins of Light\tLight Coin\tStorm Coin\t??? seed\tGrell Oil\tJinn Statue\tWisp Statue\tFly Item seed\tItem seed\tMagic Walnut\t0
Gremlin\tdark, fire, water, air, earth\tdark, fire, water, air, earth\tphysical, moon, leaf\t\tholy\tMoogle, Chibikko, Sleep, Snowman\tmoogled\t\tDarkness Coin\tNeedlion's Eye\t??? seed\t??? seed\tSpecter's Eye\tWolf Devil Oil\tFly Item seed\tPuipui Grass\tMagic Walnut\t0
Guardian\t\tfire\t\t\twater\tall\t\t\tBulette's Scale\tStorm Coin\t??? seed\t??? seed\tBee's Eye \tSlime's Eye\tFly Item seed\tDart\tHand Axe\t0
Harpy\t\t\t\tair\tearth\tMoogle\tsilence\t\tStorm Coin\tBird's Scale\tJinn Statue\tSiren's Claw\tHarpy's Fang\tBee's Eye \tRound Drop\tStar Dust Herb\tItem seed\t0
High Wizard\t\t\t\t\twater\tMoogle, Chibikko, Petrify, Sleep\tmoogled\t\tMagic seed\tSahagin's Scale\t??? seed\t??? seed\tW/A Seed\tShade Statue\tDreamsee Herb\tRound Drop\tMagic Walnut\t1
Kaiser Mimic\t\t\t\t\tearth\tall\t\t\tSahagin's Scale\tDrake's Scale\tSlime's Eye\tBattum's Eye\tHoney Drink\tAngel's Grail\tRound Drop\tRound Drop\tRound Drop\t0
Kerberos\t\tfire\t\t\twater, leaf, physical\tMoogle, Chibikko, Snowman\t\tMoonlight Forest\tKerberos' Claw\tFlame Coin\tDrake's Scale\tBee's Eye \tW/A Seed\tW/A Seed\tItem seed\tDreamsee Herb\tPakkun Chocolate\t2
King Rabite\t\t\tearth\t\tair\tMoogle, Silence\tsilence\t\tLight Coin\tMama Poto Oil \t??? seed\tPoto Oil\tW/A Seed\tW/A Seed\tRound Drop\tMysterious seed\tPakkun Chocolate\t2
Lady Bee\t\t\tearth\t\tfire\tMoogle, Poison, Chibikko\tpoison\tRuins of Light\tDrake's Scale\tBird's Scale\tAssassin Bug Eye\tBee's Eye \tHoney Drink\tBulette's Scale\tPuipui Grass\tMysterious seed\tPakkun Chocolate\t0
Lesser Demon\t\t\tfire, dark\t\twater, holy\tMoogle, Chibikko, Petrify, Snowman\tchibikko\tMoonreading Tower\tShade Statue\tSalamando Statue\t??? seed\t??? seed\tW/A Seed\tW/A Seed\tPuipui Grass\tMagical Rope\tPakkun Chocolate\t2
Machine Golem\t\t\t\tearth\tair, water\tall\t\t\tShuriken\tEarth Coin\tGnome Statue\tNeedlion's Eye\tPumpkin Bomb\tBattum's Eye\tRound Drop\tStar Dust Herb\tHand Axe\t0
Magician\t\t\t\t\twater\tMoogle, Chibikko, Petrify, Sleep\t\tRuins of Light\tFlame Coin\tIce Coin\tEarth Coin\tStorm Coin\tLight Coin\tDarkness Coin\tMagical Rope\tItem seed\tMysterious seed\t0
Mama Poto\t\tholy\t\t\tdark\tMoogle, Silence\t\tRuins of Light\tMama Poto Oil \tLight Coin\t??? seed\tWisp Statue\tPoto Oil\tSahagin's Scale\tPuipui Grass\tRound Drop\tPakkun Chocolate\t0
Mega Crawler\t\t\t\tphysical, leaf\tfire\tMoogle, Sleep, Poison\tpoison\t\tMyconid's Eye\tMatango Oil\t??? seed\tCrawler's Claw\tBulette's Scale\tHoney Drink\tRound Drop\tItem seed\tPakkun Chocolate\t0
Molebear\t\t\tearth\t\tair\tMoogle, Petrify, Sleep, Chibikko\t\t\tEarth Coin\tMolebear's Claw\tCarmilla's Claw\tSlime's Eye\tNeedlion's Eye\tKerberos' Claw\tRound Drop\tItem seed\tPakkun Chocolate\t0
Myconid\t\t\t\tleaf\tmoon, fire\tMoogle, Sleep, Poison\t\t\tMyconid's Eye\tItem seed\tMagic Walnut\tFly Item seed\tDryad Statue\tCrawler's Claw\tPuipui Grass\tRound Drop\tPakkun Chocolate\t0
Necromancer\t\t\tdark\t\tholy\tMoogle, Snowman\t\t\tMama Poto Oil \tFly Item seed\t??? seed\tPoto Oil\tW/A Seed\tShadow Zero's Eye\tRound Drop\tMysterious seed\tPakkun Chocolate\t1
Needle-bird\t\t\t\tair\tearth\tMoogle, Snowman, Sleep\t\t\tBird's Scale\tStorm Coin\tBee's Eye \tJinn Statue\tPakkun Oil\tHarpy's Fang\tRound Drop\tDreamsee Herb\tFly Item seed\t0
Needlion\tearth\tearth\t\t\tair\tMoogle, Petrify, Sleep, Chibikko\t\tRuins of Light\tMolebear's Claw\tDemon's Claw\tNeedlion's Eye\tGnome Statue\tBasilisk's Fang\tW/A Seed\tDreamsee Herb\tStar Dust Herb\tFly Item seed\t1
Night Blade\t\t\t\t\tdark\tMoogle, Poison, Snowman\tpoison\t\tFly Item seed\tNeedlion's Eye\tMoon Coin\tBattum's Eye\tW/A Seed\tW/A Seed\tDart\tDreamsee Herb\tShuriken\t2
Ninja\t\t\t\t\tdark\tMoogle, Poison, Snowman\tpoison\t\tShuriken\tShuriken\tPakkun Chocolate\tBee's Eye \tMolebear's Claw\tMagic seed\tRound Drop\tDart\tHand Axe\t0
Ninja Master\t\t\t\t\tdark\tMoogle, Poison, Snowman\tpoison\t\tShuriken\tFly Item seed\tBird's Scale\t??? seed\tW/A Seed\tPumpkin Bomb\tStar Dust Herb\tPuipui Grass\tShuriken\t1
Ogre Box\t\t\t\t\tearth\tall\t\t\tBulette's Scale\tBird's Scale\tNeedlion's Eye\tBee's Eye \tAngel's Grail\tW/A Seed\tRound Drop\tRound Drop\tRound Drop\t1
Pakkun Baby\t\t\twater\tfire\tholy\tMoogle, Snowman\t\tRuins of Light\tHand Axe\tIce Coin\t??? seed\tUndine Statue\tUndine Statue\tBee's Eye \tRound Drop\tMysterious seed\tPakkun Chocolate\t0
Pakkun Dragon\t\twater, holy\t\tfire\tdark\tMoogle, Snowman, Sleep\t\tRuins of Light\tSahagin's Scale\tPoseidon's Claw \tPumpkin Bomb\tUndine Statue\tWhite Dragon Fang\tSlime's Eye\tMysterious seed\tStar Dust Herb\tPakkun Chocolate\t0
Pakkun Lizard\t\t\twater\tfire\tdark\tMoogle, Snowman, Sleep\t\t\tHand Axe\tIce Coin\t??? seed\tUndine Statue\tUndine Statue\tBee's Eye \tRound Drop\tMysterious seed\tPakkun Chocolate\t0
Pakkuri Baby\t\twater\t\tfire\tdark\tMoogle, Snowman\t\t\tSahagin's Scale\tPoseidon's Claw \tPumpkin Bomb\tUndine Statue\tWhite Dragon Fang\tSlime's Eye\tMysterious seed\tStar Dust Herb\tPakkun Chocolate\t0
Papa Poto\tholy\tholy\t\t\tdark\tMoogle, Silence\t\t\tPoto Oil\tWisp Statue\t??? seed\t??? seed\tPapa Poto's Claw\tW/A Seed\tPuipui Grass\tItem seed\tMagic Walnut\t1
Petit Dragon\t\t\t\tearth, air, fire, water\tphysical, moon\tMoogle, Chibikko, Poison, Snowman, Petrify\t\t\tEarth Coin\tNeedlion's Eye\tAssassin Bug Eye\tMolebear's Claw\tGnome Statue\tBasilisk's Fang\tRound Drop\tPuipui Grass\tMagic seed\t0
Petit Poseidon\t\t\t\twater\tearth\tMoogle, Snowman\t\t\tSahagin's Scale\tPoseidon's Claw \t??? seed\tUndine Statue\tAngel's Grail\tWhite Dragon Fang\tRound Drop\tItem seed\tPakkun Chocolate\t0
Petit Tiamat\t\tair\t\twater, fire\tphysical, moon, earth\tMoogle, Chibikko, Poison, Snowman, Silence\tsilence\t\tStorm Coin\tBee's Eye \t??? seed\tJinn Statue\tW/A Seed\tHarpy's Fang\tStar Dust Herb\tMysterious seed\tFly Item seed\t1
Porobin Hood\t\t\tearth\t\twater\tMoogle, Sleep, Snowman\t\t\tMyconid's Eye\tMysterious seed\tAssassin Bug Eye\tPakkun Chocolate\tCarmilla's Claw\tW/A Seed\tDart\tPuipui Grass\tDreamsee Herb\t1
Porobin Leader\t\t\tearth\t\twater\tMoogle, Sleep, Snowman\t\tMoonreading Tower\tFly Item seed\tMyconid's Eye\t??? seed\tPorobin Oil\tPumpkin Bomb\tCrawler's Claw\tItem seed\tRound Drop\tPakkun Chocolate\t0
Poron\t\t\t\tearth\twater\tMoogle, Sleep, Snowman\t\t\tItem seed\tDreamsee Herb\tMyconid's Eye\tPorobin Oil\tHoney Drink\tChibi Devil's Eye\tDart\tRound Drop\tPakkun Chocolate\t0
Poto\t\t\tholy\t\tdark\tMoogle, Silence\t\tRuins of Light\tLight Coin\tIce Coin\tPoto Oil\tWisp Statue\tAngel's Grail\tPakkun Oil\tRound Drop\tStar Dust Herb\tMysterious seed\t0
Power Boulder\tall\t\tmagic\tphysical\t\tMoogle, Chibikko, Sleep\tsilence\t\tSpecter's Eye\tPumpkin Bomb\t??? seed\t??? seed\tAngel's Grail\tGhost's Eye\tItem seed\tStar Dust Herb\tMagic Walnut\t0
Queen Bee\t\tearth\t\t\tfire\tMoogle, Poison, Chibikko\tpoison\tMoonreading Tower\tBulette's Scale\tDrake's Scale\t??? seed\tBee's Eye \tHoney Drink\tW/A Seed\tItem seed\tRound Drop\tPakkun Chocolate\t1
Rabilion\t\t\t\tearth\tair\tMoogle, Silence\t\t\tMysterious seed\tBird's Scale\tSlime's Eye\tLuna Statue\tAngel's Grail\tPorobin Oil\tRound Drop\tItem seed\tStar Dust Herb\t0
Rabite\t\t\t\tearth\tair\tMoogle, Silence\t\t\tEarth Coin\tMatango Oil\tPakkun Oil\tBattum's Eye\tW/A Seed\tHoney Drink\tRound Drop\tItem seed\tPakkun Chocolate\t1
Ruster Bug\t\t\t\tair\tphysical, moon, earth\tMoogle, Poison\tpoison\tMoonlight Forest\tMyconid's Eye\tAssassin Bug Eye\t??? seed\t??? seed\tHoney Drink\tDryad Statue\tStar Dust Herb\tPuipui Grass\tPakkun Chocolate\t0
Sahagin\t\t\t\twater\tearth\tMoogle, Snowman\t\t\tSahagin's Scale\tIce Coin\tUndine Statue\tSlime's Eye\tBird's Scale\tLuna Statue\tItem seed\tPuipui Grass\tPumpkin Bomb\t0
Sea Dragon\t\twater\t\t\tfire\tMoogle, Chibikko, Snowman\t\t\tIce Coin\tPoseidon's Claw \tSlime's Eye\tUndine Statue\tNeedlion's Eye\tPoto Oil\tRound Drop\tMysterious seed\tPakkun Chocolate\t0
Sea Serpent\t\t\twater\t\tfire\tMoogle, Chibikko, Snowman\t\t\tIce Coin\tPakkun Chocolate\tUndine Statue\t??? seed\tHand Axe\tPumpkin Bomb\tItem seed\tFly Item seed\tMagic seed\t0
Shadow-zero\t\t\t\t\t\tall\t\t\tMagic seed\tMagic seed\t??? seed\t??? seed\tW/A Seed\tW/A Seed\tItem seed\tMysterious seed\tFly Item seed\t2
Shape-shifter\t\t\t\t\t\tall\t\t\tMagic seed\tMagic seed\t??? seed\t??? seed\tW/A Seed\tW/A Seed\tItem seed\tMysterious seed\tFly Item seed\t2
Shell Hunter\t\t\t\t\t\tMoogle, Chibikko\t\t\tMysterious seed\tMagical Rope\tChibi Devil's Eye\tLuna Statue\tDrake's Scale\tMama Poto Oil \tItem seed\tDreamsee Herb\tRound Drop\t0
Silver Knight\t\t\t\tphysical, leaf, moon, holy\tdark, counter\tMoogle, Chibikko, Sleep, Petrify\t\tRuins of Light\tMama Poto Oil \tMysterious seed\t??? seed\tPapa Poto's Claw\tAngel's Grail\tPoto Oil\tItem seed\tPuipui Grass\tFly Item seed\t0
Silver Wolf\t\t\tholy\tmoon, physical\tdark\tMoogle, Chibikko, Silence\t\tMoonreading Tower\tFly Item seed\tCarmilla's Claw\tPapa Poto's Claw\tPoto Oil\tAngel's Grail\tShadow Zero's Eye\tItem seed\tPuipui Grass\tPakkun Chocolate\t0
Siren\t\tair\t\t\tearth, dark\tMoogle\tsilence\tRuins of Light\tSiren's Claw\tStorm Coin\tJinn Statue\t??? seed\tHarpy's Fang\tWisp Statue\tDreamsee Herb\tItem seed\tMagic Walnut\t0
Slime\t\twater\t\tphysical, moon, leaf\tfire\tMoogle, Chibikko, Snowman, Petrify, Poison\tpoison\t\tBird's Scale\tEarth Coin\t??? seed\tNeedlion's Eye\tBee's Eye \tHoney Drink\tPuipui Grass\tDreamsee Herb\tMysterious seed\t0
Slime Prince\t\twater\tphysical, moon, leaf\t\tfire\tMoogle, Chibikko, Snowman, Petrify, Poison\tpoison\tRuins of Light\tBulette's Scale\tMyconid's Eye\tSlime's Eye\t??? seed\tHoney Drink\tAngel's Grail\tDreamsee Herb\tPuipui Grass\tPakkun Chocolate\t0
Specter\t\tdark\t\tphysical, moon, leaf\tholy\tMoogle, Chibikko, Petrify, Poison, Snowman\tmoogled\tMoonlight Forest\tMoon Coin\tDarkness Coin\tSpecter's Eye\t??? seed\tShade Statue\tGrell Oil\tPuipui Grass\tItem seed\tMagic seed\t0
Sword Master\t\t\t\tall except holy and dark\tcounter\tMoogle, Chibikko, Sleep, Petrify\t\tMoonreading Tower\tMolebear's Claw\tSiren's Claw\t??? seed\tPoseidon's Claw \tW/A Seed\tKerberos' Claw\tStar Dust Herb\tDreamsee Herb\tMagic Walnut\t1
Unicorn Head\t\t\t\tair\tearth\tMoogle, Chibikko, Sleep\t\t\tStorm Coin\tSiren's Claw\tJinn Statue\tBee's Eye \tAngel's Grail\tBird's Scale\tDart\tPuipui Grass\tMysterious seed\t0
Werewolf\t\t\t\tmoon\tleaf\tMoogle, Chibikko, Silence\t\tMoonlight Forest\tMoon Coin\tBird's Scale\tChibi Devil's Eye\tPorobin Oil\tWolf Devil Oil\tCarmilla's Claw\tMysterious seed\tStar Dust Herb\tFly Item seed\t0
Wizard\t\t\t\t\twater\tMoogle, Chibikko, Petrify, Sleep\t\t\tLight Coin\tDarkness Coin\tSalamando Statue\tUndine Statue\tJinn Statue\tGnome Statue\tMysterious seed\tPuipui Grass\tMagic Walnut\t0
Wolf Devil\t\tmoon, dark\tphysical\t\tholy\tMoogle, Chibikko, Silence\t\t\tDemon's Claw\tMoon Coin\tWolf Devil Oil\tChibi Devil's Eye\tW/A Seed\tW/A Seed\tItem seed\tRound Drop\tPakkun Chocolate\t2
Zombie\t\t\tdark\t\tholy\tMoogle, Poison\tpoison\t\tMyconid's Eye\tFlame Coin\tCarmilla's Claw\tDemon's Claw\tBird's Scale\tNeedlion's Eye\tPuipui Grass\tMagical Rope\tDreamsee Herb\t0
"""
