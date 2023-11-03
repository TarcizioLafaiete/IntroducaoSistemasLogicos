module cofre_behavorial(
    input clk,
    input reset,
    input [1:0] digito,
    output reg led
);
//Declaracao dos estados da maquina de Moore de 6 estados
localparam INICIAL = 3'b000; //Estado Inicial  e espera por C
localparam C = 3'b001;  //Estado de espera para o digito B
localparam CB = 3'b010; //Estado de espera para o digito A
localparam CBA = 3'b011; //Estado de espera para o digito B
localparam CBAB = 3'b100; //Estado de espera para o digito C
localparam CBABC = 3'b101; //Cofre desbloqueado
//registadores do estado da maquina
reg [2:0] q_state = INICIAL;
reg [2:0] nx_q_state = INICIAL;
//flip flop D para os registradores com Clock de borda de subida e reset em 0
always @(posedge clk) begin
    if(reset == 1'b1) begin 
    	q_state = nx_q_state;
    end
    else begin
    	q_state = C;
	end
end
//Maquina de estados 
always @* begin
    case (q_state)
        INICIAL: 
        begin
            //LED apagado
            led = 1'b0;
            //Digito correto =  C
            if(digito == 2'b11) begin
                nx_q_state = C;
            end
            //Qualquer outro fica o estado 000
            else begin
                nx_q_state = INICIAL;
            end
        end
        C:
            begin
                //Digito correto =  B
                if(digito == 2'b10) begin
                    nx_q_state = CB;
                end
                //Digito = 00 fica no estado
                else if(digito == 2'b00) begin
                    nx_q_state = C;
                end
                //Outro digito retorna ao estado inicial
                else begin
                    nx_q_state = INICIAL;
                end
            end
        CB:
            begin
                //Digito correto = A
                if(digito == 2'b01) begin
                    nx_q_state = CBA;
                end
                //Digito = 00 mantem estado
                else if(digito == 2'b00) begin
                    nx_q_state = CB;
                end
                //Outro digito retorna ao estado inicial
                else begin
                    nx_q_state = INICIAL;
                end
            end
        CBA:
            begin
                //Digito correto = B
                if(digito == 2'b10) begin
                    nx_q_state = CBAB;
                end
                //Digito = 00 mantem estado
                else if(digito == 2'b00) begin
                    nx_q_state = CBA;
                end
                //Outro digito retorna ao estado incial
                else begin
                    nx_q_state = INICIAL;
                end
            end
        CBAB:
            begin
                //Digito correto = C
                if(digito == 2'b11) begin
                    nx_q_state = CBABC;
                end
                //Digito = 00 mantem o estado
                else if(digito == 2'b00) begin
                    nx_q_state = CBAB;
                end
                //Outro digito retorna o estado inicial
                else begin
                    nx_q_state = INICIAL;
                end
            end
        CBABC:
            begin
                //Mantem o estado de desbloqueio do cofre ate um reset
                nx_q_state = CBABC;
                //LED Acesso
                led = 1'b1;
            end
        default: 
            //Em caso de falhas de seguranca retorna o estado inicial
            nx_q_state = INICIAL;
    endcase
end 
endmodule
