PROJECT = blinky

VERILOG_SRC = $(wildcard *.v)

#project config files
LPF_FILE = ulx3s_v20.lpf 
YOSYS_FILE = fpga_synth.ys
YOSYS_PLOT_FILE = plot_synth.ys

#build artifacts
YOSYS_OUTPUT_FILE = $(PROJECT).json
DOT_FILE = $(PROJECT).dot
OUTPUT_CONFIG =  ulx3s_out.config

BIT_FILE = $(PROJECT).bit
PDF= $(PROJECT).pdf

all: $(BIT_FILE) $(PDF)

.PHONY: clean
clean:
	rm -rf $(PDF) $(DOT_FILE) $(YOSYS_OUTPUT_FILE) $(OUTPUT_CONFIG) $(BIT_FILE)

prog: $(BIT_FILE)
	fujprog $(BIT_FILE) 


$(BIT_FILE): $(OUTPUT_CONFIG) 
	ecppack $(OUTPUT_CONFIG) $(BIT_FILE)

$(PDF): $(DOT_FILE)
	dot -T pdf $(DOT_FILE) > $(PDF)

$(OUTPUT_CONFIG): $(LPF_FILE) $(YOSYS_OUTPUT_FILE)
	nextpnr-ecp5 --85k --json $(YOSYS_OUTPUT_FILE)\
		--lpf $(LPF_FILE) \
		--textcfg $(OUTPUT_CONFIG)

$(YOSYS_OUTPUT_FILE): $(YOSYS_FILE) $(VERILOG_SRC)
	yosys $(YOSYS_FILE)

$(DOT_FILE): $(YOSYS_PLOT_FILE) $(VERILOG_SRC)
	yosys $(YOSYS_PLOT_FILE)
