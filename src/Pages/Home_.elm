module Pages.Home_ exposing (page)

import Html
import Components.Sidebar
import View exposing (View)


page : View msg
page =
    Components.Sidebar.view
        { title = "Homepage"
        , body =  [ Html.text "Hello, world!" ]
        }
