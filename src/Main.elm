module Main exposing (main)

import Html exposing (Html, div, h1, p, a, ul, li, text)
import Html.Attributes exposing (class, href, target)

main = view

view : Html msg
view =
    div [ class "hero" ]
        [
            h1 []
                [ text "JORGE.SH" ],
            p []
                [ text "Currently in my 6th semester in ",
                  a [ href "https://www.fime.uanl.mx/", target "_blank"] [text "FIME"],
                  text ". On my free time I like to hike."
                ],
            ul []
                [
                  li [] [ a [ href "https://www.github.com/MrBocch" ] [text "~> Github"]],
                  li [] [ a [ href "https://www.jorge.sh/blog" ] [text "~> Blog"]]
                ]
        ]
