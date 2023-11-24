#property indicator_chart_window         
#property version "1.0"

#property indicator_buffers 5
#property indicator_plots   1  
#property indicator_width1  3              
#property indicator_type1 DRAW_COLOR_CANDLES
           
input color color_london    = clrRed;
input color color_new_york  = clrBlack;
input color color_default   = clrSilver;

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

int calcLondon(datetime _date)
{
   int result = -1;
   
   if(_date >= D'2020.03.29 01:00' && _date < D'2020.10.25 02:00') result = 10;
   if(_date >= D'2020.10.25 02:00' && _date < D'2021.03.28 01:00') result = 11;
   if(_date >= D'2021.03.28 01:00' && _date < D'2021.10.31 02:00') result = 10;
   if(_date >= D'2021.10.31 02:00' && _date < D'2022.03.27 01:00') result = 11;
   if(_date >= D'2022.03.27 01:00' && _date < D'2022.10.30 02:00') result = 10;
   if(_date >= D'2022.10.30 02:00' && _date < D'2023.03.26 01:00') result = 11;
   if(_date >= D'2023.03.26 01:00' && _date < D'2023.10.29 02:00') result = 10;
   if(_date >= D'2023.10.29 02:00' && _date < D'2024.03.31 01:00') result = 11;
   if(_date >= D'2024.03.31 01:00' && _date < D'2024.10.27 02:00') result = 10;
   if(_date >= D'2024.10.27 02:00' && _date < D'2025.03.30 01:00') result = 11;
   if(_date >= D'2025.03.30 01:00' && _date < D'2025.10.26 02:00') result = 10;
   if(_date >= D'2025.10.26 02:00' && _date < D'2026.03.29 01:00') result = 11;
   if(_date >= D'2026.03.29 01:00' && _date < D'2026.10.25 02:00') result = 10;
   
   return result;
}

int calcNewYork(datetime _date)
{
   int result = -1;
   
   if(_date >= D'2020.03.08 02:00' && _date < D'2020.11.01 02:00') result = 15;
   if(_date >= D'2020.11.01 02:00' && _date < D'2021.03.14 02:00') result = 16;
   if(_date >= D'2021.03.14 02:00' && _date < D'2021.11.07 02:00') result = 15;
   if(_date >= D'2021.11.07 02:00' && _date < D'2022.03.13 02:00') result = 16;
   if(_date >= D'2022.03.13 02:00' && _date < D'2022.11.06 02:00') result = 15;
   if(_date >= D'2022.11.06 02:00' && _date < D'2023.03.12 02:00') result = 16;
   if(_date >= D'2023.03.12 02:00' && _date < D'2023.11.05 02:00') result = 15;
   if(_date >= D'2023.11.05 02:00' && _date < D'2024.03.10 02:00') result = 16;
   if(_date >= D'2024.03.10 02:00' && _date < D'2024.11.03 02:00') result = 15;
   if(_date >= D'2024.11.03 02:00' && _date < D'2025.03.09 02:00') result = 16;
   if(_date >= D'2025.03.09 02:00' && _date < D'2025.11.02 02:00') result = 15;
   if(_date >= D'2025.11.02 02:00' && _date < D'2026.03.08 02:00') result = 16;
   if(_date >= D'2026.03.08 02:00' && _date < D'2026.11.01 02:00') result = 15;
   
   return result;
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
      
      if( time_open.hour == calcLondon( time[ i ] ) )
      {
         buf_color_line[ i ] = 1;
      }     
      else if( time_open.hour == calcNewYork( time[ i ] ) )
      {
         buf_color_line[ i ] = 2;
      }
      else
      {
         buf_color_line[ i ] = 0;
      }  
   }

   return( rates_total - 1 );
}
