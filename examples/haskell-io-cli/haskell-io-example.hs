name2reply :: String -> String
name2reply name =
    "Pleased to meet you, " ++ name ++ " :-D Welcome to Haskell!\n" ++
    "(Btw, your name contains " ++ charcount ++ " characters.)"
    where charcount = show (length name)

main :: IO ()
main = do
       putStrLn "Greetings! What's your name?"
       inpStr <- getLine
       let outStr = name2reply inpStr
       putStrLn outStr
