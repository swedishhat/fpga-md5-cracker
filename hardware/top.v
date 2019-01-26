// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
// CREATED		"Sun Jan 20 22:33:46 2019"

module fpga_md5(
	CLOCK_50,
	GPIO_1,
	GPIO[2],
	GPIO[28],
	GPIO[29],
	GPIO[30],
	GPIO[31],
	GPIO[32],
	GPIO[33],
	LED[0],
	LED[7]
);


input wire	CLOCK_50;
input wire	[33:31] GPIO_1;
output wire	GPIO[2];
output wire	GPIO[28];
output wire	GPIO[29];
output wire	GPIO[30];
output wire	GPIO[31];
output wire	GPIO[32];
output wire	GPIO[33];
output wire	LED[0];
output wire	LED[7];

wire	[31:0] SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_2;
wire	[31:0] SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	[7:0] SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_9;
wire	[31:0] SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_12;
wire	[127:0] SYNTHESIZED_WIRE_13;





pll	b2v_inst(
	.inclk0(CLOCK_50),
	
	.c1(SYNTHESIZED_WIRE_14),
	.c2(SYNTHESIZED_WIRE_15));


SpiSlave	b2v_inst2(
	.sck(GPIO_1[33]),
	.ss(GPIO_1[31]),
	.mosi(GPIO_1[32]),
	.misoBuffer(SYNTHESIZED_WIRE_0),
	.miso(GPIO[2]),
	.shiftComplete(SYNTHESIZED_WIRE_9),
	.mosiBuffer(SYNTHESIZED_WIRE_10));
	defparam	b2v_inst2.BufferSize = 32;


Md5BruteForcer	b2v_inst4(
	.clk(SYNTHESIZED_WIRE_14),
	
	.hasReceived(SYNTHESIZED_WIRE_2),
	.dataIn(SYNTHESIZED_WIRE_3),
	.hasMatched(LED[7]),
	.resetGenerator(LED[0]),
	.dataOut(SYNTHESIZED_WIRE_0),
	.text(SYNTHESIZED_WIRE_13));


LiquidCrystalDisplay	b2v_inst5(
	.clk(SYNTHESIZED_WIRE_15),
	.writeChar(SYNTHESIZED_WIRE_5),
	.home(SYNTHESIZED_WIRE_6),
	.char(SYNTHESIZED_WIRE_7),
	.db4(GPIO[28]),
	.db5(GPIO[29]),
	.db6(GPIO[30]),
	.db7(GPIO[31]),
	.rs(GPIO[32]),
	.enable(GPIO[33]),
	.ready(SYNTHESIZED_WIRE_12)
	);


CrossDomainBuffer	b2v_inst6(
	.clk(SYNTHESIZED_WIRE_14),
	.save(SYNTHESIZED_WIRE_9),
	.in(SYNTHESIZED_WIRE_10),
	.saved(SYNTHESIZED_WIRE_2),
	.out(SYNTHESIZED_WIRE_3));


LcdLineWriter	b2v_inst9(
	.clk(SYNTHESIZED_WIRE_15),
	.ready(SYNTHESIZED_WIRE_12),
	.line(SYNTHESIZED_WIRE_13),
	.writeChar(SYNTHESIZED_WIRE_5),
	.home(SYNTHESIZED_WIRE_6),
	.char(SYNTHESIZED_WIRE_7));


endmodule
