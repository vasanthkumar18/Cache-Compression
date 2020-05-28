module COMPRESSOR(clock,UnCompressedCache,CompressedCache,DeCompressedCache);
input clock;
input [255:0]UnCompressedCache;
output reg[255:0]CompressedCache,DeCompressedCache;
reg mark8_1=0,mark8_2=0,mark8_3=0;
reg mark4_1 = 0, mark4_2 = 0,mark4_3 = 0,mark4_4 = 0,mark4_5 = 0,mark4_6 = 0,mark4_7 = 0;
reg mark2_1 = 0, mark2_2 = 0,mark2_3 = 0,mark2_4 = 0,mark2_5 = 0,mark2_6 = 0,mark2_7 = 0,mark2_8 = 0,
    mark2_9 = 0,mark2_10 = 0,mark2_11 = 0,mark2_12 = 0,mark2_13 = 0,mark2_14 = 0,mark2_15 = 0;

reg [95:0]CCL1,CCL4;
reg [127:0]CCL2;
reg [191:0]CCL3;
reg [159:0]CCL5;
reg [143:0]CCL6;

reg CoN1,CoN2,CoN3,CoN4,CoN5,CoN6,CoN7,CoN8;
reg [63:0]Base8;
reg [63:0]del8_1,del8_2,del8_3;
reg [31:0]Base4;
reg [31:0] del4_1,del4_2,del4_3,del4_4,del4_5,del4_6,del4_7;
reg [15:0]Base2;
reg [15:0] del2_1,del2_2,del2_3,del2_4,del2_5,del2_6,del2_7,del2_8,del2_9,del2_10,del2_11,del2_12,del2_13,del2_14,del2_15;




//COMPRESSOR BLOCK

always @ (posedge clock)
begin

Base8 = UnCompressedCache[63:0]; //Base is the first value
Base4 = UnCompressedCache[31:0];
Base2 = UnCompressedCache[15:0];

$display("input = %h\n",UnCompressedCache);

//BASE 8

//Calculating all the deltas
if (Base8 > UnCompressedCache[127:64])
del8_1 = Base8 - UnCompressedCache[127:64];
else 
begin
del8_1 = UnCompressedCache[127:64] - Base8 ;
mark8_1 =1;
end

if (Base8 > UnCompressedCache[191:128])
del8_2 = Base8 - UnCompressedCache[191:128];
else 
begin
del8_2 = UnCompressedCache[191:128] - Base8 ;
mark8_2 = 1;
end

if (Base8 > UnCompressedCache[255:192])
del8_3 = Base8 - UnCompressedCache[255:192];
else 
begin
del8_3 = UnCompressedCache[255:192] - Base8 ;
mark8_3=1;
end
$display (" 8_1: del1= %h, del2 =%h, del3 = %h \n",del8_1,del8_2,del8_3);


// Delta = 1 byte
if( ((del8_1[63:8]==56'hFFFFFFFFFFFFFF) || (del8_1[63:8]==56'h00000000000000)) && ((del8_2[63:8]==56'hFFFFFFFFFFFFFF) || (del8_2[63:8]==56'h00000000000000))
		&& ((del8_3[63:8]==56'hFFFFFFFFFFFFFF) || (del8_3[63:8]==56'h00000000000000)))
begin
CoN1=1;
CCL1 = {del8_3[7:0],del8_2[7:0],del8_1[7:0],8'd0,Base8};
end

else 
begin
CoN1 =0;
end
$display ("CoN1 = %b, CCL1 = %h ", CoN1,CCL1);

// Delta = 2 bytes
if( ((del8_1[63:16]==48'hFFFFFFFFFFFF) || (del8_1[63:16]==48'h000000000000)) && ((del8_2[63:16]==48'hFFFFFFFFFFFF) || (del8_2[63:16]==48'h000000000000))
		&& ((del8_3[63:16]==48'hFFFFFFFFFFFF) || (del8_3[63:16]==48'h000000000000)))
begin
CoN2=1;
CCL2 = {del8_3[15:0],del8_2[15:0],del8_1[15:0],16'd0,Base8};
end

else 
begin
CoN2 =0;
end
$display ("CoN2 = %b, CCL2 = %h ", CoN2,CCL2);

// Delta = 4 bytes
if( ((del8_1[63:32]==32'hFFFFFFFF) || (del8_1[63:32]==32'h00000000)) && ((del8_2[63:32]==32'hFFFFFFFF) || (del8_2[63:32]==32'h00000000))
		&& ((del8_3[63:32]==32'hFFFFFFFF) || (del8_3[63:32]==32'h00000000)))
begin
CoN3=1;
CCL3 = {del8_3[31:0],del8_2[31:0],del8_1[31:0],32'd0,Base8};
end

else 
begin
CoN3 =0;
end
$display ("CoN3 = %b, CCL3 = %h ", CoN3,CCL3);



//BASE 4

//Calculating all the deltas

if (Base4 > UnCompressedCache[63:32])
del4_1 = Base4 - UnCompressedCache[63:32];
else 
begin
del4_1 = UnCompressedCache[63:32] - Base4 ;
mark4_1 =1;
end

if (Base4 > UnCompressedCache[95:64])
del4_2 = Base4 - UnCompressedCache[95:64];
else 
begin
del4_2 = UnCompressedCache[95:64] - Base4 ;
mark4_2 =1;
end

if (Base4 > UnCompressedCache[127:96])
del4_3 = Base4 - UnCompressedCache[127:96];
else 
begin
del4_3 = UnCompressedCache[127:96] - Base4 ;
mark4_3 =1;
end

if (Base4 > UnCompressedCache[159:128])
del4_4 = Base4 - UnCompressedCache[159:128];
else 
begin
del4_4 = UnCompressedCache[159:128] - Base4 ;
mark4_4 =1;
end

if (Base4 > UnCompressedCache[191:160])
del4_5 = Base4 - UnCompressedCache[191:160];
else 
begin
del4_5 = UnCompressedCache[191:160] - Base4 ;
mark4_5 =1;
end

if (Base4 > UnCompressedCache[223:192])
del4_6 = Base4 - UnCompressedCache[223:192];
else 
begin
del4_6 = UnCompressedCache[223:192] - Base4 ;
mark4_6 =1;
end

if (Base4 > UnCompressedCache[255:224])
del4_7 = Base4 - UnCompressedCache[255:224];
else 
begin
del4_7 = UnCompressedCache[255:224] - Base4 ;
mark4_7 =1;
end


$display (" BASE 4: del1= %h, del2 =%h, del3 = %h del4 = %h del5 = %h del6 = %h del7 = %h\n",del4_1,del4_2,del4_3,del4_4,del4_5,del4_6,del4_7);


// DELTA = 1 BYTE 
if( ((del4_1[31:8]==24'hFFFFFF) || (del4_1[31:8]==24'h000000)) && ((del4_2[31:8]==24'hFFFFFF) || (del4_2[31:8]==24'h000000))
		&& ((del4_3[31:8]==24'hFFFFFF) || (del4_3[31:8]==24'h000000))  && ((del4_4[31:8]==24'hFFFFFF) || (del4_4[31:8]==24'h000000))  
		&& ((del4_5[31:8]==24'hFFFFFF) || (del4_5[31:8]==24'h000000))  && ((del4_6[31:8]==24'hFFFFFF) || (del4_6[31:8]==24'h000000))
		&& ((del4_7[31:8]==24'hFFFFFF) || (del4_7[31:8]==24'h000000)))
begin
CoN4=1;
CCL4 = {del4_7[7:0],del4_6[7:0],del4_5[7:0],del4_4[7:0],del4_3[7:0],del4_2[7:0],del4_1[7:0],8'd0,Base4};
end

else 
begin
CoN4 =0;
end
$display ("CoN4 = %b, CCL4 = %h ", CoN4,CCL4);


// DELTA = 2 BYTES
if( ((del4_1[31:16]==16'hFFFF) || (del4_1[31:16]==16'h0000)) && ((del4_2[31:16]==16'hFFFF) || (del4_2[31:16]==16'h0000))
		&& ((del4_3[31:16]==16'hFFFF) || (del4_3[31:16]==16'h0000))  && ((del4_4[31:16]==16'hFFFF) || (del4_4[31:16]==16'h0000))  
		&& ((del4_5[31:16]==16'hFFFF) || (del4_5[31:16]==16'h0000))  && ((del4_6[31:16]==16'hFFFF) || (del4_6[31:16]==16'h0000))
		&& ((del4_7[31:16]==16'hFFFF) || (del4_7[31:16]==16'h0000)))
begin
CoN5=1;
CCL5 = {del4_7[15:0],del4_6[15:0],del4_5[15:0],del4_4[15:0],del4_3[15:0],del4_2[15:0],del4_1[15:0],16'd0,Base4};
end

else 
begin
CoN5 =0;
end
$display ("CoN5 = %b, CCL5 = %h ", CoN5,CCL5);



//BASE 2

//Calculating all the deltas

if (Base2 > UnCompressedCache[31:16])
del2_1 = Base2 - UnCompressedCache[31:16];
else 
begin
del2_1 = UnCompressedCache[31:16] - Base2 ;
mark2_1 =1;
end

if (Base2 > UnCompressedCache[47:32])
del2_2 = Base2 - UnCompressedCache[47:32];
else 
begin
del2_2 = UnCompressedCache[47:32] - Base2 ;
mark2_2 =1;
end

if (Base2 > UnCompressedCache[63:48])
del2_3 = Base2 - UnCompressedCache[63:48];
else 
begin
del2_3 = UnCompressedCache[63:48] - Base2 ;
mark2_3 =1;
end

if (Base2 > UnCompressedCache[79:64])
del2_4 = Base2 - UnCompressedCache[79:64];
else 
begin
del2_4 = UnCompressedCache[79:64] - Base2 ;
mark2_4 =1;
end

if (Base2 > UnCompressedCache[95:80])
del2_5 = Base2 - UnCompressedCache[95:80];
else 
begin
del2_5 = UnCompressedCache[95:80] - Base2 ;
mark2_5 =1;
end

if (Base2 > UnCompressedCache[111:96])
del2_6 = Base2 - UnCompressedCache[111:96];
else 
begin
del2_6 = UnCompressedCache[111:96] - Base2 ;
mark2_6 =1;
end

if (Base2 > UnCompressedCache[127:112])
del2_6 = Base2 - UnCompressedCache[127:112];
else 
begin
del2_6 = UnCompressedCache[127:112] - Base2 ;
mark2_6 =1;
end

if (Base2 > UnCompressedCache[143:128])
del2_7 = Base2 - UnCompressedCache[143:128];
else 
begin
del2_7 = UnCompressedCache[143:128] - Base2 ;
mark2_7 =1;
end

if (Base2 > UnCompressedCache[159:144])
del2_8 = Base2 - UnCompressedCache[159:144];
else 
begin
del2_8 = UnCompressedCache[159:144] - Base2 ;
mark2_8 =1;
end

if (Base2 > UnCompressedCache[175:160])
del2_9 = Base2 - UnCompressedCache[175:160];
else 
begin
del2_9 = UnCompressedCache[175:160] - Base2 ;
mark2_9 =1;
end

if (Base2 > UnCompressedCache[191:176])
del2_10 = Base2 - UnCompressedCache[191:176];
else 
begin
del2_10 = UnCompressedCache[191:176] - Base2 ;
mark2_10 =1;
end

if (Base2 > UnCompressedCache[191:176])
del2_11 = Base2 - UnCompressedCache[191:176];
else 
begin
del2_11 = UnCompressedCache[191:176] - Base2 ;
mark2_11 =1;
end

if (Base2 > UnCompressedCache[207:192])
del2_12 = Base2 - UnCompressedCache[207:192];
else 
begin
del2_12 = UnCompressedCache[207:192] - Base2 ;
mark2_12 =1;
end

if (Base2 > UnCompressedCache[223:208])
del2_13 = Base2 - UnCompressedCache[223:208];
else 
begin
del2_13 = UnCompressedCache[223:208] - Base2 ;
mark2_13 =1;
end

if (Base2 > UnCompressedCache[239:224])
del2_14 = Base2 - UnCompressedCache[239:224];
else 
begin
del2_14 = UnCompressedCache[239:224] - Base2 ;
mark2_14 =1;
end

if (Base2 > UnCompressedCache[255:240])
del2_15 = Base2 - UnCompressedCache[255:240];
else 
begin
del2_15 = UnCompressedCache[255:240] - Base2 ;
mark2_15 =1;
end

$display (" BASE 2: del1= %h, del2 =%h, del3 = %h del4 = %h del5 = %h del6 = %h del7 = %h	del8= %h, del9 =%h, del10 = %h del11 = %h del12 = %h del13 = %h del14 = %h del7 = %h \n"
				,del2_1,del2_2,del2_3,del2_4,del2_5,del2_6,del2_7,del2_8,del2_9,del2_10,del2_11,del2_12,del2_13,del2_14,del2_15);

// DELTA = 1 BYTE 
if( ((del2_1[15:8]==24'hFF) || (del2_1[15:8]==24'h00)) && ((del2_2[15:8]==24'hFF) || (del2_2[15:8]==24'h00))
		&& ((del2_3[15:8]==24'hFF) || (del2_3[15:8]==24'h00))  && ((del2_4[15:8]==24'hFF) || (del2_4[15:8]==24'h00))  
		&& ((del2_5[15:8]==24'hFF) || (del2_5[15:8]==24'h00))  && ((del2_6[15:8]==24'hFF) || (del2_6[15:8]==24'h00))
		&& ((del2_7[15:8]==24'hFF) || (del2_7[15:8]==24'h00))  && ((del2_8[15:8]==24'hFF) || (del2_8[15:8]==24'h00))
		&& ((del2_9[15:8]==24'hFF) || (del2_9[15:8]==24'h00))  && ((del2_10[15:8]==24'hFF) || (del2_10[15:8]==24'h00))
		&& ((del2_11[15:8]==24'hFF)|| (del2_11[15:8]==24'h00))&& ((del2_12[15:8]==24'hFF) || (del2_12[15:8]==24'h00))
		&& ((del2_13[15:8]==24'hFF)|| (del2_13[15:8]==24'h00))&& ((del2_14[15:8]==24'hFF) || (del2_14[15:8]==24'h00))
		&& ((del2_15[15:8]==24'hFF)|| (del2_15[15:8]==24'h00)))
begin
CoN6=1;
CCL6 = {del2_15[7:0],del2_14[7:0],del2_13[7:0],del2_12[7:0],del2_11[7:0],del2_10[7:0],del2_9[7:0],del2_8[7:0],del2_7[7:0],del2_6[7:0],del2_5[7:0],del2_4[7:0],del2_3[7:0],del2_2[7:0],del2_1[7:0],8'd0,Base2};
end

else 
begin
CoN6 =0;
end
$display ("CoN6 = %b, CCL6 = %h ", CoN6,CCL6);
end






// DECOMPRESSOR BLOCK

always @ (posedge clock)
begin

//BASE 8 DEL 1 BYTE
if(CoN1==1)
begin
CompressedCache = CCL1;
DeCompressedCache[63:0] = CompressedCache[63:0]; //Base8

if (mark8_1 ==0)
DeCompressedCache[127:64] = Base8 - CompressedCache[79:72];
else 
DeCompressedCache[127:64] = CompressedCache[79:72]- Base8 ;

if (mark8_2 ==0)
DeCompressedCache[191:128] = Base8 - CompressedCache[87:80];
else 
DeCompressedCache[191:128] = CompressedCache[87:80]- Base8 ;

if (mark8_3 ==0)
DeCompressedCache[255:192] = Base8 - CompressedCache[95:88];
else 
DeCompressedCache[255:192] = CompressedCache[95:88]- Base8 ;

end

//BASE 8 DEL 2 BYTES
else if(CoN2==1)
begin
CompressedCache = CCL2;
DeCompressedCache[63:0] = CompressedCache[63:0]; //Base8

if (mark8_1 ==0)
DeCompressedCache[127:64] = Base8 - CompressedCache[95:80];
else 
DeCompressedCache[127:64] = CompressedCache[95:80]- Base8 ;

if (mark8_2 ==0)
DeCompressedCache[191:128] = Base8 - CompressedCache[111:96];
else 
DeCompressedCache[191:128] = CompressedCache[111:96]- Base8 ;

if (mark8_3 ==0)
DeCompressedCache[255:192] = Base8 - CompressedCache[127:112];
else 
DeCompressedCache[255:192] = CompressedCache[127:112]- Base8 ;

end

//BASE 8 DEL 4 BYTES
else if(CoN3==1)
begin
CompressedCache = CCL3;
DeCompressedCache[63:0] = CompressedCache[63:0]; //Base8

if (mark8_1 ==0)
DeCompressedCache[127:64] = Base8 - CompressedCache[127:96];
else 
DeCompressedCache[127:64] = CompressedCache[127:96]- Base8 ;

if (mark8_2 ==0)
DeCompressedCache[191:128] = Base8 - CompressedCache[159:128];
else 
DeCompressedCache[191:128] = CompressedCache[159:128]- Base8 ;

if (mark8_3 ==0)
DeCompressedCache[255:192] = Base8 - CompressedCache[191:160];
else 
DeCompressedCache[255:192] = CompressedCache[191:160]- Base8 ;
end

//BASE 4 DEL 1 BYTE
else if(CoN4==1)
begin
CompressedCache = CCL4; //96 BITS
DeCompressedCache[31:0] = CompressedCache[31:0]; //Base4

if (mark4_1 == 0)
DeCompressedCache[63:32] = Base4 - CompressedCache[47:40];
else 
DeCompressedCache[63:32] = CompressedCache[47:40]- Base4 ;

if (mark4_2 == 0)
DeCompressedCache[95:64] = Base4 - CompressedCache[55:48];
else 
DeCompressedCache[95:64] = CompressedCache[55:48]- Base4 ;

if (mark4_3 == 0)
DeCompressedCache[127:96] = Base4 - CompressedCache[63:56];
else 
DeCompressedCache[127:96] = CompressedCache[63:56]- Base4 ;

if (mark4_4 == 0)
DeCompressedCache[159:128] = Base4 - CompressedCache[71:64];
else 
DeCompressedCache[159:128] = CompressedCache[71:64]- Base4 ;

if (mark4_5 == 0)
DeCompressedCache[191:160] = Base4 - CompressedCache[79:72];
else 
DeCompressedCache[191:160] = CompressedCache[79:72]- Base4 ;

if (mark4_6 == 0)
DeCompressedCache[223:192] = Base4 - CompressedCache[87:80];
else 
DeCompressedCache[223:192] = CompressedCache[87:80]- Base4 ;

if (mark4_7 == 0)
DeCompressedCache[255:224] = Base4 - CompressedCache[95:88];
else 
DeCompressedCache[255:224] = CompressedCache[95:88]- Base4 ;
end

//BASE 4 DEL 2 BYTES
else if(CoN5==1)
begin
CompressedCache = CCL5; //160 BITS
DeCompressedCache[31:0] = CompressedCache[31:0]; //Base4

if (mark4_1 == 0)
DeCompressedCache[63:32] = Base4 - CompressedCache[63:48];
else 
DeCompressedCache[63:32] = CompressedCache[63:48]- Base4 ;

if (mark4_2 == 0)
DeCompressedCache[95:64] = Base4 - CompressedCache[79:64];
else 
DeCompressedCache[95:64] = CompressedCache[79:64]- Base4 ;

if (mark4_3 == 0)
DeCompressedCache[127:96] = Base4 - CompressedCache[95:80];
else 
DeCompressedCache[127:96] = CompressedCache[95:80]- Base4 ;

if (mark4_4 == 0)
DeCompressedCache[159:128] = Base4 - CompressedCache[111:96];
else 
DeCompressedCache[159:128] = CompressedCache[111:96]- Base4 ;

if (mark4_5 == 0)
DeCompressedCache[191:160] = Base4 - CompressedCache[127:112];
else 
DeCompressedCache[191:160] = CompressedCache[127:112]- Base4 ;

if (mark4_6 == 0)
DeCompressedCache[223:192] = Base4 - CompressedCache[143:128];
else 
DeCompressedCache[223:192] = CompressedCache[143:128]- Base4 ;

if (mark4_7 == 0)
DeCompressedCache[255:224] = Base4 - CompressedCache[159:144];
else 
DeCompressedCache[255:224] = CompressedCache[159:144]- Base4 ;
end


//BASE 2 DEL 1 BYTE
else if(CoN6==1)
begin
CompressedCache = CCL6; //144 BITS
DeCompressedCache[15:0] = CompressedCache[15:0]; //Base2

if (mark2_1 == 0)
DeCompressedCache[31:16] = Base2 - CompressedCache[31:24];
else 
DeCompressedCache[31:16] = CompressedCache[31:24]- Base2 ;

if (mark2_2 == 0)
DeCompressedCache[47:32] = Base2 - CompressedCache[39:32];
else 
DeCompressedCache[47:32] = CompressedCache[39:32]- Base2 ;

if (mark2_3 == 0)
DeCompressedCache[63:48] = Base2 - CompressedCache[47:40];
else 
DeCompressedCache[63:48] = CompressedCache[47:40]- Base2 ;

if (mark2_4 == 0)
DeCompressedCache[79:64] = Base2 - CompressedCache[55:48];
else 
DeCompressedCache[79:64] = CompressedCache[55:48]- Base2 ;

if (mark2_5 == 0)
DeCompressedCache[95:80] = Base2 - CompressedCache[63:56];
else 
DeCompressedCache[95:80] = CompressedCache[63:56]- Base2 ;

if (mark2_6 == 0)
DeCompressedCache[111:96] = Base2 - CompressedCache[71:64];
else 
DeCompressedCache[111:96] = CompressedCache[71:64]- Base2 ;

if (mark2_7 == 0)
DeCompressedCache[127:112] = Base2 - CompressedCache[79:72];
else 
DeCompressedCache[127:112] = CompressedCache[79:72]- Base2 ;

if (mark2_8 == 0)
DeCompressedCache[143:128] = Base2 - CompressedCache[87:80];
else 
DeCompressedCache[143:128] = CompressedCache[87:80]- Base2 ;

if (mark2_9 == 0)
DeCompressedCache[159:144] = Base2 - CompressedCache[95:88];
else 
DeCompressedCache[159:144] = CompressedCache[95:88]- Base2 ;

if (mark2_10 == 0)
DeCompressedCache[175:160] = Base2 - CompressedCache[103:96];
else 
DeCompressedCache[175:160] = CompressedCache[103:96]- Base2 ;

if (mark2_11 == 0)
DeCompressedCache[191:176] = Base2 - CompressedCache[111:104];
else 
DeCompressedCache[191:176] = CompressedCache[111:104]- Base2 ;

if (mark2_12 == 0)
DeCompressedCache[207:192] = Base2 - CompressedCache[119:112];
else 
DeCompressedCache[207:192] = CompressedCache[119:112]- Base2 ;

if (mark2_13 == 0)
DeCompressedCache[223:208] = Base2 - CompressedCache[127:120];
else 
DeCompressedCache[223:208] = CompressedCache[127:120]- Base2 ;

if (mark2_14 == 0)
DeCompressedCache[239:224] = Base2 - CompressedCache[135:128];
else 
DeCompressedCache[239:224] = CompressedCache[135:128]- Base2 ;

if (mark2_15 == 0)
DeCompressedCache[255:240] = Base2 - CompressedCache[143:136];
else 
DeCompressedCache[255:240] = CompressedCache[143:136]- Base2 ;
end

//No Compression feasible
else
CompressedCache = UnCompressedCache;


end

endmodule

