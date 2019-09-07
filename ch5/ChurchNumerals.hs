module ChurchNumerals where

zero = \_s -> \t -> t
chSucc = \n -> \s -> \t -> s (n s t)

churchToNumber n = n (+1) 0
numberToChurch 0 = zero
numberToChurch n = chSucc $ numberToChurch $ n - 1

plus = \m -> \n -> \s -> \t -> m s (n s t)
times = \m -> \n -> \s -> \t -> m (n s) t
pow = \b -> \p -> \s -> \t -> p b s t

lcT = \t -> \f -> t
lcF = \t -> \f -> f

pair = \x -> \y -> \f -> f x y
pFst = \p -> p lcT
pSnd = \p -> p lcF

zeroPair = pair zero zero
pairSucc = \p -> pair (pSnd p) (chSucc (pSnd p))
chPred = \n -> pFst (n pairSucc zeroPair)

-- Doesn't play nice with the typechecker.
-- minus = \m -> \n -> n chPred m
-- I'm going to move the rest of the code to JS for this reason.
