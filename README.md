# Sipeed Tang Primer 20K

Wiki: https://wiki.sipeed.com/hardware/en/tang/tang-primer-20k/primer-20k.html

IDE can be downloaded from Gowin site (requires registration) or from the course page (https://advancedsecurity.training/stream/?code=1VL4Q9JMZN).
Then you can syn&pnr via the GUI software (`Gowin_V1.9.9.03_Education_linux/IDE/bin/gw_ide`) or the cli tool (`one_day_verilog/Gowin_V1.9.9.03_Education_linux/IDE/bin/gw_sh`, see later)

To program use [openFPGAloader](https://trabucayre.github.io/openFPGALoader/)

## Programming

`openFPGALoader [-f] -b tangprimer20k litex_default.fs`

When you flash to volatile memory "SRAM" (without`-f`) there's one method, when you write to flash, there's another. There's a bug in flashing to flash with the default firmware on the BL702, which is the chip that's emulating an FTDI on the dock and is being used for both programming and UART duties.

The default firmware will get to 20-35% and say `mpsse_readError`. For this we need to update the firmware on the BL702

**Steps to update the Firmware on the BL702**
1. Disconnect everything and remove the sodimm (just in case). Also make sure you disconnect the raspberry pi, as both of these will be `/dev/ttyACM0` on Linux.
2. There's a `702-BOOT` button near the HDMI. Hold that as you plug the USB in. You should now see the BL702 in DFU as `/dev/ttyACM0`. If you don't see `/dev/ttyACM0` stop here, there's an issue somewhere.
3. Install the BL flashing utility from pip `pip3 install bflb-mcu-tool`. It will by default install to `$HOME/.local/bin`. Either add that to your path or call `~/.local/bin/bflb-mcu-tool`
4. With the BL702 in DFU call `bflb-mcu-tool --chipname=bl702 --port=/dev/ttyACM0 --xtal=32M --firmware=usb2uartjtag_bl702_uart_fix.bin`
5. Once it's flashed, disconnect USB, reconnect the SODIMM, reconnect the USB.
6. Now the `-f` flag, i.e., write to Flash, should work. Try `openFPGALoader -b tangprimer20k -f litex_default.fs`

## PNR & Synthesis

Copy `template/` folder to whatever your project is.

**CLI**  
Assuming Verilog files are under `src/` and constraint files under `syn/`, run the TCL script with `gw_sh gowin.tcl`.

**GUI**
1. Launch `gw_ide` 
2. Create a new project selecting the board "GW2A-18", inside of your project folder. DO NOT copy source and constrained files, but add them to the project one by one instead (in VScode).
3. Click "Build all" to generate bitstreams
