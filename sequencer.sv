class sequencer;

string name                 ;
sequence_item  t_gen        ;
int iteration_number        ;
mailbox gen_mail            ;
bit [3:0] unique_address[$] ;
event   gen_handover        ;  

    function new (string name = " SEQUENCER ") ;
        this.name         = name   ; 
        this.gen_mail     = new () ;
    endfunction

    task run_generator () ;
        iteration_number = 2 ; 
        for (int i=0; i<iteration_number; ++i) begin
            
            if (i == 0 ) begin
                reset_sequence() ; 
            end
            else begin
                write_sequence() ;
                read_sequence()  ;                              
            end

        end


    endtask
    task reset_sequence() ; 
        t_gen = new()                           ;
        t_gen.rst_tb     = 1'b0                 ; 
        t_gen.WrEn_tb    = 1'b0                 ; 
        t_gen.RdEn_tb    = 1'b0                 ; 
        t_gen.WrData_tb  = 16'b0                ; 
        t_gen.Address_tb = 4'b0                 ;
        t_gen.display_transaction("GENERATOR")  ;
        gen_mail.put(t_gen)                     ;
        @(gen_handover)                         ;
    endtask
    task write_sequence();
        t_gen = new() ; 
        for (int i=0; i<16; ++i) begin
            t_gen.randomize() with {t_gen.rst_tb  == 1'b1  ;
                                    t_gen.WrEn_tb == 1'b1  ;  }  ;
            $display("Iteration Number : %0P",i)                                  ; 
            t_gen.display_transaction("GENERATOR WRITE SEQUENCE")                 ;
            gen_mail.put(t_gen)                                                   ;
            @(gen_handover)                                                       ;
        end   
    endtask
    task read_sequence();
        t_gen = new() ; 
        for (int i=0; i<16; ++i) begin
            t_gen.randomize() with {t_gen.rst_tb  == 1'b1  ;
                                    t_gen.RdEn_tb == 1'b1  ;  }  ;
            $display("Iteration Number : %0P",i)                                  ;
            t_gen.display_transaction("GENERATOR READ SEQUENCE")                  ;
            gen_mail.put(t_gen)                                                   ;
            @(gen_handover)                                                       ;
        end   
    endtask

endclass