{-# LANGUAGE DeriveFunctor          #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE TypeFamilies           #-}
{-# LANGUAGE TypeFamilyDependencies #-}
{-# LANGUAGE TypeSynonymInstances   #-}

module Rings where

import           Control.Category
import           Data.Fix
import           Data.Group
import           Prelude          (Either (..), Functor (..), Integer,
                                   Monoid (..), Semigroup (..), Show, negate,
                                   ($), (*), (+))

data Plus = Plus Integer
  deriving (Show)
fromPlus (Plus m) = m

data Times = Times Integer
  deriving (Show)
fromTimes (Times m) = m

instance Semigroup Plus where
    (Plus m) <> (Plus n) = Plus (m + n)

instance Monoid Plus where
    mempty = Plus 0

instance Group Plus where
    invert (Plus m) = (Plus (negate m))

instance Abelian Plus

instance Semigroup Times where
    (Times m) <> (Times n) = Times (m * n)

instance Monoid Times where
    mempty = Times 1

tToP :: Times -> Plus
tToP (Times m) = Plus m

pToT :: Plus -> Times
pToT (Plus m) = Times m

class (Abelian m, Monoid t) => Ring m t where
    m2t :: m -> t
    t2m :: t -> m

    plus :: Either m t -> Either m t -> Either m t
    times :: Either m t -> Either m t -> Either m t
    plus (Left m) (Left n)   = Left $ m <> n
    plus (Left m) (Right n)  = Left $ m <>  t2m n
    plus (Right m) (Left n)  = Left $ t2m m <> n
    plus (Right m) (Right n) = Left $ t2m m <> t2m n

    times (Right m) (Right n) = Right $ m <> n
    times (Right m) (Left n)  = Right $ m <> m2t n
    times (Left m) (Right n)  = Right $ m2t m <> n
    times (Left m) (Left n)   = Right $ m2t m <> m2t n

    -- a ⋅ (b + c) = (a · b) + (a · c) for all a, b, c in R   (left distributivity).
    -- (b + c) · a = (b · a) + (c · a) for all a, b, c in R   (right distributivity).


instance Ring Plus Times where
    m2t = pToT
    t2m = tToP


