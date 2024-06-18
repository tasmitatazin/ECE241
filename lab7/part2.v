module part2(iResetn,iPlotBox,iBlack,iColour,iLoadX,iXY_Coord,iClock,oX,oY,oColour,oPlot,oDone);
   parameter X_SCREEN_PIXELS = 8'd160;
   parameter Y_SCREEN_PIXELS = 7'd120;

   input wire iResetn, iPlotBox, iBlack, iLoadX;
   input wire [2:0] iColour;
   input wire [6:0] iXY_Coord;
   input wire 	    iClock;

   output wire [7:0] oX;         // VGA pixel coordinates
   output wire [6:0] oY;

   output wire [2:0] oColour;     // VGA pixel colour (0-7)
   output wire 	     oPlot;       // Pixel draw enable
   output wire       oDone;       // goes high when finished drawing frame
   
   wire load_x, load_y, load_color, start_draw, start_draw_black,draw_done;

   
   // Your code goes here
  

 control u1 (
.clock(iClock), 
.iResetn(iResetn),
.iPlotBox(iPlotBox),
.iBlack( iBlack),
.iLoadX( iLoadX),
.load_x(load_x),. load_y(load_y), 
.load_color(load_color),
 .start_draw(start_draw), 
.start_draw_black(start_draw_black), 
.draw_done(draw_done),
.oDone(oDone));

wire [7:0] x_start, dim_x;         
wire [6:0] y_start, dim_y;
wire go;
wire [7:0] wx; 
wire [6:0] wy;

size  #(X_SCREEN_PIXELS, Y_SCREEN_PIXELS) u0 (.wx(wx), .wy(wy));

data_path u2 ( 
.clock(iClock), 
.reset((iResetn)), 
.load_x(load_x), 
.load_y(load_y), 
.load_color(load_color), 
.start_draw(start_draw), 
.start_draw_black(start_draw_black), 
.x_start(x_start), 
.y_start(y_start), 
.dim_x(dim_x), 
.dim_y(dim_y),
.wx(wx), 
.wy(wy),
 .Ocolor(oColour), .iColour(iColour), 
 .iXY_Coord(iXY_Coord), 
.go(go));

draw_box u3 (
  .clk((iClock)),
 .resetn(iResetn),
  .draw(go),
  .start_x(x_start),
  .start_y(y_start),
 .x_size(dim_x), 
  .y_size(dim_y), 
  .cur_x(oX),
  .cur_y(oY),
  .plot(oPlot),
  .done(draw_done)
);
   

endmodule





module control(clock, iResetn, iPlotBox, iBlack, iLoadX,load_x, load_y, load_color, start_draw, start_draw_black, draw_done, oDone);


    input clock, iResetn, iPlotBox, iBlack, iLoadX, draw_done; //draw done is draw box saying done

    output reg load_x; //bits need to be changed 
    output reg load_y; //number of bits needs to be changed 
    output reg load_color;  //change bits 
    output reg start_draw; 
    output reg start_draw_black;
    output reg oDone; //oDone stays active in S_done
   
    reg [3:0] current_state, next_state; //10 states in total 
 
               localparam   SO                =4'd0, //figure out decimal bits 
                        S_getx           =4'd1,
                        S_wait           =4'd2,
                        S_load_Y      =4'd3,
                        S_draw         =4'd4,
                        S_drawing = 4'd5,
                        S_done         =4'd6,
                        S_done_plot_wait       =4'd7,
                        S_Black       =4'd8,
                        S_draw_black             =4'd9;
                       

                        
          always@(*)
          begin: state_table 
              case (current_state) 
                        SO : begin if (iLoadX == 1)  begin next_state = S_getx; end
							         else if (iBlack == 1) begin next_state = S_Black; end
										else begin next_state = SO; end end
								
			S_getx: begin next_state =  iLoadX? S_getx : S_wait; load_x=iLoadX; end					
                        S_wait : next_state = iPlotBox? S_load_Y : S_wait; 
			S_load_Y: begin next_state = iPlotBox ? S_load_Y: S_draw;
							end
					
                        S_draw : next_state = S_drawing;
                        S_drawing: next_state = draw_done ? S_done: S_drawing; 
								S_Black: next_state = iBlack? S_Black :S_draw_black;
                        S_done: next_state =SO;
								S_draw_black: next_state = S_drawing;

                       default:     next_state =SO;
        endcase
		    end // state_table

// Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals 
  // By default make all our signals 0
    load_x=0;  //bits need to be changed 
    load_y=0; //number of bits needs to be changed 
    load_color=0; //change bits 
    start_draw=0; 
    start_draw_black=0; //change bits 
    oDone=draw_done;

    case(current_state)
      SO: begin  //everything is already set to zero by default 
       end
      S_getx : begin 
       load_x=1;
        end
      S_wait: begin load_y = 1;load_color=1;
        end
      S_load_Y: begin 
              load_color=iPlotBox;
              load_y = iPlotBox;

		
	end
      S_draw: begin 
	start_draw=1;
        oDone=0;
	
	end
	S_drawing: begin oDone=0; end
        
     S_done: begin 
	oDone=0;
	end
              
    S_draw_black: begin 
        start_draw_black=1'b1;
	end

endcase
end //end of enable signals 

//current state register 
always@(posedge clock)
begin
 if (!iResetn)
   current_state<= SO;
 else
current_state<=next_state; 
end

endmodule 



//to turn screen pixels parameter to signals
module size(
    output wire [7:0] wx,
    output wire [6:0] wy
);
   parameter X_SCREEN_PIXELS = 8'd160;
   parameter Y_SCREEN_PIXELS = 7'd120;
   assign wx = X_SCREEN_PIXELS;
   assign wy = Y_SCREEN_PIXELS;
endmodule

module data_path ( clock, reset, load_x, load_y, load_color, start_draw, start_draw_black, x_start, y_start, dim_x, dim_y, wx, wy, Ocolor, iColour,  iXY_Coord, go);


     input  load_x, load_y, load_color, start_draw, start_draw_black, clock, reset;
     output reg  go;
     output reg [7:0] x_start,  dim_x;
     output reg [6:0] y_start, dim_y;
     output reg [2:0] Ocolor;
     input wire [2:0] iColour;
     input wire [6:0] iXY_Coord;
    

//size of screen
  input  wire [7:0] wx; 
  input wire [6:0] wy;


    always@(posedge clock) begin
	    go <= 0;

        if (!reset) begin
              x_start<= 0;
              y_start<= 0;
              dim_x  <= 4;
              dim_y  <= 4; 
  	      Ocolor <= 0 ;
  	      go <= 0; end
        else if (load_x) begin
              x_start <= iXY_Coord; end
        else if (load_color && load_y) begin
	y_start <= iXY_Coord;
           Ocolor<= iColour; end
        else if  (start_draw) begin
             go <= 1; 
             dim_x  <= 4;
             dim_y  <= 4;  end
         else if (start_draw_black) begin
            go <= 1; 
           Ocolor <= 0;
              x_start<= 0;
              y_start<= 0;
              dim_x  <= wx;
              dim_y  <= wy; end
end
 
               
         


endmodule

module draw_box (
  input clk, input resetn,
  input wire draw,
  input wire [7:0] start_x,
  input wire [6:0] start_y,
  input wire [7:0] x_size, 
  input wire [6:0] y_size, 
  output wire [7:0] cur_x,
  output wire [6:0] cur_y,
  output reg plot,
  output reg done
);

  localparam s_idle = 2'b00, s_draw = 2'b01, s_done = 2'b10;

  reg [1:0] state;
  reg [7:0] current_x, x_dim, starting_x;
  reg [6:0] current_y, y_dim, starting_y;



  always @(posedge clk) begin

      plot <= 1'b0;
      done <= 1'b0;


    if (!resetn) begin
      state <= s_idle;
      current_x <= 8'b0;
      current_y <= 7'b0;
      plot <= 1'b0;
      done <= 1'b0;
      x_dim <= 0;
      y_dim <= 0;
    end else begin
      case(state)
        s_idle: begin
          if (draw) begin
            state <= s_draw;
            current_x <= start_x;
            starting_x <= start_x;
            current_y <= start_y;
            starting_y <= start_y;
            x_dim <= x_size;
            y_dim <= y_size;
            plot <= 1'b1;
          end
          done <= 1'b0;
        end
        s_draw:begin
           plot <= 1'b1;
          if (current_x < (starting_x + x_dim - 1)) begin
            current_x <= current_x + 1;
          end else if (current_y < (starting_y + y_dim - 1)) begin
            current_x <= starting_x;
            current_y <= current_y + 1;
          end else begin
            state <= s_done;
            plot <= 1'b0;
          end
         end
            
        s_done: begin
          
          plot <= 1'b0;
          done <= 1'b1;

           if (draw) begin
            state <= s_draw;
            current_x <= start_x;
            starting_x <= start_x;
            current_y <= start_y;
            starting_y <= start_y;
            x_dim <= x_size;
            y_dim <= y_size;
            plot <= 1'b1;
	    done <=0;
          end
        end
      endcase
    end
  end

  assign cur_x = current_x;
  assign cur_y = current_y;

endmodule




