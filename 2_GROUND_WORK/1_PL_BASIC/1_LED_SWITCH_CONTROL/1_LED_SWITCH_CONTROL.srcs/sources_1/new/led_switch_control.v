`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/03 22:38:49
// Design Name: 
// Module Name: led_switch_control
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


module led_switch_control(
    // port list
    sw,
    led
);
// portdeclaration
input   [3:0] sw    ;
output  [3:0] led   ;

// modeling(data flow modeling)
assign led = sw     ;

endmodule
