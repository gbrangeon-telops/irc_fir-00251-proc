# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  ipgui::add_page $IPINST -name "Page 0"

  set CLOCK_FREQ [ipgui::add_param $IPINST -name "CLOCK_FREQ"]
  set_property tooltip {AXI Clock Frequency (in Hz)} ${CLOCK_FREQ}
  set INTR_MASK_PERIOD [ipgui::add_param $IPINST -name "INTR_MASK_PERIOD"]
  set_property tooltip {Interrupt Mask Period (in seconds)} ${INTR_MASK_PERIOD}
  set FLASH_RESET_BUTTON_COUNT [ipgui::add_param $IPINST -name "FLASH_RESET_BUTTON_COUNT"]
  set_property tooltip {Number of button press to initiate flash reset} ${FLASH_RESET_BUTTON_COUNT}
  set FLASH_RESET_SECTOR_ADDR [ipgui::add_param $IPINST -name "FLASH_RESET_SECTOR_ADDR"]
  set_property tooltip {Flash sector address of GC Store} ${FLASH_RESET_SECTOR_ADDR}
  set QSPI_BASE_ADDR [ipgui::add_param $IPINST -name "QSPI_BASE_ADDR"]
  set_property tooltip {QSPI Controller Base Address} ${QSPI_BASE_ADDR}

}

proc update_PARAM_VALUE.CLOCK_FREQ { PARAM_VALUE.CLOCK_FREQ } {
	# Procedure called to update CLOCK_FREQ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLOCK_FREQ { PARAM_VALUE.CLOCK_FREQ } {
	# Procedure called to validate CLOCK_FREQ
	return true
}

proc update_PARAM_VALUE.FLASH_RESET_BUTTON_COUNT { PARAM_VALUE.FLASH_RESET_BUTTON_COUNT } {
	# Procedure called to update FLASH_RESET_BUTTON_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FLASH_RESET_BUTTON_COUNT { PARAM_VALUE.FLASH_RESET_BUTTON_COUNT } {
	# Procedure called to validate FLASH_RESET_BUTTON_COUNT
	return true
}

proc update_PARAM_VALUE.FLASH_RESET_SECTOR_ADDR { PARAM_VALUE.FLASH_RESET_SECTOR_ADDR } {
	# Procedure called to update FLASH_RESET_SECTOR_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FLASH_RESET_SECTOR_ADDR { PARAM_VALUE.FLASH_RESET_SECTOR_ADDR } {
	# Procedure called to validate FLASH_RESET_SECTOR_ADDR
	return true
}

proc update_PARAM_VALUE.INTR_MASK_PERIOD { PARAM_VALUE.INTR_MASK_PERIOD } {
	# Procedure called to update INTR_MASK_PERIOD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INTR_MASK_PERIOD { PARAM_VALUE.INTR_MASK_PERIOD } {
	# Procedure called to validate INTR_MASK_PERIOD
	return true
}

proc update_PARAM_VALUE.QSPI_BASE_ADDR { PARAM_VALUE.QSPI_BASE_ADDR } {
	# Procedure called to update QSPI_BASE_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.QSPI_BASE_ADDR { PARAM_VALUE.QSPI_BASE_ADDR } {
	# Procedure called to validate QSPI_BASE_ADDR
	return true
}


