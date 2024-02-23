module tb_updowncounter();
    reg clk;
    reg reset;
    reg up_down;
    wire [3:0] counter;
    
    updowncounter UUT (
        .clk(clk),
        .reset(reset),
        .up_down(up_down),
        .counter(counter)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_updowncounter);
        
        $monitor("M= %b Time=%0t, Counter=%b", up_down, $time, counter);
        
        clk = 0;
        reset = 1;
        up_down = 0;
        
        //#5 reset = 1;  Apply reset
        #10 reset = 0; // Release reset
        
        // Simulate counting from 0000 to 1111
        repeat (16) begin
            #5 clk = ~clk; // Toggle clock
        end

        
        // Change direction to down
        up_down = 1;
        
        // Simulate counting from 1111 to 0000
        repeat (16) begin
            #5 clk = ~clk; // Toggle clock
        end
        
        $finish;
    end
    
    always #5 clk = ~clk; // Clock generation
endmodule