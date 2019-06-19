module Divider(
    input clk,
    output reg oclk
);

reg [15:0] count, countp;
reg oclkp;

always @(posedge clk) begin
    count <= countp;
    oclk <= oclkp;
end

always @(*) begin
    countp = (count > 16'hC34F) ? 16'd0 : count + 16'd1;
    oclkp = (count > 16'hC34F) ? ~oclk : 0;
end

endmodule