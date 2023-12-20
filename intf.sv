interface  intf;

    logic clk_intf                 ;
    logic rst_intf                 ; 
    logic WrEn_intf                ; 
    logic RdEn_intf                ;
    logic [3:0]  Address_intf      ; 
    logic [15:0] WrData_intf       ; 
    bit   [15:0] RdData_intf       ; 
    
endinterface