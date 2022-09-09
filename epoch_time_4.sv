For Assertion passed:

// Code your testbench here
// or browse Examples
module tb();
 
  bit clk;
  // time clk_time = 10.0/1.0ns; // declare clk_time as 20 ns for comparison for always #10 clk++;
  time clk_time = 20.0/1.0ns; // declare clk_time as 20 ns for comparison for always #10 clk++;
 
  // always #5 clk++; // t == 10 for comparison
  always #10 clk++; // t == 20 for comparison
 
 property clk_period;
   realtime clk_time, temp;
 
   (1,temp = $realtime) |=> (1,clk_time = ($realtime - temp));
   //##0 (1,print_time(clk_time));
 
 endproperty
 
  function bit print_time(input time t);
    //if(t == 10) begin
    $display("Clock_period:-%0t",t);
    if(t == 20) // t == 10 depends on clock frequency's clock period, always #5 clk++; above gives t == 10 as comparison for assertion.
      return 1;
    else
      return 0;
    // end
    // else begin
    //   $display("Clock period did not match");
    //   return 0;
    // end
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
    
    
For Assertion Failed:

// Code your testbench here
// or browse Examples
module tb();
 
  bit clk;
  // time clk_time = 10.0/1.0ns; // declare clk_time as 20 ns for comparison for always #10 clk++;
  time clk_time = 20.0/1.0ns; // declare clk_time as 20 ns for comparison for always #10 clk++;
 
  // always #5 clk++; // t == 10 for comparison
  always #10 clk++; // t == 20 for comparison
 
 property clk_period;
   realtime clk_time, temp;
 
   (1,temp = $realtime) |=> (1,clk_time = ($realtime - temp));
   //##0 (1,print_time(clk_time));
 
 endproperty
 
  function bit print_time(input time t);
    //if(t == 10) begin
    $display("Clock_period:-%0t",t);
    if(t == 10) // t == 10 depends on clock frequency's clock period, always #5 clk++; above gives t == 10 as comparison for assertion. For assertion failed, modify t == 10 instead of t == 20.
      return 1;
    else
      return 0;
    // end
    // else begin
    //   $display("Clock period did not match");
    //   return 0;
    // end
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
