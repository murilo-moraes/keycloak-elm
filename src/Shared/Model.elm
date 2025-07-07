module Shared.Model exposing (Model, AuthModel)

{-| -}


{-| Normally, this value would live in "Shared.elm"
but that would lead to a circular dependency import cycle.

For that reason, both `Shared.Model` and `Shared.Msg` are in their
own file, so they can be imported by `Effect.elm`

-}

type alias AuthModel =
    { authenticated : Bool 
    , token : String
    , userName: String
    , email: String
    }

type alias Model =
    { authModel : AuthModel }
