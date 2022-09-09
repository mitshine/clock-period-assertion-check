// Code your testbench here
// or browse Examples
module tb();
 
  bit clk;
  time clk_time = 36.0/1.0ns; 
  
  always #18 clk++; // t == 20 for comparison
 
 property clk_period;
   realtime clk_time, temp;
   (1,temp = $realtime) |=> (1,clk_time = ($realtime - temp));
 endproperty
 
  function bit print_time(input time t);
    $display("Clock_period:-%0t",t);
    if(t == 36) // if(t == 18) for assertion failed option.
      return 1;
    else
      return 0;
  endfunction
 
  assert property(@(posedge clk)print_time(clk_time))      
    $display("Assertion Passed");
    else $display("Assertion Failed");
 
  initial
    #100 $finish;
 
 initial begin    
 $dumpfile("dump.vcd"); $dumpvars;
 end
 
endmodule 
