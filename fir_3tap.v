// -------------------- full adder (fa) --------------------
module fa(output sum, output cout,
input x, input y, input cin);
wire prop, gen, pr_cin;
xor x1(prop, x, y);
xor x2(sum, prop, cin);
and and1(pr_cin, prop, cin);
and a2(gen, x, y);
or o1(cout, gen, pr_cin);
endmodule
// -------------------- 8-bit DFF (parallel) --------------------
module DFF8(input clk, input [7:0] D, output reg [7:0] Q);
always @(posedge clk) Q <= D;
endmodule
// -------------------- 16-bit DFF (parallel) --------------------
module DFF16(input clk, input [15:0] D, output reg [15:0] Q);
always @(posedge clk) Q <= D;
endmodule
// -------------------- 16-bit Ripple Carry Adder (structural) --------------------
module RCA(output [15:0] sum, output cout,
input [15:0] a, input [15:0] b, input cinput);
wire c0 = cinput;
wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16;
fa fa0(sum[0], c1, a[0], b[0], c0);
fa fa1(sum[1], c2, a[1], b[1], c1);
fa fa2(sum[2], c3, a[2], b[2], c2);
fa fa3(sum[3], c4, a[3], b[3], c3);
fa fa4(sum[4], c5, a[4], b[4], c4);
fa fa5(sum[5], c6, a[5], b[5], c5);
fa fa6(sum[6], c7, a[6], b[6], c6);
fa fa7(sum[7], c8, a[7], b[7], c7);
fa fa8(sum[8], c9, a[8], b[8], c8);
fa fa9(sum[9], c10, a[9], b[9], c9);
fa fa10(sum[10], c11, a[10], b[10], c10);
fa fa11(sum[11], c12, a[11], b[11], c11);
fa fa12(sum[12], c13, a[12], b[12], c12);
fa fa13(sum[13], c14, a[13], b[13], c13);
fa fa14(sum[14], c15, a[14], b[14], c14);
fa fa15(sum[15], c16, a[15], b[15], c15);
assign cout = c16;
endmodule// -------------------- Braun Multiplier 8x8 (structural) --------------------
module braun_multiplier(input [7:0] a, input [7:0] b, output [15:0] prod);
wire [62:0] prod_buffer;
wire [54:0] carry_buffer;
wire [41:0] sum_buffer;
// partial products (64 ANDs)
and a1(prod[0], a[0], b[0]);
and a2(prod_buffer[0], a[1], b[0]);
and a3(prod_buffer[1], a[0], b[1]);
and a4(prod_buffer[2], a[2], b[0]);
and a5(prod_buffer[3], a[1], b[1]);
and a6(prod_buffer[4], a[0], b[2]);
and a7(prod_buffer[5], a[3], b[0]);
and a8(prod_buffer[6], a[2], b[1]);
and a9(prod_buffer[7], a[1], b[2]);
and a10(prod_buffer[8], a[0], b[3]);
and a11(prod_buffer[9], a[3], b[1]);
and a12(prod_buffer[10], a[2], b[2]);
and a13(prod_buffer[11], a[1], b[3]);
and a14(prod_buffer[12], a[3], b[2]);
and a15(prod_buffer[13], a[2], b[3]);
and a16(prod_buffer[14], a[3], b[3]);
and a17(prod_buffer[15], a[4], b[0]);
and a18(prod_buffer[16], a[4], b[1]);
and a19(prod_buffer[17], a[5], b[0]);
and a20(prod_buffer[18], a[5], b[1]);
and a21(prod_buffer[19], a[6], b[0]);
and a22(prod_buffer[20], a[6], b[1]);
and a23(prod_buffer[21], a[7], b[0]);
and a24(prod_buffer[22], a[7], b[1]);
and a25(prod_buffer[23], a[4], b[2]);
and a26(prod_buffer[24], a[5], b[2]);
and a27(prod_buffer[25], a[6], b[2]);
and a28(prod_buffer[26], a[7], b[2]);
and a29(prod_buffer[27], a[4], b[3]);
and a30(prod_buffer[28], a[5], b[3]);
and a31(prod_buffer[29], a[6], b[3]);
and a32(prod_buffer[30], a[7], b[3]);
and a33(prod_buffer[31], a[0], b[4]);
and a34(prod_buffer[32], a[1], b[4]);
and a35(prod_buffer[33], a[2], b[4]);
and a36(prod_buffer[34], a[3], b[4]);
and a37(prod_buffer[35], a[4], b[4]);
and a38(prod_buffer[36], a[5], b[4]);
and a39(prod_buffer[37], a[6], b[4]);
and a40(prod_buffer[38], a[7], b[4]);
and a41(prod_buffer[39], a[0], b[5]);
and a42(prod_buffer[40], a[1], b[5]);
and a43(prod_buffer[41], a[2], b[5]);
and a44(prod_buffer[42], a[3], b[5]);
and a45(prod_buffer[43], a[4], b[5]);
and a46(prod_buffer[44], a[5], b[5]);
and a47(prod_buffer[45], a[6], b[5]);
and a48(prod_buffer[46], a[7], b[5]);
and a49(prod_buffer[47], a[0], b[6]);
and a50(prod_buffer[48], a[1], b[6]);
and a51(prod_buffer[49], a[2], b[6]);
and a52(prod_buffer[50], a[3], b[6]);
and a53(prod_buffer[51], a[4], b[6]);
and a54(prod_buffer[52], a[5], b[6]);
and a55(prod_buffer[53], a[6], b[6]);
and a56(prod_buffer[54], a[7], b[6]);
and a57(prod_buffer[55], a[0], b[7]);
and a58(prod_buffer[56], a[1], b[7]);
and a59(prod_buffer[57], a[2], b[7]);
and a60(prod_buffer[58], a[3], b[7]);
and a61(prod_buffer[59], a[4], b[7]);
and a62(prod_buffer[60], a[5], b[7]);
and a63(prod_buffer[61], a[6], b[7]);
and a64(prod_buffer[62], a[7], b[7]);
// Full adder array (56 FAs) - same structural mapping as original
fa f1(prod[1], carry_buffer[0], prod_buffer[0], prod_buffer[1], 1'b0);
fa f2(sum_buffer[0], carry_buffer[1], prod_buffer[3], prod_buffer[2], carry_buffer[0]);
fa f3(sum_buffer[1], carry_buffer[2], prod_buffer[6], prod_buffer[5], carry_buffer[1]);
fa f4(sum_buffer[2], carry_buffer[3], prod_buffer[15], prod_buffer[9], carry_buffer[2]);
fa f5(sum_buffer[3], carry_buffer[4], prod_buffer[17], prod_buffer[16], carry_buffer[3]);
fa f6(sum_buffer[4], carry_buffer[5], prod_buffer[19], prod_buffer[18], carry_buffer[4]);
fa f7(sum_buffer[5], carry_buffer[6], prod_buffer[21], prod_buffer[20], carry_buffer[5]);
fa f8(sum_buffer[6], carry_buffer[7], 1'b0, prod_buffer[22], carry_buffer[6]);
fa f9(prod[2], carry_buffer[8], sum_buffer[0], prod_buffer[4], 1'b0);
fa f10(sum_buffer[7], carry_buffer[9], sum_buffer[1], prod_buffer[7], carry_buffer[8]);
fa f11(sum_buffer[8], carry_buffer[10], sum_buffer[2], prod_buffer[10], carry_buffer[9]);
fa f12(sum_buffer[9], carry_buffer[11], sum_buffer[3], prod_buffer[12], carry_buffer[10]);
fa f13(sum_buffer[10], carry_buffer[12], sum_buffer[4], prod_buffer[23], carry_buffer[11]);
fa f14(sum_buffer[11], carry_buffer[13], sum_buffer[5], prod_buffer[24], carry_buffer[12]);
fa f15(sum_buffer[12], carry_buffer[14], sum_buffer[6], prod_buffer[25], carry_buffer[13]);
fa f16(sum_buffer[13], carry_buffer[15], sum_buffer[7], prod_buffer[26], carry_buffer[14]);
fa f17(prod[3], carry_buffer[16], sum_buffer[7], prod_buffer[8], 1'b0);
fa f18(sum_buffer[14], carry_buffer[17], sum_buffer[8], prod_buffer[11], carry_buffer[16]);
fa f19(sum_buffer[15], carry_buffer[18], sum_buffer[9], prod_buffer[12], carry_buffer[17]);
fa f20(sum_buffer[16], carry_buffer[19], sum_buffer[10], prod_buffer[13], carry_buffer[18]);
fa f21(sum_buffer[17], carry_buffer[20], sum_buffer[11], prod_buffer[27], carry_buffer[19]);
fa f22(sum_buffer[18], carry_buffer[21], sum_buffer[12], prod_buffer[28], carry_buffer[20]);
fa f23(sum_buffer[19], carry_buffer[22], sum_buffer[13], prod_buffer[29], carry_buffer[21]);
fa f24(sum_buffer[20], carry_buffer[23], carry_buffer[15], prod_buffer[30], carry_buffer[22]);
fa f25(prod[4], carry_buffer[24], sum_buffer[14], prod_buffer[31], 1'b0);
fa f26(sum_buffer[21], carry_buffer[25], sum_buffer[15], prod_buffer[32], carry_buffer[24]);
fa f27(sum_buffer[22], carry_buffer[26], sum_buffer[16], prod_buffer[33], carry_buffer[25]);
fa f28(sum_buffer[23], carry_buffer[27], sum_buffer[17], prod_buffer[34], carry_buffer[26]);
fa f29(sum_buffer[24], carry_buffer[28], sum_buffer[18], prod_buffer[35], carry_buffer[27]);
fa f30(sum_buffer[25], carry_buffer[29], sum_buffer[19], prod_buffer[36], carry_buffer[28]);
fa f31(sum_buffer[26], carry_buffer[30], sum_buffer[20], prod_buffer[37], carry_buffer[29]);
fa f32(sum_buffer[27], carry_buffer[31], carry_buffer[23], prod_buffer[38], carry_buffer[30]);
fa f33(prod[5], carry_buffer[32], sum_buffer[21], prod_buffer[39], 1'b0);
fa f34(sum_buffer[28], carry_buffer[33], sum_buffer[22], prod_buffer[40], carry_buffer[32]);
fa f35(sum_buffer[29], carry_buffer[34], sum_buffer[23], prod_buffer[41], carry_buffer[33]);
fa f36(sum_buffer[30], carry_buffer[35], sum_buffer[24], prod_buffer[42], carry_buffer[34]);
fa f37(sum_buffer[31], carry_buffer[36], sum_buffer[25], prod_buffer[43], carry_buffer[35]);
fa f38(sum_buffer[32], carry_buffer[37], sum_buffer[26], prod_buffer[44], carry_buffer[36]);
fa f39(sum_buffer[33], carry_buffer[38], sum_buffer[27], prod_buffer[45], carry_buffer[37]);
fa f40(sum_buffer[34], carry_buffer[39], carry_buffer[31], prod_buffer[46], carry_buffer[38]);
fa f41(prod[6], carry_buffer[40], sum_buffer[28], prod_buffer[47], 1'b0);
fa f42(sum_buffer[35], carry_buffer[41], sum_buffer[29], prod_buffer[48], carry_buffer[40]);
fa f43(sum_buffer[36], carry_buffer[42], sum_buffer[30], prod_buffer[49], carry_buffer[41]);
fa f44(sum_buffer[37], carry_buffer[43], sum_buffer[31], prod_buffer[50], carry_buffer[42]);
fa f45(sum_buffer[38], carry_buffer[44], sum_buffer[32], prod_buffer[51], carry_buffer[43]);
fa f46(sum_buffer[39], carry_buffer[45], sum_buffer[33], prod_buffer[52], carry_buffer[44]);
fa f47(sum_buffer[40], carry_buffer[46], sum_buffer[34], prod_buffer[53], carry_buffer[45]);
fa f48(sum_buffer[41], carry_buffer[47], carry_buffer[39], prod_buffer[54], carry_buffer[46]);
fa f49(prod[7], carry_buffer[48], sum_buffer[35], prod_buffer[55], 1'b0);
fa f50(prod[8], carry_buffer[49], sum_buffer[36], prod_buffer[56], carry_buffer[48]);
fa f51(prod[9], carry_buffer[50], sum_buffer[37], prod_buffer[57], carry_buffer[49]);
fa f52(prod[10], carry_buffer[51], sum_buffer[38], prod_buffer[58], carry_buffer[50]);
fa f53(prod[11], carry_buffer[52], sum_buffer[39], prod_buffer[59], carry_buffer[51]);
fa f54(prod[12], carry_buffer[53], sum_buffer[40], prod_buffer[60], carry_buffer[52]);
fa f55(prod[13], carry_buffer[54], sum_buffer[41], prod_buffer[61], carry_buffer[53]);
fa f56(prod[14], prod[15], carry_buffer[47], prod_buffer[62], carry_buffer[54]);
endmodule
// -------------------- top FIR using structural modules --------------------
module fir_3tap(
input clk,
input [7:0] Xin,
input [7:0] H0,
input [7:0] H1,
input [7:0] H2,
output [15:0] Yout
);
// delays for taps
wire [7:0] x_d1, x_d2;// two 8-bit DFFs to produce X[n-1] and X[n-2]
DFF8 dff_x1(.clk(clk), .D(Xin), .Q(x_d1));
DFF8 dff_x2(.clk(clk), .D(x_d1), .Q(x_d2));
// multipliers for each tap
wire [15:0] M0, M1, M2;
braun_multiplier mul0(.a(Xin), .b(H0), .prod(M0)); // X[n]*H0
braun_multiplier mul1(.a(x_d1), .b(H1), .prod(M1)); // X[n-1]*H1
braun_multiplier mul2(.a(x_d2), .b(H2), .prod(M2)); // X[n-2]*H2
// add M0 + M1 -> s1, then s1 + M2 -> s2
wire [15:0] s1, s2;
wire ctmp;
RCA r1(.sum(s1), .cout(ctmp), .a(M0), .b(M1), .cinput(1'b0));
RCA r2(.sum(s2), .cout(ctmp), .a(s1), .b(M2), .cinput(1'b0));
// register final output
DFF16 dff_out(.clk(clk), .D(s2), .Q(Yout));
endmodule
