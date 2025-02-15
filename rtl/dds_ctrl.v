module  dds_ctrl
(
    input   wire            sys_clk     ,
    input   wire            sys_rst_n   ,
    input   wire    [3:0]   wave_sel    ,
    
    output  wire    [7:0]   dac_data    

);

parameter freq_word = 32'd42949;            // freq_word (or k) = 2**N*freq_out/freq_clk, where N = 32
parameter pha_word =  12'd1024;             // phase = theta/(2*pi)*2**N, theta = pi/2 as sine wave.
                                            // the period is 4096
reg     [31:0]      freq_adder      ;
reg     [11:0]      rom_addres_reg  ;
reg     [13:0]      rom_addr       ; 

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        freq_adder <= 32'd0;
    else
        freq_adder <= freq_adder + freq_word;
        
        
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        rom_addres_reg <= 32'd0;
    else
        rom_addres_reg <= freq_adder[31:20] + pha_word;
        
        
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        rom_addr <= 14'd0;
    else
        case(wave_sel)
            4'b0001:
                rom_addr <= rom_addres_reg;
            4'b0010:
                rom_addr <= rom_addres_reg + 14'd4096;
            4'b0100:
                rom_addr <= rom_addres_reg + 14'd8192;
            4'b1000:
                rom_addr <= rom_addres_reg + 14'd12288;
            default: rom_addr <= rom_addres_reg - 14'd4096;   // why minus 4096?  
        endcase
         
    

rom_4_waveforms     rom_4_waveforms_inst 
(
	.address ( rom_addr ),
	.clock ( sys_clk ),
	.q ( dac_data )
);


endmodule