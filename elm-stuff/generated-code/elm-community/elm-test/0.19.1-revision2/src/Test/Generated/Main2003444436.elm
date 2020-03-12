module Test.Generated.Main2003444436 exposing (main)

import Example

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    [     Test.describe "Example" [Example.suite] ]
        |> Test.concat
        |> Test.Runner.Node.run { runs = Nothing, report = (ConsoleReport UseColor), seed = 178551071187045, processes = 8, paths = ["/Users/archie/Documents/csc430/asgn7/DUNQ3/tests/Example.elm"]}