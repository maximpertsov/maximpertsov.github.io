module Page.SinOfMana exposing (Model, Msg, init, update, view)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Css exposing (..)
import Debug
import Html.Styled as H
import Html.Styled.Attributes as At
import Html.Styled.Events as Ev
import Page.SinOfMana.Character as Character
import Page.SinOfMana.Enemy as Enemy
import Page.SinOfMana.Spell as Spell
import Url
import Url.Builder as B
import Url.Parser as P exposing ((</>))



-- MODEL


type alias Model =
    { search : String }



-- INITIALIZE


init : Model
init =
    { search = "" }



-- UPDATE


type Msg
    = Search String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Search search ->
            { model | search = search }



-- VIEWS


viewCharacters : H.Html msg
viewCharacters =
    H.div
        []
        [ H.h2 [] [ H.text "Characters" ]
        , Character.viewAll
        ]


view : (Msg -> msg) -> H.Html msg
view toMsg =
    H.div
        []
        [ H.input [ Ev.onInput (toMsg << Search) ] []
        , viewCharacters
        , H.h2 [] [ H.text "Spells" ]
        , Spell.viewAll
        , H.h2 [] [ H.text "Enemies" ]
        , Enemy.viewAll
        ]
