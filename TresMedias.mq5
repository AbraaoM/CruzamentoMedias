//+------------------------------------------------------------------+
//|                                                   TresMedias.mq5 |
//|                                                   Abraão Moreira |
//|                                      abraaol.moreira@outlook.com |
//+------------------------------------------------------------------+
#property copyright "Abraão Moreira"
#property link      "abraaol.moreira@outlook.com"
#property version   "1.00"

#include <Trade\Trade.mqh>
CTrade trade;

//Parâmetros de entrada para três médias, da quantidade de papeis a serem negociados e dos niveis em pontos de sl e tp
input int smallerAvg = 3;
input int interAvg = 8;
input int biggerAvg = 21;
input double amount = 20;
input double sl = 150;
input double tp = 300;

int smallerAvgHandle = 0, interAvgHandle = 0, biggerAvgHandle = 0;
double smallerAvgBuffer[], interAvgBuffer[], biggerAvgBuffer[];
string trend = "";
double ask = 0, bid = 0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
  ArraySetAsSeries(smallerAvgBuffer, true);
  ArraySetAsSeries(interAvgBuffer, true);
  ArraySetAsSeries(biggerAvgBuffer, true);

  smallerAvgHandle = iMA(_Symbol, _Period, smallerAvg, 0, MODE_SMA, PRICE_CLOSE);
  interAvgHandle = iMA(_Symbol, _Period, interAvg, 0, MODE_SMA, PRICE_CLOSE);
  biggerAvgHandle = iMA(_Symbol, _Period, biggerAvg, 0, MODE_SMA, PRICE_CLOSE);
  return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
//---

}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
  CopyBuffer(smallerAvgHandle, 0, 0, 3, smallerAvgBuffer);
  CopyBuffer(interAvgHandle, 0, 0, 3, interAvgBuffer);
  CopyBuffer(biggerAvgHandle, 0, 0, 3, biggerAvgBuffer);

  ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
  bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);

  if(PositionsTotal() == 0) {
    if(smallerAvgBuffer[1] > interAvgBuffer[1] && smallerAvgBuffer[2] < interAvgBuffer[2]) {
      trend = "bull";
    }
    if(smallerAvgBuffer[1] < interAvgBuffer[1] && smallerAvgBuffer[2] > interAvgBuffer[2]) {
      trend = "bear";
    }
    if(interAvgBuffer[1] < biggerAvgBuffer[1] && interAvgBuffer[2] > biggerAvgBuffer[2] && trend == "bull"){
      trade.Buy(amount, NULL, ask, ask - sl*_Point, ask + tp*_Point, "Compra");
    }
    if(interAvgBuffer[1] > biggerAvgBuffer[1] && interAvgBuffer[2] < biggerAvgBuffer[2] && trend == "bear"){
      trade.Sell(amount, NULL, bid, bid + sl*_Point, bid - tp*_Point, "Venda");
    }
  }


}
//+------------------------------------------------------------------+
