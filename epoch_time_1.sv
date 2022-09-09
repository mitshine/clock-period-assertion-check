module tb; 
	time clk_period =36.0/1.0ns; // for comparison of clock period
	bit clk, RESET_N, ENABLE;
  
	property print_clock(int clk_period);
		realtime current_time;
		// disable iff(!RESET_N || !ENABLE)
		(('1,current_time=$realtime) |=>(clk_period==$realtime-current_time));
    endproperty
 
  assert_period:assert property (@(posedge clk)print_clock(clk_period))
    $display("%t : clk  period is correct", $realtime); 
       else
         $warning("%t : clk period is not correct", $realtime);
    
    initial forever #18 clk=!clk; // for half od clock period defined earlier at the top as time clk_period = 36 ns.
    
    initial begin 
	    $display("START");
      repeat(10) @(posedge clk); // for how many times we need to check from starting.
	    $finish; // #100 $finish or $finish, it means the same thing.
    end
endmodule : tb
