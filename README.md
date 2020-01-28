# Cruzamento de Médias

Os dois EAs foram programados utilizando mq5.
- Duas médias: São criadas duas médias, cada uma delas pode ter seus períodos alterados por input (originalmente 8 e 21), mas para o funcionamento adequado os períodos menor e maior devem ser respeitados.
Quando a média de menor período cruzar a de maior período para cima, é executada uma ordem de compra com 500 pontos de stop loss e 500 pontos de take profit, analogamente para a o cruzamento contrário.

- Três Médias: São criadas três médias, uma com um período menor, outra com um período intermediário e uma terceira com um período maior, que podem ser alteradas por meio de input (originalmente 3, 8 , 21), os períodos menor, intermediário e maior devem ser respeitados. 
Quando a média menor cruza a intermediária é definida a tendência vigente entre tendência de alta e de baixa, caso a media maior cruze a menor no mesmo sentido da tendência é aberta uma ordem de compra em tendência e alta e de venda em tendência de baixa, com stop loss e take profit definidos por input.
