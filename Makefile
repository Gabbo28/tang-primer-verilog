TOP = top
SRC = ./src/*.v 
CST = ./syn/*.cst 
IMPL = ./impl/pnr/project.fs

TOP_TB = top_tb
SIM = ./sim/*.sv
BIN = ./sim/$(TOP_TB).vvp

LOADER = ../openFPGALoader
GW_SH = ../Gowin_V1.9.9.03_Education_linux/IDE/bin/gw_sh

.PHONY: clean

all: $(IMPL)

$(IMPL): $(SRC) $(CST)
	$(GW_SH) ./gowin.tcl

sim: $(BIN)
	vvp $(BIN) && mv ./*.vcd ./sim/.

$(BIN): $(SRC) $(SIM)
	iverilog -o $(BIN) -g2012 -s $(TOP_TB) $(SRC) $(SIM)

prog:
	$(LOADER) -b tangprimer20k $(IMPL)

flash:
	$(LOADER) -f -b tangprimer20k $(IMPL)

clean:
	rm -f -r ./impl/ ./sim/*.vvp ./sim/*.vcd
