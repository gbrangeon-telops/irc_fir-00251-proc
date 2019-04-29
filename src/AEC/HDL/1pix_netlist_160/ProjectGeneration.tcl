# Note: This file is produced automatically, and will be overwritten the next
# time you press "Generate" in System Generator. 
#


namespace eval ::xilinx::dsp::planaheaddriver {
	set Compilation {HDL Netlist}
	set CompilationFlow {STANDARD}
	set DSPDevice {xc7k160t}
	set DSPFamily {kintex7}
	set DSPPackage {fbg676}
	set DSPSpeed {-1}
	set FPGAClockPeriod 6.25
	set GenerateTestBench 0
	set HDLLanguage {vhdl}
	set IPOOCCacheRootPath {C:/Users/laboutilis/AppData/Local/Xilinx/Sysgen/SysgenVivado/win64.o/ip}
	set ImplStrategyName {Vivado Implementation Defaults}
	set Project {histogram_axis_tmi}
	set ProjectFiles {
		{{conv_pkg.vhd} -lib {work}}
		{{synth_reg.vhd} -lib {work}}
		{{synth_reg_w_init.vhd} -lib {work}}
		{{srl17e.vhd} -lib {work}}
		{{srl33e.vhd} -lib {work}}
		{{synth_reg_reg.vhd} -lib {work}}
		{{single_reg_w_init.vhd} -lib {work}}
		{{xlclockdriver_rd.vhd} -lib {work}}
		{{vivado_ip.tcl}}
		{{histogram_axis_tmi_blk_mem_gen_v8_3_i0_vivado.coe}}
		{{histogram_axis_tmi_entity_declarations.vhd} -lib {work}}
		{{histogram_axis_tmi.vhd} -lib {work}}
		{{histogram_axis_tmi_clock.xdc}}
		{{histogram_axis_tmi.xdc}}
		{{histogram_axis_tmi.htm}}
	}
	set SimPeriod 1
	set SimTime 1
	set SimulationTime {212.50000000 ns}
	set SynthStrategyName {Vivado Synthesis Defaults}
	set SynthesisTool {Vivado}
	set TargetDir {D:/Telops/FIR-00251-Proc/src/AEC/HDL/1pix_netlist_160}
	set TopLevelModule {histogram_axis_tmi}
	set TopLevelSimulinkHandle 2.00024
	set VHDLLib {work}
	set TopLevelPortInterface {}
	dict set TopLevelPortInterface tmi_mosi_rnw Name {tmi_mosi_rnw}
	dict set TopLevelPortInterface tmi_mosi_rnw Type Bool
	dict set TopLevelPortInterface tmi_mosi_rnw ArithmeticType xlUnsigned
	dict set TopLevelPortInterface tmi_mosi_rnw BinaryPoint 0
	dict set TopLevelPortInterface tmi_mosi_rnw Width 1
	dict set TopLevelPortInterface tmi_mosi_rnw DatFile {histogram_axis_tmi_axis16_histogram_tmi_mosi_rnw.dat}
	dict set TopLevelPortInterface tmi_mosi_rnw IconText {TMI_MOSI_RNW}
	dict set TopLevelPortInterface tmi_mosi_rnw Direction in
	dict set TopLevelPortInterface tmi_mosi_rnw Period 1
	dict set TopLevelPortInterface tmi_mosi_rnw Interface 0
	dict set TopLevelPortInterface tmi_mosi_rnw InterfaceName {}
	dict set TopLevelPortInterface tmi_mosi_rnw InterfaceString {DATA}
	dict set TopLevelPortInterface tmi_mosi_rnw ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface tmi_mosi_rnw Locs {}
	dict set TopLevelPortInterface tmi_mosi_rnw IOStandard {}
	dict set TopLevelPortInterface tmi_mosi_dval Name {tmi_mosi_dval}
	dict set TopLevelPortInterface tmi_mosi_dval Type Bool
	dict set TopLevelPortInterface tmi_mosi_dval ArithmeticType xlUnsigned
	dict set TopLevelPortInterface tmi_mosi_dval BinaryPoint 0
	dict set TopLevelPortInterface tmi_mosi_dval Width 1
	dict set TopLevelPortInterface tmi_mosi_dval DatFile {histogram_axis_tmi_axis16_histogram_tmi_mosi_dval.dat}
	dict set TopLevelPortInterface tmi_mosi_dval IconText {TMI_MOSI_DVAL}
	dict set TopLevelPortInterface tmi_mosi_dval Direction in
	dict set TopLevelPortInterface tmi_mosi_dval Period 1
	dict set TopLevelPortInterface tmi_mosi_dval Interface 0
	dict set TopLevelPortInterface tmi_mosi_dval InterfaceName {}
	dict set TopLevelPortInterface tmi_mosi_dval InterfaceString {DATA}
	dict set TopLevelPortInterface tmi_mosi_dval ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface tmi_mosi_dval Locs {}
	dict set TopLevelPortInterface tmi_mosi_dval IOStandard {}
	dict set TopLevelPortInterface tmi_mosi_add Name {tmi_mosi_add}
	dict set TopLevelPortInterface tmi_mosi_add Type UFix_7_0
	dict set TopLevelPortInterface tmi_mosi_add ArithmeticType xlUnsigned
	dict set TopLevelPortInterface tmi_mosi_add BinaryPoint 0
	dict set TopLevelPortInterface tmi_mosi_add Width 7
	dict set TopLevelPortInterface tmi_mosi_add DatFile {histogram_axis_tmi_axis16_histogram_tmi_mosi_add.dat}
	dict set TopLevelPortInterface tmi_mosi_add IconText {TMI_MOSI_ADD}
	dict set TopLevelPortInterface tmi_mosi_add Direction in
	dict set TopLevelPortInterface tmi_mosi_add Period 1
	dict set TopLevelPortInterface tmi_mosi_add Interface 0
	dict set TopLevelPortInterface tmi_mosi_add InterfaceName {}
	dict set TopLevelPortInterface tmi_mosi_add InterfaceString {DATA}
	dict set TopLevelPortInterface tmi_mosi_add ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface tmi_mosi_add Locs {}
	dict set TopLevelPortInterface tmi_mosi_add IOStandard {}
	dict set TopLevelPortInterface rx_tvalid Name {rx_tvalid}
	dict set TopLevelPortInterface rx_tvalid Type Bool
	dict set TopLevelPortInterface rx_tvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface rx_tvalid BinaryPoint 0
	dict set TopLevelPortInterface rx_tvalid Width 1
	dict set TopLevelPortInterface rx_tvalid DatFile {histogram_axis_tmi_axis16_histogram_rx_tvalid.dat}
	dict set TopLevelPortInterface rx_tvalid IconText {RX_TVALID}
	dict set TopLevelPortInterface rx_tvalid Direction in
	dict set TopLevelPortInterface rx_tvalid Period 1
	dict set TopLevelPortInterface rx_tvalid Interface 0
	dict set TopLevelPortInterface rx_tvalid InterfaceName {}
	dict set TopLevelPortInterface rx_tvalid InterfaceString {DATA}
	dict set TopLevelPortInterface rx_tvalid ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface rx_tvalid Locs {}
	dict set TopLevelPortInterface rx_tvalid IOStandard {}
	dict set TopLevelPortInterface rx_tready Name {rx_tready}
	dict set TopLevelPortInterface rx_tready Type Bool
	dict set TopLevelPortInterface rx_tready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface rx_tready BinaryPoint 0
	dict set TopLevelPortInterface rx_tready Width 1
	dict set TopLevelPortInterface rx_tready DatFile {histogram_axis_tmi_axis16_histogram_rx_tready.dat}
	dict set TopLevelPortInterface rx_tready IconText {RX_TREADY}
	dict set TopLevelPortInterface rx_tready Direction in
	dict set TopLevelPortInterface rx_tready Period 1
	dict set TopLevelPortInterface rx_tready Interface 0
	dict set TopLevelPortInterface rx_tready InterfaceName {}
	dict set TopLevelPortInterface rx_tready InterfaceString {DATA}
	dict set TopLevelPortInterface rx_tready ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface rx_tready Locs {}
	dict set TopLevelPortInterface rx_tready IOStandard {}
	dict set TopLevelPortInterface rx_tlast Name {rx_tlast}
	dict set TopLevelPortInterface rx_tlast Type Bool
	dict set TopLevelPortInterface rx_tlast ArithmeticType xlUnsigned
	dict set TopLevelPortInterface rx_tlast BinaryPoint 0
	dict set TopLevelPortInterface rx_tlast Width 1
	dict set TopLevelPortInterface rx_tlast DatFile {histogram_axis_tmi_axis16_histogram_rx_tlast.dat}
	dict set TopLevelPortInterface rx_tlast IconText {RX_TLAST}
	dict set TopLevelPortInterface rx_tlast Direction in
	dict set TopLevelPortInterface rx_tlast Period 1
	dict set TopLevelPortInterface rx_tlast Interface 0
	dict set TopLevelPortInterface rx_tlast InterfaceName {}
	dict set TopLevelPortInterface rx_tlast InterfaceString {DATA}
	dict set TopLevelPortInterface rx_tlast ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface rx_tlast Locs {}
	dict set TopLevelPortInterface rx_tlast IOStandard {}
	dict set TopLevelPortInterface rx_tdata Name {rx_tdata}
	dict set TopLevelPortInterface rx_tdata Type UFix_16_0
	dict set TopLevelPortInterface rx_tdata ArithmeticType xlUnsigned
	dict set TopLevelPortInterface rx_tdata BinaryPoint 0
	dict set TopLevelPortInterface rx_tdata Width 16
	dict set TopLevelPortInterface rx_tdata DatFile {histogram_axis_tmi_axis16_histogram_rx_tdata.dat}
	dict set TopLevelPortInterface rx_tdata IconText {RX_TDATA}
	dict set TopLevelPortInterface rx_tdata Direction in
	dict set TopLevelPortInterface rx_tdata Period 1
	dict set TopLevelPortInterface rx_tdata Interface 0
	dict set TopLevelPortInterface rx_tdata InterfaceName {}
	dict set TopLevelPortInterface rx_tdata InterfaceString {DATA}
	dict set TopLevelPortInterface rx_tdata ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface rx_tdata Locs {}
	dict set TopLevelPortInterface rx_tdata IOStandard {}
	dict set TopLevelPortInterface msb_pos Name {msb_pos}
	dict set TopLevelPortInterface msb_pos Type UFix_2_0
	dict set TopLevelPortInterface msb_pos ArithmeticType xlUnsigned
	dict set TopLevelPortInterface msb_pos BinaryPoint 0
	dict set TopLevelPortInterface msb_pos Width 2
	dict set TopLevelPortInterface msb_pos DatFile {histogram_axis_tmi_axis16_histogram_msb_pos.dat}
	dict set TopLevelPortInterface msb_pos IconText {MSB_POS}
	dict set TopLevelPortInterface msb_pos Direction in
	dict set TopLevelPortInterface msb_pos Period 1
	dict set TopLevelPortInterface msb_pos Interface 0
	dict set TopLevelPortInterface msb_pos InterfaceName {}
	dict set TopLevelPortInterface msb_pos InterfaceString {DATA}
	dict set TopLevelPortInterface msb_pos ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface msb_pos Locs {}
	dict set TopLevelPortInterface msb_pos IOStandard {}
	dict set TopLevelPortInterface ext_data_in2 Name {ext_data_in2}
	dict set TopLevelPortInterface ext_data_in2 Type UFix_32_0
	dict set TopLevelPortInterface ext_data_in2 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface ext_data_in2 BinaryPoint 0
	dict set TopLevelPortInterface ext_data_in2 Width 32
	dict set TopLevelPortInterface ext_data_in2 DatFile {histogram_axis_tmi_axis16_histogram_ext_data_in2.dat}
	dict set TopLevelPortInterface ext_data_in2 IconText {EXT_DATA_IN2}
	dict set TopLevelPortInterface ext_data_in2 Direction in
	dict set TopLevelPortInterface ext_data_in2 Period 1
	dict set TopLevelPortInterface ext_data_in2 Interface 0
	dict set TopLevelPortInterface ext_data_in2 InterfaceName {}
	dict set TopLevelPortInterface ext_data_in2 InterfaceString {DATA}
	dict set TopLevelPortInterface ext_data_in2 ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface ext_data_in2 Locs {}
	dict set TopLevelPortInterface ext_data_in2 IOStandard {}
	dict set TopLevelPortInterface ext_data_in Name {ext_data_in}
	dict set TopLevelPortInterface ext_data_in Type UFix_32_0
	dict set TopLevelPortInterface ext_data_in ArithmeticType xlUnsigned
	dict set TopLevelPortInterface ext_data_in BinaryPoint 0
	dict set TopLevelPortInterface ext_data_in Width 32
	dict set TopLevelPortInterface ext_data_in DatFile {histogram_axis_tmi_axis16_histogram_ext_data_in.dat}
	dict set TopLevelPortInterface ext_data_in IconText {EXT_DATA_IN}
	dict set TopLevelPortInterface ext_data_in Direction in
	dict set TopLevelPortInterface ext_data_in Period 1
	dict set TopLevelPortInterface ext_data_in Interface 0
	dict set TopLevelPortInterface ext_data_in InterfaceName {}
	dict set TopLevelPortInterface ext_data_in InterfaceString {DATA}
	dict set TopLevelPortInterface ext_data_in ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface ext_data_in Locs {}
	dict set TopLevelPortInterface ext_data_in IOStandard {}
	dict set TopLevelPortInterface clear_mem Name {clear_mem}
	dict set TopLevelPortInterface clear_mem Type Bool
	dict set TopLevelPortInterface clear_mem ArithmeticType xlUnsigned
	dict set TopLevelPortInterface clear_mem BinaryPoint 0
	dict set TopLevelPortInterface clear_mem Width 1
	dict set TopLevelPortInterface clear_mem DatFile {histogram_axis_tmi_axis16_histogram_clear_mem.dat}
	dict set TopLevelPortInterface clear_mem IconText {CLEAR_MEM}
	dict set TopLevelPortInterface clear_mem Direction in
	dict set TopLevelPortInterface clear_mem Period 1
	dict set TopLevelPortInterface clear_mem Interface 0
	dict set TopLevelPortInterface clear_mem InterfaceName {}
	dict set TopLevelPortInterface clear_mem InterfaceString {DATA}
	dict set TopLevelPortInterface clear_mem ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface clear_mem Locs {}
	dict set TopLevelPortInterface clear_mem IOStandard {}
	dict set TopLevelPortInterface areset Name {areset}
	dict set TopLevelPortInterface areset Type Bool
	dict set TopLevelPortInterface areset ArithmeticType xlUnsigned
	dict set TopLevelPortInterface areset BinaryPoint 0
	dict set TopLevelPortInterface areset Width 1
	dict set TopLevelPortInterface areset DatFile {histogram_axis_tmi_axis16_histogram_areset.dat}
	dict set TopLevelPortInterface areset IconText {ARESET}
	dict set TopLevelPortInterface areset Direction in
	dict set TopLevelPortInterface areset Period 1
	dict set TopLevelPortInterface areset Interface 0
	dict set TopLevelPortInterface areset InterfaceName {}
	dict set TopLevelPortInterface areset InterfaceString {DATA}
	dict set TopLevelPortInterface areset ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface areset Locs {}
	dict set TopLevelPortInterface areset IOStandard {}
	dict set TopLevelPortInterface ext_data_out Name {ext_data_out}
	dict set TopLevelPortInterface ext_data_out Type UFix_32_0
	dict set TopLevelPortInterface ext_data_out ArithmeticType xlUnsigned
	dict set TopLevelPortInterface ext_data_out BinaryPoint 0
	dict set TopLevelPortInterface ext_data_out Width 32
	dict set TopLevelPortInterface ext_data_out DatFile {histogram_axis_tmi_axis16_histogram_ext_data_out.dat}
	dict set TopLevelPortInterface ext_data_out IconText {EXT_DATA_OUT}
	dict set TopLevelPortInterface ext_data_out Direction out
	dict set TopLevelPortInterface ext_data_out Period 1
	dict set TopLevelPortInterface ext_data_out Interface 0
	dict set TopLevelPortInterface ext_data_out InterfaceName {}
	dict set TopLevelPortInterface ext_data_out InterfaceString {DATA}
	dict set TopLevelPortInterface ext_data_out ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface ext_data_out Locs {}
	dict set TopLevelPortInterface ext_data_out IOStandard {}
	dict set TopLevelPortInterface ext_data_out2 Name {ext_data_out2}
	dict set TopLevelPortInterface ext_data_out2 Type UFix_32_0
	dict set TopLevelPortInterface ext_data_out2 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface ext_data_out2 BinaryPoint 0
	dict set TopLevelPortInterface ext_data_out2 Width 32
	dict set TopLevelPortInterface ext_data_out2 DatFile {histogram_axis_tmi_axis16_histogram_ext_data_out2.dat}
	dict set TopLevelPortInterface ext_data_out2 IconText {EXT_DATA_OUT2}
	dict set TopLevelPortInterface ext_data_out2 Direction out
	dict set TopLevelPortInterface ext_data_out2 Period 1
	dict set TopLevelPortInterface ext_data_out2 Interface 0
	dict set TopLevelPortInterface ext_data_out2 InterfaceName {}
	dict set TopLevelPortInterface ext_data_out2 InterfaceString {DATA}
	dict set TopLevelPortInterface ext_data_out2 ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface ext_data_out2 Locs {}
	dict set TopLevelPortInterface ext_data_out2 IOStandard {}
	dict set TopLevelPortInterface histogram_rdy Name {histogram_rdy}
	dict set TopLevelPortInterface histogram_rdy Type Bool
	dict set TopLevelPortInterface histogram_rdy ArithmeticType xlUnsigned
	dict set TopLevelPortInterface histogram_rdy BinaryPoint 0
	dict set TopLevelPortInterface histogram_rdy Width 1
	dict set TopLevelPortInterface histogram_rdy DatFile {histogram_axis_tmi_axis16_histogram_histogram_rdy.dat}
	dict set TopLevelPortInterface histogram_rdy IconText {HISTOGRAM_RDY}
	dict set TopLevelPortInterface histogram_rdy Direction out
	dict set TopLevelPortInterface histogram_rdy Period 1
	dict set TopLevelPortInterface histogram_rdy Interface 0
	dict set TopLevelPortInterface histogram_rdy InterfaceName {}
	dict set TopLevelPortInterface histogram_rdy InterfaceString {DATA}
	dict set TopLevelPortInterface histogram_rdy ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface histogram_rdy Locs {}
	dict set TopLevelPortInterface histogram_rdy IOStandard {}
	dict set TopLevelPortInterface timestamp Name {timestamp}
	dict set TopLevelPortInterface timestamp Type UFix_32_0
	dict set TopLevelPortInterface timestamp ArithmeticType xlUnsigned
	dict set TopLevelPortInterface timestamp BinaryPoint 0
	dict set TopLevelPortInterface timestamp Width 32
	dict set TopLevelPortInterface timestamp DatFile {histogram_axis_tmi_axis16_histogram_timestamp.dat}
	dict set TopLevelPortInterface timestamp IconText {TIMESTAMP}
	dict set TopLevelPortInterface timestamp Direction out
	dict set TopLevelPortInterface timestamp Period 1
	dict set TopLevelPortInterface timestamp Interface 0
	dict set TopLevelPortInterface timestamp InterfaceName {}
	dict set TopLevelPortInterface timestamp InterfaceString {DATA}
	dict set TopLevelPortInterface timestamp ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface timestamp Locs {}
	dict set TopLevelPortInterface timestamp IOStandard {}
	dict set TopLevelPortInterface tmi_miso_busy Name {tmi_miso_busy}
	dict set TopLevelPortInterface tmi_miso_busy Type Bool
	dict set TopLevelPortInterface tmi_miso_busy ArithmeticType xlUnsigned
	dict set TopLevelPortInterface tmi_miso_busy BinaryPoint 0
	dict set TopLevelPortInterface tmi_miso_busy Width 1
	dict set TopLevelPortInterface tmi_miso_busy DatFile {histogram_axis_tmi_axis16_histogram_tmi_miso_busy.dat}
	dict set TopLevelPortInterface tmi_miso_busy IconText {TMI_MISO_BUSY}
	dict set TopLevelPortInterface tmi_miso_busy Direction out
	dict set TopLevelPortInterface tmi_miso_busy Period 1
	dict set TopLevelPortInterface tmi_miso_busy Interface 0
	dict set TopLevelPortInterface tmi_miso_busy InterfaceName {}
	dict set TopLevelPortInterface tmi_miso_busy InterfaceString {DATA}
	dict set TopLevelPortInterface tmi_miso_busy ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface tmi_miso_busy Locs {}
	dict set TopLevelPortInterface tmi_miso_busy IOStandard {}
	dict set TopLevelPortInterface tmi_miso_error Name {tmi_miso_error}
	dict set TopLevelPortInterface tmi_miso_error Type Bool
	dict set TopLevelPortInterface tmi_miso_error ArithmeticType xlUnsigned
	dict set TopLevelPortInterface tmi_miso_error BinaryPoint 0
	dict set TopLevelPortInterface tmi_miso_error Width 1
	dict set TopLevelPortInterface tmi_miso_error DatFile {histogram_axis_tmi_axis16_histogram_tmi_miso_error.dat}
	dict set TopLevelPortInterface tmi_miso_error IconText {TMI_MISO_ERROR}
	dict set TopLevelPortInterface tmi_miso_error Direction out
	dict set TopLevelPortInterface tmi_miso_error Period 1
	dict set TopLevelPortInterface tmi_miso_error Interface 0
	dict set TopLevelPortInterface tmi_miso_error InterfaceName {}
	dict set TopLevelPortInterface tmi_miso_error InterfaceString {DATA}
	dict set TopLevelPortInterface tmi_miso_error ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface tmi_miso_error Locs {}
	dict set TopLevelPortInterface tmi_miso_error IOStandard {}
	dict set TopLevelPortInterface tmi_miso_idle Name {tmi_miso_idle}
	dict set TopLevelPortInterface tmi_miso_idle Type Bool
	dict set TopLevelPortInterface tmi_miso_idle ArithmeticType xlUnsigned
	dict set TopLevelPortInterface tmi_miso_idle BinaryPoint 0
	dict set TopLevelPortInterface tmi_miso_idle Width 1
	dict set TopLevelPortInterface tmi_miso_idle DatFile {histogram_axis_tmi_axis16_histogram_tmi_miso_idle.dat}
	dict set TopLevelPortInterface tmi_miso_idle IconText {TMI_MISO_IDLE}
	dict set TopLevelPortInterface tmi_miso_idle Direction out
	dict set TopLevelPortInterface tmi_miso_idle Period 1
	dict set TopLevelPortInterface tmi_miso_idle Interface 0
	dict set TopLevelPortInterface tmi_miso_idle InterfaceName {}
	dict set TopLevelPortInterface tmi_miso_idle InterfaceString {DATA}
	dict set TopLevelPortInterface tmi_miso_idle ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface tmi_miso_idle Locs {}
	dict set TopLevelPortInterface tmi_miso_idle IOStandard {}
	dict set TopLevelPortInterface tmi_miso_rd_data Name {tmi_miso_rd_data}
	dict set TopLevelPortInterface tmi_miso_rd_data Type UFix_21_0
	dict set TopLevelPortInterface tmi_miso_rd_data ArithmeticType xlUnsigned
	dict set TopLevelPortInterface tmi_miso_rd_data BinaryPoint 0
	dict set TopLevelPortInterface tmi_miso_rd_data Width 21
	dict set TopLevelPortInterface tmi_miso_rd_data DatFile {histogram_axis_tmi_axis16_histogram_tmi_miso_rd_data.dat}
	dict set TopLevelPortInterface tmi_miso_rd_data IconText {TMI_MISO_RD_DATA}
	dict set TopLevelPortInterface tmi_miso_rd_data Direction out
	dict set TopLevelPortInterface tmi_miso_rd_data Period 1
	dict set TopLevelPortInterface tmi_miso_rd_data Interface 0
	dict set TopLevelPortInterface tmi_miso_rd_data InterfaceName {}
	dict set TopLevelPortInterface tmi_miso_rd_data InterfaceString {DATA}
	dict set TopLevelPortInterface tmi_miso_rd_data ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface tmi_miso_rd_data Locs {}
	dict set TopLevelPortInterface tmi_miso_rd_data IOStandard {}
	dict set TopLevelPortInterface tmi_miso_rd_dval Name {tmi_miso_rd_dval}
	dict set TopLevelPortInterface tmi_miso_rd_dval Type Bool
	dict set TopLevelPortInterface tmi_miso_rd_dval ArithmeticType xlUnsigned
	dict set TopLevelPortInterface tmi_miso_rd_dval BinaryPoint 0
	dict set TopLevelPortInterface tmi_miso_rd_dval Width 1
	dict set TopLevelPortInterface tmi_miso_rd_dval DatFile {histogram_axis_tmi_axis16_histogram_tmi_miso_rd_dval.dat}
	dict set TopLevelPortInterface tmi_miso_rd_dval IconText {TMI_MISO_RD_DVAL}
	dict set TopLevelPortInterface tmi_miso_rd_dval Direction out
	dict set TopLevelPortInterface tmi_miso_rd_dval Period 1
	dict set TopLevelPortInterface tmi_miso_rd_dval Interface 0
	dict set TopLevelPortInterface tmi_miso_rd_dval InterfaceName {}
	dict set TopLevelPortInterface tmi_miso_rd_dval InterfaceString {DATA}
	dict set TopLevelPortInterface tmi_miso_rd_dval ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface tmi_miso_rd_dval Locs {}
	dict set TopLevelPortInterface tmi_miso_rd_dval IOStandard {}
	dict set TopLevelPortInterface clk Name {clk}
	dict set TopLevelPortInterface clk Type -
	dict set TopLevelPortInterface clk ArithmeticType xlUnsigned
	dict set TopLevelPortInterface clk BinaryPoint 0
	dict set TopLevelPortInterface clk Width 1
	dict set TopLevelPortInterface clk DatFile {}
	dict set TopLevelPortInterface clk Direction in
	dict set TopLevelPortInterface clk Period 1
	dict set TopLevelPortInterface clk Interface 6
	dict set TopLevelPortInterface clk InterfaceName {}
	dict set TopLevelPortInterface clk InterfaceString {CLOCK}
	dict set TopLevelPortInterface clk ClockDomain {histogram_axis_tmi}
	dict set TopLevelPortInterface clk Locs {}
	dict set TopLevelPortInterface clk IOStandard {}
	dict set TopLevelPortInterface clk AssociatedInterfaces {}
	dict set TopLevelPortInterface clk AssociatedResets {}
	set MemoryMappedPort {}
}

source SgPaProject.tcl
::xilinx::dsp::planaheadworker::dsp_create_project