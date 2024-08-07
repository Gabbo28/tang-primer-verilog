`timescale 1ns/1ps

module tx_tb();

reg tb_clk = 1'b1;
reg tb_en = 1'b0;

uart_tx txi (
    .clk(tb_clk),
    .data_in(8'hAA),
    .en(tb_en)
);

always
begin
    #18 tb_clk <= ~tb_clk;
end

initial
begin
    #100
    tb_en <= 1'b1;
    #100
    tb_en <= 1'b0;
    #200000
    $finish;
end

initial
begin
    $dumpfile("tx_tb.vcd");
    $dumpvars(1,txi);
end

endmodule
