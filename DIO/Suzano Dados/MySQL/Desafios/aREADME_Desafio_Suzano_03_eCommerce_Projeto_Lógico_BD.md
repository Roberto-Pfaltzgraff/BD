# BootCamp 🌿Suzano & DIO: Análise de Dados com Power BI 🎲 (*Desafio 03*)
### Desafio 03 - Projeto Lógico de Banco de Dados – E-COMMERCE  
    
## 🎯Objetivo:
Realizar a **modelagem de dados** do projeto proposto de **E-Commerce**, conforme descrição na **Apresentação do Desafio**.  
O intuito é aplicar o conhecimento compartilhado até essa etapa do curso.  
A ferramenta a ser utilizada será: **MySQL Workbench**.  
OBS: O ponto de partida será o meu modelo conceitual, gerado no Desafio 01.  
[Desafio 1 - Projeto Conceitual de Banco de Dados](aREADME_Desafio_Suzano_01_eCommerce_Projeto_Conceitual.md)  
    ![alt text](.\imagens\img_DesafioAceito.png)

    
## 🤓Apresentação do Desafio:
>### Descrição do Desafio
>Replique a modelagem do projeto lógico de banco de dados para o cenário de e-commerce.  
>Fique atento as definições de chave primária e estrangeira, assim como as constraints presentes no cenário modelado.  
>Perceba que dentro desta modelagem haverá relacionamentos presentes no modelo EER.  
>Sendo assim, consulte como proceder para estes casos.  
>Além disso, aplique o mapeamento de modelos aos refinamentos propostos no módulo de modelagem conceitual.  
>
>Assim como demonstrado durante o desafio, realize a criação do Script SQL para criação do esquema do banco de dados.  
>Posteriormente, realize a persistência de dados para realização de testes.  
>Especifique ainda queries mais complexas dos que apresentadas durante a explicação do desafio.  
>Sendo assim, crie queries SQL com as cláusulas abaixo:
    

- 📋 1) Recuperações simples com SELECT Statement
- 📋 2) Filtros com WHERE Statement
- 📋 3) Crie expressões para gerar atributos derivados
- 📋 4) Defina ordenações dos dados com ORDER BY
- 📋 5) Condições de filtros aos grupos – HAVING Statement
- 📋 6) Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados
    
>### Diretrizes
>- Não há um mínimo de queries a serem realizadas;  
>- Os tópicos supracitados devem estar presentes nas queries;  
>- Elabore perguntas que podem ser respondidas pelas consultas;  
>- As cláusulas podem estar presentes em mais de uma query;  


>### Algumas das perguntas que podes fazer para embasar as queries SQL:
>- Quantos pedidos foram feitos por cada cliente?  
>- Algum vendedor também é fornecedor?  
>- Relação de produtos fornecedores e estoques;  
>- Relação de nomes dos fornecedores e nomes dos produtos;  

### Premissas e Considerações:

Maiores detalhes podem ser consultados no mesmo item da Solução do Desafio 1:  
[Desafio 1 - Projeto Conceitual de Banco de Dados](aREADME_Desafio_Suzano_01_eCommerce_Projeto_Conceitual.md)  


## 🤓Desafio Feito😎! Minha resolução🎉🎉🎉:
> ## 📋**Modelo Lógico**:  
> ![Desafio_03 - Modelo Lógico](.\imagens\img_Desafio_Suzano_01_eCommerce_Projeto_Conceitual.png)

- Garantiremos a regra de informe apenas do CPF ou CNPJ do cliente com uma Check Constraint nesta tabela.

- Status do Pedido: Solicitado, Aguardando Aprovação, Confirmando Pagamento, Preparando Envio, Enviado p/ Transportadora, Entregue e Cancelado. Também será uma Check Constraint.

- Meio de pagamento: A aplicação irá controla o processo de forma de pagamentos, inclusive garantir que o somatório dos valores de todas os meios de pagamentos utilizados é igual ao valor Total do Pedido. A base de dados disponibilizará em sua estrutura uma tabela com as formas de pagamentos possíveis e outra para relacionar com Pedido, correspondendo as formas de pagamentos utilizadas para pagamento de determinado pedido.

- O código de rastreio da entrega será um campo no pedido.

> ## 📋**Modelo Físico** (Link ⇒ [Script_Geracao_Tabelas_BD_eCommerce.sql](.\scripts\Script_MySQL_Schema_ECommerce_FromDiagram.sql)):  


> ## 📋**Persistindo os dados para testes: **:  
```sql
-- Acessando o Schema ecommerce
use ecommerce;

-- Persistindo dados de Fornecedor
desc fornecedor;
insert into fornecedor
  (idFornecedor, nomeFornecedor, CNPJ)
values
  (null, "Suzano", 123),
  (null, "Mercado Municipal", 456),
  (null, "Latex Cia", 457),
  (null, "Global SA", 458);

select * from fornecedor;

-- Persistindo dados de Cliente
desc cliente;
insert into cliente
  (idCliente, nomeCliente, CPF, CNPJ)
values
  (null, "Roberval Junior", 11, null),
  (null, "Padaria Manuel Ltda", null, 321),
  (null, "Veronica Modas FI", null, 322),
  (null, "Jeniffer Lopes", 12, null),
  (null, "Paola Oliveira", 14, null);

select * from cliente;

-- Persistindo dados de Meios de Pagamento
desc meio_pagamento;
insert into meio_pagamento
  (idMeio_Pagamento, nomeMeio_Pagamento)
values
  (null, "Dinheiro"),
  (null, "Boleto/FCB"),
  (null, "Cheque"),
  (null, "Cartão de Crédito"),
  (null, "Cartão de Débito"),
  (null, "Pix");

select * from meio_pagamento order by 1;

-- Persistindo dados de Endereço do Cliente
desc endereco_cliente;
insert into endereco_cliente
  (idEndereco_Cliente, Cliente_idCliente, Logradouro, Numero, Complemento, CEP, Bairro, Cidade, Estado)
values
  (null, 1, "Av. Professor Magalhães Neto", 1752, "10º andar, salas 1009, 1010 e 1011", "41810012", "Centro", "Salvador", "BA"),
  (null, 1, "Av. Brigadeiro Faria Lima", 1355, "8º andar", "01452919", "Pinheiros", "São Paulo", "SP"),
  (null, 2, "Avenida Embaixador Abelardo Bueno", 425, null, "22775040", "Barra da Tijuca", "Rio de Janeiro", "RJ"),
  (null, 3, "Rua ABC", 33, null, "00000000", "Centro", "Porto Alegre", "RS"),
  (null, 4, "Rua da Felicidade", 150, null, "00000000", "Centro", "Recife", "PE"),
  (null, 5, "Estrada Toneledo", 25, null, "00000000", "Centro", "Campo Grande", "MS");

select * from endereco_cliente;

-- Persistindo dados de Produto
desc produto;
insert into produto
  (idProduto, Fornecedor_idFornecedor, nomeProduto, qtdEstoque)
values
  (null, 1, "Papel A4", 5555),
  (null, 1, "Papel Higiênico", 1575),
  (null, 1, "Embalagem de Papelão", 450),
  (null, 2, "Uniformes", 350),
  (null, 3, "Borrachas", 240),
  (null, 4, "Relógio", 150),
  (null, 4, "Pulseira", 25);

select * from produto;

-- Persistindo dados de Vendedor
desc vendedor;
insert into vendedor
  (idVendedor, nomeVendedor, CNPJ)
values
  (null, "Antonio", 715),
  (null, "Alfredo", 716),
  (null, "Angelina", 717),
  (null, "Vera Lucia", 718),
  (null, "Margarida", 719);

select * from vendedor;

-- Persistindo dados de Pedido
desc pedido;
insert into pedido
  (idPedido, Endereco_Cliente_Cliente_idCliente, Endereco_Cliente_idEndereco_Cliente,
   dataPedido, statusPedido, dataEntrega,
   dataPrazoDevolucao, valorFrete, codigoRastreioEntrega)
values
  (null, 1, 7, "2024-11-01", "Entregue", "2024-11-22", "2024-11-29", 19.90, "XYK79383"),
  (null, 1, 8, "2024-11-25", "Aguardando Aprovação", "2024-12-08", "2024-12-16", 8.70, "B6SDGG978"),
  (null, 2, 9, "2024-11-10", "Entregue", "2024-11-15", "2024-11-22", 14.50, "KDO7866Z"),
  (null, 3, 10, "2024-12-01", "Confirmando Pagamento", "2024-12-05", "2024-12-12", 17.00, "XYK79383"),
  (null, 4, 11, "2024-11-01", "Entregue", "2024-11-22", "2024-11-29", 19.90, "LSD9EN0"),
  (null, 5, 12, "2024-11-01", "Preparando Envio", "2024-11-22", "2024-11-29", 29.90, "93PXKPA3"),
  (null, 1, 7, "2024-11-12", "Solicitado", "2024-11-22", "2024-11-29", 17.80, "PAZME45WZ2"),
  (null, 1, 8, "2024-11-13", "Enviado p/ Transportadora", "2024-11-22", "2024-11-29", 19.90, "OIJGR9043"),
  (null, 2, 9, "2024-12-01", "Aguardando Aprovação", "2024-12-03", null, 11.35, "OSD0W3M"),
  (null, 3, 10, "2024-11-01", "Preparando Envio", "2024-11-22", "2024-11-29", 13.60, "9JCWKNWEC"),
  (null, 4, 11, "2024-11-23", "Cancelado", "2024-11-26", null, 5.70, null),
  (null, 5, 12, "2024-11-01", "Confirmando Pagamento", "2024-11-22", "2024-11-29", 0.00, "8C3NIWEF"),
  (null, 2, 9, "2024-11-01", "Enviado p/ Transportadora", "2024-11-22", "2024-11-29", 17.10, "LKCWFVC091"),
  (null, 1, 7, "2024-11-01", "Solicitado", "2024-11-22", "2024-11-29", 4.90, "561DSCIO35XL");

select * from pedido;

-- Persistindo dados na tabela Item_Pedido
desc item_pedido;
insert into item_pedido
  (Produto_idProduto, Pedido_idPedido, Quatidade, valorUnitario, Vendedor_idVendedor)
values
  (1, 1, 10, 15.00, 1), -- Pedido 1, Produto 1 (Papel A4) vendido por Antonio
  (2, 1, 5, 8.50, 2),  -- Pedido 1, Produto 2 (Papel Higiênico) vendido por Alfredo
  (3, 2, 7, 12.00, 3), -- Pedido 2, Produto 3 (Embalagem de Papelão) vendido por Angelina
  (4, 2, 3, 35.00, 4), -- Pedido 2, Produto 4 (Uniformes) vendido por Vera Lucia
  (5, 3, 20, 2.50, 5), -- Pedido 3, Produto 5 (Borrachas) vendido por Margarida
  (6, 4, 2, 150.00, 1), -- Pedido 4, Produto 6 (Relógio) vendido por Antonio
  (7, 5, 1, 25.00, 2), -- Pedido 5, Produto 7 (Pulseira) vendido por Alfredo
  (1, 6, 15, 14.50, 3), -- Pedido 6, Produto 1 (Papel A4) vendido por Angelina
  (3, 7, 10, 11.75, 4), -- Pedido 7, Produto 3 (Embalagem de Papelão) vendido por Vera Lucia
  (4, 8, 5, 33.00, 5); -- Pedido 8, Produto 4 (Uniformes) vendido por Margarida

select * from item_pedido;

-- Persistindo dados na tabela Pagamento_Pedido
desc pagamento_pedido;
insert into pagamento_pedido
  (idPagamento_Pedido, Pedido_idPedido, Meio_Pagamento_idMeio_Pagamento, valorPagamento, numeroParcelas)
values
  (null, 1, 1, 150.00, 1), -- Pedido 1, pago em dinheiro (1 parcela)
  (null, 2, 4, 200.00, 2), -- Pedido 2, pago no cartão de crédito (2 parcelas)
  (null, 3, 5, 50.00, 1), -- Pedido 3, pago no cartão de débito (1 parcela)
  (null, 4, 3, 300.00, 3), -- Pedido 4, pago em cheque (3 parcelas)
  (null, 5, 6, 25.00, 1), -- Pedido 5, pago via Pix (1 parcela)
  (null, 6, 2, 175.00, 2), -- Pedido 6, pago via boleto (2 parcelas)
  (null, 7, 4, 55.00, 3), -- Pedido 7, pago no cartão de crédito (3 parcelas)
  (null, 8, 1, 80.00, 1); -- Pedido 8, pago em dinheiro (1 parcela)

select * from pagamento_pedido;
```

> ## 📋**Queries elaboradas**:  
```sql
use ecommerce;
-- 1) Recuperações simples com SELECT Statement
-- Listar todos os meios de pagamentos existentes na base
select mp.idMeio_Pagamento as id, mp.nomeMeio_Pagamento as Meio_Pagamento
from ecommerce.meio_pagamento mp
order by 1;

-- 2) Filtros com WHERE Statement
-- Listar os pedido solicitados na 1ª quinzena de novembro de 2024
select p.idPedido, p.dataPedido, p.statusPedido, p.dataEntrega, p.dataPrazoDevolucao, p.valorFrete
from ecommerce.pedido p
where p.dataPedido between "2024-11-01" and "2024-11-15";

-- 3) Crie expressões para gerar atributos derivados
-- Liste os pedidos gerados adicionando
-- 1 coluna com número de dias entre o pedido e a entrega
-- e outra com o número de dias do prazo de devolução
select p.idPedido, p.dataPedido, p.statusPedido, p.dataEntrega, p.dataPrazoDevolucao, p.valorFrete,
       (p.dataEntrega - p.dataPedido) as Num_Dias_Pedido_Entrega, (p.dataPrazoDevolucao - p.dataEntrega) Num_Dias_Prazo_Devoluc
from ecommerce.pedido p;

-- 4) Defina ordenações dos dados com ORDER BY
-- Listar os produtos e seus dados, ordenandos por nome do produto
select p.idProduto as Id, p.nomeProduto as Nome_Produto, p.qtdEstoque as Quantidade_Estoque
from produto p
order by 2;

-- 5) Condições de filtros aos grupos – HAVING Statement
-- Listar pedidos agrupados por data e status do pedido 
-- Totalizando o frente e fazendo a contagem de pedidos por esse agrupamento
-- Apresente apenas os resultados com valores superiores a R$9.00
-- Ordenando o total do frete de forma decrescente
select p.dataPedido as Data_Pedido, p.statusPedido as Status_Pedido,
       sum(p.valorFrete) as Total_Frete, count(distinct p.idPedido) as Quantidade_Pedido
from ecommerce.pedido p
group by p.dataPedido, p.statusPedido
having sum(p.valorFrete) > 9
order by 3 desc;

-- 6) Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados
-- Listar os pedidos, ordenado os pelo nome do cliente e id do pedido.
-- Exiba também a data do pedido. Desconsidere os pedidos cancelados
select c.nomeCliente as Nome_Cliente, p.idPedido as Id_Pedido, p.dataPedido as Data_Pedido
from ecommerce.pedido p
inner join ecommerce.cliente c on p.Endereco_Cliente_Cliente_idCliente = c.idCliente
where p.statusPedido <> "Cancelado"
order by 1, 2;

-- 7) Quantos pedidos foram feitos por cada cliente?
select c.nomeCliente as Nome_Cliente, count(distinct p.idPedido) as Quantidade_Pedido
from ecommerce.pedido p
inner join ecommerce.cliente c on p.Endereco_Cliente_Cliente_idCliente = c.idCliente
group by c.nomeCliente
order by 1;

-- 8) Algum vendedor também é fornecedor?
-- Liste todos que forem ambos
select f.idFornecedor, f.nomeFornecedor, f.CNPJ,
	v.idVendedor, v.nomeVendedor
from ecommerce.fornecedor f
inner join ecommerce.vendedor v on f.CNPJ = v.CNPJ;

-- 9) Relação de produtos, fornecedores e estoques;
select p.idProduto as Id_Produto, p.nomeProduto as Nome_Produto,
       f.nomeFornecedor as Nome_Fornecedor, f.CNPJ as CNPJ, p.qtdEstoque as Quantidade_Estoque
from ecommerce.produto p
inner join ecommerce.fornecedor f on p.Fornecedor_idFornecedor = f.idFornecedor
order by p.nomeProduto, f.nomeFornecedor;


-- 10) Relação de nomes dos fornecedores e nomes dos produtos;
select f.nomeFornecedor as Nome_Fornecedor, p.nomeProduto as Nome_Produto
from ecommerce.produto p
inner join ecommerce.fornecedor f on p.Fornecedor_idFornecedor = f.idFornecedor
order by f.nomeFornecedor, p.nomeProduto;
```

Script com inserts para persistência dos dados de testes e Queries elaboradas conforme proposta do desafio:  
[Script_Desafio3_Entrega_Solucao.SQL](./scripts/Script_MySQL_Schema_ECommerce_Inserts_Queries_Desafio3.sql)

❗👏🎉Fim do Desafio 03