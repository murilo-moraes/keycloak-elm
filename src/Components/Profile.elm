module Components.Profile exposing (view)

import Html exposing (..)
import Effect exposing (Effect)
import Shared.Model exposing (AuthModel)
import Html.Events exposing (onClick)

viewUnauthenticated : () -> Html msg
viewUnauthenticated () =
    div [] 
        [ button [] [text "Login"] ]

viewAutheticated :
    { authModel: AuthModel } -> Html msg
viewAutheticated props =
    div []
        [ p [] [ text props.authModel.userName ]
        , p [] [ text props.authModel.email ]
        -- , button [ onClick props.onLogout ] [ text "Logout"]
        ]

view :
    { authModel: AuthModel } -> Html msg
view props =
    if props.authModel.authenticated then viewAutheticated props
    else viewUnauthenticated ()
