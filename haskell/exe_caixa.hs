import Data.List (find, intercalate)
import Numeric (showFFloat)

type Codigo = Int
type Nome = String
type Preco = Float

type Produto = (Codigo, Nome, Preco)

tabelaProdutos :: [Produto]
tabelaProdutos =
  [ (001, "Chocolate", 5.25)
  , (002, "Biscoito", 8.50)
  , (003, "Laranja", 4.60)
  , (004, "Sabao", 24.90)
  , (005, "Batata Chips", 6.90)
  , (006, "Doritos", 8.90)
  ]

-- Função para obter o preço de um produto a partir do código
getPreco :: Codigo -> [Produto] -> Maybe Preco
getPreco codigo produtos = fmap (\(_, _, preco) -> preco) (find (\(cod, _, _) -> cod == codigo) produtos)

-- Função para gerar a nota fiscal
gerarNotaFiscal :: [Codigo] -> [Produto] -> String
gerarNotaFiscal codigos produtos =
  let itens = map (\codigo -> (codigo, getPreco codigo produtos)) codigos
      formatItem (codigo, Just preco) = nomeProduto ++ replicate (30 - length nomeProduto - length precoFormatado) '.' ++ precoFormatado
        where
          nomeProduto = maybe "" (\(_, nome, _) -> nome) (find (\(cod, _, _) -> cod == codigo) produtos)
          precoFormatado = showFFloat (Just 2) preco ""
      formatItem (_, Nothing) = replicate 30 '.'
      total = sum $ map (\(_, Just preco) -> preco) itens
  in unlines $
    [ "**********Nota Fiscal**********"
    , intercalate "\n" $ map formatItem itens
    , replicate 30 '.'
    , "Total: " ++ showFFloat (Just 2) total ""
    ]

-- Função para cadastrar um novo produto
cadastrarProduto :: Codigo -> Nome -> Preco -> [Produto] -> [Produto]
cadastrarProduto codigo nome preco produtos = (codigo, nome, preco) : produtos

-- Função para remover um produto
removerProduto :: Codigo -> [Produto] -> [Produto]
removerProduto codigo produtos = filter (\(cod, _, _) -> cod /= codigo) produtos

-- Função para alterar o preço de um produto
alterarPreco :: Codigo -> Preco -> [Produto] -> [Produto]
alterarPreco codigo novoPreco produtos = map (\(cod, nome, preco) -> if cod == codigo then (cod, nome, novoPreco) else (cod, nome, preco)) produtos

-- Função para exibir os produtos de uma lista
exibirProdutos :: [Produto] -> String
exibirProdutos produtos = intercalate "\n" $ map (\(cod, nome, preco) -> show cod ++ "\t" ++ nome ++ "\t" ++ showFFloat (Just 2) preco "") produtos


-- Exemplo de uso
main :: IO ()
main = do
  let compra = [001, 006, 003, 001]
      notaFiscal = gerarNotaFiscal compra tabelaProdutos
  writeFile "nota_fiscal.txt" notaFiscal
  putStrLn ""
  putStrLn "Nota fiscal impressa no arquivo 'nota_fiscal.txt'"
  putStrLn ""

  let produtosCadastrados = cadastrarProduto 007 "Pão de Forma" 3.50 tabelaProdutos
  putStrLn "Produtos cadastrados:"
  putStrLn (exibirProdutos produtosCadastrados)

  let produtosRemovidos = removerProduto 004 produtosCadastrados
  putStrLn "\nProdutos removidos:"
  putStrLn (exibirProdutos produtosRemovidos)

  let produtosPreco = alterarPreco 002 9.00 produtosRemovidos
  putStrLn "\nProdutos alterados:"
  putStrLn (exibirProdutos produtosPreco)

  let tabelaProdutosAtualizada = produtosPreco -- Atualiza a tabela de produtos com as alterações
  putStrLn "\nTabela de produtos atualizada:"
  putStrLn (exibirProdutos tabelaProdutosAtualizada)

  let compra2 = [007, 002]
      notaFiscal = gerarNotaFiscal compra2 tabelaProdutosAtualizada
  appendFile "nota_fiscal.txt" notaFiscal
  putStrLn ""
  putStrLn "Nota fiscal impressa no arquivo 'nota_fiscal.txt'"

--fiz as duas notas fiscais junta para ver q esta alterando