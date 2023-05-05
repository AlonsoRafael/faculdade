module Main where
import System.Directory (doesFileExist)
import System.IO

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering

  putStrLn " "
  putStrLn "=================================="
  putStrLn "------------- Banco -------------"
  putStrLn "=================================="
  putStrLn "Opções:"
  putStrLn "1. Saldo"
  putStrLn "2. Extrato"
  putStrLn "3. Depósito"
  putStrLn "4. Saque"
  putStrLn "5. Fim"
  putStr "Escolha uma opção: "
  
  let roubo = "./"
      arquivo_de_Saque = "saldo.txt"
      diretorio_de_Saque = roubo ++ arquivo_de_Saque
  temArquivoSaque <- doesFileExist diretorio_de_Saque
  if temArquivoSaque
    then putStrLn ""
    else writeFile diretorio_de_Saque "0\n"

  let pericia = "./"
      arquivo_de_Extrato = "extrato.txt"
      diretorio_de_Extrato = pericia ++ arquivo_de_Extrato
  temArquivoExtrato <- doesFileExist diretorio_de_Extrato
  if temArquivoExtrato
    then putStrLn ""
    else writeFile diretorio_de_Extrato "0\n"
    
  opcao <- getLine
  putStrLn " "
  

  case opcao of
    "1" -> imprime "saldo.txt"
    "2" -> imprime "extrato.txt"
    "3" -> do
      putStr "Digite o valor do deposito: "
      valor1 <- getLine
      putStrLn " "
      deposito (read valor1)
    "4" -> do
      putStr "Digite o valor que deseja sacar: "
      valor2 <- getLine
      putStrLn " "
      saque (read valor2)
    "5" -> putStrLn "Obrigado por usar o banco!"
    _ -> putStrLn "Opção inválida"

  putStrLn " "

       
  if opcao /= "5"
    then main
    else return ()

imprime :: String -> IO ()
imprime path = do
  conteudo <- readFile path
  putStrLn conteudo

deposito :: Float -> IO ()
deposito valorD = do
  saldo <- readFile "saldo.txt"
  putStrLn "saldo anterior:"
  putStrLn saldo
  let saldoAtual = read saldo :: Float
      novoSaldo = saldoAtual + valorD
  writeFile "saldo.txt" (show novoSaldo)
  appendFile "extrato.txt" ("\n+" ++ show valorD )
  putStrLn "Depósito realizado com sucesso!!!"
  
saque :: Float -> IO ()
saque valorS = do
  saldoAntes <- readFile "saldo.txt"
  if valorS > read saldoAntes
    then putStrLn "Saldo Insuficiente!!!"
    else do
      let saldo = read saldoAntes :: Float
          novoSaldo = saldo - valorS
      writeFile "saldo.txt" (show novoSaldo)
      appendFile "extrato.txt" ("\n-" ++ show valorS )
      putStrLn "Saque realizado com sucesso!!!"
