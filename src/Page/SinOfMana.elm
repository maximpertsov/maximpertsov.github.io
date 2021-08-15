module Page.SinOfMana exposing (view)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Css exposing (..)
import Debug
import Html.Styled as H
import Html.Styled.Attributes as At
import Html.Styled.Events as Ev
import Page.SinOfMana.Spell
import Url
import Url.Builder as B
import Url.Parser as P exposing ((</>))



-- MODEL


type alias Character =
    { name : String
    , notes : List String
    }



-- DATA


characters =
    [ Character
        "Duran"
        [ "can equip shields to draw aggro" ]
    , Character
        "Kevin"
        [ "dual attacks"
        , "wolf form increases attack by (3% + VIT)"
        ]
    , Character
        "Hawk"
        [ "dual attacks" ]
    , Character
        "Angela"
        [ "Fireball is learnable with light spirit but still a fire elemental spell"
        , "Ice Smash is learnable with earth spirit but still an ice elemental spell"
        ]
    , Character
        "Carlie"
        [ "Ghoul'n'Ghost can be learned early with the air spirit but still keep their respective elements" ]
    , Character
        "Lise"
        [ "can equip shields to draw aggro (only Red Heat, Thunder God and Gold)" ]
    ]



-- VIEWS


view : H.Html msg
view =
    H.div
        []
        [ viewCharacters
        , case Page.SinOfMana.Spell.all of
            Err error ->
                H.div [] [ H.text <| Debug.toString error ]

            -- H.div [] [ H.text <| "Problem loading spells" ]
            Ok spells ->
                H.div [] <| List.map (\spell -> H.text spell.name) spells
        ]


viewCharacters : H.Html msg
viewCharacters =
    H.div
        []
        (List.map viewCharacter characters)


viewCharacter : Character -> H.Html msg
viewCharacter character =
    H.div []
        [ H.div [] [ H.text character.name ]
        , H.ul [] <| List.map (\note -> H.li [] [ H.text note ]) character.notes
        ]
