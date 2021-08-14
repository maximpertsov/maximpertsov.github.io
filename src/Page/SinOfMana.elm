module Page.SinOfMana exposing (view)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Css exposing (..)
import Html.Styled as H
import Html.Styled.Attributes as At
import Html.Styled.Events as Ev
import Url
import Url.Builder as B
import Url.Parser as P exposing ((</>))



-- MODEL


type alias Character =
    { name : String
    , notes : List String
    }


characters =
    [ Character "Duran" []
    , Character "Kevin" []
    , Character "Hawk" []
    , Character "Angela" []
    , Character "Carlie" []
    , Character "Lise" []
    ]



-- VIEWS


view : H.Html msg
view =
    H.div
        []
        [ viewCharacters ]


viewCharacters : H.Html msg
viewCharacters =
    H.div
        []
        (List.map viewCharacter characters)


viewCharacter : Character -> H.Html msg
viewCharacter character =
    H.div [] [ H.text character.name ]
