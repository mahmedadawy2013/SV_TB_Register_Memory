class subscriber ; 

string name            ;
int covered            ;
int total              ; 
sequence_item  t_sub   ;
mailbox subs_mail      ;

  function new (string name = " SUBSCRIBER ") ;
    this.name          = name   ; 
    this.subs_mail     = new()  ;
    this.groub1        = new()  ; 
  endfunction

  covergroup groub1 ; 
    coverpoint t_sub.RdData_tb {bins All[] = { [0:$] } ; } 
  endgroup 

  task run_subscriber();
    $display("subscriber Starting To Recieve Data From the monitor ") ;
    forever  begin 

      t_sub = new ()                                    ; 
      subs_mail.get(t_sub)                              ;
      groub1.sample()                                   ; 
      t_sub.display_transaction(" SUBSCRIBER")          ;
      $display("subscriber has recieved the data from the monitor at time : %0P",$realtime()) ;
 

    end 

  endtask 

  task display_coverage_percentage() ; 
    $display("The Coverage is :%0P ",groub1.get_coverage(covered,total));
    $display("The covered  is :%0P ",covered);
    $display("The total    is :%0P ",total);
  endtask

endclass 