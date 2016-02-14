library ieee;
use ieee.std_logic_1164.all;

library work;
use work.tel2000.all;

entity flash_output is
  port (
    Flash_Command_IO       : inout std_logic_vector(5 downto 0);
    Flash_Command_In       : in std_logic_vector(5 downto 0);
    Flash_Command_Out      : out std_logic_vector(5 downto 0);
    Flash_Command_Ctrl     : in std_logic_vector(5 downto 0);
    Flash_Data_IO          : inout std_logic_vector(7 downto 0);
    Flash_Data_In          : in std_logic_vector(7 downto 0);
    Flash_Data_Out         : out std_logic_vector(7 downto 0);
    Flash_Data_Ctrl        : in std_logic_vector(7 downto 0);
    NAND_RDENn             : in std_logic;
    NAND_WRENn             : in std_logic;
    NAND_DATA_WRITE_iv8    : in std_logic_vector(7 downto 0);
    NAND_WRITE_BUSY        : in std_logic;
    NAND_READ_BUSY         : in std_logic
);
end flash_output;

architecture implementation of flash_output is

component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
end component IOBUF;

signal flash_command_in0 : std_logic;
signal flash_command_in1 : std_logic;

signal flash_data_in0 : std_logic;
signal flash_data_in1 : std_logic;
signal flash_data_in2 : std_logic;
signal flash_data_in3 : std_logic;
signal flash_data_in4 : std_logic;
signal flash_data_in5 : std_logic;
signal flash_data_in6 : std_logic;
signal flash_data_in7 : std_logic;

signal flash_data_ctrl0 : std_logic;
signal flash_data_ctrl1 : std_logic;
signal flash_data_ctrl2 : std_logic;
signal flash_data_ctrl3 : std_logic;
signal flash_data_ctrl4 : std_logic;
signal flash_data_ctrl5 : std_logic;
signal flash_data_ctrl6 : std_logic;
signal flash_data_ctrl7 : std_logic;

-------------------------------------------------------------------------------
-- Signal Declarations
-------------------------------------------------------------------------------

begin
flash_command_in0 <= (Flash_Command_In(0) and NAND_RDENn);
flash_command_in1 <= (Flash_Command_In(1) and NAND_WRENn);

flash_data_in0    <= (Flash_Data_In(0) and not NAND_WRITE_BUSY) or NAND_DATA_WRITE_iv8(0);
flash_data_in1    <= (Flash_Data_In(1) and not NAND_WRITE_BUSY) or NAND_DATA_WRITE_iv8(1);
flash_data_in2    <= (Flash_Data_In(2) and not NAND_WRITE_BUSY) or NAND_DATA_WRITE_iv8(2);
flash_data_in3    <= (Flash_Data_In(3) and not NAND_WRITE_BUSY) or NAND_DATA_WRITE_iv8(3);
flash_data_in4    <= (Flash_Data_In(4) and not NAND_WRITE_BUSY) or NAND_DATA_WRITE_iv8(4);
flash_data_in5    <= (Flash_Data_In(5) and not NAND_WRITE_BUSY) or NAND_DATA_WRITE_iv8(5);
flash_data_in6    <= (Flash_Data_In(6) and not NAND_WRITE_BUSY) or NAND_DATA_WRITE_iv8(6);
flash_data_in7    <= (Flash_Data_In(7) and not NAND_WRITE_BUSY) or NAND_DATA_WRITE_iv8(7);

flash_data_ctrl0  <= ((Flash_Data_Ctrl(0) and not NAND_WRITE_BUSY) or NAND_READ_BUSY);
flash_data_ctrl1  <= ((Flash_Data_Ctrl(1) and not NAND_WRITE_BUSY) or NAND_READ_BUSY);
flash_data_ctrl2  <= ((Flash_Data_Ctrl(2) and not NAND_WRITE_BUSY) or NAND_READ_BUSY);
flash_data_ctrl3  <= ((Flash_Data_Ctrl(3) and not NAND_WRITE_BUSY) or NAND_READ_BUSY);
flash_data_ctrl4  <= ((Flash_Data_Ctrl(4) and not NAND_WRITE_BUSY) or NAND_READ_BUSY);
flash_data_ctrl5  <= ((Flash_Data_Ctrl(5) and not NAND_WRITE_BUSY) or NAND_READ_BUSY);
flash_data_ctrl6  <= ((Flash_Data_Ctrl(6) and not NAND_WRITE_BUSY) or NAND_READ_BUSY);
flash_data_ctrl7  <= ((Flash_Data_Ctrl(7) and not NAND_WRITE_BUSY) or NAND_READ_BUSY);

        flash_command_io8_tri_iobuf_0: component IOBUF
            port map (
              I => flash_command_in0,
              IO => Flash_Command_IO(0),
              O => Flash_Command_Out(0),
              T => Flash_Command_Ctrl(0)
            );
            
        flash_command_io8_tri_iobuf_1: component IOBUF
            port map (
              I => flash_command_in1,
              IO => Flash_Command_IO(1),
              O => Flash_Command_Out(1),
              T => Flash_Command_Ctrl(1)
            );
            
        flash_command_io8_tri_iobuf_2: component IOBUF
            port map (
              I => Flash_Command_In(2),
              IO => Flash_Command_IO(2),
              O => Flash_Command_Out(2),
              T => Flash_Command_Ctrl(2)
            );
            
        flash_command_io8_tri_iobuf_3: component IOBUF
            port map (
              I => Flash_Command_In(3),
              IO => Flash_Command_IO(3),
              O => Flash_Command_Out(3),
              T => Flash_Command_Ctrl(3)
            );
            
        flash_command_io8_tri_iobuf_4: component IOBUF
            port map (
              I => Flash_Command_In(4),
              IO => Flash_Command_IO(4),
              O => Flash_Command_Out(4),
              T => Flash_Command_Ctrl(4)
            );
            
        flash_command_io8_tri_iobuf_5: component IOBUF
            port map (
              I => Flash_Command_In(5),
              IO => Flash_Command_IO(5),
              O => Flash_Command_Out(5),
              T => Flash_Command_Ctrl(5)
            );
            
        flash_data_io8_tri_iobuf_0: component IOBUF
            port map (
              I => flash_data_in0,
              IO => Flash_Data_IO(0),
              O => Flash_Data_Out(0),
              T => flash_data_ctrl0
            );
            
        flash_data_io8_tri_iobuf_1: component IOBUF
            port map (
              I => flash_data_in1,
              IO => Flash_Data_IO(1),
              O => Flash_Data_Out(1),
              T => flash_data_ctrl1
            );
            
        flash_data_io8_tri_iobuf_2: component IOBUF
            port map (
              I => flash_data_in2,
              IO => Flash_Data_IO(2),
              O => Flash_Data_Out(2),
              T => flash_data_ctrl2
            );
            
        flash_data_io8_tri_iobuf_3: component IOBUF
            port map (
              I => flash_data_in3,
              IO => Flash_Data_IO(3),
              O => Flash_Data_Out(3),
              T => flash_data_ctrl3
            );
            
        flash_data_io8_tri_iobuf_4: component IOBUF
            port map (
              I => flash_data_in4,
              IO => Flash_Data_IO(4),
              O => Flash_Data_Out(4),
              T => flash_data_ctrl4
            );
            
        flash_data_io8_tri_iobuf_5: component IOBUF
            port map (
              I => flash_data_in5,
              IO => Flash_Data_IO(5),
              O => Flash_Data_Out(5),
              T => flash_data_ctrl5
            );
            
        flash_data_io8_tri_iobuf_6: component IOBUF
            port map (
              I => flash_data_in6,
              IO => Flash_Data_IO(6),
              O => Flash_Data_Out(6),
              T => flash_data_ctrl6
            );
            
        flash_data_io8_tri_iobuf_7: component IOBUF
            port map (
              I => flash_data_in7,
              IO => Flash_Data_IO(7),
              O => Flash_Data_Out(7),
              T => flash_data_ctrl7
            );
            
end implementation;
