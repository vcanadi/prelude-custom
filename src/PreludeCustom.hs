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


-- same as bool without value for false case
monoidBool :: (Monoid a) => a -> Bool -> a
monoidBool = bool mempty


-- if A then B else C where A,B,C <- [V (value), F (function), Z (zero, mempty, for monoid type)]
-- example if Value then Function else Function
type V a   = a
type F a b = (a -> b)

type IfVFF a b = V Bool   ->  F a b  ->  F a b  ->  F a b
type IfFFF a b = F a Bool ->  F a b  ->  F a b  ->  F a b

type IfVVZ a   = V Bool   ->  V a    ->  V a
type IfVFZ a b = V Bool   ->  F a b  ->  F a b
type IfFFZ a b = F a Bool ->  F a b  ->  F a b



ifVFF        ::             IfVFF a b
ifFFF, (??>) ::             IfFFF a b

ifVVZ        :: Monoid a => IfVVZ a
ifVFZ        :: Monoid b => IfVFZ a b
ifFFZ, (?>)  :: Monoid b => IfFFZ a b


ifVFF b f g = bool <$> g <*> f <*> const b
ifFFF p f g = bool <$> g <*> f <*> p

ifVVZ b x   = monoidBool x b
ifVFZ b f   = flip monoidBool b . f
ifFFZ p f   = monoidBool <$> f <*> p


infixr 2 ?>
(?>) = ifFFZ

infixr 2 ??>
(??>)       = ifFFF

infixr 1 ||>
(||>)       = ($)








