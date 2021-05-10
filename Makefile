PROJECT = blinky

SYNTHESIS_TOP = fpga.v

VERILOG_SRC = fpga.v blinky.v

LPF_FILE = ulx3s_v20.lpf 
YOSYS_FILE = $(PROJECT).ys
BIT_FILE = $(PROJECT).bit
YOSYS_OUTPUT_FILE = $(PROJECT).json
OUTPUT_CONFIG =  ulx3s_out.config

all: $(BIT_FILE)

.PHONY: clean
clean:
	rm -rf $(YOSYS_OUTPUT_FILE) $(OUTPUT_CONFIG) $(BIT_FILE)

prog: $(BIT_FILE)
	fujprog $(BIT_FILE) 


$(BIT_FILE): $(OUTPUT_CONFIG) 
	ecppack $(OUTPUT_CONFIG) $(BIT_FILE)

$(OUTPUT_CONFIG): $(YOSYS_OUTPUT_FILE)
	nextpnr-ecp5 --85k --json $(YOSYS_OUTPUT_FILE)\
		--lpf $(LPF_FILE) \
		--textcfg $(OUTPUT_CONFIG)

$(YOSYS_OUTPUT_FILE):$(YOSYS_FILE) $(SYNTHESIS_TOP)
	yosys $(YOSYS_FILE)
	

