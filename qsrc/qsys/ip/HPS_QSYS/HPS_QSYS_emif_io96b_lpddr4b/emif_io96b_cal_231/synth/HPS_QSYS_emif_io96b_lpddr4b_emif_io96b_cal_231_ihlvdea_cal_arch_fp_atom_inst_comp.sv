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


module cal_arch_fp_atom_inst_comp #(
   parameter IS_USED  = 0,

   parameter BASE_ADDRESS                                    = 0,

   localparam PORT_I_AVM_ADDRESS_WIDTH                        = 22,
   localparam PORT_I_AVM_WRITEDATA_WIDTH                      = 32,
   localparam PORT_O_AVM_READDATA_COMP_WIDTH                  = 32
) (
);
   timeunit 1ns;
   timeprecision 1ps;

   logic                                                      avm_clk;
   logic                                                      avm_rst_n;
   logic [PORT_I_AVM_ADDRESS_WIDTH-1:0]                       i_avm_address;
   logic                                                      i_avm_read;
   logic                                                      i_avm_write;
   logic [PORT_I_AVM_WRITEDATA_WIDTH-1:0]                     i_avm_writedata;
   logic [PORT_O_AVM_READDATA_COMP_WIDTH-1:0]                 o_avm_readdata_comp;

   tennm_compensation_block # (
      .base_address                                         (BASE_ADDRESS)
   ) comp (
      .avm_clk                                              (avm_clk),
      .avm_rst_n                                            (avm_rst_n),
      .i_avm_address                                        (i_avm_address),
      .i_avm_read                                           (i_avm_read),
      .i_avm_write                                          (i_avm_write),
      .i_avm_writedata                                      (i_avm_writedata),
      .o_avm_readdata_comp                                  (o_avm_readdata_comp)
   );

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1Yr5pL078yZd60RSD5OUhjgkqmIqkqR5bVq2zQw1FVHKlxuZrGxIOoTMUPBzbZoh+1Ayy5+uBET/gmoTIStRdtrBFyTa82HEl6+29ZsMO2hcohtByQDKtfaIhLlsgsGdl6EmOWXJZWTumQ2YpYzUQ9LV82QJd0bmgFIOF9pu4BToss0JAJc2Tbfd/P3SWLhHYzH9kRhfF0n9HMHQSUumXLJWfO5vJt77MPvZWHzfuAkJWk3oADvK0NvbXTle29ys/PLZFR5FyzPSm0aGaj0Yk0eNNS8r+cPB9PCbxa+VBNY+ThBaLEtjan/BKkeXZDpYRheVuFYIbQo+/w5FkgEpVwIoCMzY7qHQlsev+J3910C6nltQv+hWaMak0dRimPIeqncErzpEII14/UTKOP/vYhZvOus3EYjho3kw4u9SdKIofjkAh7x9oMkskLiVJS4WT4egshNSvaKQSrlOcT2qSXZu4Nt8J7UXTShAr+Kl6ZLwGTvsbVLVnnTIVu9cvMe1tKT53MGC6UHNbKuLaMlqHFz9dPgRlVaNTdJ0VN8uV4ayDXYEnS2jAhp4EEuKVQf2Tjwd7ExWeshgoc+mUVOi58YRe6xO//YrTHclcAlRXammykURJCrXmutM+HC3Uj5fAoE4F4FpncTGgdXBZT3//NldTiccrYBXswLB14vPYoW3kkaQxujSvGlq3joQ5O8+w10udivWc8MKw708KRK9bMbBfXVz9ah+SvnKW3i7KLGcj6D8zfXD6OGUib4+iqKRS9b/w9wuCjPjxGlfd4uV041"
`endif