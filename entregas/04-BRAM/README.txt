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

------------------------- Explicação -------------------------

Os arquivos são os seguintes:

* BRAM_tb_prof: contém a implementação do testbench do professor (corrigido, inicializando o address em 0). Para simular, alterar o nome do arquivo para BRAM_tb.vhd
* BRAM_tb: contém a implementação do testbench para meu nome
* RAM_1_port: RAM criada pelo Wizard. q=8, 1024 endereços e para Cyclone II
* BRAM: Implementação da BRAM fornecida pelo professor, conectando-se com a RAM

Também é disponibilizado um .do para simulação em gate level.

Não entendi muito bem o comportamento dos sinais para RST e CS. 
No caso de RST alto, fiz com que a RAM não escreva ou leia (READDATA é 0x00 e WR_EN é baixo).
No caso de CS baixo, fiz com que a RAM não altere o sinal de READDATA, mas que não escreva (WR_EN é baixo).

O screeshot "04-BRAM_tb_prof.PNG" mostra a simulação feita com o testbench do professor para gate level.

Após isso, o testbench foi alterado para escrever "Waine Oliveira Junior +++--+++ ". 
Foram feitas modificações mínimas nos estados e também adicionadas algumas variáveis auxiliares para escrever o nome.

O screenshot "04-BRAM_tb_nome.PNG" mostra a simulação feita com o testbench modificado para gate level.
