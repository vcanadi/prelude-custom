module Examples where

import PreludeCustom
import Debug.Trace

fac :: Int -> Int
fac = (==0) ?>-> 1
             ||> (*) <$> id
                     <*> fac . pred

-- can't check execution of this but implementations looks neat
collatz :: Int -> Int
collatz = (==1) ?>-> 1
                 ||> even ?>>> collatz . (`div` 2)
                           ||> collatz . succ . (*3)


-- implementation looks messy but result is list of input values
-- collatz branch to (merged result of first rec call and input) and (merger result of second rec call input)
collatzAcc :: Int -> [Int]
collatzAcc = (==1) ?>-> [1]
                    ||> even ?>>> (<>) <$> collatzAcc . (`div` 2)
                                       <*> return
                              ||> (<>) <$> collatzAcc . succ . (*3)
                                       <*> return

-- merge (result of collatz branch) and input
collatzAcc2 :: Int -> [Int]
collatzAcc2 = (==1) ?>-> [1]
                     ||> (<>) <$> ( even  ?>>>  collatzAcc2 . (`div` 2)
                                           ||>  collatzAcc2 . succ . (*3) )
                              <*> return
