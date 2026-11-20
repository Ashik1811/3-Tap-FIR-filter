// --- 1. Supporting Modules ---

// full adder (fa)
module fa(output sum, output cout,
input x, input y, input cin);
wire prop, gen, pr_cin;
xor x1(prop, x, y);
xor x2(sum, prop, cin);
and and1(pr_cin, prop, cin);
and a2(gen, x, y);
or o1(cout, gen, pr_cin);
endmodule

// 8-bit DFF (parallel)
module DFF8(input clk, input [7:0] D, output reg [7:0] Q);
always @(posedge clk) Q <= D;
endmodule

// 16-bit DFF (parallel)
module DFF16(input clk, input [15:0] D, output reg [15:0] Q);
always @(posedge clk) Q <= D;
endmodule

// 16-bit Ripple Carry Adder (RCA)
module RCA(output [15:0] sum, output cout,
input [15:0] a, input [15:0] b, input cinput);
wire c0 = cinput;
wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16;
fa fa0(sum[0], c1, a[0], b[0], c0);
fa fa1(sum[1], c2, a[1], b[1], c1);
fa fa2(sum[2], c3, a[2], b[2], c2);
fa fa3(sum [3], c4, a[3], b[3], c3);
fa fa4(sum[4], c5, a[4], b[4], c4);
fa fa5(sum [5], c6, a[5], b[5], c5);
fa fa6(sum[6], c7, a[6], b[6], c6);
fa fa7(sum [7], c8, a[7], b[7], c7);
fa fa8(sum[8], c9, a[8], b[8], c8);
fa fa9(sum[9], c10, a[9], b[9], c9);
fa fa10(sum [10], c11, a[10], b[10], c10);
fa fa11(sum[11], c12, a [11], b[11], c11);
fa fa12(sum[12], c13, a[12], b[12], c12);
fa fa13(sum [13], c14, a[13], b[13], c13);
fa fa14(sum [14], c15, a [14], b[14], c14);
fa fa15(sum[15], c16, a [15], b[15], c15);
assign cout = c16;
endmodule

// --- 2. Structural N-bit Multiplier Module ---

module n_bit_multiplier #(
    parameter N = 16 
)(
    input clk,                   
    input [N-1:0] a,             
    input [N-1:0] b,             
    output reg [2*N-1:0] product 
);

    reg [N-1:0] a_reg, b_reg;
    reg [2*N-1:0] product_comb; 

    wire [2*N-1:0] partial_products [0:N-1]; 
    wire [2*N-1:0] sums [0:N-1];            
    wire [2*N-1:0] carries [0:N-1];         

    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1) begin : partial_gen
            for (j = 0; j < N; j = j + 1) begin : bit_gen
                assign partial_products[i][j + i] = a_reg[j] & b_reg[i]; 
            end
            for (j = 0; j < i; j = j + 1) begin : zero_low
                assign partial_products[i][j] = 1'b0;
            end
            for (j = i + N; j < 2*N; j = j + 1) begin : zero_high
                assign partial_products[i][j] = 1'b0;
            end
        end
    endgenerate

    assign sums[0] = partial_products[0];
    assign carries[0] = {2*N{1'b0}}; 

    generate
        for (i = 1; i < N; i = i + 1) begin : sum_gen
            wire [2*N-1:0] add_result;
            wire [2*N-1:0] add_carry;

            assign {add_carry[0], add_result[0]} = sums[i-1][0] + partial_products[i][0] + carries[i-1][0];
            for (j = 1; j < 2*N; j = j + 1) begin : adder_chain
                assign {add_carry[j], add_result[j]} = sums[i-1][j] + partial_products[i][j] + add_carry[j-1];
            end

            assign sums[i] = add_result;
            assign carries[i] = add_carry;
        end
    endgenerate

    always @(*) begin
        product_comb = sums[N-1];
    end

    always @(posedge clk) begin
        a_reg <= a;             
        b_reg <= b;             
        product <= product_comb; 
    end

endmodule

// --- 3. Top Level FIR Filter Module (DUT) ---

module fir_3tap(
input clk,
input [7:0] Xin,
input [7:0] H0,
input [7:0] H1,
input [7:0] H2,
output [15:0] Yout
);

// Delays for taps
wire [7:0] x_d1, x_d2;
DFF8 dff_x1(.clk(clk), .D(Xin), .Q(x_d1));
DFF8 dff_x2(.clk(clk), .D(x_d1), .Q(x_d2));

// Multipliers for each tap - USING n_bit_multiplier (N=8)
wire [15:0] M0, M1, M2;
n_bit_multiplier #(8) mul0(.clk(clk), .a(Xin),  .b(H0), .product(M0)); // X[n]*H0
n_bit_multiplier #(8) mul1(.clk(clk), .a(x_d1), .b(H1), .product(M1)); // X[n-1]*H1
n_bit_multiplier #(8) mul2(.clk(clk), .a(x_d2), .b(H2), .product(M2)); // X[n-2]*H2

// Add MO + M1 -> s1, then s1 + M2 -> s2
wire [15:0] s1, s2;
wire ctmp1, ctmp2;
RCA r1(.sum(s1), .cout(ctmp1), .a(M0), .b(M1), .cinput(1'b0));
RCA r2(.sum(s2), .cout(ctmp2), .a(s1), .b(M2), .cinput(1'b0));

// Register final output
DFF16 dff_out(.clk(clk), .D(s2), .Q(Yout));

endmodule


