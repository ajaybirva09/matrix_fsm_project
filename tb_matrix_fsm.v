`timescale 1ns/1ps
module tb_matrix_fsm;

  reg clk = 0;
  always #5 clk = ~clk;

  reg rst = 0;
  reg start = 0;
  reg [7:0] A11 = 2, A12 = 3, A21 = 4, A22 = 1;
  reg [7:0] B11 = 5, B12 = 6, B21 = 7, B22 = 8;
  wire done;
  wire [15:0] C11, C12, C21, C22;

  matrix_fsm uut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .A11(A11), .A12(A12), .A21(A21), .A22(A22),
    .B11(B11), .B12(B12), .B21(B21), .B22(B22),
    .done(done),
    .C11(C11), .C12(C12), .C21(C21), .C22(C22)
  );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_matrix_fsm);
    
    rst = 1; #10; rst = 0;
    start = 1; #10; start = 0;

    wait (done == 1);
    #10;

    $display("Matrix C Output:");
    $display("C11 = %d", C11);  // 2*5 + 3*7 = 31
    $display("C12 = %d", C12);  // 2*6 + 3*8 = 36
    $display("C21 = %d", C21);  // 4*5 + 1*7 = 27
    $display("C22 = %d", C22);  // 4*6 + 1*8 = 32

    $finish;
  end
endmodule
