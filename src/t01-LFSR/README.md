# README

Nas pastas `sw` e `hw` estão apenas os arquivos criados por mim.
O arquivo compactado snios.rar contém o projeto completo.

Vale notar que talvez caminhos devam ser atualizados para compilá-lo corretamente.
A pasta estava inicialmente no caminho [/d/Pastas/snios].

**NÃO DESCOMPACTAR A PASTA DE `snios.rar` EM UM CAMINHO LONGO POIS DÁ ERRO DE PATH MUITO LONGO AO TENTAR RODAR O PROGRAMA. DESCOMPACTAR A PASTA EM UM CAMINHO PRÓXIMO DA RAIZ.**

## Instruções apoós descompactar

É necessário o Quartus 13 para simulação

Para rodar a simulação e reproduzir os resultados obtidos:
1. Abrir o projeto no Quartus ([SimpleNios.qsf](SimpleNios.qsf))
2. Abrir o Qsys (Tools->Qsys)
3. Gerar os componentes (Aba Generation->Genarate)
4. Abrir o Eclipse a partir do Qsys (Tools -> Nios II Software Build Tools Eclipse)
5. Gerar o BSP (botão direito no projeto BSP -> Nios II -> Generate BSP)
6. Dar build no projeto (Project -> Build All com o projeto sem BSP selecionado)
7. Dar run no projeto (Run -> Nios II Modelsim)

O software e o hardware são integrados no sentido dos registradores que utilizam.
Para qualquer alteração no software ou no hardware é necessário garantir que os registradores/endereços utilizados sejam os mesmos para ambos.

A interface do hardware:
* só gera números caso o endereço seja o de leitura da geração de números aleatórios (addr=00) e seja uma leitura (rd_en=1).
* só escreve seed caso o endereço seja o correto da seed (addr=00) e seja uma operação de escrita (wr_en=1)
* só escreve a geração de número aleatórios caso o endereço seja o correto da geração (addr=01) e seja uma operação de escrita (wr_en=1)
