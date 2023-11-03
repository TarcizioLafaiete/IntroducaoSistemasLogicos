`timescale 1ns/1ps
module tesbanch;
//Password CBABC
localparam half_period = 10;
localparam period = 20;
localparam nulo = 2'b00;
localparam A = 2'b01;
localparam B = 2'b10;
localparam C = 2'b11;
reg clk;
reg [1:0] digito;
reg reset;
wire led;
cofre_behavorial test(
    .clk(clk),
    .reset(reset),
    .digito(digito),
    .led(led)
);
always begin
    clk = 1'b1;
    #half_period;
    clk = 1'b0;
    #half_period;
end
always begin
    reset = 1'b1;
    digito = nulo;
    #period;
    digito = C;
    #period;
    digito = A;
    #period
    digito = A;
    #period
    digito = C;
    #period
    digito = B;
    #period
    digito = nulo;
    #period
    digito = nulo;
    #period;
    digito  = A;
    #period;
    digito = nulo;
    #period;
    digito = B;
    #period;
    digito = C;
    #period;
    digito = B;
    #period;
    reset = 1'b0;
    #period;
end
endmodule