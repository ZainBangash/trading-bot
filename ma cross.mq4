//+------------------------------------------------------------------+
//|                                                     ma cross.mq4 |
//|                                                              ZYS |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "ZYS"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
datetime dt;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
int OnInit()
   {
//---
   dt = Time [0];
//--- 
   return(INIT_SUCCEEDED);
   }

void OnDeinit(const int reason){

}

void OnTick(){
   if (isnewbar()){
      double prev_ma10 = iMA(NULL, PERIOD_CURRENT, 10, 0, MODE_SMA, PRICE_CLOSE, 2);
      double prev_ma5 = iMA(NULL, PERIOD_CURRENT, 5, 0, MODE_SMA, PRICE_CLOSE, 2);
      double ma10 = iMA(NULL, PERIOD_CURRENT, 10, 0, MODE_SMA, PRICE_CLOSE, 1);
      double ma5 = iMA(NULL, PERIOD_CURRENT, 5, 0, MODE_SMA, PRICE_CLOSE, 1);
      
      if(prev_ma10 > prev_ma5 && ma10 < ma5){
         if(OrdersTotal()!=0) closeexisting();
         
         OrderSend(Symbol(), OP_BUY, 0.01, Ask, 10, 0, 0);
      }
      else if (prev_ma10 < prev_ma5 && ma10 > ma5){
         if(OrdersTotal()!=0) closeexisting();
         
         OrderSend(Symbol(), OP_SELL, 0.01, Bid, 10, 0, 0); 
      }
      
   }
}

void closeexisting(){
   OrderSelect(0, SELECT_BY_POS);
   OrderClose(OrderTicket(), OrderLots(), MarketInfo(Symbol(), MODE_BID+OrderType()), 10);
}

bool isnewbar(){
   if (Time[0] != dt){
      dt = Time[0];
      return true;
   }
   return false;
}
//---    
  
//+------------------------------------------------------------------+
