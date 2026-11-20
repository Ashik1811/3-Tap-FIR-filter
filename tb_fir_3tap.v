module tb_3tapfir;
reg clk;
reg [7:0] Xin;
reg [7:0] H0;
reg [7:0] H1;
reg [7:0] H2;
wire [15:0] Yout;
fir_3tap myfilter(.clk(clk), .Xin(Xin), .H0(H0), .H1(H1), .H2(H2), .Yout(Yout));
initial clk = 0;
always #5 clk = ~clk;
initial begin
$dumpfile("tb_3tap.vcd");
$dumpvars(0, tb_3tapfir);
$display("time\tclk\tXin\tH0\tH1\tH2\tYout");
$monitor("%0t\t%b\t%0d\t%0d\t%0d\t%0d\t%0d", $time, clk, Xin, H0, H1, H2, Yout);
// set coefficients (your expected waveform uses 10,20,30)
H0 = 8'd10;
H1 = 8'd20;H2 = 8'd30;
// initial sample and sequence
Xin = 8'd0;
@(posedge clk); // 1st posedge
@(posedge clk); // pipeline ready (x_d1/x_d2 initialized)
// sequence: 0,3,1,1,2,1,4,5,6,0
@(posedge clk); Xin = 8'd3;
@(posedge clk); Xin = 8'd1;
@(posedge clk); Xin = 8'd1;
@(posedge clk); Xin = 8'd2;
@(posedge clk); Xin = 8'd1;
@(posedge clk); Xin = 8'd4;
@(posedge clk); Xin = 8'd5;
@(posedge clk); Xin = 8'd6;
@(posedge clk); Xin = 8'd0;
// flush pipeline
repeat (6) @(posedge clk);
$finish;
end
endmodule
