module LFSRMain(
    input clk,
    input rst,
    output [31:0] result
);
    wire [3:0] raddr1;
    wire [3:0] raddr2;
    wire isZero;
    wire wen;
    wire [3:0] waddr;
    wire wdsrc;
    wire [3:0] func;
    wire [31:0] constant;
    wire alusrc;
    wire [31:0] aluconst;

    LFSRFSM fsm (
        .clk (clk),
        .rst (rst),
        .isZero (isZero),
        .raddr1 (raddr1),
        .raddr2 (raddr2),
        .wen (wen),
        .waddr (waddr),
        .wdsrc (wdsrc),
        .func (func),
        .constant (constant),
        .alusrc(alusrc),
        .aluconst(aluconst)
    );

    GPPM gppm (
        .clk (clk),
        .raddr1 (raddr1),
        .raddr2 (raddr2),
        .wen (wen),
        .waddr (waddr),
        .wdsrc (wdsrc),
        .func (func),
        .constant (constant),
        .alusrc(alusrc),
        .aluconst(aluconst),
        .isZero (isZero),
        .outrdata1(result)
    );
endmodule
