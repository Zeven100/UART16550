`include "uart_tx_top.sv"
module uart_tx_tb ();

reg clk , rst , baud_pulse , pen , thre , stb , stick_parity , eps  , set_break ;
reg[7:0] din ;
reg [1:0] wls ;
wire pop , sreg_empty , tx ;

uart_tx_top tx_dut(clk , rst , baud_pulse , pen , thre 
, stb , stick_parity , eps , set_break , din , wls , pop , sreg_empty, tx) ;
     
initial begin
     rst = 0 ;
     clk = 0 ;
     baud_pulse = 0 ;
     pen = 1'b1 ;
     thre = 0 ;
     stb = 1 ; /// stop will be for 2-bit duration
     stick_parity = 0 ; /// sticky parity is off
     eps = 1 ; /// even parity
     set_break = 0 ;
     din = 8'h13 ;
     wls = 2'b11 ;/// data width : 8-bits
end
///////////////

always #5 clk = ~clk ;
/////////////
initial begin
     rst = 1'b1 ;
     repeat(5)@(posedge clk);
     rst = 0 ;
end
// 00010011
/////////////////
integer count = 5 ;

always @(posedge clk)begin
     if(rst == 0)begin
          if(count != 0)begin
               count <= count - 1 ;
               baud_pulse <= 1'b0 ;

          end
          else begin
               count <= 5 ;
               baud_pulse <= 1'b1 ;
               
          end
     end
end


endmodule