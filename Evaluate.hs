module Evaluate where

import Terms

smallStep :: Term -> Term
smallStep (TIfThenElse t1 t2 t3) =
  case t1' of
    TTrue -> t2
    TFalse -> t3
    _ -> (TIfThenElse t1' t2 t3)
  where t1' = smallStep t1

smallStep (TSucc t) =
  case t of
    (TSucc _) -> (TSucc t)
    TZero -> (TSucc t)
    _ -> (TSucc t)

smallStep (TPred t) =
  case t of
    (TSucc t1) -> t1
    TZero -> TZero
    _ -> (TPred t)

smallStep (TIsZero t) =
  case t of
    TZero -> TTrue
    (TSucc _) -> TFalse
    _ -> (TIsZero t)

-- Other terms are either values, or stuck
smallStep t = t

evaluate :: Term -> Term
evaluate = until (\t -> smallStep t == t) smallStep

