port module Shared exposing
    ( Flags, decoder
    , Model, Msg
    , init, update, subscriptions
    )

{-|

@docs Flags, decoder
@docs Model, Msg
@docs init, update, subscriptions

-}

import Effect exposing (Effect)
import Json.Decode exposing (Decoder, decodeValue, map4, field, bool, string, int)
import Json.Encode
import Route exposing (Route)
import Route.Path
import Shared.Model
import Shared.Msg



-- FLAGS


type alias Flags =
    {}


decoder : Json.Decode.Decoder Flags
decoder =
    Json.Decode.succeed {}

-- PORTS

port authStateUpdated : (Json.Encode.Value -> msg) -> Sub msg

-- INIT


type alias Model =
    Shared.Model.Model


init : Result Json.Decode.Error Flags -> Route () -> ( Model, Effect Msg )
init flagsResult route =
    ( { authModel =
        { authenticated = False
        , token = ""
        , userName = ""
        , email = ""
        }
    }
    , Effect.none
    )



-- UPDATE


type alias Msg =
    Shared.Msg.Msg


update : Route () -> Msg -> Model -> ( Model, Effect Msg )
update route msg model =
    case msg of
        Shared.Msg.UpdateAuthState authState ->
            case decodeValue authModelDecoder authState of
                Ok newAuthModel ->
                    ( { model | authModel = newAuthModel }
                    , Effect.none
                    )
                Err _ -> ( model, Effect.none )



-- SUBSCRIPTIONS


subscriptions : Route () -> Model -> Sub Msg
subscriptions route model =
    authStateUpdated Shared.Msg.UpdateAuthState

authModelDecoder : Decoder Shared.Model.AuthModel
authModelDecoder =
    map4 Shared.Model.AuthModel
        (field "authenticated" bool)
        (field "token" string)
        (field "userName" string)
        (field "email" string)