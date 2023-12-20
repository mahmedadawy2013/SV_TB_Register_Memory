class sequence_item ; 

// This is the base transaction object Container that will be used 
// in the environment to initiate new transactions and // capture transactions at DUT interface
rand  bit        rst_tb          ;
rand  bit        WrEn_tb         ;
rand  bit        RdEn_tb         ;
randc bit [3:0]  Address_tb      ; /* َQuestion is it impotant to use rand */ 
rand  bit [15:0] WrData_tb       ; /* َQuestion is it impotant to use rand */ 
bit       [15:0] RdData_tb       ; 


      constraint un { unique {WrEn_tb,RdEn_tb} ;  }

// This function allows us to print contents of the data packet
// so that it is easier to track in a logfile 

      function void display_transaction(input string name = "SEQUENCE ITEM" ); 
	$display ("*************** This is the %0P **********************",name)      ;  
	$display (" rst_tb     = %0d WrEn_tb    =   %0d  ", rst_tb    , WrEn_tb     ) ; 
      $display (" RdEn_tb    = %0d Address_tb =   %0d  ", RdEn_tb   , Address_tb  ) ; 
      $display (" WrData_tb  = %0d RdData_tb  =   %0d  ", WrData_tb , RdData_tb   ) ; 
      $display ("**********************************************************")       ;
      
	endfunction 
	  


endclass 