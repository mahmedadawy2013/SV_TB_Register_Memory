class driver ; 

string name            ;
sequence_item  t_driv  ;
mailbox driv_mail      ;
event   driv_handover  ;
virtual intf driv_intf ;   

  function new (string name = " DRIVER ") ;
    this.name          = name   ; 
    this.driv_mail     = new()  ;
  endfunction
  /*******************************************************************************
  * Try to get a new transaction every time and then assign 
  * transaction contents to the interface. But do this only if the 
  * design is ready to accept new transactions 
  *********************************************************************************/
  task run_driver();

    $display("Driver Starting To Recieve Data From the Generator ") ;
    forever  begin 
      
      $display("Driver Is Waiting For Packet ......")  ;    
      t_driv = new ()        /* ??  */                 ; 
      driv_mail.get(t_driv)                            ;
      @(negedge driv_intf.clk_intf)
      t_driv.display_transaction("DRIVER")             ;
      
      
      $display("Drive has insert the data into the DUT at time : %0P",$realtime()) ;
      driv_intf.rst_intf      = t_driv.rst_tb          ; 
      driv_intf.Address_intf  = t_driv.Address_tb      ;
      driv_intf.WrEn_intf     = t_driv.WrEn_tb         ;  
      driv_intf.RdEn_intf     = t_driv.RdEn_tb         ; 
      driv_intf.WrData_intf   = t_driv.WrData_tb       ;
      ->driv_handover                                  ;
 

    end 
      
  endtask 

endclass 