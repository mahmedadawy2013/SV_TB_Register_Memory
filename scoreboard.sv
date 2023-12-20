class scoreboard ; 

string name            ;
sequence_item  t_score ;
mailbox scor_mail      ;
int passed_test_cases  ; 
int failed_test_cases  ; 

  function new (string name = " SCOREBOARD ") ;
    this.name          = name   ; 
    this.scor_mail     = new()  ;
  endfunction
/**
rst_tb   
WrEn_tb  
RdEn_tb  
Address_t
WrData_tb
RdData_tb
**/
  task run_scoreboard();
    static reg [15:0] golden_memory [15:0]   ; 
    static int  golgen_output ;  
    $display("Scoreboard Starting To Recieve Data From the monitor ") ;
    forever  begin 
      t_score = new ()                                  ; 
      scor_mail.get(t_score)                            ;
      /************************  Reset Test Case ************************/
      if (t_score.rst_tb == 0) begin 
        for (int i=0 ; i < 16 ; i = i +1)
          begin
            golden_memory[i] = 0 ;
          end
        golgen_output = 0 ; 
        if (t_score.RdData_tb == golgen_output)
          begin 
           $display("Reset Test Case Passed At time : %0P",$realtime()) ; 
           passed_test_cases++  ; 
          end
          else  begin
            $display("Reset Test Case Failed At time : %0P",$realtime()) ; 
            failed_test_cases++ ; 
          end
      end  
      /*******************************************************************/
      /************************  Write Test Case *************************/
      else if (t_score.WrEn_tb == 1) begin 
        golden_memory[t_score.Address_tb] = t_score.WrData_tb   ; 
        if (t_score.RdData_tb == golgen_output)
          begin 
           $display("Write Test Case Passed At time : %0P",$realtime()) ; 
           passed_test_cases++  ; 
          end
          else  begin
            $display("Write Test Case Failed At time : %0P",$realtime()) ; 
            failed_test_cases++ ; 
          end
      end  
      /*******************************************************************/
      /************************  Read Test Case **************************/
      else if (t_score.RdEn_tb == 1) begin 
        golgen_output = golden_memory[t_score.Address_tb]   ; 
        if (t_score.RdData_tb == golgen_output)
          begin 
           $display("Read Test Case Passed At time : %0P",$realtime()) ; 
           passed_test_cases++  ; 
          end
          else  begin
            $display("Read Test Case Failed At time : %0P",$realtime()) ; 
            failed_test_cases++ ; 
          end
      end  
      /*******************************************************************/
  
    end


      
  endtask 

  task display_test_cases_report () ;

    $display("The Number of Passed test cases is :%0P " , passed_test_cases ) ; 
    $display("The Number of Failed test cases is :%0P " , failed_test_cases ) ; 
  
  endtask 


endclass 