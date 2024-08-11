`timescale 1ns/1ps

module top_tb();


proj_module mod_inst (
    .clk(tb_clk),
    .data_in(r_in),
    .data_out(w_out)
);

always
begin
    #18 tb_clk <= ~tb_clk;
end

initial
begin
    #100 //nanoseconds
    repeat(3) @(posedge tb_clk); //clk cycles
    ...
    assert(w_out == 1'b1);
    $finish;
end

initial
begin
    $dumpfile("top_tb.vcd");
    $dumpvars;
end

endmodule
