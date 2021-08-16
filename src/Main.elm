module Main exposing (main)

-- import Html.Styled.Events as Ev

import Browser exposing (Document)
import Browser.Navigation as Nav
import Css exposing (..)
import Html.Styled as H
import Html.Styled.Attributes as At
import Page.SinOfMana
import Url
import Url.Builder as B
import Url.Parser as P exposing ((</>))



-- PROGRAM


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type alias Model =
    { -- Display
      mobileView : Bool

    -- Url Navigation
    , key : Nav.Key
    , route : Maybe Route

    -- sinOfMana
    , sinOfMana : Page.SinOfMana.Model
    }


type Route
    = Home
    | SinsOfMana


router : P.Parser (Route -> a) a
router =
    P.oneOf
        [ P.map Home <| P.top
        , P.map SinsOfMana <| P.top </> P.s "sin-of-mana"
        ]



-- INITIALIZE


type alias Flags =
    { mobileView : Bool }


init : Flags -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        model =
            { mobileView = flags.mobileView

            -- Url Navigation
            , key = key
            , route = P.parse router url
            , sinOfMana = Page.SinOfMana.init
            }
    in
    ( model, Cmd.none )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | SinOfManaMsg Page.SinOfMana.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            handleUrlChanged url model

        SinOfManaMsg subMsg ->
            ( { model | sinOfMana = Page.SinOfMana.update subMsg model.sinOfMana }
            , Cmd.none
            )


handleUrlChanged : Url.Url -> Model -> ( Model, Cmd Msg )
handleUrlChanged url model =
    let
        newRoute =
            P.parse router url
    in
    ( { model | route = newRoute }
    , Cmd.none
    )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEWS


view : Model -> Document Msg
view model =
    { title = "maximpertsov"
    , body = List.map H.toUnstyled [ viewBody model ]
    }


viewBody : Model -> H.Html Msg
viewBody model =
    case model.route of
        Just Home ->
            viewHome

        Just SinsOfMana ->
            Page.SinOfMana.view SinOfManaMsg

        Nothing ->
            viewNotFound


viewHome : H.Html Msg
viewHome =
    H.div []
        [ H.div
            []
            [ H.a
                [ At.href <| B.absolute [ "sin-of-mana" ] [] ]
                [ H.text "Sin of Mana" ]
            ]
        ]


viewNotFound : H.Html Msg
viewNotFound =
    H.div
        []
        [ H.div
            []
            [ H.text "Not found" ]
        , H.div
            []
            [ H.a
                [ At.href <| B.absolute [] [] ]
                [ H.text "Return home" ]
            ]
        ]
