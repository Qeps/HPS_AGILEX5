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




`timescale 1ps/1ps

module compare_eq #(
    parameter WIDTH=10
) (
    input [WIDTH-1:0]  in_a,
    input [WIDTH-1:0]  in_b,
    output             equal
);

assign equal = (in_a==in_b);

endmodule 
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "3wrV9vxkV6cm3KZuU0YmrpECz0gO85cpwPAwvoDmqQfm97s5UZmfYguhz8/428PUc52yhrNL2DIcflQpOkDgIHixsN/qQIr1Yl8RrFxWUW9+BWG4mgSfzo8rnvUQWJayS2cUu9k11ZYcmdN3LHF6s1KoNJ9JXlORxyEgsglhkdhkf1ALusfEVuG233HcW8M7RNXR6hb8GxDqWtwlLRj1qCOttHqbLRcgsbfjrMDR1FjQL9exbfXYTp137Dtd6Y0g6L4MgYOzwjRQpR0jP8MXyY0JHzOEOLBvGLeAfT0zJFN5eB54bfkyPWJXaUD9Yt++782v+rIWyQg5F3Q+VN5KWZObQSZSJZjskCikMATWs4odQUY2/UcTZ3iS0cyZ1gXZBv5vGyXsGpo3JMt8UqBRfF1GddwcaSNOLRFHi1adCsXu76Z1F1CAuiXCV+d92LcX5yDP9SbxTbuY8uOetEv1wHnVth16O1avdtiqUj8qtb0rrDaBUiskNDQOGgJrkP3YC2PV5p5Ep5C4udKdywI3ziips38Ds90PuJy67yjR8tG/R6zabBtu54dn1e8SLL326vGTA2sisJaEzjaRfIKsLJnA326qDRFJRXuJyNTM7cWuc6AbVd7frqsYkl08yfw34RPfW1+c+YH4f3PlPLrR0O6uYYvNhwJ9mQUj23tFchjYyASeMky7PNT0BIRTQEikjAtaLzBKpg5fs5fbnOqOERLQBFzbBPh4+FDq/9hu4gCx7eTa7MyIsxZKV5gt/lwT2hZcqDd/Z33loBENj5mAY5TuV7o5T6CQNg04nejD9dHDDPGwYJWtrjyx7Cdd/NXGCkPee8GzhdSawScqvEdT4qSIxEZ5C/Yaco4E3KjR+kltA956dS76He9dUzKofYAjSx8SNrd00sOxpHpDnq0yCOcmq6U2usnwNpYR4/6dZvcbsyarjLzWAiNvHJzbqrGMYbPHq2pU03yyDXkLFcSkzzETYMcG+/Jb0ZL6RUUP88PAn1MYWRVdlTzrc4hYcISV"
`endif
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1ae3xH1psIgU3rQy+youP9od5NVzrRNgvC9g3MgR1iCtZgckUA4Ltj/EXSRpS+IGZfdkpAF2+hfzdsLhnYfVnulyMN/5Z6yAjspZ3bHvcAA9akCycsdoJh/8eE0flsmhWcEQ/FvF6nOhzRigDbbt6mjsf+p57h4MWhSAnomcgOogZrkHx5AxRS0hGdnG+K3ylNAuYpPaGzUrqr5yMeTV3b4XU7vvpl4BBrT9krl9Z8Xd+kKjT9Z0OzdJ5wU/rbWQsv8BCkrVd7hAcQK/3Dqoqg73gANzv74ohbL+ls/ectv9fBOI8iQ8hse1+2cwjPBz8zt8XpwXet76Z16k1558FeLllYbXJVTWkD3DIK9TCDVwvXdCtyWAsmoZNda0gWOhOAwH2Z5hIPOKTQESfCwDFKfj9DwPhRV/wXiJCXHPGwfMqsf0adec/s4iggwsHxi4IiXRqqJvHkOw3mElAXsKC3OEwCHhbzPTxDHdj6BgfCp1joku12mKtcXlp7kv9oJg5Oiee7RvOpT5xFQ85Z3ki1AgeOvJUjOPph36fne+x7ySHODohuJ1KPGh7Hd8Dj/D85nMqrV3qkw9YRGIMTUakEMxrvIxh2bvsPfJjlAwJqGrVBOjrzfBvGSG2FnmHqPUxgXm67S/blGVbJIPQUjUtXAft4aAOTrGWJPyo0p1vT6rxMC7RbFlVUfdTIFh0V6zVR/hc3I5aqxFZccRuTjGM26ZvCt+4QyT4yJDmMd59t33wlfDyc8F89u+EIMXHIaPRExnbyTxlN7kVO3SYxRrTyj"
`endif