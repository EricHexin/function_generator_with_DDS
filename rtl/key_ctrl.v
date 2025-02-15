module key_ctrl
(
    input   wire            sys_clk     ,
    input   wire            sys_rst_n   ,
    input   wire    [3:0]   key         ,
    
    output  reg     [3:0]   wave_sel

);

wire    key3   ;
wire    key2   ;
wire    key1   ;
wire    key0   ;


always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        wave_sel <= 4'b1000;
    else if(key3 == 1'b1)
        wave_sel <= 4'b1000;
    else if(key2 == 1'b1)
        wave_sel <= 4'b0100;
    else if(key1 == 1'b1)
        wave_sel <= 4'b0010;
    else if(key0 == 1'b1)
        wave_sel <= 4'b0001;


button_filter
#(
   .CNT_MAX(20'd999_999)
)
button_filter_inst3
(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .button_in  (key[3]),

    .key_flag   (key3)

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



endmodule