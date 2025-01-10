module JAM(
    input CLK,
    input RST,
    output reg [2:0] W,
    output reg [2:0] J,
    input [6:0] Cost,
    output reg [3:0] MatchCount,
    output reg [9:0] MinCost,
    output reg Valid
);

// State definition
reg [2:0] state;
localparam IDLE = 3'd0;
localparam GET = 3'd1;
localparam CAL = 3'd2;
localparam FIND = 3'd3;
localparam SWAP = 3'd4;
localparam REVERSE = 3'd5;
localparam DONE = 3'd6;

// Work registers
reg [6:0] p[0:7];
reg [6:0] tmp;
reg [9:0] current_cost;
reg [3:0] counter;
// reg [2:0] pointer;
reg [3:0] reverse_start_pointer;
reg [3:0] reverse_end_pointer;
reg [3:0] current_max_pointer;
reg [6:0] current_max_value;
// reg test;
reg cost_ready;

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        state <= IDLE;
        Valid <= 0;
        MinCost <= 10'h3FF;  // Set to max value
        MatchCount <= 0;
        current_cost <= 0;
        counter <= 0;
        cost_ready <= 0;
        reverse_start_pointer <= 0;
        reverse_end_pointer <= 0;
        current_max_pointer <= 0;
        current_max_value <= 0;
        W <= 0;
        J <= 0;
        // test = 1'b0;
        // Initialize first permutation
        p[0] <= 0; p[1] <= 1; p[2] <= 2; p[3] <= 3;
        p[4] <= 4; p[5] <= 5; p[6] <= 6; p[7] <= 7;
    end
    else begin
        case(state)
            IDLE: begin
                current_cost <= 0;
                counter <= 0;
                cost_ready <= 0;
                state <= GET;
            end

            GET: begin
                if (!cost_ready) begin
                    case(counter)
                        0: begin J <= p[0]; W <= 0; end
                        1: begin J <= p[1]; W <= 1; end
                        2: begin J <= p[2]; W <= 2; end
                        3: begin J <= p[3]; W <= 3; end
                        4: begin J <= p[4]; W <= 4; end
                        5: begin J <= p[5]; W <= 5; end
                        6: begin J <= p[6]; W <= 6; end
                        7: begin J <= p[7]; W <= 7; end
                    endcase
                    cost_ready <= 1;
                end
                else begin
                    current_cost <= current_cost + Cost;
                    cost_ready <= 0;
                    if (counter == 7) begin
                        state <= CAL;
                        // counter <= 0;  // Reset counter for next use
                    end
                    else
                        counter <= counter + 1;
                end
            end

            CAL: begin
                // Update MinCost and MatchCount
                if (current_cost < MinCost) begin
                    MinCost <= current_cost;
                    MatchCount <= 1;
                end
                else if (current_cost == MinCost) begin
                    MatchCount <= MatchCount + 1;
                end
                
                counter <= 6;// Start from second last position
                state <= FIND;// Find next permutation
                  
            end

            FIND: begin
                if (counter >= 0 & counter <= 6 & p[counter] < p[counter + 1]) begin
                    reverse_start_pointer <= counter;  // 存儲替換點的位置
                    reverse_end_pointer <= 7;
                    current_max_pointer <= counter + 1;  // 初始化為右邊第一個數
                    current_max_value <= p[counter + 1];
                    counter <= counter + 2;  // 從替換點右邊第二個數開始找
                    state <= SWAP;
                end
                else if (counter > 0) begin
                    counter <= counter - 1;
                end
                else begin  // 7 6 5 4 3 2 1 0 -> Done
                    state <= DONE;
                end
            end
            
            SWAP: begin
                if(counter > 7) begin
                    // 交換替換點與找到的最小大數
                    // tmp <= p[reverse_start_pointer];
                    p[reverse_start_pointer] <= p[current_max_pointer];
                    p[current_max_pointer] <= p[reverse_start_pointer];
                    reverse_start_pointer <= reverse_start_pointer + 1;  // 更新反轉的起始位置
                    state <= REVERSE;
                end
                else begin
                    // 在替換點右邊找比替換點大的最小數
                    if(p[counter] > p[reverse_start_pointer] && p[counter] < current_max_value) begin
                        current_max_pointer <= counter;
                        current_max_value <= p[counter];
                    end
                    counter <= counter + 1;
                end
            end

            REVERSE: begin
                if(reverse_start_pointer >= reverse_end_pointer) begin
                    counter <= 0;
                    current_cost <= 0;
                    state <= GET;
                    
                end
                else begin
                    p[reverse_start_pointer] <= p[reverse_end_pointer];
                    p[reverse_end_pointer] <= p[reverse_start_pointer];
                    reverse_start_pointer <= reverse_start_pointer + 1;
                    reverse_end_pointer <= reverse_end_pointer - 1;
                end
            end
            DONE: begin
                Valid <= 1;
            end
        endcase
    end
end

endmodule