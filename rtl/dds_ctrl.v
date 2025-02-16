module  dds_ctrl
(
    input   wire            sys_clk     ,
    input   wire            sys_rst_n   ,
    
    input   wire    [1:0]   waveform_counter    ,
    input   wire    [4:0]   freq_counter        ,
    input   wire    [4:0]   freq_counter2        ,
    
    output  wire    [7:0]   dac_data    

);


//4294967 is from 50 kHz output freq increment, N = 32, and 50 MHz sys_clk
parameter freq_word_incr = 32'd4294967;            // freq_word (or k) = 2**N*freq_out/freq_clk, where N = 32
parameter freq_word = 32'd85899346;  // base frequency is 1 MHz
parameter pha_word =  12'd1024;             // phase = theta/(2*pi)*2**N, theta = pi/2 as sine wave.
                                            // the period is 4096
reg     [31:0]      freq_adder      ;
reg     [11:0]      rom_addres_reg  ;
reg     [13:0]      rom_addr       ; 

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        freq_adder <= 32'd0;
    else
        freq_adder <= freq_adder + freq_word + freq_word_incr*(freq_counter - freq_counter2);
        
        
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        rom_addres_reg <= 32'd0;
    else
        rom_addres_reg <= freq_adder[31:20] + pha_word;
        
        
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        rom_addr <= 14'd0;
    else
        case(waveform_counter)
            2'b00:
                rom_addr <= rom_addres_reg;
            2'b01:
                rom_addr <= rom_addres_reg + 14'd4096;
            2'b10:
                rom_addr <= rom_addres_reg + 14'd8192;
            2'b11:
                rom_addr <= rom_addres_reg + 14'd12288;
            default: rom_addr <= rom_addres_reg;   
        endcase
         
    

rom_4_waveforms     rom_4_waveforms_inst 
(
	.address ( rom_addr ),
	.clock ( sys_clk ),
	.q ( dac_data )
);


endmodule