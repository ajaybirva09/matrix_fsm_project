module matrix_fsm (
  input clk,
  input rst,
  input start,
  input [7:0] A11, A12, A21, A22,
  input [7:0] B11, B12, B21, B22,
  output reg done,
  output reg [15:0] C11, C12, C21, C22
);

  typedef enum reg [2:0] {
    IDLE, LOAD, MULT, STORE, DONE
  } state_t;

  state_t state = IDLE;

  reg [7:0] a11, a12, a21, a22;
  reg [7:0] b11, b12, b21, b22;

  reg [15:0] temp_C11, temp_C12, temp_C21, temp_C22;

  function [15:0] MAC;
    input [7:0] m1, m2, m3, m4;
    begin
      MAC = m1 * m2 + m3 * m4;
    end
  endfunction

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= IDLE;
      done <= 0;
    end else begin
      case (state)
        IDLE: begin
          done <= 0;
          if (start)
            state <= LOAD;
        end
        LOAD: begin
          a11 <= A11; a12 <= A12;
          a21 <= A21; a22 <= A22;
          b11 <= B11; b12 <= B12;
          b21 <= B21; b22 <= B22;
          state <= MULT;
        end
        MULT: begin
          temp_C11 <= MAC(a11, b11, a12, b21);
          temp_C12 <= MAC(a11, b12, a12, b22);
          temp_C21 <= MAC(a21, b11, a22, b21);
          temp_C22 <= MAC(a21, b12, a22, b22);
          state <= STORE;
        end
        STORE: begin
          C11 <= temp_C11;
          C12 <= temp_C12;
          C21 <= temp_C21;
          C22 <= temp_C22;
          state <= DONE;
        end
        DONE: begin
          done <= 1;
          state <= IDLE;
        end
      endcase
    end
  end
endmodule
