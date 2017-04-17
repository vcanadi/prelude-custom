{-# LANGUAGE NoImplicitPrelude #-}

module PreludeCustom
    ( module PreludeCustom
    , module ReEx
    ) where

import Prelude         as ReEx
import Data.Bool       as ReEx
import Data.Monoid     as ReEx
import Data.Function   as ReEx
import Data.Maybe      as ReEx
import Data.Ord        as ReEx
import Data.Bifunctor  as ReEx (bimap)
import Control.Arrow   as ReEx


monoidBool :: (Monoid a) => a -> Bool -> a
monoidBool = bool mempty


type FuncIfThenElse a b = (a -> Bool) -> (a -> b) -> (a -> b) -> (a -> b)
type MonoidFuncIfThenElse a b = (a -> Bool) -> (a -> b) -> (a -> b)
type MonoidIfThenElse a = Bool -> a -> a


monoidIfThenElse :: Monoid a => MonoidIfThenElse a
monoidIfThenElse = flip monoidBool

monoidFuncIfThenElse, (?>) :: (Monoid b) => MonoidFuncIfThenElse a b
monoidFuncIfThenElse p f = monoidBool <$> f <*> p
(?>) = monoidFuncIfThenElse


funcIfThenElse, (??>) :: FuncIfThenElse a b
funcIfThenElse p f g = bool <$> g <*> f <*> p
(??>) = funcIfThenElse
(||>) = ($)

infixr 2 ??>
infixr 1 ||>








