module key_ctrl
(
    input   wire            sys_clk     ,
    input   wire            sys_rst_n   ,
    input   wire    [2:0]   key         ,
    
    // output  reg     [3:0]   wave_sel
    output  reg     [1:0]   waveform_counter    ,      //00,01,10 and 11 for the four wave forms.
    output  reg     [4:0]   freq_counter,               //register to tune the frequency from 500 Hz to 1.5 MHz
    output  reg     [4:0]   freq_counter2

);

// wire    key3   ;
wire    key2   ;
wire    key1   ;
wire    key0   ;



always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        waveform_counter <= 2'b00;
    else if (key0 == 1'b1)
        waveform_counter <= waveform_counter + 1;
    else
        waveform_counter <= waveform_counter;


// always@(posedge sys_clk or negedge sys_rst_n)
    // if(sys_rst_n == 1'b0)
        // wave_sel <= 4'b0001;
    // else if(waveform_counter == 2'b11)
        // wave_sel <= 4'b1000;
    // else if(waveform_counter == 2'b10)
        // wave_sel <= 4'b0100;
    // else if(waveform_counter == 2'b01)
        // wave_sel <= 4'b0010;
    // else if(waveform_counter == 2'b00)
        // wave_sel <= 4'b0001;


always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        freq_counter <= 5'b00000;
    else if (key1 == 1'b1)
        freq_counter <= freq_counter + 1;
    else if (key2 == 1'b1)
        freq_counter2 <= freq_counter2 + 1;
    else
        begin
            freq_counter <= freq_counter;
            freq_counter2 <= freq_counter2;
            
        end







button_filter
#(
   .CNT_MAX(20'd999_999)
)
button_filter_inst1
(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .button_in  (key[1]),

    .key_flag   (key1)

);

button_filter
#(
   .CNT_MAX(20'd999_999)
)
button_filter_inst0
(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .button_in  (key[0]),

    .key_flag   (key0)

);
button_filter
#(
   .CNT_MAX(20'd999_999)
)
button_filter_inst2
(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .button_in  (key[2]),

    .key_flag   (key2)

);


endmodule