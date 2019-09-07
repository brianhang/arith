module List where

nil = \c -> \n -> n

lcCons = \e -> \l -> \c -> \n -> c e (l c n)

lcListToList l = l (++) []
