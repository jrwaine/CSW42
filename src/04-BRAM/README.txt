4 BRAM instanciação, implementação e teste 24/07/2021

A intenção deste projeto é familiarizar os alunos com as seguintes questões
1) Instanciação de blocos especializados (no caso Block RAMs) com a ajuda de "wizards" do Quartus
2) Interação de blocos criados pelos alunos com um testbench que emula a interface com o NIOS
3) Codificação em VHDL para interfaceamento com o microprocessador NIOS  (neste caso simulado pelo TB)

Especificação do projeto:
_ Implementar o componente BRAM, utilizando-se de uma Block Ram de 1024 x 8. Este componente deve interagir com o tb fornecido
_ Esta implementação da BRAM deve ser capaz de receber um dado (CS, WR_EN, ADD, WRITEDATA) e gravá-lo na posição indicada por ADD. Deve também ser capaz de ler uma posição de memória ( CS, RD_EN, ADD) e devolvê-lo ao TB no sinal READDATA
_ Modificar o TB para que ele continuamente escreva o nome completo de cada aluno (sem acentuação) em ASCII. Os nomes parciais devem ser separados por espaços e entre os nomes completos deve haver uma sequencia de 
"espaço +++--+++ espaço" que dá um total de 10 caracteres.
Exemplo :    '  'JOAO' 'DA' 'SILVA'  ' +++--+++' ' '  'JOAO' 'DA' 'SILVA'  ' +++--+++' ' ....
_ para verificar o funcionamento, a string acima deve aparecer no sinal READDATA
_ O TB atual faz escritas e leituras intercaladas. Deve ser modificado para fazer 1024 escritas e depois 1024 leituras.
Sugestão: utilizar o TB como está para verificações prévias.  Quando estas verificações  estiverem OK, completar as mudanças no TB

ENTREGAS:
1) Projeto do Quartus / Modelsim completo (compactar o diretório inteiro)
2) Evidências de execução (prints das telas evidenciando os aspectos relevantes da implementação e teste)
A tarefa é individual.