/******************************************************************************
*
* Module: Private - Test bench For Register Memory Block  ' Storage ' Block 
*
* File Name: TB.sv
*
* Description:  this file is used for Testing the Register Memory Block
*               , Storage unit is one of the  fundamental building blocks of the                
*               processor which is responsible for store the data calculted with ALU           
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
`include "sequence_item.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "subscriber.sv"
`include "environment.sv"
module Test_bench();
    

    intf intf1()  ; 
    environment e ;

    initial begin 

        e = new()           ;
        e.env_intf = intf1  ; 
        e.run_environment() ;

    end

    initial begin 
        intf1.clk_intf = 1 ; 
    end  

    always  begin
       #5 intf1.clk_intf = ~ intf1.clk_intf ; 
    end

RegFile REG_TEST (
.clk        (intf1.clk_intf)     ,
.rst        (intf1.rst_intf)     , 
.WrEn       (intf1.WrEn_intf)    ,
.RdEn       (intf1.RdEn_intf)    ,
.Address    (intf1.Address_intf) ,
.WrData     (intf1.WrData_intf)  ,
.RdData     (intf1.RdData_intf)
) ; 


endmodule
