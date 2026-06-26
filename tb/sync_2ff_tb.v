`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2026 12:34:06
// Design Name: 
// Module Name: sync_2ff_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps

module sync_2ff_tb;

    reg clk_dst;
    reg rst_dst;
    reg async_in;

    wire sync_out;

    // DUT
    sync_2ff dut (
        .clk_dst(clk_dst),
        .rst_dst(rst_dst),
        .async_in(async_in),
        .sync_out(sync_out)
    );

    // Destination Clock (100 MHz)
    initial begin
        clk_dst = 0;
        forever #5 clk_dst = ~clk_dst;
    end

    // Stimulus
    initial begin

        rst_dst = 1;
        async_in = 0;

        #20;
        rst_dst = 0;

        // Toggle async input
        #17 async_in = 1;
        #13 async_in = 0;

        #27 async_in = 1;
        #11 async_in = 0;

        #19 async_in = 1;
        #14 async_in = 0;

        #30 async_in = 1;
        #16 async_in = 0;

        #50;
        $finish;

    end

    // Monitor
    initial begin
        $monitor("Time=%0t  async_in=%b  ff1=%b  ff2=%b  sync_out=%b",
                 $time, async_in, dut.ff1, dut.ff2, sync_out);
    end

endmodule
