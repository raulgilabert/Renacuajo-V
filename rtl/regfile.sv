import renacuajo_types::*;

module regfile (
    input logic clk_i,
    input logic rst_n_i,
    input bus32_t rd_d_i,
    input reg_addr_t rd_addr_i,
    input logic we_i,
    input reg_addr_t rs1_addr_i,
    input reg_addr_t rs2_addr_i,
    output bus32_t rs1_d_o,
    output bus32_t rs2_d_o
);

    // Declare the register file
    reg_t[31:0] regs;

    // Assign the outputs
    assign rs1_d_o = regs[rs1_addr_i];
    assign rs2_d_o = regs[rs2_addr_i];

    // Reset the register file and write to it
    always_ff @(posedge clk_i or negedge rst_n_i)
    begin
        if (!rst_n_i)
        begin
            for (int i = 0; i < 32; i++) begin
                regs <= '0;
            end
        end
        else
        begin
            if (we_i)
            begin
                if (rd_addr_i != 0) begin // x0 is hardwired to 0
                    regs[rd_addr_i] <= rd_d_i;
                end
            end
        end
    end
endmodule