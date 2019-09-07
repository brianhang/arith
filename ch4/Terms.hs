module Terms where


data Term = TTrue
          | TFalse
          | TIfThenElse Term Term Term
          | TZero
          | TSucc Term
          | TPred Term
          | TIsZero Term
          deriving (Show, Eq)

