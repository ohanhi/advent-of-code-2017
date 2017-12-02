module Main exposing (main)

import Array
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



-- PART 2


sum2 : List Int -> Int
sum2 numbers =
    let
        array =
            Array.fromList numbers

        length =
            Array.length array

        halfwayAcross fromIdx =
            Array.get ((fromIdx + length // 2) % length) array
    in
    array
        |> Array.toIndexedList
        |> List.filter (\( idx, num ) -> halfwayAcross idx == Just num)
        |> List.map Tuple.second
        |> List.sum


main : Html msg
main =
    { shouldBe3 = sum [ 1, 1, 2, 2 ]
    , shouldBe4 = sum [ 1, 1, 1, 1 ]
    , shouldBe9 = sum [ 9, 1, 2, 1, 2, 1, 2, 9 ]
    , part2_shouldBe6 = sum2 [ 1, 2, 1, 2 ]
    , part2_shouldBe0 = sum2 [ 1, 2, 2, 1 ]
    , part2_shouldBe4 = sum2 [ 1, 2, 3, 4, 2, 5 ]
    }
        |> toString
        |> text
        |> (\s -> Html.pre [] [ s ])
