module Test.Generated.Main202289994 exposing (main)

import Example

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    [     Test.describe "Example" [Example.suite] ]
        |> Test.concat
        |> Test.Runner.Node.run { runs = Nothing, report = (ConsoleReport UseColor), seed = 189504430721020, processes = 16, paths = ["/Users/willfuchs/Documents/Cal Poly 2019/csc430/assignments/as07/tests/Example.elm"]}