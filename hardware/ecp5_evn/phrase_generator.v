`define STATE_PROGRAMMING 0
`define STATE_RUNNING 1
`define STATE_SUCCESS 2
`define STATE_IDLE 3
`define STATE_START 4

module generator(
	input wire clk,

	input wire initiate,

	input wire program,
	input wire[8*127-1:0] prg_format,
	input wire[7:0] prg_num_characters,
	input wire[7:0] prg_len,
	input wire[127:0] prg_h_goal,

	input wire[127:0] h_res,
	input wire[511:0] m_res,

	output wire[447:0] m,
	output reg[63:0] m_len,
	output reg[7:0] state=`STATE_IDLE
	);

reg[8*127-1:0] format;
reg[25*8-1:0] lengths;

reg[7:0] len = 0;
reg[7:0] num_characters = 0;

reg[127:0] h_goal=0;

wire carry_array[0:25];
reg[25:0] enable_array;

wire count;
assign count = (state==`STATE_RUNNING) ? clk : 1'b0;

generate
	genvar i;
		for(i=0;i<25;i=i+1)
		begin : generate_char_generators
			character_counter char_gen_i(
				.count(count),
				.carry_in(carry_array[i]),
				.carry_out(carry_array[i+1]),
				.prg_numchars(lengths[i*8+:8]),
				.prg_charlist(format),
				.enable(enable_array[i +: 1]),
				.program(program),
				.char(m[8*i +: 8])
			);
		end

endgenerate

reg[4:0] index=0;
reg[4:0] index2=0;

always @(posedge clk)
begin
	case (state)

	`STATE_PROGRAMMING: 
	begin
		format<=prg_format;
		len<=prg_len;
		num_characters<=prg_num_characters;
		h_goal<=prg_h_goal;
		m_len<=prg_len;
		enable_array<=0;

		state<=`STATE_IDLE;	
	end

	`STATE_IDLE:
	begin
		enable_array <= 25'b1111111111111111111111111 >> (25-num_characters);
		if(initiate==1'b1)
		begin
			state<=`STATE_RUNNING;
		end
		else if(program==1'b1)
		begin
			state<=`STATE_PROGRAMMING;
		end
	end

	`STATE_START:
	begin

		state = `STATE_RUNNING;
	end

	`STATE_RUNNING:
	begin
		if(h_goal==h_res) //check if already cracked
		begin
			state=`STATE_SUCCESS;
			$display("success! | %x (%x)",m_res,h_res);
		end
	end

	endcase

end	
endmodule