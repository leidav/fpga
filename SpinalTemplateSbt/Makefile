PROJECT = counter

VERILOG_SRC = $(wildcard *.v)
SCALA_SRC = $(wildcard src/main/scala/mylib/*.scala)
GENERATED_SRC = Counter.v

#project config files
LPF_FILE = ulx3s_v20.lpf 
YOSYS_FILE = fpga_synth.ys

#build artifacts
YOSYS_OUTPUT_FILE = $(PROJECT).json
OUTPUT_CONFIG =  ulx3s_out.config

BIT_FILE = $(PROJECT).bit

all: $(BIT_FILE)

.PHONY: clean
clean:
	rm -rf $(GENERATED_SRC) $(YOSYS_OUTPUT_FILE) $(OUTPUT_CONFIG) $(BIT_FILE)

prog: $(BIT_FILE)
	fujprog $(BIT_FILE) 


$(BIT_FILE): $(OUTPUT_CONFIG) 
	ecppack $(OUTPUT_CONFIG) $(BIT_FILE)

$(OUTPUT_CONFIG): $(LPF_FILE) $(YOSYS_OUTPUT_FILE)
	nextpnr-ecp5 --85k --json $(YOSYS_OUTPUT_FILE)\
		--lpf $(LPF_FILE) \
		--textcfg $(OUTPUT_CONFIG)

$(YOSYS_OUTPUT_FILE): $(YOSYS_FILE) $(VERILOG_SRC) $(GENERATED_SRC)
	yosys $(YOSYS_FILE)

$(GENERATED_SRC): $(SCALA_SRC)
	sbt "runMain mylib.MyTopLevelVerilog"
