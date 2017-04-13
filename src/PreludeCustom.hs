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



mbool :: (Monoid a) => a -> Bool -> a
mbool = bool mempty

mboolFunc :: (Monoid a) => (b -> a) -> Bool -> b -> a
mboolFunc f b = flip mbool b . f
