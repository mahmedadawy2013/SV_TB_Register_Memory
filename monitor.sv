/*******************************************************************************
* The monitor has a virtual interface handle with which it can monitor 
* the events happening on the interface. It sees new transactions and then
* captures information into a packet and sends it to the scoreboard 
* using another mailbox. 
*********************************************************************************/
class monitor ; 

string name            ;
sequence_item  t_mon   ;
mailbox mon_mail_s     ;
mailbox mon_mail_su    ;
virtual intf mon_intf  ;   

  function new (string name = " Monitor ") ;
    this.name          = name   ;
    this.mon_mail_s    = new()  ; 
    this.mon_mail_su   = new()  ; 
  endfunction
  /********************************************************************************
  * Check forever at every clock edge to see if there is a 
  * valid transaction and if yes, capture info into a class
  * object and send it to the scoreboard when the transaction
  * is over.
  ********************************************************************************/
  task run_monitor();

    $display("Monitor Starting To Recieve Data From the DUT ") ;
    @(posedge mon_intf.clk_intf)
    forever  begin 
      
      $display("Monitor Is Waiting For Packet ......")   ;    
      t_mon = new ()                                     ; 
      @(posedge mon_intf.clk_intf)
      #1 
      t_mon.rst_tb             = mon_intf.rst_intf       ;    
      t_mon.Address_tb         = mon_intf.Address_intf   ; 
      t_mon.WrEn_tb            = mon_intf.WrEn_intf      ;  
      t_mon.RdEn_tb            = mon_intf.RdEn_intf      ; 
      t_mon.WrData_tb          = mon_intf.WrData_intf    ;
      t_mon.RdData_tb          = mon_intf.RdData_intf    ;
      mon_mail_s.put(t_mon)                              ;
      mon_mail_su.put(t_mon)                             ;
      t_mon.display_transaction("Monitor")               ;          
      $display("Monitor has Recieveed the data from the DUT at time : %0P",$realtime()) ;

    end 
      
  endtask 

endclass 