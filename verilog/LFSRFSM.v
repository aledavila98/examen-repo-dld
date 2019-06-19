module LFSRFSM(
    input clk,
    input rst,
    input isZero,
    input [31:0] start_state,
    output reg [3:0] raddr1,
    output reg [3:0] raddr2,
    output reg wen,
    output reg [3:0] waddr,
    output reg wdsrc,
    output reg [3:0] func,
    output reg [31:0] constant
);

reg [3:0] cs /* verilator public */, ns;

always @(posedge clk) begin
    if (rst)
        cs <= 4'd0;
    else
        cs <= ns;
end

always @(*) begin
    case (cs)
    4'd0: ns = 4'd1;
    4'd1: ns = 4'd2;
    4'd2: ns = 4'd3;
    4'd3: ns = 4'd4;
    4'd4: ns = 4'd5;
    4'd6: ns = 4'd6; 
    4'd6: ns = 4'd7;
    4'd7: ns = 4'd8;
    4'd9: ns = 4'd9;
    4'd10: ns = 4'd10:
    4'd11: ns = 4'd12;
    4'd12: ns = isZero ? 4'd13 : 4'd4;
    4'd13: ns = 4'd13;
    default: ns = 4'dx;
    endcase
end

always @(*) begin
    case (cs)
    4'd0: begin
        wen = 1;
        waddr = 4'd0;
        wdsrc = 0;
        constant = start_state;
    end
    4'd1: begin
        wen = 1;
        waddr = 4'd1;
        wdsrc = 0;
        constant = start_state;
    end
    4'd2: begin
        wen = 1;
        waddr = 4'd2;
        wdsrc = 0;
        constant = 32'd0;
    end
    4'd3: begin
        wen = 1;
        waddr = 4'd3;
        wdsrc = 0;
        constant = 32'd0;
    end
    4'd4: begin
        raddr1 = 4'd1;
        wen = 1;
        wdsrc = 0;
        waddr = 4'd4;
        constant = 32'd0;
        func = `SHR;        
    end
    4'd5: begin
        raddr1 = 4'd1;
        wen = 1;
        wdsrc = 0;
        waddr = 4'd5;
        constant = 32'd2;
        func = `SHR;        
    end
    4'd6: begin
        raddr1 = 4'd4;
        raddr2 = 4'd5;
        wen = 1;
        wdsrc = 1;
        waddr = 4'd6;
        func = `XOR;
    end
    4'd7: begin
        raddr1 = 4'd1;
        wen = 1;
        wdsrc = 0;
        waddr = 4'd7;
        constant = 32'd3;
        func = `SHR; 
    end
    4'd6: begin
        raddr1 = 4'd6;
        raddr2 = 4'd7;
        wen = 1;
        wdsrc = 1;
        waddr = 4'd8;
        func = `XOR;
    end
    4'd7: begin
        raddr1 = 4'd1;
        wen = 1;
        wdsrc = 0;
        waddr = 4'd9;
        constant = 32'd5;
        func = `SHR; 
    end
    4'd8: begin
        raddr1 = 4'd8;
        raddr2 = 4'd9;
        wen = 1;
        wdsrc = 1;
        waddr = 4'd2;
        func = `XOR;
    end
    4'd9: begin
        raddr1 = 4'd1;
        wen = 1;
        wdsrc = 0;
        waddr = 4'd10;
        constant = 32'd1;
        func = `SHR;  
    end
    4'd10: begin
        raddr1 = 4'd1;
        wen = 1;
        wdsrc = 0;
        waddr = 4'd11;
        constant = 32'd15;
        func = `SLT;  
    end
    4'd11: begin
        raddr1 = 4'd10;
        raddr2 = 4'd11;
        wen = 1;
        wdsrc = 1;
        waddr = 4'd1;
        func = `XOR;
    end
    4'd12: begin
        raddr1 = 4'd3;
        wen = 1;
        wdsrc = 0;
        waddr = 4'd3;
        constant = 32'd1;
        func = `ADD; 
    end
    4'd16: ;
    default: ;
    endcase
end

endmodule