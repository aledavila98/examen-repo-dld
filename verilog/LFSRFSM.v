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

reg [2:0] cs /* verilator public */, ns;

always @(posedge clk) begin
    if (rst)
        cs <= 3'd0;
    else
        cs <= ns;
end

always @(*) begin
    case (cs)
    3'd0: ns = 3'd1;
    3'd1: ns = 3'd2;
    3'd2: ns = 3'd3;
    3'd3: ns = 3'd4;
    3'd4: ns = 3'd5;
    3'd6: ns = 3'd6; 
    3'd6: ns = isZero ? 3'd7 : 3'd4;
    3'd7: ns = 3'd7;
    default: ns = 3'dx;
    endcase
end

always @(*) begin
    case (cs)
    3'd0: begin
        wen = 1;
        waddr = 4'd0;
        wdsrc = 0;
        constant = start_state;
    end
    3'd1: begin
        wen = 1;
        waddr = 4'd1;
        wdsrc = 0;
        constant = start_state;
    end
    3'd2: begin
        wen = 1;
        waddr = 4'd2;
        wdsrc = 0;
        constant = 32'd0;
    end
    3'd3: begin
        wen = 1;
        waddr = 4'd3;
        wdsrc = 0;
        constant = 32'd0;
    end
    3'd4: begin
        raddr1 = 4'd1;
        wen = 1;
        wdsrc = 0;
        waddr = 4'd4;
        constant = 32'd0;
        func = `SHR;        
    end
    3'd5: begin
        raddr1 = 4'd1;
        wen = 1;
        wdsrc = 0;
        waddr = 4'd5;
        constant = 32'd2;
        func = `SHR;        
    end
    3'd6: begin
        raddr1 = 4'd4;
        raddr2 = 4'd5;
        wen = 1;
        wdsrc = 1;
        waddr = 4'd6;
        func = `XOR;
    end
    3'd7: begin
        raddr1 = 4'd1;
        wen = 1;
        wdsrc = 0;
        waddr = 4'd7;
        constant = 32'd3;
        func = `SHR; 
    end
     3'd6: begin
        raddr1 = 4'd6;
        raddr2 = 4'd7;
        wen = 1;
        wdsrc = 1;
        waddr = 4'd8;
        func = `XOR;
    end
    3'd7: begin
        raddr1 = 4'd1;
        wen = 1;
        wdsrc = 0;
        waddr = 4'd9;
        constant = 32'd5;
        func = `SHR; 
    end
    3'd8: begin
        raddr1 = 4'd8;
        raddr2 = 4'd9;
        wen = 1;
        wdsrc = 1;
        waddr = 4'd2;
        func = `XOR;
    end
    3'd9: begin
        raddr1 = 4'd1;
        wen = 1;
        wdsrc = 0;
        waddr = 4'd10;
        constant = 32'd1;
        func = `SHR;  
    end
    3'd9: begin
        raddr1 = 4'd1;
        wen = 1;
        wdsrc = 0;
        waddr = 4'd11;
        constant = 32'd15;
        func = `SLT;  
    end
    3'd8: begin
        raddr1 = 4'd10;
        raddr2 = 4'd11;
        wen = 1;
        wdsrc = 1;
        waddr = 4'd1;
        func = `XOR;
    end
    3'd9: begin
        raddr1 = 4'd3;
        wen = 1;
        wdsrc = 0;
        waddr = 4'd3;
        constant = 32'd1;
        func = `ADD; 
    end
    endcase
end

endmodule