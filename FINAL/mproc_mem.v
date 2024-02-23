/*
PROBLEM STATEMENT-

while(i<21){
  sum=sum+a+b;
}

Code runs by decrementing 21 to 0 after which it stops

*/


module ram_128_16 (input wire clk, reset, wr, input wire [6:0] addr, input wire [15:0] din, output wire [15:0] dout);
  reg [0:127] ram [15:0];

  initial begin
    ram[0]=16'b10xxxxx000xxxxxx; // load r0, 4 where r0=a
    ram[1]=16'b0000000000000100;
    ram[2]=16'b10xxxxx001xxxxxx; // load r1, 7 where r1=b
    ram[3]=16'b0000000000000111;
    ram[4]=16'b10xxxxx010xxxxxx; // load r2, where it is used for 21
    ram[5]=16'b0000000000010101;
    ram[6]=16'b10xxxxx011xxxxxx; // load r3, sum =0
    ram[7]=16'b0000000000000000;
    ram[8] = 16'b10xxxxx101xxxxxx; // load 1 to r5
    ram[9] = 16'b0000000000000001; // 1 
    ram[10]=16'b0000000011011000; // add r3, r0, r3
    ram[11]=16'b0000000011011001; // add r3, r1, r3
    //ram[10]=16'b0000010011100100; // move r3, r4 (and r3, r4, r4)
    ram[12]=16'b0000001010101010; // sub r2, r5, r2
    ram[13]=16'b01xxxxxx00000100; // jbc ram[10]
    //ram[14] = 16'b0000010000110011; // move r0, r3 (and r0, r3, r3)


  end
  always @(wr) ram[addr]=din;
  assign dout=ram[addr];


endmodule

module mproc_mem (input wire clk, reset);
  wire wr; wire [6:0] addr; wire [15:0] d_in, d_out;

  ram_128_16 ram_128_16_0 (clk, reset, 1'b0, addr, d_out, d_in);
  mproc mproc_0 (clk, reset, d_in, addr, d_out);
endmodule
