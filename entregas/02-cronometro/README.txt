Entregas: Arquivos do projeto, resultados da simulação, "screenshots" do funcionamento e do signal tap 

Os arquivos do projeto estão zipados em "02-cronometro_source.rar"
A simulação no multisim está no arquivo "02-snapshot-modelsim.png", mostrando a correta soma de números 
a partir dos centésimos até a dezena
O arquivo .do foi copiado da pasta "simulation" do .rar

Levei em consideração que o clock já entra no "cont6000.vhd" com frequência de subida de 1 centésimo de segundo.
Caso não entre, basta fazer um divisor de clock anteriormente (seguindo a mesma lógica do contador) e então passar 
esse sinal para o componente.