# Set target device
# Usage:
#   set_device [-name <name>] [-device_version <device_version>] <part number>
set_device -name GW2A-18 -device_version C GW2A-LV18PG256C8/I7

# Set options

# Defaults that can be uncommented and changed:
#set_option -top_module top
#set_option -verilog_std v2001

# Dual-purpose pins
# Uncomment to allow use as regular IO pins:
#set_option -use_jtag_as_gpio 1
#set_option -use_sspi_as_gpio 1
#set_option -use_mspi_as_gpio 1
set_option -use_ready_as_gpio 1
set_option -use_done_as_gpio 1
#set_option -use_reconfign_as_gpio 1
#set_option -use_i2c_as_gpio 1

# Add Verilog files
foreach file [glob -directory "src" -- "*.v"] {
    add_file $file
}

# Add contraint files
foreach file [glob -directory "syn" -- "*.cst"] {
    add_file $file
}

# Run all (syn and pnr)
# Alternatively this can be changed to run only syn or only pnr
# Usage:
#   run <syn/pnr/all>
run all