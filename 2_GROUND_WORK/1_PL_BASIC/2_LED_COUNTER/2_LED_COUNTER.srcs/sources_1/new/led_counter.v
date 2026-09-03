`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/03 23:20:12
// Design Name: 
// Module Name: led_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module led_counter(
    // port list
    clk     , // 125MHz, 8ns
    btn0    , // btn for physical rst
    led       // led0 ~ led3
);
// port declaration
input               clk         ;
input               btn0        ; 
output [3:0]        led         ;

reg    [26:0]       cnt         ; // clog(124_999_999)
reg    [1:0]        idx         ;
reg    [3:0]        led         ; // overriding
always @(posedge clk, posedge btn0) 
begin
    if (btn0 == 1) // rst ON
    begin
        cnt <= 27'd0;
        idx <= 2'd0;
        led <= 4'b0000;
    end
    else // rst OFF
    begin
        if (cnt == 27'd124_999_999) // 1sec
        begin
            cnt <= 27'd0            ;
            idx <= idx + 1'b1       ;
            led <= 4'b0001 << idx   ;
        end
        else
        begin
            cnt <= cnt + 1'b1       ;
        end
    end
    
end

endmodule
