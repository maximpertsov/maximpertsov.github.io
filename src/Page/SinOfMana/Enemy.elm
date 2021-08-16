module Page.SinOfMana.Enemy exposing (Enemy, raw)

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
    , rareItem : List String
    , rareItem28 : List String
    , rareItem60 : List String
    }


raw =
    """
Name^IRepel^IDrain^IVoid^IHalf^IWeak^IStatus Resistances^IStatus Infliction^ILocations^IRare1^IRare2^IRare3 (Lv28+)^IRare4 (Lv28+)^IRare5 (Lv60+)^IRare6 (Lv60+)^ICommon1^ICommon2^ICommon3 (Lv 45+)^IW/A Seed^M
Armor Knight^I^I^I^Ileaf, moon^Iair, counter^IMoogle, Chibikko, Sleep, Petrify^I^I^IMolebear's Claw^IItem seed^IAngel's Grail^IDemon's Claw^IBulette's Scale^IHand Axe^IDreamsee Herb^IRound Drop^IPakkun Chocolate^I0^M
Assassin Bug^I^I^I^I^Iphysical, moon, earth^IMoogle, Poison^Ipoison^I^IMysterious seed^IMyconid's Eye^IAssassin Bug Eye^IHoney Drink^IGrell Oil^IMatango Oil^IPuipui Grass^IRound Drop^IItem seed^I0^M
Basilisk^I^Iearth^I^Ifire^Iwater^IMoogle, Petrify, Poison, Chibikko^Ipetrified^IRuins of Light^IEarth Coin^IMolebear's Claw^I??? seed^I??? seed^IHoney Drink^IBasilisk's Fang^IPuipui Grass^IMysterious seed^IMagic Walnut^I0^M
Battum^I^I^Idark^I^Iholy^IMoogle^I^I^IBird's Scale^IMatango Oil^IBattum's Eye^INeedlion's Eye^IAssassin Bug Eye^ISpecter's Eye^IDreamsee Herb^IStar Dust Herb^IRound Drop^I0^M
Beast Master^Iearth^Iearth^I^I^Iair^IMoogle, Petrify, Silence^I^IMoonreading Tower^IBulette's Scale^IMolebear's Claw^I??? seed^ISlime's Eye^IBattum's Eye^INeedlion's Eye^IItem seed^IPuipui Grass^IMagic seed^I0^M
Black Fang^I^I^Idark^Imoon, physical^Iholy^IMoogle, Chibikko, Silence^I^IMoonlight Forest^IDarkness Coin^IDrake's Scale^I??? seed^IShade Statue^IAngel's Grail^IWolf Devil Oil^IRound Drop^IItem seed^IPakkun Chocolate^I0^M
Bloody Wolf^I^I^Imoon, physical^I^Ileaf^IMoogle, Chibikko, Silence^I^IMoonreading Tower^IMoon Coin^IDemon's Claw^IShade Statue^IWolf Devil Oil^IW/A Seed^IGhost's Eye^IRound Drop^IFly Item seed^IPakkun Chocolate^I1^M
Boulder^I^I^Imoon, physical^I^Iearth^IMoogle, Chibikko, Sleep^Isilence^IMoonlight Forest^IMama Poto Oil ^ISpecter's Eye^I??? seed^I??? seed^IPakkun Oil^IPoto Oil^IPuipui Grass^IMagical Rope^IPakkun Chocolate^I0^M
Bound Wolf^I^I^I^I^Iphysical, leaf^IMoogle, Chibikko, Snowman^I^IMoonlight Forest^IItem seed^IKerberos' Claw^IPorobin Oil^IMagic seed^IMoon Coin^IBattum's Eye^IRound Drop^IPuipui Grass^IPakkun Chocolate^I0^M
Bulette^I^I^Iearth^Imoon, physical^Iair^IMoogle, Petrify, Snowman^I^IMoonlight Forest^IBulette's Scale^IMolebear's Claw^IGnome Statue^I??? seed^IAngel's Grail^IDrake's Scale^IPuipui Grass^IDreamsee Herb^IPakkun Chocolate^I0^M
Carmilla^I^Idark^Imoon, physical^I^Ifire^IMoogle, Poison, Sleep^Ipoison^IMoonlight Forest^IBird's Scale^ILuna Statue^ICarmilla's Claw^ISpecter's Eye^IHoney Drink^IWolf Devil Oil^IPuipui Grass^IStar Dust Herb^IMysterious seed^I0^M
Carmilla Queen^I^Idark^Imoon, physical^I^Ifire^IMoogle, Poison, Sleep^Ipoison^IMoonreading Tower^ISpecter's Eye^ICarmilla's Claw^I??? seed^I??? seed^IHoney Drink^IShadow Zero's Eye^IMagical Rope^IPuipui Grass^IMagic seed^I0^M
Chibi-Devil^I^Idark^I^Iphysical, moon^Iholy^IMoogle, Chibikko, Sleep, Snowman^I^I^IDarkness Coin^IBird's Scale^IChibi Devil's Eye^I??? seed^IPorobin Oil^ICarmilla's Claw^IPuipui Grass^IItem seed^IMagic Walnut^I0^M
Cocka-trice^I^I^Iearth^I^Iwater^IMoogle, Petrify^Ipetrified^I^IEarth Coin^IBird's Scale^IGnome Statue^I??? seed^INeedlion's Eye^IBasilisk's Fang^IFly Item seed^IStar Dust Herb^IMagic seed^I0^M
Cockabird^I^I^Iair, earth^I^Iholy^IMoogle, Snowman, Petrify, Sleep^Ipetrified^IRuins of Light^IEarth Coin^IBird's Scale^IGnome Statue^I??? seed^INeedlion's Eye^IBasilisk's Fang^IFly Item seed^IStar Dust Herb^IMagic seed^I0^M
Dark Battum^I^Idark^I^Iphysical, moon, leaf^Iholy^IMoogle^Ichibikko^IMoonlight Forest^IMyconid's Eye^IMatango Oil^I??? seed^IBattum's Eye^INeedlion's Eye^IChibi Devil's Eye^IDreamsee Herb^IPuipui Grass^IMagic seed^I0^M
Dark Lord^I^Idark^I^Iphysical, moon, leaf^Iholy, counter^IMoogle, Chibikko, Sleep, Petrify^I^I^IDemon's Claw^IRare^I??? seed^I??? seed^ISpecter's Eye^IDemon's Claw^IPuipui Grass^IStar Dust Herb^IMagic Walnut^I0^M
Dark Priest^I^I^Iholy^I^Idark^IMoogle, Snowman^I^IMoonlight Forest^IPakkun Chocolate^IDarkness Coin^IAngel's Grail^ILight Coin^IMoon Coin^IPoto Oil^IItem seed^IStar Dust Herb^IPakkun Chocolate^I0^M
Darth Matango^I^I^I^Ileaf^Imoon, fire^IMoogle, Sleep, Poison^Isilence^I^IMyconid's Eye^IMatango Oil^I??? seed^IMagic seed^IW/A Seed^IGrell Oil^IStar Dust Herb^IDreamsee Herb^IMysterious seed^I1^M
Death Machine^Iwater, fire^Iwater, fire^I^Iearth^Iair^Iall^Isilence^I^ISahagin's Scale^IDrake's Scale^ISalamando Statue^IUndine Statue^IW/A Seed^IW/A Seed^IDreamsee Herb^IFly Item seed^IShuriken^I2^M
Dragon Zombie^I^Idark^I^Iall except holy and dark^I^IMoogle, Chibikko, Poison, Snowman, Silence^Ipoison^I^IFlame Coin^IBattum's Eye^ISalamando Statue^IAngel's Grail^IW/A Seed^IFire Lizard Fang^IPuipui Grass^IDreamsee Herb^IStar Dust Herb^I1^M
Duck General^I^I^I^Iwater, holy^Ifire, physical, leaf^IMoogle, Silence^I^I^IFly Item seed^IMagic Walnut^IPumpkin Bomb^I??? seed^ISalamando Statue^IHoney Drink^IItem seed^IDreamsee Herb^IStar Dust Herb^I0^M
Duck Soldier^I^I^I^Iwater, holy^Ifire, physical, leaf^IMoogle, Silence^I^I^IMysterious seed^IFlame Coin^IPumpkin Bomb^IBattum's Eye^IMama Poto Oil ^IPakkun Chocolate^IRound Drop^IItem seed^IMagical Rope^I0^M
Element Sword^I^I^I^Iearth, air, fire, water^Icounter^IMoogle, Chibikko, Poison^I^I^IPapa Poto's Claw^IDemon's Claw^ICarmilla's Claw^ICrawler's Claw^IW/A Seed^IW/A Seed^IStar Dust Herb^IDart^IDreamsee Herb^I2^M
Evil Shaman^I^Iholy, dark^I^I^Iearth, air, fire, water^IMoogle, Snowman^Ichibikko^I^IMagic seed^IMyconid's Eye^ISpecter's Eye^I??? seed^IPoto Oil^IAngel's Grail^IStar Dust Herb^IRound Drop^IPakkun Chocolate^I0^M
Evil Sword^I^I^Iair^I^Iearth, counter^IMoogle, Chibikko, Poison^I^I^IMolebear's Claw^ISiren's Claw^IPoseidon's Claw ^IKerberos' Claw^IBird's Scale^INeedlion's Eye^IPuipui Grass^IMysterious seed^IStorm Coin^I0^M
Firedrake^I^Ifire^I^I^Iwater^IMoogle, Sleep, Poison, Chibikko^Imoogled^I^IDrake's Scale^IFlame Coin^I??? seed^ISalamando Statue^IFire Lizard Fang^IAngel's Grail^IRound Drop^IItem seed^IMagic Walnut^I0^M
Frost Dragon^I^Iwater^I^Iearth, air^Iphysical, moon, fire^IMoogle, Chibikko, Poison, Snowman, Petrify^Isnowman^I^IPoseidon's Claw ^IIce Coin^IUndine Statue^ISahagin's Scale^IW/A Seed^IWhite Dragon Fang^IFly Item seed^IPuipui Grass^IMagic seed^I1^M
Gal Bee^I^I^I^Iearth^Ifire^IMoogle, Poison, Chibikko^Ipoison^I^IMysterious seed^IMama Poto Oil ^IBee's Eye ^IMagic seed^ISahagin's Scale^IAssassin Bug Eye^IItem seed^IPuipui Grass^IFly Item seed^I0^M
Ghost^I^Idark^I^Iphysical, moon, leaf^Iholy^IMoogle, Chibikko, Petrify, Poison, Snowman^Ichibikko^I^IDarkness Coin^IIce Coin^I??? seed^I??? seed^IGhost's Eye^IShadow Zero's Eye^IFly Item seed^IPuipui Grass^IMagic Walnut^I0^M
Ghoul^I^Idark^I^Iphysical, moon, leaf^Iholy^IMoogle, Poison^Ipoison^I^IMama Poto Oil ^IMyconid's Eye^I??? seed^ICarmilla's Claw^IDryad Statue^IDryad Statue^IRound Drop^IItem seed^IFly Item seed^I0^M
Giga Crawler^Ileaf^I^Iphysical^I^Ifire^IMoogle, Sleep, Poison^Ipoison^I^ICrawler's Claw^IShuriken^I??? seed^IAssassin Bug Eye^IW/A Seed^IAngel's Grail^IPuipui Grass^IDart^IHand Axe^I1^M
Goblin^I^I^I^Iearth^Iair^IMoogle, Petrify, Silence^I^I^IHand Axe^IMama Poto Oil ^IFly Item seed^IEarth Coin^IGnome Statue^IPakkun Chocolate^IRound Drop^IItem seed^IHand Axe^I0^M
Goblin Lord^I^I^Iearth^I^Iair^IMoogle, Petrify, Silence^I^I^IMatango Oil^IEarth Coin^IBattum's Eye^INeedlion's Eye^IMoon Coin^IW/A Seed^IDreamsee Herb^IMagical Rope^IMysterious seed^I1^M
Gold Bulette^Iearth^I^I^Imoon, physical^Iair^IMoogle, Petrify, Snowman^I^I^IPoto Oil^IBulette's Scale^IAngel's Grail^IHoney Drink^IShadow Zero's Eye^IGhost's Eye^IMysterious seed^IStar Dust Herb^IPakkun Chocolate^I0^M
Gold Unicorn^I^I^Iair^Iphysical, moon, leaf^Iearth^IMoogle, Chibikko, Sleep^I^I^IStorm Coin^IDrake's Scale^INeedlion's Eye^IJinn Statue^IW/A Seed^IW/A Seed^IRound Drop^IItem seed^IMagic seed^I2^M
Great Demon^Iearth^Ifire, dark^I^I^Iholy^IMoogle, Chibikko, Petrify, Snowman, Silence^Ichibikko^I^IShuriken^IMoon Coin^IDryad Statue^ILuna Statue^IW/A Seed^IW/A Seed^IMagical Rope^IRound Drop^IMagic Walnut^I2^M
Great Rabite^I^Iearth^I^I^Iair^IMoogle, Silence^I^I^IMolebear's Claw^ISiren's Claw^IGnome Statue^IHoney Drink^IW/A Seed^IW/A Seed^IStar Dust Herb^IFly Item seed^IMagic seed^I2^M
Grell^I^I^I^Iholy^Idark^IMoogle, Chibikko, Sleep^Ichibikko^I^IIce Coin^IPoseidon's Claw ^IGrell Oil^ISlime's Eye^IUndine Statue^IPakkun Oil^IItem seed^IPuipui Grass^IMagic Walnut^I0^M
Grell Mage^I^Iholy^I^Iearth, air, fire, water^Idark^IMoogle, Chibikko, Sleep^Imoogled^IRuins of Light^ILight Coin^IStorm Coin^I??? seed^IGrell Oil^IJinn Statue^IWisp Statue^IFly Item seed^IItem seed^IMagic Walnut^I0^M
Gremlin^Idark, fire, water, air, earth^Idark, fire, water, air, earth^Iphysical, moon, leaf^I^Iholy^IMoogle, Chibikko, Sleep, Snowman^Imoogled^I^IDarkness Coin^INeedlion's Eye^I??? seed^I??? seed^ISpecter's Eye^IWolf Devil Oil^IFly Item seed^IPuipui Grass^IMagic Walnut^I0^M
Guardian^I^Ifire^I^I^Iwater^Iall^I^I^IBulette's Scale^IStorm Coin^I??? seed^I??? seed^IBee's Eye ^ISlime's Eye^IFly Item seed^IDart^IHand Axe^I0^M
Harpy^I^I^I^Iair^Iearth^IMoogle^Isilence^I^IStorm Coin^IBird's Scale^IJinn Statue^ISiren's Claw^IHarpy's Fang^IBee's Eye ^IRound Drop^IStar Dust Herb^IItem seed^I0^M
High Wizard^I^I^I^I^Iwater^IMoogle, Chibikko, Petrify, Sleep^Imoogled^I^IMagic seed^ISahagin's Scale^I??? seed^I??? seed^IW/A Seed^IShade Statue^IDreamsee Herb^IRound Drop^IMagic Walnut^I1^M
Kaiser Mimic^I^I^I^I^Iearth^Iall^I^I^ISahagin's Scale^IDrake's Scale^ISlime's Eye^IBattum's Eye^IHoney Drink^IAngel's Grail^IRound Drop^IRound Drop^IRound Drop^I0^M
Kerberos^I^Ifire^I^I^Iwater, leaf, physical^IMoogle, Chibikko, Snowman^I^IMoonlight Forest^IKerberos' Claw^IFlame Coin^IDrake's Scale^IBee's Eye ^IW/A Seed^IW/A Seed^IItem seed^IDreamsee Herb^IPakkun Chocolate^I2^M
King Rabite^I^I^Iearth^I^Iair^IMoogle, Silence^Isilence^I^ILight Coin^IMama Poto Oil ^I??? seed^IPoto Oil^IW/A Seed^IW/A Seed^IRound Drop^IMysterious seed^IPakkun Chocolate^I2^M
Lady Bee^I^I^Iearth^I^Ifire^IMoogle, Poison, Chibikko^Ipoison^IRuins of Light^IDrake's Scale^IBird's Scale^IAssassin Bug Eye^IBee's Eye ^IHoney Drink^IBulette's Scale^IPuipui Grass^IMysterious seed^IPakkun Chocolate^I0^M
Lesser Demon^I^I^Ifire, dark^I^Iwater, holy^IMoogle, Chibikko, Petrify, Snowman^Ichibikko^IMoonreading Tower^IShade Statue^ISalamando Statue^I??? seed^I??? seed^IW/A Seed^IW/A Seed^IPuipui Grass^IMagical Rope^IPakkun Chocolate^I2^M
Machine Golem^I^I^I^Iearth^Iair, water^Iall^I^I^IShuriken^IEarth Coin^IGnome Statue^INeedlion's Eye^IPumpkin Bomb^IBattum's Eye^IRound Drop^IStar Dust Herb^IHand Axe^I0^M
Magician^I^I^I^I^Iwater^IMoogle, Chibikko, Petrify, Sleep^I^IRuins of Light^IFlame Coin^IIce Coin^IEarth Coin^IStorm Coin^ILight Coin^IDarkness Coin^IMagical Rope^IItem seed^IMysterious seed^I0^M
Mama Poto^I^Iholy^I^I^Idark^IMoogle, Silence^I^IRuins of Light^IMama Poto Oil ^ILight Coin^I??? seed^IWisp Statue^IPoto Oil^ISahagin's Scale^IPuipui Grass^IRound Drop^IPakkun Chocolate^I0^M
Mega Crawler^I^I^I^Iphysical, leaf^Ifire^IMoogle, Sleep, Poison^Ipoison^I^IMyconid's Eye^IMatango Oil^I??? seed^ICrawler's Claw^IBulette's Scale^IHoney Drink^IRound Drop^IItem seed^IPakkun Chocolate^I0^M
Molebear^I^I^Iearth^I^Iair^IMoogle, Petrify, Sleep, Chibikko^I^I^IEarth Coin^IMolebear's Claw^ICarmilla's Claw^ISlime's Eye^INeedlion's Eye^IKerberos' Claw^IRound Drop^IItem seed^IPakkun Chocolate^I0^M
Myconid^I^I^I^Ileaf^Imoon, fire^IMoogle, Sleep, Poison^I^I^IMyconid's Eye^IItem seed^IMagic Walnut^IFly Item seed^IDryad Statue^ICrawler's Claw^IPuipui Grass^IRound Drop^IPakkun Chocolate^I0^M
Necromancer^I^I^Idark^I^Iholy^IMoogle, Snowman^I^I^IMama Poto Oil ^IFly Item seed^I??? seed^IPoto Oil^IW/A Seed^IShadow Zero's Eye^IRound Drop^IMysterious seed^IPakkun Chocolate^I1^M
Needle-bird^I^I^I^Iair^Iearth^IMoogle, Snowman, Sleep^I^I^IBird's Scale^IStorm Coin^IBee's Eye ^IJinn Statue^IPakkun Oil^IHarpy's Fang^IRound Drop^IDreamsee Herb^IFly Item seed^I0^M
Needlion^Iearth^Iearth^I^I^Iair^IMoogle, Petrify, Sleep, Chibikko^I^IRuins of Light^IMolebear's Claw^IDemon's Claw^INeedlion's Eye^IGnome Statue^IBasilisk's Fang^IW/A Seed^IDreamsee Herb^IStar Dust Herb^IFly Item seed^I1^M
Night Blade^I^I^I^I^Idark^IMoogle, Poison, Snowman^Ipoison^I^IFly Item seed^INeedlion's Eye^IMoon Coin^IBattum's Eye^IW/A Seed^IW/A Seed^IDart^IDreamsee Herb^IShuriken^I2^M
Ninja^I^I^I^I^Idark^IMoogle, Poison, Snowman^Ipoison^I^IShuriken^IShuriken^IPakkun Chocolate^IBee's Eye ^IMolebear's Claw^IMagic seed^IRound Drop^IDart^IHand Axe^I0^M
Ninja Master^I^I^I^I^Idark^IMoogle, Poison, Snowman^Ipoison^I^IShuriken^IFly Item seed^IBird's Scale^I??? seed^IW/A Seed^IPumpkin Bomb^IStar Dust Herb^IPuipui Grass^IShuriken^I1^M
Ogre Box^I^I^I^I^Iearth^Iall^I^I^IBulette's Scale^IBird's Scale^INeedlion's Eye^IBee's Eye ^IAngel's Grail^IW/A Seed^IRound Drop^IRound Drop^IRound Drop^I1^M
Pakkun Baby^I^I^Iwater^Ifire^Iholy^IMoogle, Snowman^I^IRuins of Light^IHand Axe^IIce Coin^I??? seed^IUndine Statue^IUndine Statue^IBee's Eye ^IRound Drop^IMysterious seed^IPakkun Chocolate^I0^M
Pakkun Dragon^I^Iwater, holy^I^Ifire^Idark^IMoogle, Snowman, Sleep^I^IRuins of Light^ISahagin's Scale^IPoseidon's Claw ^IPumpkin Bomb^IUndine Statue^IWhite Dragon Fang^ISlime's Eye^IMysterious seed^IStar Dust Herb^IPakkun Chocolate^I0^M
Pakkun Lizard^I^I^Iwater^Ifire^Idark^IMoogle, Snowman, Sleep^I^I^IHand Axe^IIce Coin^I??? seed^IUndine Statue^IUndine Statue^IBee's Eye ^IRound Drop^IMysterious seed^IPakkun Chocolate^I0^M
Pakkuri Baby^I^Iwater^I^Ifire^Idark^IMoogle, Snowman^I^I^ISahagin's Scale^IPoseidon's Claw ^IPumpkin Bomb^IUndine Statue^IWhite Dragon Fang^ISlime's Eye^IMysterious seed^IStar Dust Herb^IPakkun Chocolate^I0^M
Papa Poto^Iholy^Iholy^I^I^Idark^IMoogle, Silence^I^I^IPoto Oil^IWisp Statue^I??? seed^I??? seed^IPapa Poto's Claw^IW/A Seed^IPuipui Grass^IItem seed^IMagic Walnut^I1^M
Petit Dragon^I^I^I^Iearth, air, fire, water^Iphysical, moon^IMoogle, Chibikko, Poison, Snowman, Petrify^I^I^IEarth Coin^INeedlion's Eye^IAssassin Bug Eye^IMolebear's Claw^IGnome Statue^IBasilisk's Fang^IRound Drop^IPuipui Grass^IMagic seed^I0^M
Petit Poseidon^I^I^I^Iwater^Iearth^IMoogle, Snowman^I^I^ISahagin's Scale^IPoseidon's Claw ^I??? seed^IUndine Statue^IAngel's Grail^IWhite Dragon Fang^IRound Drop^IItem seed^IPakkun Chocolate^I0^M
Petit Tiamat^I^Iair^I^Iwater, fire^Iphysical, moon, earth^IMoogle, Chibikko, Poison, Snowman, Silence^Isilence^I^IStorm Coin^IBee's Eye ^I??? seed^IJinn Statue^IW/A Seed^IHarpy's Fang^IStar Dust Herb^IMysterious seed^IFly Item seed^I1^M
Porobin Hood^I^I^Iearth^I^Iwater^IMoogle, Sleep, Snowman^I^I^IMyconid's Eye^IMysterious seed^IAssassin Bug Eye^IPakkun Chocolate^ICarmilla's Claw^IW/A Seed^IDart^IPuipui Grass^IDreamsee Herb^I1^M
Porobin Leader^I^I^Iearth^I^Iwater^IMoogle, Sleep, Snowman^I^IMoonreading Tower^IFly Item seed^IMyconid's Eye^I??? seed^IPorobin Oil^IPumpkin Bomb^ICrawler's Claw^IItem seed^IRound Drop^IPakkun Chocolate^I0^M
Poron^I^I^I^Iearth^Iwater^IMoogle, Sleep, Snowman^I^I^IItem seed^IDreamsee Herb^IMyconid's Eye^IPorobin Oil^IHoney Drink^IChibi Devil's Eye^IDart^IRound Drop^IPakkun Chocolate^I0^M
Poto^I^I^Iholy^I^Idark^IMoogle, Silence^I^IRuins of Light^ILight Coin^IIce Coin^IPoto Oil^IWisp Statue^IAngel's Grail^IPakkun Oil^IRound Drop^IStar Dust Herb^IMysterious seed^I0^M
Power Boulder^Iall^I^Imagic^Iphysical^I^IMoogle, Chibikko, Sleep^Isilence^I^ISpecter's Eye^IPumpkin Bomb^I??? seed^I??? seed^IAngel's Grail^IGhost's Eye^IItem seed^IStar Dust Herb^IMagic Walnut^I0^M
Queen Bee^I^Iearth^I^I^Ifire^IMoogle, Poison, Chibikko^Ipoison^IMoonreading Tower^IBulette's Scale^IDrake's Scale^I??? seed^IBee's Eye ^IHoney Drink^IW/A Seed^IItem seed^IRound Drop^IPakkun Chocolate^I1^M
Rabilion^I^I^I^Iearth^Iair^IMoogle, Silence^I^I^IMysterious seed^IBird's Scale^ISlime's Eye^ILuna Statue^IAngel's Grail^IPorobin Oil^IRound Drop^IItem seed^IStar Dust Herb^I0^M
Rabite^I^I^I^Iearth^Iair^IMoogle, Silence^I^I^IEarth Coin^IMatango Oil^IPakkun Oil^IBattum's Eye^IW/A Seed^IHoney Drink^IRound Drop^IItem seed^IPakkun Chocolate^I1^M
Ruster Bug^I^I^I^Iair^Iphysical, moon, earth^IMoogle, Poison^Ipoison^IMoonlight Forest^IMyconid's Eye^IAssassin Bug Eye^I??? seed^I??? seed^IHoney Drink^IDryad Statue^IStar Dust Herb^IPuipui Grass^IPakkun Chocolate^I0^M
Sahagin^I^I^I^Iwater^Iearth^IMoogle, Snowman^I^I^ISahagin's Scale^IIce Coin^IUndine Statue^ISlime's Eye^IBird's Scale^ILuna Statue^IItem seed^IPuipui Grass^IPumpkin Bomb^I0^M
Sea Dragon^I^Iwater^I^I^Ifire^IMoogle, Chibikko, Snowman^I^I^IIce Coin^IPoseidon's Claw ^ISlime's Eye^IUndine Statue^INeedlion's Eye^IPoto Oil^IRound Drop^IMysterious seed^IPakkun Chocolate^I0^M
Sea Serpent^I^I^Iwater^I^Ifire^IMoogle, Chibikko, Snowman^I^I^IIce Coin^IPakkun Chocolate^IUndine Statue^I??? seed^IHand Axe^IPumpkin Bomb^IItem seed^IFly Item seed^IMagic seed^I0^M
Shadow-zero^I^I^I^I^I^Iall^I^I^IMagic seed^IMagic seed^I??? seed^I??? seed^IW/A Seed^IW/A Seed^IItem seed^IMysterious seed^IFly Item seed^I2^M
Shape-shifter^I^I^I^I^I^Iall^I^I^IMagic seed^IMagic seed^I??? seed^I??? seed^IW/A Seed^IW/A Seed^IItem seed^IMysterious seed^IFly Item seed^I2^M
Shell Hunter^I^I^I^I^I^IMoogle, Chibikko^I^I^IMysterious seed^IMagical Rope^IChibi Devil's Eye^ILuna Statue^IDrake's Scale^IMama Poto Oil ^IItem seed^IDreamsee Herb^IRound Drop^I0^M
Silver Knight^I^I^I^Iphysical, leaf, moon, holy^Idark, counter^IMoogle, Chibikko, Sleep, Petrify^I^IRuins of Light^IMama Poto Oil ^IMysterious seed^I??? seed^IPapa Poto's Claw^IAngel's Grail^IPoto Oil^IItem seed^IPuipui Grass^IFly Item seed^I0^M
Silver Wolf^I^I^Iholy^Imoon, physical^Idark^IMoogle, Chibikko, Silence^I^IMoonreading Tower^IFly Item seed^ICarmilla's Claw^IPapa Poto's Claw^IPoto Oil^IAngel's Grail^IShadow Zero's Eye^IItem seed^IPuipui Grass^IPakkun Chocolate^I0^M
Siren^I^Iair^I^I^Iearth, dark^IMoogle^Isilence^IRuins of Light^ISiren's Claw^IStorm Coin^IJinn Statue^I??? seed^IHarpy's Fang^IWisp Statue^IDreamsee Herb^IItem seed^IMagic Walnut^I0^M
Slime^I^Iwater^I^Iphysical, moon, leaf^Ifire^IMoogle, Chibikko, Snowman, Petrify, Poison^Ipoison^I^IBird's Scale^IEarth Coin^I??? seed^INeedlion's Eye^IBee's Eye ^IHoney Drink^IPuipui Grass^IDreamsee Herb^IMysterious seed^I0^M
Slime Prince^I^Iwater^Iphysical, moon, leaf^I^Ifire^IMoogle, Chibikko, Snowman, Petrify, Poison^Ipoison^IRuins of Light^IBulette's Scale^IMyconid's Eye^ISlime's Eye^I??? seed^IHoney Drink^IAngel's Grail^IDreamsee Herb^IPuipui Grass^IPakkun Chocolate^I0^M
Specter^I^Idark^I^Iphysical, moon, leaf^Iholy^IMoogle, Chibikko, Petrify, Poison, Snowman^Imoogled^IMoonlight Forest^IMoon Coin^IDarkness Coin^ISpecter's Eye^I??? seed^IShade Statue^IGrell Oil^IPuipui Grass^IItem seed^IMagic seed^I0^M
Sword Master^I^I^I^Iall except holy and dark^Icounter^IMoogle, Chibikko, Sleep, Petrify^I^IMoonreading Tower^IMolebear's Claw^ISiren's Claw^I??? seed^IPoseidon's Claw ^IW/A Seed^IKerberos' Claw^IStar Dust Herb^IDreamsee Herb^IMagic Walnut^I1^M
Unicorn Head^I^I^I^Iair^Iearth^IMoogle, Chibikko, Sleep^I^I^IStorm Coin^ISiren's Claw^IJinn Statue^IBee's Eye ^IAngel's Grail^IBird's Scale^IDart^IPuipui Grass^IMysterious seed^I0^M
Werewolf^I^I^I^Imoon^Ileaf^IMoogle, Chibikko, Silence^I^IMoonlight Forest^IMoon Coin^IBird's Scale^IChibi Devil's Eye^IPorobin Oil^IWolf Devil Oil^ICarmilla's Claw^IMysterious seed^IStar Dust Herb^IFly Item seed^I0^M
Wizard^I^I^I^I^Iwater^IMoogle, Chibikko, Petrify, Sleep^I^I^ILight Coin^IDarkness Coin^ISalamando Statue^IUndine Statue^IJinn Statue^IGnome Statue^IMysterious seed^IPuipui Grass^IMagic Walnut^I0^M
Wolf Devil^I^Imoon, dark^Iphysical^I^Iholy^IMoogle, Chibikko, Silence^I^I^IDemon's Claw^IMoon Coin^IWolf Devil Oil^IChibi Devil's Eye^IW/A Seed^IW/A Seed^IItem seed^IRound Drop^IPakkun Chocolate^I2^M
Zombie^I^I^Idark^I^Iholy^IMoogle, Poison^Ipoison^I^IMyconid's Eye^IFlame Coin^ICarmilla's Claw^IDemon's Claw^IBird's Scale^INeedlion's Eye^IPuipui Grass^IMagical Rope^IDreamsee Herb^I0
"""
