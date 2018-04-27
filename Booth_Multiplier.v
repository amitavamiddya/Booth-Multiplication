//		Lab: 1
//		Author: Stephen
//		ID: 0560827
//--------------------------------------

/*--------------------------------------
			MAIN MODULE
----------------------------------------
*/
module Booth (
	in_1, 
	in_2, 
	in_3, 
	in_4, 
	in_5,
	out
);
parameter width = 6;
input  signed[width-1:0] in_1;   
input  signed[width-1:0] in_2;   
input  signed[width-1:0] in_3;   
input  signed[width-1:0] in_4;   
input  signed[width-1:0] in_5;   
   
output reg signed[2*width-1:0] out; //product

// internal wire
wire signed[width-1:0] second_num;
wire signed[width-1:0] third_num;

//instantiate Sort module
Sort Sort_u1(
				//input
				.i_1(in_1),
				.i_2(in_2),
				.i_3(in_3),
				.i_4(in_4),
				.i_5(in_5),
				//output
				.o_2(second_num),
				.o_3(third_num)
);

//register
reg signed[2*width:0] P;

//-----------------------------
//		MULTIPLIER
//-----------------------------
always@* begin
	//initial
	P[0] = 1'b0;
	P[width:1] = second_num[width-1:0];
	P[2*width:width+1] = 6'b00_00_00;
	
	//1
	case(P[1:0])
		2'b01: P[2*width:width+1] = P[2*width:width+1] + third_num[width-1:0];
		2'b10: P[2*width:width+1] = P[2*width:width+1] - third_num[width-1:0];
	endcase
	P = P>>>1;
	
	//2
	case(P[1:0])
		2'b01: P[2*width:width+1] = P[2*width:width+1] + third_num[width-1:0];
		2'b10: P[2*width:width+1] = P[2*width:width+1] - third_num[width-1:0];
	endcase
	P = P>>>1;
	
	//3
	case(P[1:0])
		2'b01: P[2*width:width+1] = P[2*width:width+1] + third_num[width-1:0];
		2'b10: P[2*width:width+1] = P[2*width:width+1] - third_num[width-1:0];
	endcase
	P = P>>>1;
	
	//4
	case(P[1:0])
		2'b01: P[2*width:width+1] = P[2*width:width+1] + third_num[width-1:0];
		2'b10: P[2*width:width+1] = P[2*width:width+1] - third_num[width-1:0];
	endcase
	P = P>>>1;
	
	//5 
	case(P[1:0])
		2'b01: P[2*width:width+1] = P[2*width:width+1] + third_num[width-1:0];
		2'b10: P[2*width:width+1] = P[2*width:width+1] - third_num[width-1:0];
	endcase
	P = P>>>1;
	
	//6
	case(P[1:0])
		2'b01: P[2*width:width+1] = P[2*width:width+1] + third_num[width-1:0];
		2'b10: P[2*width:width+1] = P[2*width:width+1] - third_num[width-1:0];
	endcase
	P = P>>>1;
	
	//output
	out[2*width-1:0] = P[2*width:1];
end

endmodule

//----------------------------------------------------
//				SORTING MODULE
//----------------------------------------------------
module Sort(
			//input
			i_1,
			i_2,
			i_3,
			i_4,
			i_5,
			//output
			//o_1,
			o_2,
			o_3
			//o_4,
			//o_5
);

parameter w = 6;
//input
input signed[w-1:0] i_1;
input signed[w-1:0] i_2;
input signed[w-1:0] i_3;
input signed[w-1:0] i_4;
input signed[w-1:0] i_5;

//output
//output signed[w-1:0] o_1;
output signed[w-1:0] o_2;
output signed[w-1:0] o_3;
//output signed[w-1:0] o_4;
//output signed[w-1:0] o_5;

//internal wire
//stage 1
wire signed[w-1:0] 	s1_1, 
					s1_2,
					s1_3,
					s1_4,
					s1_5
;

//stage 2
wire signed[w-1:0] 	s2_1,
					s2_2,
					s2_3,
					s2_4,
					s2_5
;

//stage 3
wire signed[w-1:0] 	s3_1,
					s3_2,
					s3_3,
					s3_4,
					s3_5
;

//stage 4 
wire signed[w-1:0] 	s4_1,
					s4_2,
					s4_3,
					s4_4,
					s4_5
;

//stage 1
assign	{s1_1,s1_2} = (i_2 > i_1) ? {i_2,i_1} : {i_1,i_2},
		{s1_3,s1_4} = (i_4 > i_3) ? {i_4,i_3} : {i_3,i_4},
		s1_5 = i_5;
	   
//stage 2
assign	s2_1 = s1_1,
		{s2_2,s2_3} = (s1_3 > s1_2) ? {s1_3,s1_2} : {s1_2,s1_3},
		{s2_4,s2_5} = (s1_5 > s1_4) ? {s1_5, s1_4} : {s1_4, s1_5};

//stage 3
assign	{s3_1,s3_2} = (s2_2 > s2_1) ? {s2_2,s2_1} : {s2_1,s2_2},
		{s3_3,s3_4} = (s2_4 > s2_3) ? {s2_4,s2_3} : {s2_3,s2_4},
		s3_5 = s2_5;
	   
//stage 4
assign 	s4_1 = s3_1,
		{s4_2,s4_3} = (s3_3 > s3_2) ? {s3_3,s3_2} : {s3_2,s3_3},
		{s4_4,s4_5} = (s3_5 > s3_4) ? {s3_5,s3_4} : {s3_4,s3_5};
		
//stage 5
assign 	o_2 = (s4_2 > s4_1) ? s4_1 : s4_2,
		o_3 = (s4_4 > s4_3) ? s4_4 : s4_3
		//o_5 = s4_5
;

endmodule




