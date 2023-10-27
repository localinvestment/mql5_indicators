#property indicator_chart_window         
#property version "1.0"

#property indicator_buffers 5
#property indicator_plots   1  
#property indicator_width1  3              
#property indicator_type1 DRAW_COLOR_CANDLES
           


input color color_london    = clrRed;
input color color_new_york  = clrBlack;
input color color_default   = clrLightSlateGray;

double buf_open[],buf_high[],buf_low[],buf_close[];
double buf_color_line[];

int OnInit()
{
   SetIndexBuffer( 0, buf_open,  INDICATOR_DATA );
   SetIndexBuffer( 1, buf_high,  INDICATOR_DATA );
   SetIndexBuffer( 2, buf_low,   INDICATOR_DATA );
   SetIndexBuffer( 3, buf_close, INDICATOR_DATA );
   
   SetIndexBuffer( 4, buf_color_line, INDICATOR_COLOR_INDEX );
   
   PlotIndexSetInteger( 0, PLOT_COLOR_INDEXES, 4 );
   PlotIndexSetInteger( 0, PLOT_LINE_COLOR, 0, color_default );
   PlotIndexSetInteger( 0, PLOT_LINE_COLOR, 1, color_london );
   PlotIndexSetInteger( 0, PLOT_LINE_COLOR, 2, color_new_york );

   return(0);
}

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  { 
 
   MqlDateTime time_open;
   for( int i = prev_calculated; i <= rates_total - 1; i++ )
   { 
      buf_open[i]    = open[i];
      buf_high[i]    = high[i];
      buf_low[i]     = low[i];
      buf_close[i]   = close[i]; 
      
      TimeToStruct( time[ i ], time_open );
      
      switch( time_open.hour )
      {
         case 10 :
            buf_color_line[ i ] = 1;
            break;
            
         case 15 :
            buf_color_line[ i ] = 2;
            break;
      
         default :
            buf_color_line[ i ] = 0;
      }  
   }

   return( rates_total - 1 );
}
