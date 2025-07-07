module Pages.Account exposing (page)

import Html
import View exposing (View)
import Components.Sidebar

page : View msg
page =
    Components.Sidebar.view
        { title = "Pages.Account"
        , body = [ Html.text "/Account" ]
        }
