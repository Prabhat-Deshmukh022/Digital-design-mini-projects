module tflipflop ( input clk, input rst, input t, output reg out);  
  always @ (posedge clk) begin  
    if (rst)  
      out <= 0;  
    else  
        if (t)  
            out <= ~out;  
        else  
            out <= out;  
  end 
endmodule

module updowncounter(input wire clk, reset, up_down , output wire [3:0]counter);

    wire [3:0]count;
    
    wire t0 = (1'b1);
    wire t1 = (counter[0] & (!up_down)) | ((!counter[0]) & up_down);
    wire t2 = (counter[1] & counter[0] & (!up_down)) | ((!counter[1]) & (!counter[0]) & up_down);
    wire t3 = (counter[2] & counter[1] & counter[0] & (!up_down)) | ((!counter[2]) & (!counter[1] & (!counter[0]) & (up_down)));

    tflipflop T3(clk, reset, t3, count[3]); 
    tflipflop T2(clk, reset, t2, count[2]);
    tflipflop T1(clk, reset, t1, count[1]);
    tflipflop T0(clk, reset, 1'b1, count[0]);

    assign counter = count;
endmodule
