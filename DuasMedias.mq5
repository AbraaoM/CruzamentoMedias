//+------------------------------------------------------------------+
//|                                                   DuasMedias.mq5 |
//|                                                   Abraão Moreira |
//|                                      abraaol.moreira@outlook.com |
//+------------------------------------------------------------------+
#property copyright "Abraão Moreira"
#property link      "abraaol.moreira@outlook.com"
#property version   "1.00"

#include <Trade\Trade.mqh>
CTrade trade;

int smallerAvgHandle = 0, biggerAvgHandle = 0;
double smallerAvgBuffer[], biggerAvgBuffer[];
input int smallerAvg = 3;
input int biggerAvg = 8;
string trend = "";
double amount = 20;
double ask = 0, bid = 0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
  ArraySetAsSeries(smallerAvgBuffer, true);
  ArraySetAsSeries(biggerAvgBuffer, true);

  smallerAvgHandle = iMA(_Symbol, _Period, smallerAvg, 0, MODE_SMA, PRICE_CLOSE);
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
  CopyBuffer(biggerAvgHandle, 0, 0, 3, biggerAvgBuffer);

  ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
  bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);

  if(PositionsTotal() == 0) {
    if(smallerAvgBuffer[1] > biggerAvgBuffer[1] && smallerAvgBuffer[2] < biggerAvgBuffer[2]) {
      trade.Buy(amount, NULL, ask, ask - 500*_Point, ask + 500*_Point, "Compra");
    }
    if(smallerAvgBuffer[1] < biggerAvgBuffer[1] && smallerAvgBuffer[2] > biggerAvgBuffer[2]) {
      trade.Sell(amount, NULL, bid, bid + 500*_Point, bid - 500*_Point, "Venda");
    }
  }


}
//+------------------------------------------------------------------+
