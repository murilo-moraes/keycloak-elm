module Layouts.Sidebar exposing (Model, Msg, Props, layout)

import Effect exposing (Effect)
import Html exposing (Html, div, aside, a, text)
import Html.Attributes exposing (class, href)
import Components.Profile
import Layout exposing (Layout)
import Route exposing (Route)
import Shared
import View exposing (View)


type alias Props =
    {}


layout : Props -> Shared.Model -> Route () -> Layout () Model Msg contentMsg
layout props shared route =
    Layout.new
        { init = init
        , update = update
        , view = view shared
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    {}


init : () -> ( Model, Effect Msg )
init _ =
    ( {}
    , Effect.none
    )



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model
            , Effect.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW

view : Shared.Model -> { toContentMsg : Msg -> contentMsg, content : View contentMsg, model : Model } -> View contentMsg
view shared { toContentMsg, model, content } =
    { title = content.title
    , body =
        [ div [ class "layout" ]
            [ aside [ class "sidebar" ]
                [ Components.Profile.view { authModel = shared.authModel }
                , a [ href "/" ] [ text "Home" ]
                , a [ href "/account" ] [ text "Account" ]
                ]
            , div [ class "page" ] content.body
            ]
        ]
    }
