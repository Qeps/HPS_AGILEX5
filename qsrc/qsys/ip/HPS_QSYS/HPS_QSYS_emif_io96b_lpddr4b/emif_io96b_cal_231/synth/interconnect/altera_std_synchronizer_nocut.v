// (C) 2001-2025 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.





`timescale 1ns / 1ns

module altera_std_synchronizer_nocut (
                                clk, 
                                reset_n, 
                                din, 
                                dout
                                );

   parameter depth = 3; 
   parameter rst_value = 0;

   parameter retiming_reg_en = 0;
     
   input   clk;
   input   reset_n;    
   input   din;
   output  dout;
   

   (* altera_attribute = {"-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW; -name SYNCHRONIZER_IDENTIFICATION FORCED; -name DONT_MERGE_REGISTER ON; -name PRESERVE_REGISTER ON  "} *) reg din_s1;

   (* altera_attribute = {"-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW; -name DONT_MERGE_REGISTER ON; -name PRESERVE_REGISTER ON"} *) reg [depth-2:0] dreg;    

   // synthesis translate_off
   `ifndef QUARTUS_CDC
   initial begin
     if (retiming_reg_en == 0 ) begin
       if (depth <2) begin 
         $display("%m: Error: synchronizer length: %0d less than 2.", depth);
       end
      end
     else begin
       if (depth <4) begin 
         $display("%m: Error: synchronizer length: %0d less than 4 with retiming enabled.", depth);
       end
     end
   end
   `endif 

   
`ifdef __ALTERA_STD__METASTABLE_SIM

   reg[31:0]  RANDOM_SEED = 123456;      
   wire  next_din_s1;
   wire  dout;
   reg   din_last;
   reg          random;
   event metastable_event; 

   initial begin
      $display("%m: Info: Metastable event injection simulation mode enabled");
      random = $random;
   end
   
   always @(posedge clk) begin
      if (reset_n == 0)
        random <= $random(RANDOM_SEED);
      else
        random <= $random;
   end

   assign next_din_s1 = (din_last ^ din) ? random : din;   

   always @(posedge clk or negedge reset_n) begin
       if (reset_n == 0) 
         din_last <= (rst_value == 0)? 1'b0 : 1'b1;
       else
         din_last <= din;
   end

   always @(posedge clk or negedge reset_n) begin
       if (reset_n == 0) 
         din_s1 <= (rst_value == 0)? 1'b0 : 1'b1;
       else
         din_s1 <= next_din_s1;
   end
   
`else 

   // synthesis translate_on   
   generate if (rst_value == 0)
       always @(posedge clk or negedge reset_n) begin
           if (reset_n == 0) 
             din_s1 <= 1'b0;
           else
             din_s1 <= din;
       end
   endgenerate
   
   generate if (rst_value == 1)
       always @(posedge clk or negedge reset_n) begin
           if (reset_n == 0) 
             din_s1 <= 1'b1;
           else
             din_s1 <= din;
       end
   endgenerate
   // synthesis translate_off      

`endif

`ifdef __ALTERA_STD__METASTABLE_SIM_VERBOSE
   always @(*) begin
      if (reset_n && (din_last != din) && (random != din)) begin
         $display("%m: Verbose Info: metastable event @ time %t", $time);
         ->metastable_event;
      end
   end      
`endif

   // synthesis translate_on

   generate if (rst_value == 0) begin
      if (retiming_reg_en == 0) begin
         if (depth < 3) begin
            always @(posedge clk or negedge reset_n) begin
               if (reset_n == 0) 
                 dreg <= {depth-1{1'b0}};            
               else
                 dreg <= din_s1;
            end         
         end else begin
            always @(posedge clk or negedge reset_n) begin
               if (reset_n == 0) 
                 dreg <= {depth-1{1'b0}};
               else
                 dreg <= {dreg[depth-3:0], din_s1};
            end
         end

         assign dout = dreg[depth-2];
       end

       else begin 
          (* altera_attribute = {"-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW; -name DONT_MERGE_REGISTER ON; -name PRESERVE_REGISTER ON"} *) reg [1:0] dreg1;
          reg [depth-4:0] dreg2;
          wire [depth-2:0] dreg3;

          assign dreg3 = {dreg2,dreg1};

          if (depth <= 3) begin
             always @(posedge clk or negedge reset_n) begin
                if (reset_n == 0)
                  dreg1 <= {depth-1{1'b0}};
                else
                  dreg1 <= din_s1;
               end
           end
           else begin
              always @(posedge clk or negedge reset_n) begin
                if (reset_n == 0)
                  {dreg2,dreg1} <= {depth-1{1'b0}};
                else
                  {dreg2,dreg1} <= {dreg3[depth-3:0], din_s1};
              end
           end
           assign dout = dreg3[depth-2];
       end
    end

   
   else begin
      if (retiming_reg_en == 0) begin
         if (depth < 3) begin
            always @(posedge clk or negedge reset_n) begin
               if (reset_n == 0) 
                 dreg <= {depth-1{1'b1}};            
               else
                 dreg <= din_s1;
             end         
         end else begin
            always @(posedge clk or negedge reset_n) begin
               if (reset_n == 0) 
                 dreg <= {depth-1{1'b1}};
               else
                 dreg <= {dreg[depth-3:0], din_s1};
            end
         end
       assign dout = dreg[depth-2];
    end

      else begin
         (* altera_attribute = {"-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW; -name DONT_MERGE_REGISTER ON; -name PRESERVE_REGISTER ON"} *) reg [1:0] dreg1;
         reg [depth-4:0] dreg2;
         wire [depth-2:0] dreg3;

         assign dreg3 = {dreg2,dreg1};

           if (depth <= 3) begin
               always @(posedge clk or negedge reset_n) begin
                  if (reset_n == 0)
                    dreg1 <= {depth-1{1'b1}};
                  else
                    dreg1 <= din_s1;
               end
           end
           else begin
               always @(posedge clk or negedge reset_n) begin
                  if (reset_n == 0)
                    {dreg2,dreg1} <= {depth-1{1'b1}};
                  else
                    {dreg2,dreg1} <= {dreg3[depth-3:0], din_s1};
               end
            end  
          assign dout = dreg3[depth-2];
        end
     end
   endgenerate

endmodule 
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "nATEpDWf3CgajPjgH0t9FI3P3v7c7W2p1Bjo8KPiWXptDDKP83tHlZV4/kOjbfP5B3iPKq3r9UGmKAo7uM5E+NrMJJrWKQHFxNhuD9YH7WIm4w92BUZP4bPiPCFjEfA8Gg2F5To+TwSe7HVsQs+/7MZQj0QmDr2hjiVbFLL88xfR21RarRUIjnXzluc0JvTFFI13vcHyvhug/HSbBYjOOLVxyFVn/zaj46Yp0VXaMOw1nlZhJnKcXQsJx0gJoXbJzhqXMAEUYlyGq9c1wdgQSBXE8l1jREheSOvQ0cfeRX88+8g4+XINHMQVcPl0OjfoyRZ3JmyxFBhhTKaBFTuwa9JPGjKsP23EId66pNJyNHw+kx9hfuti4zKPh+4qDKzImqe3EvW9LvOpRFmLrX2Uxvpo1FTEMNxGrXb1ke0Z7vcuC95O72ct3MSS89UfL7tYbP1vXYWRLQ8C82nSl0K+WK6SnZZVbZLDHRpCCYtfelsLw7JJdfz2uhT+702K/cMywBt9oqHNmoTZubqV7787HlJwx1FqO2KI+EJorlVBtLfK7PJ4fOhDL7SQ23Tmb67gx0VsXcDYP/832+fsZsVMzSvS/3CiJjMDZAG0NuCMdvDXLySCkFUgqtHyScmaaundWnVAa+e66Sx7mp7VFD2d91rm0/mT6kUthgdXh1QRF/0/Ip6hP5huj45XBDVGZvX1ZQluQO/BXZXjyiuHXjM+ciVm9ZSPvoSKLFn9QolBYAEnDPQ3meQJpCkgBKNo6sG2vgaH89bYRlanB14+4Oqf7bAr3180nN8Z9LDTJRFfw0lWJ3OGhrRI1NyQ5YEzAsUO+H029+cDiasAmGbTULVUCBCkqyPlboA6mBIxBGWHngeFhEu5HagTbe2Xbew0EmTDW/5vz/BCGK4o27Md24EDRxAKVS/gyU4yVrE2LtGN26kHjxWvloc59PFbZL7EjLB+5tx8lFaZU+DwmAVNAwauX4DQYtDhS9XUFO0Pzj7ryCBHw0ifW2bHRF/R/fHkbo30"
`endif
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1Z0+7rSpLu/G8TvqoesMvXjz0XNkfpbaluTDIUq6P3uqQh8DpeaYhRsqmoUZH9cP/oX4VGKrrmrsQazKFjFE3tvNASuMrWHWXLcF5PfjV3FkS/QfATka6uVYT6Ur6tphAd+VoSpWPdwDthWI8yUT5ztfPtT3a1icCbEwSSvjk0vXqZETveCbfTHdb5xBBQgVm5iRfATwytBdZWvjiJbV0cqGJV/M2txtlmX4RshTWU5sRh6MC4ZB31+Ta3TpiOjCzQ32YlsGfg3SaroDgpPLdxuX3iRkDeg1cg6HfdUYE9oeT3wSHHshLnMgUCXR2I7RtJIojIVkt73Lo93Gj5EYHE1teIvEOVUauuBQ3rRR2I7XxwYEHk8DkEfcMGaxQIL1FDuHO/E1XpNU/agRa37m5/UdCkE8CeTmAWLseEfwItpMYGXMy1p/KQuGTbiNJqK5RdvmwivTpc/j9N3GN1YrM7HJev90eKjObm/7XaNE0ciRWeAF6vpjKB/EcavRWrC7VMl/xUIvqpeXDWNS6WLVBskeV5Pvxz0P8YugXX5FTtqWyVLlPjnTB7FGBGePhitxe330lwFFoeS4Ar+9fTBS+OzCVQb9K6gF6rR+KV/FkPkcoM/CbeArAfGfkmt0XuLeuJmfr1g54/Wut9dwhlqx/yU8lb5f77LWhIWeheyYMlGnmKRSDs5Qj0k4cjrKs5b990mHjp59oR+9UlJ+KOyktCrg5PNQZAGejAALqR1gC53JuiZ7Me+doyfW+n9tXhdTOf2VhPrWrGwaOnKlXBO/Jij"
`endif