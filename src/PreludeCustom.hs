{-# LANGUAGE NoImplicitPrelude #-}

module PreludeCustom
    ( module ReEx
    , (?---)
    , (?-->)
    , (?->-)
    , (?->>)
    , (?>--)
    , (?>->)
    , (?>>-)
    , (?>>>)
    , (?--)
    , (?->)
    , (?>-)
    , (?>>)
    , (||>)
    ) where

import Prelude         as ReEx
import Data.Bool       as ReEx
import Data.Monoid     as ReEx
import Data.Function   as ReEx
import Data.Maybe      as ReEx
import Data.Ord        as ReEx
import Data.Bifunctor  as ReEx (bimap)
import Control.Arrow   as ReEx



-- if A then B [else C] where A,B,C e {V (value), F (function)}  (optional C is for monoid type where else is mempty)
-- example if Value then Function else Function
type V a   = a
type F a b = (a -> b)

type IfVVV b   = V Bool   ->  V b    ->  V b    ->  V b
type IfVVF a b = V Bool   ->  V b    ->  F a b  ->  F a b
type IfVFV a b = V Bool   ->  F a b  ->  V b    ->  F a b
type IfVFF a b = V Bool   ->  F a b  ->  F a b  ->  F a b
type IfFVV a b = F a Bool ->  V b    ->  V b    ->  F a b
type IfFVF a b = F a Bool ->  V b    ->  F a b  ->  F a b
type IfFFV a b = F a Bool ->  F a b  ->  V b    ->  F a b
type IfFFF a b = F a Bool ->  F a b  ->  F a b  ->  F a b


ifVFF, (?->>)  ::             IfVFF a b
ifFFF, (?>>>)  ::             IfFFF a b


ifVVV b x y = bool y x b
ifVVF b x g = bool <$> g       <*> const x <*> const b
ifVFV b f y = bool <$> const y <*> f       <*> const b
ifVFF b f g = bool <$> g       <*> f       <*> const b
ifFVV p x y = bool <$> const y <*> const x <*> p
ifFVF p x g = bool <$> g       <*> const x <*> p
ifFFV p f y = bool <$> const y <*> f       <*> p
ifFFF p f g = bool <$> g       <*> f       <*> p

ifVV b x = ifVVV b x mempty
ifVF b f = ifVFV b f mempty
ifFV p x = ifFVV p x mempty
ifFF p f = ifFFV p f mempty



infixr 2 ?---, ?-->, ?->-, ?->>, ?>--, ?>->, ?>>-, ?>>>
(?---) = ifVVV
(?-->) = ifVVF
(?->-) = ifVFV
(?->>) = ifVFF
(?>--) = ifFVV
(?>->) = ifFVF
(?>>-) = ifFFV
(?>>>) = ifFFF



type IfVV  b   = V Bool   ->  V b    ->  V b
type IfVF  a b = V Bool   ->  F a b  ->  F a b
type IfFV  a b = F a Bool ->  V b    ->  F a b
type IfFF  a b = F a Bool ->  F a b  ->  F a b


ifVV,  (?--)   :: Monoid a => IfVV a
ifVF,  (?->)   :: Monoid b => IfVF a b
ifFV,  (?>-)   :: Monoid b => IfFV a b
ifFF,  (?>>)   :: Monoid b => IfFF a b


infixr 2 ?--, ?->, ?>-, ?>>
(?--) = ifVV
(?->) = ifVF
(?>-) = ifFV
(?>>) = ifFF

infixr 1 ||>
(||>)       = ($)

ifEnd :: Monoid b => a -> b
ifEnd = const mempty









