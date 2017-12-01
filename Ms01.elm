module Main exposing (main)

import Html exposing (Html, text)


sum : List Int -> Int
sum numbers =
    case numbers of
        a :: b :: rest ->
            gather a [] numbers

        _ ->
            0


gather : Int -> List Int -> List Int -> Int
gather first acc remaining =
    case remaining of
        [] ->
            -- Empty list! (this shouldn't really happen, but let's cover our bases)
            List.sum acc

        a :: [] ->
            -- The last number remaining in the list, circle back to the first and return the sum
            if a == first then
                List.sum (a :: acc)
            else
                List.sum acc

        a :: b :: rest ->
            -- At least two numbers in the list!
            let
                -- Add the number in the accumulator if necessary
                nextAcc =
                    if a == b then
                        a :: acc
                    else
                        acc
            in
            -- Recurse with a clipped list
            gather first nextAcc (b :: rest)


main : Html msg
main =
    { shouldBe3 = sum [ 1, 1, 2, 2 ]
    , shouldBe4 = sum [ 1, 1, 1, 1 ]
    , shouldBe9 = sum [ 9, 1, 2, 1, 2, 1, 2, 9 ]
    }
        |> toString
        |> text
        |> (\s -> Html.pre [] [ s ])
