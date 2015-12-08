Binários
======

## Changelog

### 20151207(07/12/2015)

- resolvidos 3 bugs no blending do VirtualSensorNet: no agendador de tarefas, nos parâmetros repetidos e trocados
- incluído busca de link com query strings omcp://virtualsensornet.osiris/link/?sensor={id}&collector={id}&network={id}
- pequenas alterações na api 

### 20150722(22/07/2015)

- Tentativa de sanar o bug do loop ao incializar os módulos 
- mudanças internas no omcp
- mudanças em algumas propriedades da api
- criação de exchanges de forma automatizada pelo sensornet e virtualsensornet

### 20150427(09/05/2015)

- implementado a busca de histórico no SensorNet e VirtualSensorNet

### 20150427(27/04/2015)

- blending funcionando no virtualsensornet síncrona e assincronamente
- adição de exemplos dos módulos de função para o blending
- adição de um grupo de exemplos de requisições para o virtualsensornet
- mudanças na api
- remoção de fila temporária no omcp quando requisitando pelo cliente 

### 20151104(04/11/2015)

- atualização da API
- correção do bug do virtualsensornet no consumo de memoria e armazenamento de revisões
- descoberto bug de valores strings
- sensornet ainda não corrigido o armazenamento de revisões