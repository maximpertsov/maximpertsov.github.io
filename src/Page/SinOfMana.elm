module Page.SinOfMana exposing (view)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Css exposing (..)
import Debug
import Html.Styled as H
import Html.Styled.Attributes as At
import Html.Styled.Events as Ev
import Page.SinOfMana.Character as Character exposing (Character)
import Page.SinOfMana.Spell as Spell exposing (Spell)
import Url
import Url.Builder as B
import Url.Parser as P exposing ((</>))



-- MODEL
-- VIEWS


viewCharacters : H.Html msg
viewCharacters =
    H.div
        []
        [ H.h2 [] [ H.text "Characters" ]
        , Character.viewAll
        ]


view : H.Html msg
view =
    H.div
        []
        [ viewCharacters
        , H.div
            []
            [ H.h2 [] [ H.text "Spells" ]
            , Spell.viewAll
            ]
        ]
