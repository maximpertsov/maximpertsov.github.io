module Main exposing (main)

-- import Html.Styled.Attributes as At
-- import Html.Styled.Events as Ev
-- import Url.Builder as B

import Browser exposing (Document)
import Browser.Navigation as Nav
import Css exposing (..)
import Html.Styled as H exposing (Html)
import Url
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
    }


type Route
    = Home


router : P.Parser (Route -> a) a
router =
    P.oneOf
        [ P.map Home <| P.top

        -- , P.map Round <| P.top </> P.string
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
            }
    in
    ( model, Cmd.none )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


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


viewBody : Model -> Html Msg
viewBody model =
    case model.route of
        Just Home ->
            H.div [] [ H.text "HI" ]

        Nothing ->
            H.div [] [ H.text "???" ]
