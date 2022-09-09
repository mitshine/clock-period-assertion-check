// Code your testbench here
// or browse Examples
module tb();
 
  bit clk;
  time clk_time = 20.0/1.0ns;
 
  always #5 clk++;
 
 
 property clk_period;
   realtime clk_time, temp;
 
   // (1,temp = $realtime) |=> (1,clk_time = ($realtime - temp)) ##0 (1,print_time(clk_time));
   (1,temp = $realtime) |=> (1,clk_time = ($realtime - temp));
 
 endproperty
 
  function bit print_time(input time t);
    //if(t == 10) begin
    $display("Clock_period:-%0t",t);
    return 1;
    // end
    // else begin
    //   $display("Clock period did not match");
    //   return 0;
    // end
  endfunction
 
  assert property(@(posedge clk)print_time(clk_time))      
    $display("Assertion Passed"); // it always passes the assertion, that is need to be corrected. need to take a scenario for assertion failed.
    else $display("Assertion Failed");
 
 initial
   #100 $finish;
 
 initial begin    
   $dumpfile("dump.vcd"); $dumpvars;
 end
 
endmodule 
