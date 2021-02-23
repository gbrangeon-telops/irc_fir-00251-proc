-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
-- Date        : Tue Feb 23 11:44:21 2021
-- Host        : TELOPS258-7 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               D:/Telops/FIR-00251-Proc/IP/325/fwft_sfifo_w71_d256/fwft_sfifo_w71_d256_sim_netlist.vhdl
-- Design      : fwft_sfifo_w71_d256
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k325tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_dmem is
  port (
    \goreg_dm.dout_i_reg[70]\ : out STD_LOGIC_VECTOR ( 70 downto 0 );
    clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 70 downto 0 );
    ram_full_fb_i_reg : in STD_LOGIC;
    \gc0.count_d1_reg[7]\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 5 downto 0 );
    \gcc0.gc1.gsym.count_d2_reg[7]\ : in STD_LOGIC;
    \gcc0.gc1.gsym.count_d2_reg[6]\ : in STD_LOGIC;
    ram_full_fb_i_reg_0 : in STD_LOGIC;
    ADDRC : in STD_LOGIC_VECTOR ( 5 downto 0 );
    ADDRA : in STD_LOGIC_VECTOR ( 5 downto 0 );
    srst : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_dmem : entity is "dmem";
end fwft_sfifo_w71_d256_dmem;

architecture STRUCTURE of fwft_sfifo_w71_d256_dmem is
  signal RAM_reg_0_63_0_2_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_0_2_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_0_2_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_12_14_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_12_14_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_12_14_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_15_17_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_15_17_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_15_17_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_18_20_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_18_20_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_18_20_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_21_23_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_21_23_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_21_23_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_24_26_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_24_26_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_24_26_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_27_29_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_27_29_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_27_29_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_30_32_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_30_32_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_30_32_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_33_35_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_33_35_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_33_35_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_36_38_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_36_38_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_36_38_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_39_41_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_39_41_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_39_41_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_3_5_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_3_5_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_3_5_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_42_44_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_42_44_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_42_44_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_45_47_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_45_47_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_45_47_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_48_50_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_48_50_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_48_50_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_51_53_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_51_53_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_51_53_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_54_56_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_54_56_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_54_56_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_57_59_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_57_59_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_57_59_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_60_62_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_60_62_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_60_62_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_63_65_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_63_65_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_63_65_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_66_68_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_66_68_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_66_68_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_69_69_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_6_8_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_6_8_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_6_8_n_2 : STD_LOGIC;
  signal RAM_reg_0_63_70_70_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_9_11_n_0 : STD_LOGIC;
  signal RAM_reg_0_63_9_11_n_1 : STD_LOGIC;
  signal RAM_reg_0_63_9_11_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_0_2_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_0_2_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_0_2_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_12_14_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_12_14_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_12_14_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_15_17_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_15_17_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_15_17_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_18_20_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_18_20_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_18_20_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_21_23_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_21_23_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_21_23_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_24_26_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_24_26_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_24_26_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_27_29_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_27_29_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_27_29_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_30_32_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_30_32_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_30_32_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_33_35_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_33_35_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_33_35_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_36_38_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_36_38_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_36_38_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_39_41_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_39_41_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_39_41_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_3_5_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_3_5_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_3_5_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_42_44_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_42_44_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_42_44_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_45_47_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_45_47_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_45_47_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_48_50_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_48_50_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_48_50_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_51_53_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_51_53_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_51_53_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_54_56_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_54_56_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_54_56_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_57_59_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_57_59_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_57_59_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_60_62_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_60_62_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_60_62_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_63_65_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_63_65_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_63_65_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_66_68_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_66_68_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_66_68_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_69_69_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_6_8_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_6_8_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_6_8_n_2 : STD_LOGIC;
  signal RAM_reg_128_191_70_70_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_9_11_n_0 : STD_LOGIC;
  signal RAM_reg_128_191_9_11_n_1 : STD_LOGIC;
  signal RAM_reg_128_191_9_11_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_0_2_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_0_2_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_0_2_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_12_14_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_12_14_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_12_14_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_15_17_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_15_17_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_15_17_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_18_20_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_18_20_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_18_20_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_21_23_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_21_23_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_21_23_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_24_26_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_24_26_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_24_26_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_27_29_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_27_29_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_27_29_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_30_32_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_30_32_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_30_32_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_33_35_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_33_35_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_33_35_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_36_38_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_36_38_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_36_38_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_39_41_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_39_41_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_39_41_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_3_5_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_3_5_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_3_5_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_42_44_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_42_44_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_42_44_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_45_47_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_45_47_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_45_47_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_48_50_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_48_50_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_48_50_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_51_53_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_51_53_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_51_53_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_54_56_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_54_56_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_54_56_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_57_59_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_57_59_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_57_59_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_60_62_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_60_62_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_60_62_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_63_65_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_63_65_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_63_65_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_66_68_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_66_68_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_66_68_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_69_69_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_6_8_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_6_8_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_6_8_n_2 : STD_LOGIC;
  signal RAM_reg_192_255_70_70_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_9_11_n_0 : STD_LOGIC;
  signal RAM_reg_192_255_9_11_n_1 : STD_LOGIC;
  signal RAM_reg_192_255_9_11_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_0_2_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_0_2_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_0_2_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_12_14_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_12_14_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_12_14_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_15_17_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_15_17_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_15_17_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_18_20_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_18_20_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_18_20_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_21_23_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_21_23_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_21_23_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_24_26_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_24_26_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_24_26_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_27_29_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_27_29_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_27_29_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_30_32_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_30_32_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_30_32_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_33_35_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_33_35_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_33_35_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_36_38_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_36_38_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_36_38_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_39_41_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_39_41_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_39_41_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_3_5_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_3_5_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_3_5_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_42_44_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_42_44_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_42_44_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_45_47_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_45_47_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_45_47_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_48_50_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_48_50_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_48_50_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_51_53_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_51_53_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_51_53_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_54_56_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_54_56_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_54_56_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_57_59_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_57_59_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_57_59_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_60_62_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_60_62_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_60_62_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_63_65_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_63_65_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_63_65_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_66_68_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_66_68_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_66_68_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_69_69_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_6_8_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_6_8_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_6_8_n_2 : STD_LOGIC;
  signal RAM_reg_64_127_70_70_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_9_11_n_0 : STD_LOGIC;
  signal RAM_reg_64_127_9_11_n_1 : STD_LOGIC;
  signal RAM_reg_64_127_9_11_n_2 : STD_LOGIC;
  signal p_0_out : STD_LOGIC_VECTOR ( 70 downto 0 );
  signal NLW_RAM_reg_0_63_0_2_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_12_14_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_15_17_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_18_20_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_21_23_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_24_26_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_27_29_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_30_32_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_33_35_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_36_38_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_39_41_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_3_5_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_42_44_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_45_47_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_48_50_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_51_53_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_54_56_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_57_59_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_60_62_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_63_65_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_66_68_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_69_69_SPO_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_6_8_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_70_70_SPO_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_9_11_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_0_2_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_12_14_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_15_17_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_18_20_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_21_23_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_24_26_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_27_29_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_30_32_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_33_35_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_36_38_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_39_41_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_3_5_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_42_44_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_45_47_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_48_50_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_51_53_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_54_56_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_57_59_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_60_62_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_63_65_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_66_68_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_69_69_SPO_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_6_8_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_70_70_SPO_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_128_191_9_11_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_0_2_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_12_14_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_15_17_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_18_20_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_21_23_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_24_26_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_27_29_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_30_32_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_33_35_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_36_38_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_39_41_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_3_5_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_42_44_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_45_47_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_48_50_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_51_53_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_54_56_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_57_59_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_60_62_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_63_65_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_66_68_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_69_69_SPO_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_6_8_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_70_70_SPO_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_192_255_9_11_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_0_2_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_12_14_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_15_17_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_18_20_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_21_23_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_24_26_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_27_29_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_30_32_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_33_35_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_36_38_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_39_41_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_3_5_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_42_44_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_45_47_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_48_50_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_51_53_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_54_56_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_57_59_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_60_62_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_63_65_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_66_68_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_69_69_SPO_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_6_8_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_70_70_SPO_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_64_127_9_11_DOD_UNCONNECTED : STD_LOGIC;
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_0_2 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_12_14 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_15_17 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_18_20 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_21_23 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_24_26 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_27_29 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_30_32 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_33_35 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_36_38 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_39_41 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_3_5 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_42_44 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_45_47 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_48_50 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_51_53 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_54_56 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_57_59 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_60_62 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_63_65 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_66_68 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_6_8 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_0_63_9_11 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_0_2 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_12_14 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_15_17 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_18_20 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_21_23 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_24_26 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_27_29 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_30_32 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_33_35 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_36_38 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_39_41 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_3_5 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_42_44 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_45_47 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_48_50 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_51_53 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_54_56 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_57_59 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_60_62 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_63_65 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_66_68 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_6_8 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_128_191_9_11 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_0_2 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_12_14 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_15_17 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_18_20 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_21_23 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_24_26 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_27_29 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_30_32 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_33_35 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_36_38 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_39_41 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_3_5 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_42_44 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_45_47 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_48_50 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_51_53 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_54_56 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_57_59 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_60_62 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_63_65 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_66_68 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_6_8 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_192_255_9_11 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_0_2 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_12_14 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_15_17 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_18_20 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_21_23 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_24_26 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_27_29 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_30_32 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_33_35 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_36_38 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_39_41 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_3_5 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_42_44 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_45_47 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_48_50 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_51_53 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_54_56 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_57_59 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_60_62 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_63_65 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_66_68 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_6_8 : label is "";
  attribute METHODOLOGY_DRC_VIOS of RAM_reg_64_127_9_11 : label is "";
begin
RAM_reg_0_63_0_2: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(0),
      DIB => din(1),
      DIC => din(2),
      DID => '0',
      DOA => RAM_reg_0_63_0_2_n_0,
      DOB => RAM_reg_0_63_0_2_n_1,
      DOC => RAM_reg_0_63_0_2_n_2,
      DOD => NLW_RAM_reg_0_63_0_2_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_12_14: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(12),
      DIB => din(13),
      DIC => din(14),
      DID => '0',
      DOA => RAM_reg_0_63_12_14_n_0,
      DOB => RAM_reg_0_63_12_14_n_1,
      DOC => RAM_reg_0_63_12_14_n_2,
      DOD => NLW_RAM_reg_0_63_12_14_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_15_17: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(15),
      DIB => din(16),
      DIC => din(17),
      DID => '0',
      DOA => RAM_reg_0_63_15_17_n_0,
      DOB => RAM_reg_0_63_15_17_n_1,
      DOC => RAM_reg_0_63_15_17_n_2,
      DOD => NLW_RAM_reg_0_63_15_17_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_18_20: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(18),
      DIB => din(19),
      DIC => din(20),
      DID => '0',
      DOA => RAM_reg_0_63_18_20_n_0,
      DOB => RAM_reg_0_63_18_20_n_1,
      DOC => RAM_reg_0_63_18_20_n_2,
      DOD => NLW_RAM_reg_0_63_18_20_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_21_23: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(21),
      DIB => din(22),
      DIC => din(23),
      DID => '0',
      DOA => RAM_reg_0_63_21_23_n_0,
      DOB => RAM_reg_0_63_21_23_n_1,
      DOC => RAM_reg_0_63_21_23_n_2,
      DOD => NLW_RAM_reg_0_63_21_23_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_24_26: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(24),
      DIB => din(25),
      DIC => din(26),
      DID => '0',
      DOA => RAM_reg_0_63_24_26_n_0,
      DOB => RAM_reg_0_63_24_26_n_1,
      DOC => RAM_reg_0_63_24_26_n_2,
      DOD => NLW_RAM_reg_0_63_24_26_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_27_29: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(27),
      DIB => din(28),
      DIC => din(29),
      DID => '0',
      DOA => RAM_reg_0_63_27_29_n_0,
      DOB => RAM_reg_0_63_27_29_n_1,
      DOC => RAM_reg_0_63_27_29_n_2,
      DOD => NLW_RAM_reg_0_63_27_29_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_30_32: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(30),
      DIB => din(31),
      DIC => din(32),
      DID => '0',
      DOA => RAM_reg_0_63_30_32_n_0,
      DOB => RAM_reg_0_63_30_32_n_1,
      DOC => RAM_reg_0_63_30_32_n_2,
      DOD => NLW_RAM_reg_0_63_30_32_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_33_35: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(33),
      DIB => din(34),
      DIC => din(35),
      DID => '0',
      DOA => RAM_reg_0_63_33_35_n_0,
      DOB => RAM_reg_0_63_33_35_n_1,
      DOC => RAM_reg_0_63_33_35_n_2,
      DOD => NLW_RAM_reg_0_63_33_35_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_36_38: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(36),
      DIB => din(37),
      DIC => din(38),
      DID => '0',
      DOA => RAM_reg_0_63_36_38_n_0,
      DOB => RAM_reg_0_63_36_38_n_1,
      DOC => RAM_reg_0_63_36_38_n_2,
      DOD => NLW_RAM_reg_0_63_36_38_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_39_41: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(39),
      DIB => din(40),
      DIC => din(41),
      DID => '0',
      DOA => RAM_reg_0_63_39_41_n_0,
      DOB => RAM_reg_0_63_39_41_n_1,
      DOC => RAM_reg_0_63_39_41_n_2,
      DOD => NLW_RAM_reg_0_63_39_41_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_3_5: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(3),
      DIB => din(4),
      DIC => din(5),
      DID => '0',
      DOA => RAM_reg_0_63_3_5_n_0,
      DOB => RAM_reg_0_63_3_5_n_1,
      DOC => RAM_reg_0_63_3_5_n_2,
      DOD => NLW_RAM_reg_0_63_3_5_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_42_44: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(42),
      DIB => din(43),
      DIC => din(44),
      DID => '0',
      DOA => RAM_reg_0_63_42_44_n_0,
      DOB => RAM_reg_0_63_42_44_n_1,
      DOC => RAM_reg_0_63_42_44_n_2,
      DOD => NLW_RAM_reg_0_63_42_44_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_45_47: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(45),
      DIB => din(46),
      DIC => din(47),
      DID => '0',
      DOA => RAM_reg_0_63_45_47_n_0,
      DOB => RAM_reg_0_63_45_47_n_1,
      DOC => RAM_reg_0_63_45_47_n_2,
      DOD => NLW_RAM_reg_0_63_45_47_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_48_50: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(48),
      DIB => din(49),
      DIC => din(50),
      DID => '0',
      DOA => RAM_reg_0_63_48_50_n_0,
      DOB => RAM_reg_0_63_48_50_n_1,
      DOC => RAM_reg_0_63_48_50_n_2,
      DOD => NLW_RAM_reg_0_63_48_50_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_51_53: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(51),
      DIB => din(52),
      DIC => din(53),
      DID => '0',
      DOA => RAM_reg_0_63_51_53_n_0,
      DOB => RAM_reg_0_63_51_53_n_1,
      DOC => RAM_reg_0_63_51_53_n_2,
      DOD => NLW_RAM_reg_0_63_51_53_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_54_56: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(54),
      DIB => din(55),
      DIC => din(56),
      DID => '0',
      DOA => RAM_reg_0_63_54_56_n_0,
      DOB => RAM_reg_0_63_54_56_n_1,
      DOC => RAM_reg_0_63_54_56_n_2,
      DOD => NLW_RAM_reg_0_63_54_56_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_57_59: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(57),
      DIB => din(58),
      DIC => din(59),
      DID => '0',
      DOA => RAM_reg_0_63_57_59_n_0,
      DOB => RAM_reg_0_63_57_59_n_1,
      DOC => RAM_reg_0_63_57_59_n_2,
      DOD => NLW_RAM_reg_0_63_57_59_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_60_62: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(60),
      DIB => din(61),
      DIC => din(62),
      DID => '0',
      DOA => RAM_reg_0_63_60_62_n_0,
      DOB => RAM_reg_0_63_60_62_n_1,
      DOC => RAM_reg_0_63_60_62_n_2,
      DOD => NLW_RAM_reg_0_63_60_62_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_63_65: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(63),
      DIB => din(64),
      DIC => din(65),
      DID => '0',
      DOA => RAM_reg_0_63_63_65_n_0,
      DOB => RAM_reg_0_63_63_65_n_1,
      DOC => RAM_reg_0_63_63_65_n_2,
      DOD => NLW_RAM_reg_0_63_63_65_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_66_68: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(66),
      DIB => din(67),
      DIC => din(68),
      DID => '0',
      DOA => RAM_reg_0_63_66_68_n_0,
      DOB => RAM_reg_0_63_66_68_n_1,
      DOC => RAM_reg_0_63_66_68_n_2,
      DOD => NLW_RAM_reg_0_63_66_68_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_69_69: unisim.vcomponents.RAM64X1D
     port map (
      A0 => Q(0),
      A1 => Q(1),
      A2 => Q(2),
      A3 => Q(3),
      A4 => Q(4),
      A5 => Q(5),
      D => din(69),
      DPO => RAM_reg_0_63_69_69_n_0,
      DPRA0 => ADDRA(0),
      DPRA1 => ADDRA(1),
      DPRA2 => ADDRA(2),
      DPRA3 => ADDRA(3),
      DPRA4 => ADDRA(4),
      DPRA5 => ADDRA(5),
      SPO => NLW_RAM_reg_0_63_69_69_SPO_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_6_8: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(6),
      DIB => din(7),
      DIC => din(8),
      DID => '0',
      DOA => RAM_reg_0_63_6_8_n_0,
      DOB => RAM_reg_0_63_6_8_n_1,
      DOC => RAM_reg_0_63_6_8_n_2,
      DOD => NLW_RAM_reg_0_63_6_8_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_70_70: unisim.vcomponents.RAM64X1D
     port map (
      A0 => Q(0),
      A1 => Q(1),
      A2 => Q(2),
      A3 => Q(3),
      A4 => Q(4),
      A5 => Q(5),
      D => din(70),
      DPO => RAM_reg_0_63_70_70_n_0,
      DPRA0 => ADDRA(0),
      DPRA1 => ADDRA(1),
      DPRA2 => ADDRA(2),
      DPRA3 => ADDRA(3),
      DPRA4 => ADDRA(4),
      DPRA5 => ADDRA(5),
      SPO => NLW_RAM_reg_0_63_70_70_SPO_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_0_63_9_11: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(9),
      DIB => din(10),
      DIC => din(11),
      DID => '0',
      DOA => RAM_reg_0_63_9_11_n_0,
      DOB => RAM_reg_0_63_9_11_n_1,
      DOC => RAM_reg_0_63_9_11_n_2,
      DOD => NLW_RAM_reg_0_63_9_11_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg
    );
RAM_reg_128_191_0_2: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(0),
      DIB => din(1),
      DIC => din(2),
      DID => '0',
      DOA => RAM_reg_128_191_0_2_n_0,
      DOB => RAM_reg_128_191_0_2_n_1,
      DOC => RAM_reg_128_191_0_2_n_2,
      DOD => NLW_RAM_reg_128_191_0_2_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_12_14: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(12),
      DIB => din(13),
      DIC => din(14),
      DID => '0',
      DOA => RAM_reg_128_191_12_14_n_0,
      DOB => RAM_reg_128_191_12_14_n_1,
      DOC => RAM_reg_128_191_12_14_n_2,
      DOD => NLW_RAM_reg_128_191_12_14_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_15_17: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(15),
      DIB => din(16),
      DIC => din(17),
      DID => '0',
      DOA => RAM_reg_128_191_15_17_n_0,
      DOB => RAM_reg_128_191_15_17_n_1,
      DOC => RAM_reg_128_191_15_17_n_2,
      DOD => NLW_RAM_reg_128_191_15_17_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_18_20: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(18),
      DIB => din(19),
      DIC => din(20),
      DID => '0',
      DOA => RAM_reg_128_191_18_20_n_0,
      DOB => RAM_reg_128_191_18_20_n_1,
      DOC => RAM_reg_128_191_18_20_n_2,
      DOD => NLW_RAM_reg_128_191_18_20_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_21_23: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(21),
      DIB => din(22),
      DIC => din(23),
      DID => '0',
      DOA => RAM_reg_128_191_21_23_n_0,
      DOB => RAM_reg_128_191_21_23_n_1,
      DOC => RAM_reg_128_191_21_23_n_2,
      DOD => NLW_RAM_reg_128_191_21_23_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_24_26: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(24),
      DIB => din(25),
      DIC => din(26),
      DID => '0',
      DOA => RAM_reg_128_191_24_26_n_0,
      DOB => RAM_reg_128_191_24_26_n_1,
      DOC => RAM_reg_128_191_24_26_n_2,
      DOD => NLW_RAM_reg_128_191_24_26_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_27_29: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(27),
      DIB => din(28),
      DIC => din(29),
      DID => '0',
      DOA => RAM_reg_128_191_27_29_n_0,
      DOB => RAM_reg_128_191_27_29_n_1,
      DOC => RAM_reg_128_191_27_29_n_2,
      DOD => NLW_RAM_reg_128_191_27_29_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_30_32: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(30),
      DIB => din(31),
      DIC => din(32),
      DID => '0',
      DOA => RAM_reg_128_191_30_32_n_0,
      DOB => RAM_reg_128_191_30_32_n_1,
      DOC => RAM_reg_128_191_30_32_n_2,
      DOD => NLW_RAM_reg_128_191_30_32_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_33_35: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(33),
      DIB => din(34),
      DIC => din(35),
      DID => '0',
      DOA => RAM_reg_128_191_33_35_n_0,
      DOB => RAM_reg_128_191_33_35_n_1,
      DOC => RAM_reg_128_191_33_35_n_2,
      DOD => NLW_RAM_reg_128_191_33_35_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_36_38: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(36),
      DIB => din(37),
      DIC => din(38),
      DID => '0',
      DOA => RAM_reg_128_191_36_38_n_0,
      DOB => RAM_reg_128_191_36_38_n_1,
      DOC => RAM_reg_128_191_36_38_n_2,
      DOD => NLW_RAM_reg_128_191_36_38_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_39_41: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(39),
      DIB => din(40),
      DIC => din(41),
      DID => '0',
      DOA => RAM_reg_128_191_39_41_n_0,
      DOB => RAM_reg_128_191_39_41_n_1,
      DOC => RAM_reg_128_191_39_41_n_2,
      DOD => NLW_RAM_reg_128_191_39_41_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_3_5: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(3),
      DIB => din(4),
      DIC => din(5),
      DID => '0',
      DOA => RAM_reg_128_191_3_5_n_0,
      DOB => RAM_reg_128_191_3_5_n_1,
      DOC => RAM_reg_128_191_3_5_n_2,
      DOD => NLW_RAM_reg_128_191_3_5_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_42_44: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(42),
      DIB => din(43),
      DIC => din(44),
      DID => '0',
      DOA => RAM_reg_128_191_42_44_n_0,
      DOB => RAM_reg_128_191_42_44_n_1,
      DOC => RAM_reg_128_191_42_44_n_2,
      DOD => NLW_RAM_reg_128_191_42_44_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_45_47: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(45),
      DIB => din(46),
      DIC => din(47),
      DID => '0',
      DOA => RAM_reg_128_191_45_47_n_0,
      DOB => RAM_reg_128_191_45_47_n_1,
      DOC => RAM_reg_128_191_45_47_n_2,
      DOD => NLW_RAM_reg_128_191_45_47_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_48_50: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(48),
      DIB => din(49),
      DIC => din(50),
      DID => '0',
      DOA => RAM_reg_128_191_48_50_n_0,
      DOB => RAM_reg_128_191_48_50_n_1,
      DOC => RAM_reg_128_191_48_50_n_2,
      DOD => NLW_RAM_reg_128_191_48_50_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_51_53: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(51),
      DIB => din(52),
      DIC => din(53),
      DID => '0',
      DOA => RAM_reg_128_191_51_53_n_0,
      DOB => RAM_reg_128_191_51_53_n_1,
      DOC => RAM_reg_128_191_51_53_n_2,
      DOD => NLW_RAM_reg_128_191_51_53_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_54_56: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(54),
      DIB => din(55),
      DIC => din(56),
      DID => '0',
      DOA => RAM_reg_128_191_54_56_n_0,
      DOB => RAM_reg_128_191_54_56_n_1,
      DOC => RAM_reg_128_191_54_56_n_2,
      DOD => NLW_RAM_reg_128_191_54_56_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_57_59: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(57),
      DIB => din(58),
      DIC => din(59),
      DID => '0',
      DOA => RAM_reg_128_191_57_59_n_0,
      DOB => RAM_reg_128_191_57_59_n_1,
      DOC => RAM_reg_128_191_57_59_n_2,
      DOD => NLW_RAM_reg_128_191_57_59_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_60_62: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(60),
      DIB => din(61),
      DIC => din(62),
      DID => '0',
      DOA => RAM_reg_128_191_60_62_n_0,
      DOB => RAM_reg_128_191_60_62_n_1,
      DOC => RAM_reg_128_191_60_62_n_2,
      DOD => NLW_RAM_reg_128_191_60_62_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_63_65: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(63),
      DIB => din(64),
      DIC => din(65),
      DID => '0',
      DOA => RAM_reg_128_191_63_65_n_0,
      DOB => RAM_reg_128_191_63_65_n_1,
      DOC => RAM_reg_128_191_63_65_n_2,
      DOD => NLW_RAM_reg_128_191_63_65_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_66_68: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(66),
      DIB => din(67),
      DIC => din(68),
      DID => '0',
      DOA => RAM_reg_128_191_66_68_n_0,
      DOB => RAM_reg_128_191_66_68_n_1,
      DOC => RAM_reg_128_191_66_68_n_2,
      DOD => NLW_RAM_reg_128_191_66_68_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_69_69: unisim.vcomponents.RAM64X1D
     port map (
      A0 => Q(0),
      A1 => Q(1),
      A2 => Q(2),
      A3 => Q(3),
      A4 => Q(4),
      A5 => Q(5),
      D => din(69),
      DPO => RAM_reg_128_191_69_69_n_0,
      DPRA0 => ADDRA(0),
      DPRA1 => ADDRA(1),
      DPRA2 => ADDRA(2),
      DPRA3 => ADDRA(3),
      DPRA4 => ADDRA(4),
      DPRA5 => ADDRA(5),
      SPO => NLW_RAM_reg_128_191_69_69_SPO_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_6_8: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(6),
      DIB => din(7),
      DIC => din(8),
      DID => '0',
      DOA => RAM_reg_128_191_6_8_n_0,
      DOB => RAM_reg_128_191_6_8_n_1,
      DOC => RAM_reg_128_191_6_8_n_2,
      DOD => NLW_RAM_reg_128_191_6_8_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_70_70: unisim.vcomponents.RAM64X1D
     port map (
      A0 => Q(0),
      A1 => Q(1),
      A2 => Q(2),
      A3 => Q(3),
      A4 => Q(4),
      A5 => Q(5),
      D => din(70),
      DPO => RAM_reg_128_191_70_70_n_0,
      DPRA0 => ADDRA(0),
      DPRA1 => ADDRA(1),
      DPRA2 => ADDRA(2),
      DPRA3 => ADDRA(3),
      DPRA4 => ADDRA(4),
      DPRA5 => ADDRA(5),
      SPO => NLW_RAM_reg_128_191_70_70_SPO_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_128_191_9_11: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(9),
      DIB => din(10),
      DIC => din(11),
      DID => '0',
      DOA => RAM_reg_128_191_9_11_n_0,
      DOB => RAM_reg_128_191_9_11_n_1,
      DOC => RAM_reg_128_191_9_11_n_2,
      DOD => NLW_RAM_reg_128_191_9_11_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[6]\
    );
RAM_reg_192_255_0_2: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(0),
      DIB => din(1),
      DIC => din(2),
      DID => '0',
      DOA => RAM_reg_192_255_0_2_n_0,
      DOB => RAM_reg_192_255_0_2_n_1,
      DOC => RAM_reg_192_255_0_2_n_2,
      DOD => NLW_RAM_reg_192_255_0_2_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_12_14: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(12),
      DIB => din(13),
      DIC => din(14),
      DID => '0',
      DOA => RAM_reg_192_255_12_14_n_0,
      DOB => RAM_reg_192_255_12_14_n_1,
      DOC => RAM_reg_192_255_12_14_n_2,
      DOD => NLW_RAM_reg_192_255_12_14_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_15_17: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(15),
      DIB => din(16),
      DIC => din(17),
      DID => '0',
      DOA => RAM_reg_192_255_15_17_n_0,
      DOB => RAM_reg_192_255_15_17_n_1,
      DOC => RAM_reg_192_255_15_17_n_2,
      DOD => NLW_RAM_reg_192_255_15_17_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_18_20: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(18),
      DIB => din(19),
      DIC => din(20),
      DID => '0',
      DOA => RAM_reg_192_255_18_20_n_0,
      DOB => RAM_reg_192_255_18_20_n_1,
      DOC => RAM_reg_192_255_18_20_n_2,
      DOD => NLW_RAM_reg_192_255_18_20_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_21_23: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(21),
      DIB => din(22),
      DIC => din(23),
      DID => '0',
      DOA => RAM_reg_192_255_21_23_n_0,
      DOB => RAM_reg_192_255_21_23_n_1,
      DOC => RAM_reg_192_255_21_23_n_2,
      DOD => NLW_RAM_reg_192_255_21_23_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_24_26: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(24),
      DIB => din(25),
      DIC => din(26),
      DID => '0',
      DOA => RAM_reg_192_255_24_26_n_0,
      DOB => RAM_reg_192_255_24_26_n_1,
      DOC => RAM_reg_192_255_24_26_n_2,
      DOD => NLW_RAM_reg_192_255_24_26_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_27_29: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(27),
      DIB => din(28),
      DIC => din(29),
      DID => '0',
      DOA => RAM_reg_192_255_27_29_n_0,
      DOB => RAM_reg_192_255_27_29_n_1,
      DOC => RAM_reg_192_255_27_29_n_2,
      DOD => NLW_RAM_reg_192_255_27_29_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_30_32: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(30),
      DIB => din(31),
      DIC => din(32),
      DID => '0',
      DOA => RAM_reg_192_255_30_32_n_0,
      DOB => RAM_reg_192_255_30_32_n_1,
      DOC => RAM_reg_192_255_30_32_n_2,
      DOD => NLW_RAM_reg_192_255_30_32_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_33_35: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(33),
      DIB => din(34),
      DIC => din(35),
      DID => '0',
      DOA => RAM_reg_192_255_33_35_n_0,
      DOB => RAM_reg_192_255_33_35_n_1,
      DOC => RAM_reg_192_255_33_35_n_2,
      DOD => NLW_RAM_reg_192_255_33_35_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_36_38: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(36),
      DIB => din(37),
      DIC => din(38),
      DID => '0',
      DOA => RAM_reg_192_255_36_38_n_0,
      DOB => RAM_reg_192_255_36_38_n_1,
      DOC => RAM_reg_192_255_36_38_n_2,
      DOD => NLW_RAM_reg_192_255_36_38_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_39_41: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(39),
      DIB => din(40),
      DIC => din(41),
      DID => '0',
      DOA => RAM_reg_192_255_39_41_n_0,
      DOB => RAM_reg_192_255_39_41_n_1,
      DOC => RAM_reg_192_255_39_41_n_2,
      DOD => NLW_RAM_reg_192_255_39_41_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_3_5: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(3),
      DIB => din(4),
      DIC => din(5),
      DID => '0',
      DOA => RAM_reg_192_255_3_5_n_0,
      DOB => RAM_reg_192_255_3_5_n_1,
      DOC => RAM_reg_192_255_3_5_n_2,
      DOD => NLW_RAM_reg_192_255_3_5_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_42_44: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(42),
      DIB => din(43),
      DIC => din(44),
      DID => '0',
      DOA => RAM_reg_192_255_42_44_n_0,
      DOB => RAM_reg_192_255_42_44_n_1,
      DOC => RAM_reg_192_255_42_44_n_2,
      DOD => NLW_RAM_reg_192_255_42_44_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_45_47: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(45),
      DIB => din(46),
      DIC => din(47),
      DID => '0',
      DOA => RAM_reg_192_255_45_47_n_0,
      DOB => RAM_reg_192_255_45_47_n_1,
      DOC => RAM_reg_192_255_45_47_n_2,
      DOD => NLW_RAM_reg_192_255_45_47_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_48_50: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(48),
      DIB => din(49),
      DIC => din(50),
      DID => '0',
      DOA => RAM_reg_192_255_48_50_n_0,
      DOB => RAM_reg_192_255_48_50_n_1,
      DOC => RAM_reg_192_255_48_50_n_2,
      DOD => NLW_RAM_reg_192_255_48_50_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_51_53: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(51),
      DIB => din(52),
      DIC => din(53),
      DID => '0',
      DOA => RAM_reg_192_255_51_53_n_0,
      DOB => RAM_reg_192_255_51_53_n_1,
      DOC => RAM_reg_192_255_51_53_n_2,
      DOD => NLW_RAM_reg_192_255_51_53_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_54_56: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(54),
      DIB => din(55),
      DIC => din(56),
      DID => '0',
      DOA => RAM_reg_192_255_54_56_n_0,
      DOB => RAM_reg_192_255_54_56_n_1,
      DOC => RAM_reg_192_255_54_56_n_2,
      DOD => NLW_RAM_reg_192_255_54_56_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_57_59: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(57),
      DIB => din(58),
      DIC => din(59),
      DID => '0',
      DOA => RAM_reg_192_255_57_59_n_0,
      DOB => RAM_reg_192_255_57_59_n_1,
      DOC => RAM_reg_192_255_57_59_n_2,
      DOD => NLW_RAM_reg_192_255_57_59_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_60_62: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(60),
      DIB => din(61),
      DIC => din(62),
      DID => '0',
      DOA => RAM_reg_192_255_60_62_n_0,
      DOB => RAM_reg_192_255_60_62_n_1,
      DOC => RAM_reg_192_255_60_62_n_2,
      DOD => NLW_RAM_reg_192_255_60_62_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_63_65: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(63),
      DIB => din(64),
      DIC => din(65),
      DID => '0',
      DOA => RAM_reg_192_255_63_65_n_0,
      DOB => RAM_reg_192_255_63_65_n_1,
      DOC => RAM_reg_192_255_63_65_n_2,
      DOD => NLW_RAM_reg_192_255_63_65_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_66_68: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(66),
      DIB => din(67),
      DIC => din(68),
      DID => '0',
      DOA => RAM_reg_192_255_66_68_n_0,
      DOB => RAM_reg_192_255_66_68_n_1,
      DOC => RAM_reg_192_255_66_68_n_2,
      DOD => NLW_RAM_reg_192_255_66_68_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_69_69: unisim.vcomponents.RAM64X1D
     port map (
      A0 => Q(0),
      A1 => Q(1),
      A2 => Q(2),
      A3 => Q(3),
      A4 => Q(4),
      A5 => Q(5),
      D => din(69),
      DPO => RAM_reg_192_255_69_69_n_0,
      DPRA0 => ADDRA(0),
      DPRA1 => ADDRA(1),
      DPRA2 => ADDRA(2),
      DPRA3 => ADDRA(3),
      DPRA4 => ADDRA(4),
      DPRA5 => ADDRA(5),
      SPO => NLW_RAM_reg_192_255_69_69_SPO_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_6_8: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(6),
      DIB => din(7),
      DIC => din(8),
      DID => '0',
      DOA => RAM_reg_192_255_6_8_n_0,
      DOB => RAM_reg_192_255_6_8_n_1,
      DOC => RAM_reg_192_255_6_8_n_2,
      DOD => NLW_RAM_reg_192_255_6_8_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_70_70: unisim.vcomponents.RAM64X1D
     port map (
      A0 => Q(0),
      A1 => Q(1),
      A2 => Q(2),
      A3 => Q(3),
      A4 => Q(4),
      A5 => Q(5),
      D => din(70),
      DPO => RAM_reg_192_255_70_70_n_0,
      DPRA0 => ADDRA(0),
      DPRA1 => ADDRA(1),
      DPRA2 => ADDRA(2),
      DPRA3 => ADDRA(3),
      DPRA4 => ADDRA(4),
      DPRA5 => ADDRA(5),
      SPO => NLW_RAM_reg_192_255_70_70_SPO_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_192_255_9_11: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(9),
      DIB => din(10),
      DIC => din(11),
      DID => '0',
      DOA => RAM_reg_192_255_9_11_n_0,
      DOB => RAM_reg_192_255_9_11_n_1,
      DOC => RAM_reg_192_255_9_11_n_2,
      DOD => NLW_RAM_reg_192_255_9_11_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_full_fb_i_reg_0
    );
RAM_reg_64_127_0_2: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(0),
      DIB => din(1),
      DIC => din(2),
      DID => '0',
      DOA => RAM_reg_64_127_0_2_n_0,
      DOB => RAM_reg_64_127_0_2_n_1,
      DOC => RAM_reg_64_127_0_2_n_2,
      DOD => NLW_RAM_reg_64_127_0_2_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_12_14: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(12),
      DIB => din(13),
      DIC => din(14),
      DID => '0',
      DOA => RAM_reg_64_127_12_14_n_0,
      DOB => RAM_reg_64_127_12_14_n_1,
      DOC => RAM_reg_64_127_12_14_n_2,
      DOD => NLW_RAM_reg_64_127_12_14_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_15_17: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(15),
      DIB => din(16),
      DIC => din(17),
      DID => '0',
      DOA => RAM_reg_64_127_15_17_n_0,
      DOB => RAM_reg_64_127_15_17_n_1,
      DOC => RAM_reg_64_127_15_17_n_2,
      DOD => NLW_RAM_reg_64_127_15_17_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_18_20: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(18),
      DIB => din(19),
      DIC => din(20),
      DID => '0',
      DOA => RAM_reg_64_127_18_20_n_0,
      DOB => RAM_reg_64_127_18_20_n_1,
      DOC => RAM_reg_64_127_18_20_n_2,
      DOD => NLW_RAM_reg_64_127_18_20_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_21_23: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(21),
      DIB => din(22),
      DIC => din(23),
      DID => '0',
      DOA => RAM_reg_64_127_21_23_n_0,
      DOB => RAM_reg_64_127_21_23_n_1,
      DOC => RAM_reg_64_127_21_23_n_2,
      DOD => NLW_RAM_reg_64_127_21_23_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_24_26: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(24),
      DIB => din(25),
      DIC => din(26),
      DID => '0',
      DOA => RAM_reg_64_127_24_26_n_0,
      DOB => RAM_reg_64_127_24_26_n_1,
      DOC => RAM_reg_64_127_24_26_n_2,
      DOD => NLW_RAM_reg_64_127_24_26_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_27_29: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(27),
      DIB => din(28),
      DIC => din(29),
      DID => '0',
      DOA => RAM_reg_64_127_27_29_n_0,
      DOB => RAM_reg_64_127_27_29_n_1,
      DOC => RAM_reg_64_127_27_29_n_2,
      DOD => NLW_RAM_reg_64_127_27_29_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_30_32: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(30),
      DIB => din(31),
      DIC => din(32),
      DID => '0',
      DOA => RAM_reg_64_127_30_32_n_0,
      DOB => RAM_reg_64_127_30_32_n_1,
      DOC => RAM_reg_64_127_30_32_n_2,
      DOD => NLW_RAM_reg_64_127_30_32_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_33_35: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(33),
      DIB => din(34),
      DIC => din(35),
      DID => '0',
      DOA => RAM_reg_64_127_33_35_n_0,
      DOB => RAM_reg_64_127_33_35_n_1,
      DOC => RAM_reg_64_127_33_35_n_2,
      DOD => NLW_RAM_reg_64_127_33_35_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_36_38: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(36),
      DIB => din(37),
      DIC => din(38),
      DID => '0',
      DOA => RAM_reg_64_127_36_38_n_0,
      DOB => RAM_reg_64_127_36_38_n_1,
      DOC => RAM_reg_64_127_36_38_n_2,
      DOD => NLW_RAM_reg_64_127_36_38_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_39_41: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(39),
      DIB => din(40),
      DIC => din(41),
      DID => '0',
      DOA => RAM_reg_64_127_39_41_n_0,
      DOB => RAM_reg_64_127_39_41_n_1,
      DOC => RAM_reg_64_127_39_41_n_2,
      DOD => NLW_RAM_reg_64_127_39_41_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_3_5: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(3),
      DIB => din(4),
      DIC => din(5),
      DID => '0',
      DOA => RAM_reg_64_127_3_5_n_0,
      DOB => RAM_reg_64_127_3_5_n_1,
      DOC => RAM_reg_64_127_3_5_n_2,
      DOD => NLW_RAM_reg_64_127_3_5_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_42_44: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(42),
      DIB => din(43),
      DIC => din(44),
      DID => '0',
      DOA => RAM_reg_64_127_42_44_n_0,
      DOB => RAM_reg_64_127_42_44_n_1,
      DOC => RAM_reg_64_127_42_44_n_2,
      DOD => NLW_RAM_reg_64_127_42_44_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_45_47: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(45),
      DIB => din(46),
      DIC => din(47),
      DID => '0',
      DOA => RAM_reg_64_127_45_47_n_0,
      DOB => RAM_reg_64_127_45_47_n_1,
      DOC => RAM_reg_64_127_45_47_n_2,
      DOD => NLW_RAM_reg_64_127_45_47_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_48_50: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(48),
      DIB => din(49),
      DIC => din(50),
      DID => '0',
      DOA => RAM_reg_64_127_48_50_n_0,
      DOB => RAM_reg_64_127_48_50_n_1,
      DOC => RAM_reg_64_127_48_50_n_2,
      DOD => NLW_RAM_reg_64_127_48_50_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_51_53: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(51),
      DIB => din(52),
      DIC => din(53),
      DID => '0',
      DOA => RAM_reg_64_127_51_53_n_0,
      DOB => RAM_reg_64_127_51_53_n_1,
      DOC => RAM_reg_64_127_51_53_n_2,
      DOD => NLW_RAM_reg_64_127_51_53_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_54_56: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(54),
      DIB => din(55),
      DIC => din(56),
      DID => '0',
      DOA => RAM_reg_64_127_54_56_n_0,
      DOB => RAM_reg_64_127_54_56_n_1,
      DOC => RAM_reg_64_127_54_56_n_2,
      DOD => NLW_RAM_reg_64_127_54_56_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_57_59: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(57),
      DIB => din(58),
      DIC => din(59),
      DID => '0',
      DOA => RAM_reg_64_127_57_59_n_0,
      DOB => RAM_reg_64_127_57_59_n_1,
      DOC => RAM_reg_64_127_57_59_n_2,
      DOD => NLW_RAM_reg_64_127_57_59_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_60_62: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(60),
      DIB => din(61),
      DIC => din(62),
      DID => '0',
      DOA => RAM_reg_64_127_60_62_n_0,
      DOB => RAM_reg_64_127_60_62_n_1,
      DOC => RAM_reg_64_127_60_62_n_2,
      DOD => NLW_RAM_reg_64_127_60_62_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_63_65: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRC(5 downto 0),
      ADDRB(5 downto 0) => ADDRC(5 downto 0),
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(63),
      DIB => din(64),
      DIC => din(65),
      DID => '0',
      DOA => RAM_reg_64_127_63_65_n_0,
      DOB => RAM_reg_64_127_63_65_n_1,
      DOC => RAM_reg_64_127_63_65_n_2,
      DOD => NLW_RAM_reg_64_127_63_65_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_66_68: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(66),
      DIB => din(67),
      DIC => din(68),
      DID => '0',
      DOA => RAM_reg_64_127_66_68_n_0,
      DOB => RAM_reg_64_127_66_68_n_1,
      DOC => RAM_reg_64_127_66_68_n_2,
      DOD => NLW_RAM_reg_64_127_66_68_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_69_69: unisim.vcomponents.RAM64X1D
     port map (
      A0 => Q(0),
      A1 => Q(1),
      A2 => Q(2),
      A3 => Q(3),
      A4 => Q(4),
      A5 => Q(5),
      D => din(69),
      DPO => RAM_reg_64_127_69_69_n_0,
      DPRA0 => ADDRA(0),
      DPRA1 => ADDRA(1),
      DPRA2 => ADDRA(2),
      DPRA3 => ADDRA(3),
      DPRA4 => ADDRA(4),
      DPRA5 => ADDRA(5),
      SPO => NLW_RAM_reg_64_127_69_69_SPO_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_6_8: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(6),
      DIB => din(7),
      DIC => din(8),
      DID => '0',
      DOA => RAM_reg_64_127_6_8_n_0,
      DOB => RAM_reg_64_127_6_8_n_1,
      DOC => RAM_reg_64_127_6_8_n_2,
      DOD => NLW_RAM_reg_64_127_6_8_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_70_70: unisim.vcomponents.RAM64X1D
     port map (
      A0 => Q(0),
      A1 => Q(1),
      A2 => Q(2),
      A3 => Q(3),
      A4 => Q(4),
      A5 => Q(5),
      D => din(70),
      DPO => RAM_reg_64_127_70_70_n_0,
      DPRA0 => ADDRA(0),
      DPRA1 => ADDRA(1),
      DPRA2 => ADDRA(2),
      DPRA3 => ADDRA(3),
      DPRA4 => ADDRA(4),
      DPRA5 => ADDRA(5),
      SPO => NLW_RAM_reg_64_127_70_70_SPO_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
RAM_reg_64_127_9_11: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRB(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRC(5 downto 0) => \gc0.count_d1_reg[7]\(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => din(9),
      DIB => din(10),
      DIC => din(11),
      DID => '0',
      DOA => RAM_reg_64_127_9_11_n_0,
      DOB => RAM_reg_64_127_9_11_n_1,
      DOC => RAM_reg_64_127_9_11_n_2,
      DOD => NLW_RAM_reg_64_127_9_11_DOD_UNCONNECTED,
      WCLK => clk,
      WE => \gcc0.gc1.gsym.count_d2_reg[7]\
    );
\gpr1.dout_i[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_0_2_n_0,
      I1 => RAM_reg_128_191_0_2_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_0_2_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_0_2_n_0,
      O => p_0_out(0)
    );
\gpr1.dout_i[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_9_11_n_1,
      I1 => RAM_reg_128_191_9_11_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_9_11_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_9_11_n_1,
      O => p_0_out(10)
    );
\gpr1.dout_i[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_9_11_n_2,
      I1 => RAM_reg_128_191_9_11_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_9_11_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_9_11_n_2,
      O => p_0_out(11)
    );
\gpr1.dout_i[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_12_14_n_0,
      I1 => RAM_reg_128_191_12_14_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_12_14_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_12_14_n_0,
      O => p_0_out(12)
    );
\gpr1.dout_i[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_12_14_n_1,
      I1 => RAM_reg_128_191_12_14_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_12_14_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_12_14_n_1,
      O => p_0_out(13)
    );
\gpr1.dout_i[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_12_14_n_2,
      I1 => RAM_reg_128_191_12_14_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_12_14_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_12_14_n_2,
      O => p_0_out(14)
    );
\gpr1.dout_i[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_15_17_n_0,
      I1 => RAM_reg_128_191_15_17_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_15_17_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_15_17_n_0,
      O => p_0_out(15)
    );
\gpr1.dout_i[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_15_17_n_1,
      I1 => RAM_reg_128_191_15_17_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_15_17_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_15_17_n_1,
      O => p_0_out(16)
    );
\gpr1.dout_i[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_15_17_n_2,
      I1 => RAM_reg_128_191_15_17_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_15_17_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_15_17_n_2,
      O => p_0_out(17)
    );
\gpr1.dout_i[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_18_20_n_0,
      I1 => RAM_reg_128_191_18_20_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_18_20_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_18_20_n_0,
      O => p_0_out(18)
    );
\gpr1.dout_i[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_18_20_n_1,
      I1 => RAM_reg_128_191_18_20_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_18_20_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_18_20_n_1,
      O => p_0_out(19)
    );
\gpr1.dout_i[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_0_2_n_1,
      I1 => RAM_reg_128_191_0_2_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_0_2_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_0_2_n_1,
      O => p_0_out(1)
    );
\gpr1.dout_i[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_18_20_n_2,
      I1 => RAM_reg_128_191_18_20_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_18_20_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_18_20_n_2,
      O => p_0_out(20)
    );
\gpr1.dout_i[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_21_23_n_0,
      I1 => RAM_reg_128_191_21_23_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_21_23_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_21_23_n_0,
      O => p_0_out(21)
    );
\gpr1.dout_i[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_21_23_n_1,
      I1 => RAM_reg_128_191_21_23_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_21_23_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_21_23_n_1,
      O => p_0_out(22)
    );
\gpr1.dout_i[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_21_23_n_2,
      I1 => RAM_reg_128_191_21_23_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_21_23_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_21_23_n_2,
      O => p_0_out(23)
    );
\gpr1.dout_i[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_24_26_n_0,
      I1 => RAM_reg_128_191_24_26_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_24_26_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_24_26_n_0,
      O => p_0_out(24)
    );
\gpr1.dout_i[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_24_26_n_1,
      I1 => RAM_reg_128_191_24_26_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_24_26_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_24_26_n_1,
      O => p_0_out(25)
    );
\gpr1.dout_i[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_24_26_n_2,
      I1 => RAM_reg_128_191_24_26_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_24_26_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_24_26_n_2,
      O => p_0_out(26)
    );
\gpr1.dout_i[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_27_29_n_0,
      I1 => RAM_reg_128_191_27_29_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_27_29_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_27_29_n_0,
      O => p_0_out(27)
    );
\gpr1.dout_i[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_27_29_n_1,
      I1 => RAM_reg_128_191_27_29_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_27_29_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_27_29_n_1,
      O => p_0_out(28)
    );
\gpr1.dout_i[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_27_29_n_2,
      I1 => RAM_reg_128_191_27_29_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_27_29_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_27_29_n_2,
      O => p_0_out(29)
    );
\gpr1.dout_i[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_0_2_n_2,
      I1 => RAM_reg_128_191_0_2_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_0_2_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_0_2_n_2,
      O => p_0_out(2)
    );
\gpr1.dout_i[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_30_32_n_0,
      I1 => RAM_reg_128_191_30_32_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_30_32_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_30_32_n_0,
      O => p_0_out(30)
    );
\gpr1.dout_i[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_30_32_n_1,
      I1 => RAM_reg_128_191_30_32_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_30_32_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_30_32_n_1,
      O => p_0_out(31)
    );
\gpr1.dout_i[32]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_30_32_n_2,
      I1 => RAM_reg_128_191_30_32_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_30_32_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_30_32_n_2,
      O => p_0_out(32)
    );
\gpr1.dout_i[33]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_33_35_n_0,
      I1 => RAM_reg_128_191_33_35_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_33_35_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_33_35_n_0,
      O => p_0_out(33)
    );
\gpr1.dout_i[34]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_33_35_n_1,
      I1 => RAM_reg_128_191_33_35_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_33_35_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_33_35_n_1,
      O => p_0_out(34)
    );
\gpr1.dout_i[35]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_33_35_n_2,
      I1 => RAM_reg_128_191_33_35_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_33_35_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_33_35_n_2,
      O => p_0_out(35)
    );
\gpr1.dout_i[36]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_36_38_n_0,
      I1 => RAM_reg_128_191_36_38_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_36_38_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_36_38_n_0,
      O => p_0_out(36)
    );
\gpr1.dout_i[37]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_36_38_n_1,
      I1 => RAM_reg_128_191_36_38_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_36_38_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_36_38_n_1,
      O => p_0_out(37)
    );
\gpr1.dout_i[38]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_36_38_n_2,
      I1 => RAM_reg_128_191_36_38_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_36_38_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_36_38_n_2,
      O => p_0_out(38)
    );
\gpr1.dout_i[39]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_39_41_n_0,
      I1 => RAM_reg_128_191_39_41_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_39_41_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_39_41_n_0,
      O => p_0_out(39)
    );
\gpr1.dout_i[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_3_5_n_0,
      I1 => RAM_reg_128_191_3_5_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_3_5_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_3_5_n_0,
      O => p_0_out(3)
    );
\gpr1.dout_i[40]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_39_41_n_1,
      I1 => RAM_reg_128_191_39_41_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_39_41_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_39_41_n_1,
      O => p_0_out(40)
    );
\gpr1.dout_i[41]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_39_41_n_2,
      I1 => RAM_reg_128_191_39_41_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_39_41_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_39_41_n_2,
      O => p_0_out(41)
    );
\gpr1.dout_i[42]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_42_44_n_0,
      I1 => RAM_reg_128_191_42_44_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_42_44_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_42_44_n_0,
      O => p_0_out(42)
    );
\gpr1.dout_i[43]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_42_44_n_1,
      I1 => RAM_reg_128_191_42_44_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_42_44_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_42_44_n_1,
      O => p_0_out(43)
    );
\gpr1.dout_i[44]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_42_44_n_2,
      I1 => RAM_reg_128_191_42_44_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_42_44_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_42_44_n_2,
      O => p_0_out(44)
    );
\gpr1.dout_i[45]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_45_47_n_0,
      I1 => RAM_reg_128_191_45_47_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_45_47_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_45_47_n_0,
      O => p_0_out(45)
    );
\gpr1.dout_i[46]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_45_47_n_1,
      I1 => RAM_reg_128_191_45_47_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_45_47_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_45_47_n_1,
      O => p_0_out(46)
    );
\gpr1.dout_i[47]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_45_47_n_2,
      I1 => RAM_reg_128_191_45_47_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_45_47_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_45_47_n_2,
      O => p_0_out(47)
    );
\gpr1.dout_i[48]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_48_50_n_0,
      I1 => RAM_reg_128_191_48_50_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_48_50_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_48_50_n_0,
      O => p_0_out(48)
    );
\gpr1.dout_i[49]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_48_50_n_1,
      I1 => RAM_reg_128_191_48_50_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_48_50_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_48_50_n_1,
      O => p_0_out(49)
    );
\gpr1.dout_i[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_3_5_n_1,
      I1 => RAM_reg_128_191_3_5_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_3_5_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_3_5_n_1,
      O => p_0_out(4)
    );
\gpr1.dout_i[50]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_48_50_n_2,
      I1 => RAM_reg_128_191_48_50_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_48_50_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_48_50_n_2,
      O => p_0_out(50)
    );
\gpr1.dout_i[51]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_51_53_n_0,
      I1 => RAM_reg_128_191_51_53_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_51_53_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_51_53_n_0,
      O => p_0_out(51)
    );
\gpr1.dout_i[52]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_51_53_n_1,
      I1 => RAM_reg_128_191_51_53_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_51_53_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_51_53_n_1,
      O => p_0_out(52)
    );
\gpr1.dout_i[53]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_51_53_n_2,
      I1 => RAM_reg_128_191_51_53_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_51_53_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_51_53_n_2,
      O => p_0_out(53)
    );
\gpr1.dout_i[54]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_54_56_n_0,
      I1 => RAM_reg_128_191_54_56_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_54_56_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_54_56_n_0,
      O => p_0_out(54)
    );
\gpr1.dout_i[55]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_54_56_n_1,
      I1 => RAM_reg_128_191_54_56_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_54_56_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_54_56_n_1,
      O => p_0_out(55)
    );
\gpr1.dout_i[56]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_54_56_n_2,
      I1 => RAM_reg_128_191_54_56_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_54_56_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_54_56_n_2,
      O => p_0_out(56)
    );
\gpr1.dout_i[57]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_57_59_n_0,
      I1 => RAM_reg_128_191_57_59_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_57_59_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_57_59_n_0,
      O => p_0_out(57)
    );
\gpr1.dout_i[58]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_57_59_n_1,
      I1 => RAM_reg_128_191_57_59_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_57_59_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_57_59_n_1,
      O => p_0_out(58)
    );
\gpr1.dout_i[59]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_57_59_n_2,
      I1 => RAM_reg_128_191_57_59_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_57_59_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_57_59_n_2,
      O => p_0_out(59)
    );
\gpr1.dout_i[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_3_5_n_2,
      I1 => RAM_reg_128_191_3_5_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_3_5_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_3_5_n_2,
      O => p_0_out(5)
    );
\gpr1.dout_i[60]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_60_62_n_0,
      I1 => RAM_reg_128_191_60_62_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_60_62_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_60_62_n_0,
      O => p_0_out(60)
    );
\gpr1.dout_i[61]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_60_62_n_1,
      I1 => RAM_reg_128_191_60_62_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_60_62_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_60_62_n_1,
      O => p_0_out(61)
    );
\gpr1.dout_i[62]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_60_62_n_2,
      I1 => RAM_reg_128_191_60_62_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_60_62_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_60_62_n_2,
      O => p_0_out(62)
    );
\gpr1.dout_i[63]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_63_65_n_0,
      I1 => RAM_reg_128_191_63_65_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_63_65_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_63_65_n_0,
      O => p_0_out(63)
    );
\gpr1.dout_i[64]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_63_65_n_1,
      I1 => RAM_reg_128_191_63_65_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_63_65_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_63_65_n_1,
      O => p_0_out(64)
    );
\gpr1.dout_i[65]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_63_65_n_2,
      I1 => RAM_reg_128_191_63_65_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_63_65_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_63_65_n_2,
      O => p_0_out(65)
    );
\gpr1.dout_i[66]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_66_68_n_0,
      I1 => RAM_reg_128_191_66_68_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_66_68_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_66_68_n_0,
      O => p_0_out(66)
    );
\gpr1.dout_i[67]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_66_68_n_1,
      I1 => RAM_reg_128_191_66_68_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_66_68_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_66_68_n_1,
      O => p_0_out(67)
    );
\gpr1.dout_i[68]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_66_68_n_2,
      I1 => RAM_reg_128_191_66_68_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_66_68_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_66_68_n_2,
      O => p_0_out(68)
    );
\gpr1.dout_i[69]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_69_69_n_0,
      I1 => RAM_reg_128_191_69_69_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_69_69_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_69_69_n_0,
      O => p_0_out(69)
    );
\gpr1.dout_i[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_6_8_n_0,
      I1 => RAM_reg_128_191_6_8_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_6_8_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_6_8_n_0,
      O => p_0_out(6)
    );
\gpr1.dout_i[70]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_70_70_n_0,
      I1 => RAM_reg_128_191_70_70_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_70_70_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_70_70_n_0,
      O => p_0_out(70)
    );
\gpr1.dout_i[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_6_8_n_1,
      I1 => RAM_reg_128_191_6_8_n_1,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_6_8_n_1,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_6_8_n_1,
      O => p_0_out(7)
    );
\gpr1.dout_i[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_6_8_n_2,
      I1 => RAM_reg_128_191_6_8_n_2,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_6_8_n_2,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_6_8_n_2,
      O => p_0_out(8)
    );
\gpr1.dout_i[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => RAM_reg_192_255_9_11_n_0,
      I1 => RAM_reg_128_191_9_11_n_0,
      I2 => \gc0.count_d1_reg[7]\(7),
      I3 => RAM_reg_64_127_9_11_n_0,
      I4 => \gc0.count_d1_reg[7]\(6),
      I5 => RAM_reg_0_63_9_11_n_0,
      O => p_0_out(9)
    );
\gpr1.dout_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(0),
      Q => \goreg_dm.dout_i_reg[70]\(0),
      R => srst
    );
\gpr1.dout_i_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(10),
      Q => \goreg_dm.dout_i_reg[70]\(10),
      R => srst
    );
\gpr1.dout_i_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(11),
      Q => \goreg_dm.dout_i_reg[70]\(11),
      R => srst
    );
\gpr1.dout_i_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(12),
      Q => \goreg_dm.dout_i_reg[70]\(12),
      R => srst
    );
\gpr1.dout_i_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(13),
      Q => \goreg_dm.dout_i_reg[70]\(13),
      R => srst
    );
\gpr1.dout_i_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(14),
      Q => \goreg_dm.dout_i_reg[70]\(14),
      R => srst
    );
\gpr1.dout_i_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(15),
      Q => \goreg_dm.dout_i_reg[70]\(15),
      R => srst
    );
\gpr1.dout_i_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(16),
      Q => \goreg_dm.dout_i_reg[70]\(16),
      R => srst
    );
\gpr1.dout_i_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(17),
      Q => \goreg_dm.dout_i_reg[70]\(17),
      R => srst
    );
\gpr1.dout_i_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(18),
      Q => \goreg_dm.dout_i_reg[70]\(18),
      R => srst
    );
\gpr1.dout_i_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(19),
      Q => \goreg_dm.dout_i_reg[70]\(19),
      R => srst
    );
\gpr1.dout_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(1),
      Q => \goreg_dm.dout_i_reg[70]\(1),
      R => srst
    );
\gpr1.dout_i_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(20),
      Q => \goreg_dm.dout_i_reg[70]\(20),
      R => srst
    );
\gpr1.dout_i_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(21),
      Q => \goreg_dm.dout_i_reg[70]\(21),
      R => srst
    );
\gpr1.dout_i_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(22),
      Q => \goreg_dm.dout_i_reg[70]\(22),
      R => srst
    );
\gpr1.dout_i_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(23),
      Q => \goreg_dm.dout_i_reg[70]\(23),
      R => srst
    );
\gpr1.dout_i_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(24),
      Q => \goreg_dm.dout_i_reg[70]\(24),
      R => srst
    );
\gpr1.dout_i_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(25),
      Q => \goreg_dm.dout_i_reg[70]\(25),
      R => srst
    );
\gpr1.dout_i_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(26),
      Q => \goreg_dm.dout_i_reg[70]\(26),
      R => srst
    );
\gpr1.dout_i_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(27),
      Q => \goreg_dm.dout_i_reg[70]\(27),
      R => srst
    );
\gpr1.dout_i_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(28),
      Q => \goreg_dm.dout_i_reg[70]\(28),
      R => srst
    );
\gpr1.dout_i_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(29),
      Q => \goreg_dm.dout_i_reg[70]\(29),
      R => srst
    );
\gpr1.dout_i_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(2),
      Q => \goreg_dm.dout_i_reg[70]\(2),
      R => srst
    );
\gpr1.dout_i_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(30),
      Q => \goreg_dm.dout_i_reg[70]\(30),
      R => srst
    );
\gpr1.dout_i_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(31),
      Q => \goreg_dm.dout_i_reg[70]\(31),
      R => srst
    );
\gpr1.dout_i_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(32),
      Q => \goreg_dm.dout_i_reg[70]\(32),
      R => srst
    );
\gpr1.dout_i_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(33),
      Q => \goreg_dm.dout_i_reg[70]\(33),
      R => srst
    );
\gpr1.dout_i_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(34),
      Q => \goreg_dm.dout_i_reg[70]\(34),
      R => srst
    );
\gpr1.dout_i_reg[35]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(35),
      Q => \goreg_dm.dout_i_reg[70]\(35),
      R => srst
    );
\gpr1.dout_i_reg[36]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(36),
      Q => \goreg_dm.dout_i_reg[70]\(36),
      R => srst
    );
\gpr1.dout_i_reg[37]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(37),
      Q => \goreg_dm.dout_i_reg[70]\(37),
      R => srst
    );
\gpr1.dout_i_reg[38]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(38),
      Q => \goreg_dm.dout_i_reg[70]\(38),
      R => srst
    );
\gpr1.dout_i_reg[39]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(39),
      Q => \goreg_dm.dout_i_reg[70]\(39),
      R => srst
    );
\gpr1.dout_i_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(3),
      Q => \goreg_dm.dout_i_reg[70]\(3),
      R => srst
    );
\gpr1.dout_i_reg[40]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(40),
      Q => \goreg_dm.dout_i_reg[70]\(40),
      R => srst
    );
\gpr1.dout_i_reg[41]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(41),
      Q => \goreg_dm.dout_i_reg[70]\(41),
      R => srst
    );
\gpr1.dout_i_reg[42]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(42),
      Q => \goreg_dm.dout_i_reg[70]\(42),
      R => srst
    );
\gpr1.dout_i_reg[43]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(43),
      Q => \goreg_dm.dout_i_reg[70]\(43),
      R => srst
    );
\gpr1.dout_i_reg[44]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(44),
      Q => \goreg_dm.dout_i_reg[70]\(44),
      R => srst
    );
\gpr1.dout_i_reg[45]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(45),
      Q => \goreg_dm.dout_i_reg[70]\(45),
      R => srst
    );
\gpr1.dout_i_reg[46]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(46),
      Q => \goreg_dm.dout_i_reg[70]\(46),
      R => srst
    );
\gpr1.dout_i_reg[47]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(47),
      Q => \goreg_dm.dout_i_reg[70]\(47),
      R => srst
    );
\gpr1.dout_i_reg[48]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(48),
      Q => \goreg_dm.dout_i_reg[70]\(48),
      R => srst
    );
\gpr1.dout_i_reg[49]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(49),
      Q => \goreg_dm.dout_i_reg[70]\(49),
      R => srst
    );
\gpr1.dout_i_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(4),
      Q => \goreg_dm.dout_i_reg[70]\(4),
      R => srst
    );
\gpr1.dout_i_reg[50]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(50),
      Q => \goreg_dm.dout_i_reg[70]\(50),
      R => srst
    );
\gpr1.dout_i_reg[51]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(51),
      Q => \goreg_dm.dout_i_reg[70]\(51),
      R => srst
    );
\gpr1.dout_i_reg[52]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(52),
      Q => \goreg_dm.dout_i_reg[70]\(52),
      R => srst
    );
\gpr1.dout_i_reg[53]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(53),
      Q => \goreg_dm.dout_i_reg[70]\(53),
      R => srst
    );
\gpr1.dout_i_reg[54]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(54),
      Q => \goreg_dm.dout_i_reg[70]\(54),
      R => srst
    );
\gpr1.dout_i_reg[55]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(55),
      Q => \goreg_dm.dout_i_reg[70]\(55),
      R => srst
    );
\gpr1.dout_i_reg[56]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(56),
      Q => \goreg_dm.dout_i_reg[70]\(56),
      R => srst
    );
\gpr1.dout_i_reg[57]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(57),
      Q => \goreg_dm.dout_i_reg[70]\(57),
      R => srst
    );
\gpr1.dout_i_reg[58]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(58),
      Q => \goreg_dm.dout_i_reg[70]\(58),
      R => srst
    );
\gpr1.dout_i_reg[59]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(59),
      Q => \goreg_dm.dout_i_reg[70]\(59),
      R => srst
    );
\gpr1.dout_i_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(5),
      Q => \goreg_dm.dout_i_reg[70]\(5),
      R => srst
    );
\gpr1.dout_i_reg[60]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(60),
      Q => \goreg_dm.dout_i_reg[70]\(60),
      R => srst
    );
\gpr1.dout_i_reg[61]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(61),
      Q => \goreg_dm.dout_i_reg[70]\(61),
      R => srst
    );
\gpr1.dout_i_reg[62]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(62),
      Q => \goreg_dm.dout_i_reg[70]\(62),
      R => srst
    );
\gpr1.dout_i_reg[63]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(63),
      Q => \goreg_dm.dout_i_reg[70]\(63),
      R => srst
    );
\gpr1.dout_i_reg[64]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(64),
      Q => \goreg_dm.dout_i_reg[70]\(64),
      R => srst
    );
\gpr1.dout_i_reg[65]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(65),
      Q => \goreg_dm.dout_i_reg[70]\(65),
      R => srst
    );
\gpr1.dout_i_reg[66]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(66),
      Q => \goreg_dm.dout_i_reg[70]\(66),
      R => srst
    );
\gpr1.dout_i_reg[67]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(67),
      Q => \goreg_dm.dout_i_reg[70]\(67),
      R => srst
    );
\gpr1.dout_i_reg[68]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(68),
      Q => \goreg_dm.dout_i_reg[70]\(68),
      R => srst
    );
\gpr1.dout_i_reg[69]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(69),
      Q => \goreg_dm.dout_i_reg[70]\(69),
      R => srst
    );
\gpr1.dout_i_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(6),
      Q => \goreg_dm.dout_i_reg[70]\(6),
      R => srst
    );
\gpr1.dout_i_reg[70]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(70),
      Q => \goreg_dm.dout_i_reg[70]\(70),
      R => srst
    );
\gpr1.dout_i_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(7),
      Q => \goreg_dm.dout_i_reg[70]\(7),
      R => srst
    );
\gpr1.dout_i_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(8),
      Q => \goreg_dm.dout_i_reg[70]\(8),
      R => srst
    );
\gpr1.dout_i_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_0_out(9),
      Q => \goreg_dm.dout_i_reg[70]\(9),
      R => srst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_rd_bin_cntr is
  port (
    Q : out STD_LOGIC_VECTOR ( 7 downto 0 );
    \gpr1.dout_i_reg[70]\ : out STD_LOGIC_VECTOR ( 7 downto 0 );
    ADDRC : out STD_LOGIC_VECTOR ( 5 downto 0 );
    \gpr1.dout_i_reg[70]_0\ : out STD_LOGIC;
    \gpr1.dout_i_reg[70]_1\ : out STD_LOGIC;
    \gpr1.dout_i_reg[70]_2\ : out STD_LOGIC;
    \gpr1.dout_i_reg[70]_3\ : out STD_LOGIC;
    \gpr1.dout_i_reg[70]_4\ : out STD_LOGIC;
    \gpr1.dout_i_reg[70]_5\ : out STD_LOGIC;
    srst : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_rd_bin_cntr : entity is "rd_bin_cntr";
end fwft_sfifo_w71_d256_rd_bin_cntr;

architecture STRUCTURE of fwft_sfifo_w71_d256_rd_bin_cntr is
  signal \^q\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \gc0.count[7]_i_2_n_0\ : STD_LOGIC;
  signal plusOp : STD_LOGIC_VECTOR ( 7 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gc0.count[1]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \gc0.count[2]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \gc0.count[3]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \gc0.count[4]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \gc0.count[6]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \gc0.count[7]_i_1\ : label is "soft_lutpair1";
  attribute ORIG_CELL_NAME : string;
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[0]\ : label is "gc0.count_d1_reg[0]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[0]_rep\ : label is "gc0.count_d1_reg[0]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[0]_rep__0\ : label is "gc0.count_d1_reg[0]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[1]\ : label is "gc0.count_d1_reg[1]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[1]_rep\ : label is "gc0.count_d1_reg[1]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[1]_rep__0\ : label is "gc0.count_d1_reg[1]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[2]\ : label is "gc0.count_d1_reg[2]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[2]_rep\ : label is "gc0.count_d1_reg[2]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[2]_rep__0\ : label is "gc0.count_d1_reg[2]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[3]\ : label is "gc0.count_d1_reg[3]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[3]_rep\ : label is "gc0.count_d1_reg[3]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[3]_rep__0\ : label is "gc0.count_d1_reg[3]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[4]\ : label is "gc0.count_d1_reg[4]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[4]_rep\ : label is "gc0.count_d1_reg[4]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[4]_rep__0\ : label is "gc0.count_d1_reg[4]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[5]\ : label is "gc0.count_d1_reg[5]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[5]_rep\ : label is "gc0.count_d1_reg[5]";
  attribute ORIG_CELL_NAME of \gc0.count_d1_reg[5]_rep__0\ : label is "gc0.count_d1_reg[5]";
begin
  Q(7 downto 0) <= \^q\(7 downto 0);
\gc0.count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(0),
      O => plusOp(0)
    );
\gc0.count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      O => plusOp(1)
    );
\gc0.count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => \^q\(2),
      O => plusOp(2)
    );
\gc0.count[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      I2 => \^q\(2),
      I3 => \^q\(3),
      O => plusOp(3)
    );
\gc0.count[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \^q\(2),
      I1 => \^q\(0),
      I2 => \^q\(1),
      I3 => \^q\(3),
      I4 => \^q\(4),
      O => plusOp(4)
    );
\gc0.count[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => \^q\(3),
      I1 => \^q\(1),
      I2 => \^q\(0),
      I3 => \^q\(2),
      I4 => \^q\(4),
      I5 => \^q\(5),
      O => plusOp(5)
    );
\gc0.count[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \gc0.count[7]_i_2_n_0\,
      I1 => \^q\(6),
      O => plusOp(6)
    );
\gc0.count[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \gc0.count[7]_i_2_n_0\,
      I1 => \^q\(6),
      I2 => \^q\(7),
      O => plusOp(7)
    );
\gc0.count[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => \^q\(5),
      I1 => \^q\(3),
      I2 => \^q\(1),
      I3 => \^q\(0),
      I4 => \^q\(2),
      I5 => \^q\(4),
      O => \gc0.count[7]_i_2_n_0\
    );
\gc0.count_d1_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(0),
      Q => \gpr1.dout_i_reg[70]\(0),
      R => srst
    );
\gc0.count_d1_reg[0]_rep\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(0),
      Q => ADDRC(0),
      R => srst
    );
\gc0.count_d1_reg[0]_rep__0\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(0),
      Q => \gpr1.dout_i_reg[70]_5\,
      R => srst
    );
\gc0.count_d1_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(1),
      Q => \gpr1.dout_i_reg[70]\(1),
      R => srst
    );
\gc0.count_d1_reg[1]_rep\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(1),
      Q => ADDRC(1),
      R => srst
    );
\gc0.count_d1_reg[1]_rep__0\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(1),
      Q => \gpr1.dout_i_reg[70]_4\,
      R => srst
    );
\gc0.count_d1_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(2),
      Q => \gpr1.dout_i_reg[70]\(2),
      R => srst
    );
\gc0.count_d1_reg[2]_rep\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(2),
      Q => ADDRC(2),
      R => srst
    );
\gc0.count_d1_reg[2]_rep__0\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(2),
      Q => \gpr1.dout_i_reg[70]_3\,
      R => srst
    );
\gc0.count_d1_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(3),
      Q => \gpr1.dout_i_reg[70]\(3),
      R => srst
    );
\gc0.count_d1_reg[3]_rep\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(3),
      Q => ADDRC(3),
      R => srst
    );
\gc0.count_d1_reg[3]_rep__0\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(3),
      Q => \gpr1.dout_i_reg[70]_2\,
      R => srst
    );
\gc0.count_d1_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(4),
      Q => \gpr1.dout_i_reg[70]\(4),
      R => srst
    );
\gc0.count_d1_reg[4]_rep\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(4),
      Q => ADDRC(4),
      R => srst
    );
\gc0.count_d1_reg[4]_rep__0\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(4),
      Q => \gpr1.dout_i_reg[70]_1\,
      R => srst
    );
\gc0.count_d1_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(5),
      Q => \gpr1.dout_i_reg[70]\(5),
      R => srst
    );
\gc0.count_d1_reg[5]_rep\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(5),
      Q => ADDRC(5),
      R => srst
    );
\gc0.count_d1_reg[5]_rep__0\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(5),
      Q => \gpr1.dout_i_reg[70]_0\,
      R => srst
    );
\gc0.count_d1_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(6),
      Q => \gpr1.dout_i_reg[70]\(6),
      R => srst
    );
\gc0.count_d1_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \^q\(7),
      Q => \gpr1.dout_i_reg[70]\(7),
      R => srst
    );
\gc0.count_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => E(0),
      D => plusOp(0),
      Q => \^q\(0),
      S => srst
    );
\gc0.count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => plusOp(1),
      Q => \^q\(1),
      R => srst
    );
\gc0.count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => plusOp(2),
      Q => \^q\(2),
      R => srst
    );
\gc0.count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => plusOp(3),
      Q => \^q\(3),
      R => srst
    );
\gc0.count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => plusOp(4),
      Q => \^q\(4),
      R => srst
    );
\gc0.count_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => plusOp(5),
      Q => \^q\(5),
      R => srst
    );
\gc0.count_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => plusOp(6),
      Q => \^q\(6),
      R => srst
    );
\gc0.count_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => plusOp(7),
      Q => \^q\(7),
      R => srst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_rd_fwft is
  port (
    empty : out STD_LOGIC;
    valid : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \count_reg[0]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \gc0.count_d1_reg[0]_rep__0\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \goreg_dm.dout_i_reg[70]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    srst : in STD_LOGIC;
    clk : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    \out\ : in STD_LOGIC;
    ram_full_fb_i_reg : in STD_LOGIC;
    wr_en : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_rd_fwft : entity is "rd_fwft";
end fwft_sfifo_w71_d256_rd_fwft;

architecture STRUCTURE of fwft_sfifo_w71_d256_rd_fwft is
  signal aempty_fwft_fb_i : STD_LOGIC;
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of aempty_fwft_fb_i : signal is std.standard.true;
  signal aempty_fwft_i : STD_LOGIC;
  attribute DONT_TOUCH of aempty_fwft_i : signal is std.standard.true;
  signal \aempty_fwft_i0__6\ : STD_LOGIC;
  signal curr_fwft_state : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute DONT_TOUCH of curr_fwft_state : signal is std.standard.true;
  signal empty_fwft_fb_i : STD_LOGIC;
  attribute DONT_TOUCH of empty_fwft_fb_i : signal is std.standard.true;
  signal empty_fwft_fb_o_i : STD_LOGIC;
  attribute DONT_TOUCH of empty_fwft_fb_o_i : signal is std.standard.true;
  signal empty_fwft_fb_o_i_reg0 : STD_LOGIC;
  signal empty_fwft_i : STD_LOGIC;
  attribute DONT_TOUCH of empty_fwft_i : signal is std.standard.true;
  signal \empty_fwft_i0__1\ : STD_LOGIC;
  signal next_fwft_state : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal user_valid : STD_LOGIC;
  attribute DONT_TOUCH of user_valid : signal is std.standard.true;
  attribute DONT_TOUCH of aempty_fwft_fb_i_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of aempty_fwft_fb_i_reg : label is "yes";
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of aempty_fwft_fb_i_reg : label is "no";
  attribute DONT_TOUCH of aempty_fwft_i_reg : label is std.standard.true;
  attribute KEEP of aempty_fwft_i_reg : label is "yes";
  attribute equivalent_register_removal of aempty_fwft_i_reg : label is "no";
  attribute DONT_TOUCH of empty_fwft_fb_i_reg : label is std.standard.true;
  attribute KEEP of empty_fwft_fb_i_reg : label is "yes";
  attribute equivalent_register_removal of empty_fwft_fb_i_reg : label is "no";
  attribute DONT_TOUCH of empty_fwft_fb_o_i_reg : label is std.standard.true;
  attribute KEEP of empty_fwft_fb_o_i_reg : label is "yes";
  attribute equivalent_register_removal of empty_fwft_fb_o_i_reg : label is "no";
  attribute DONT_TOUCH of empty_fwft_i_reg : label is std.standard.true;
  attribute KEEP of empty_fwft_i_reg : label is "yes";
  attribute equivalent_register_removal of empty_fwft_i_reg : label is "no";
  attribute DONT_TOUCH of \gpregsm1.curr_fwft_state_reg[0]\ : label is std.standard.true;
  attribute KEEP of \gpregsm1.curr_fwft_state_reg[0]\ : label is "yes";
  attribute equivalent_register_removal of \gpregsm1.curr_fwft_state_reg[0]\ : label is "no";
  attribute DONT_TOUCH of \gpregsm1.curr_fwft_state_reg[1]\ : label is std.standard.true;
  attribute KEEP of \gpregsm1.curr_fwft_state_reg[1]\ : label is "yes";
  attribute equivalent_register_removal of \gpregsm1.curr_fwft_state_reg[1]\ : label is "no";
  attribute DONT_TOUCH of \gpregsm1.user_valid_reg\ : label is std.standard.true;
  attribute KEEP of \gpregsm1.user_valid_reg\ : label is "yes";
  attribute equivalent_register_removal of \gpregsm1.user_valid_reg\ : label is "no";
begin
  empty <= empty_fwft_i;
  valid <= user_valid;
aempty_fwft_fb_i_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EEFD8000"
    )
        port map (
      I0 => curr_fwft_state(0),
      I1 => \out\,
      I2 => rd_en,
      I3 => curr_fwft_state(1),
      I4 => aempty_fwft_fb_i,
      O => \aempty_fwft_i0__6\
    );
aempty_fwft_fb_i_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => '1',
      D => \aempty_fwft_i0__6\,
      Q => aempty_fwft_fb_i,
      S => srst
    );
aempty_fwft_i_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => '1',
      D => \aempty_fwft_i0__6\,
      Q => aempty_fwft_i,
      S => srst
    );
\count[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8788"
    )
        port map (
      I0 => user_valid,
      I1 => rd_en,
      I2 => ram_full_fb_i_reg,
      I3 => wr_en,
      O => \count_reg[0]\(0)
    );
empty_fwft_fb_i_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F320"
    )
        port map (
      I0 => rd_en,
      I1 => curr_fwft_state(1),
      I2 => curr_fwft_state(0),
      I3 => empty_fwft_fb_i,
      O => \empty_fwft_i0__1\
    );
empty_fwft_fb_i_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => '1',
      D => \empty_fwft_i0__1\,
      Q => empty_fwft_fb_i,
      S => srst
    );
empty_fwft_fb_o_i_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F320"
    )
        port map (
      I0 => rd_en,
      I1 => curr_fwft_state(1),
      I2 => curr_fwft_state(0),
      I3 => empty_fwft_fb_o_i,
      O => empty_fwft_fb_o_i_reg0
    );
empty_fwft_fb_o_i_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => '1',
      D => empty_fwft_fb_o_i_reg0,
      Q => empty_fwft_fb_o_i,
      S => srst
    );
empty_fwft_i_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => '1',
      D => \empty_fwft_i0__1\,
      Q => empty_fwft_i,
      S => srst
    );
\gc0.count_d1[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00BF"
    )
        port map (
      I0 => rd_en,
      I1 => curr_fwft_state(0),
      I2 => curr_fwft_state(1),
      I3 => \out\,
      O => \gc0.count_d1_reg[0]_rep__0\(0)
    );
\goreg_dm.dout_i[70]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A2"
    )
        port map (
      I0 => curr_fwft_state(1),
      I1 => curr_fwft_state(0),
      I2 => rd_en,
      O => \goreg_dm.dout_i_reg[70]\(0)
    );
\gpr1.dout_i[70]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00F7"
    )
        port map (
      I0 => curr_fwft_state(1),
      I1 => curr_fwft_state(0),
      I2 => rd_en,
      I3 => \out\,
      O => E(0)
    );
\gpregsm1.curr_fwft_state[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => curr_fwft_state(1),
      I1 => rd_en,
      I2 => curr_fwft_state(0),
      O => next_fwft_state(0)
    );
\gpregsm1.curr_fwft_state[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"20FF"
    )
        port map (
      I0 => curr_fwft_state(1),
      I1 => rd_en,
      I2 => curr_fwft_state(0),
      I3 => \out\,
      O => next_fwft_state(1)
    );
\gpregsm1.curr_fwft_state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => next_fwft_state(0),
      Q => curr_fwft_state(0),
      R => srst
    );
\gpregsm1.curr_fwft_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => next_fwft_state(1),
      Q => curr_fwft_state(1),
      R => srst
    );
\gpregsm1.user_valid_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => next_fwft_state(0),
      Q => user_valid,
      R => srst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_rd_status_flags_ss is
  port (
    \out\ : out STD_LOGIC;
    srst : in STD_LOGIC;
    ram_empty_fb_i_reg_0 : in STD_LOGIC;
    clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_rd_status_flags_ss : entity is "rd_status_flags_ss";
end fwft_sfifo_w71_d256_rd_status_flags_ss;

architecture STRUCTURE of fwft_sfifo_w71_d256_rd_status_flags_ss is
  signal ram_empty_fb_i : STD_LOGIC;
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of ram_empty_fb_i : signal is std.standard.true;
  signal ram_empty_i : STD_LOGIC;
  attribute DONT_TOUCH of ram_empty_i : signal is std.standard.true;
  attribute DONT_TOUCH of ram_empty_fb_i_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of ram_empty_fb_i_reg : label is "yes";
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of ram_empty_fb_i_reg : label is "no";
  attribute DONT_TOUCH of ram_empty_i_reg : label is std.standard.true;
  attribute KEEP of ram_empty_i_reg : label is "yes";
  attribute equivalent_register_removal of ram_empty_i_reg : label is "no";
begin
  \out\ <= ram_empty_fb_i;
ram_empty_fb_i_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => '1',
      D => ram_empty_fb_i_reg_0,
      Q => ram_empty_fb_i,
      S => srst
    );
ram_empty_i_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => '1',
      D => ram_empty_fb_i_reg_0,
      Q => ram_empty_i,
      S => srst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_updn_cntr is
  port (
    Q : out STD_LOGIC_VECTOR ( 8 downto 0 );
    valid : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    srst : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_updn_cntr : entity is "updn_cntr";
end fwft_sfifo_w71_d256_updn_cntr;

architecture STRUCTURE of fwft_sfifo_w71_d256_updn_cntr is
  signal \^q\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \count[0]_i_1_n_0\ : STD_LOGIC;
  signal \count[4]_i_2_n_0\ : STD_LOGIC;
  signal \count[4]_i_3_n_0\ : STD_LOGIC;
  signal \count[4]_i_4_n_0\ : STD_LOGIC;
  signal \count[4]_i_5_n_0\ : STD_LOGIC;
  signal \count[4]_i_6_n_0\ : STD_LOGIC;
  signal \count[8]_i_3_n_0\ : STD_LOGIC;
  signal \count[8]_i_4_n_0\ : STD_LOGIC;
  signal \count[8]_i_5_n_0\ : STD_LOGIC;
  signal \count[8]_i_6_n_0\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \count_reg[8]_i_2_n_1\ : STD_LOGIC;
  signal \count_reg[8]_i_2_n_2\ : STD_LOGIC;
  signal \count_reg[8]_i_2_n_3\ : STD_LOGIC;
  signal \count_reg[8]_i_2_n_4\ : STD_LOGIC;
  signal \count_reg[8]_i_2_n_5\ : STD_LOGIC;
  signal \count_reg[8]_i_2_n_6\ : STD_LOGIC;
  signal \count_reg[8]_i_2_n_7\ : STD_LOGIC;
  signal \NLW_count_reg[8]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of \count_reg[4]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of \count_reg[8]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
begin
  Q(8 downto 0) <= \^q\(8 downto 0);
\count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(0),
      O => \count[0]_i_1_n_0\
    );
\count[4]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(1),
      O => \count[4]_i_2_n_0\
    );
\count[4]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \^q\(3),
      I1 => \^q\(4),
      O => \count[4]_i_3_n_0\
    );
\count[4]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \^q\(2),
      I1 => \^q\(3),
      O => \count[4]_i_4_n_0\
    );
\count[4]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(2),
      O => \count[4]_i_5_n_0\
    );
\count[4]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \^q\(1),
      I1 => valid,
      I2 => rd_en,
      O => \count[4]_i_6_n_0\
    );
\count[8]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \^q\(7),
      I1 => \^q\(8),
      O => \count[8]_i_3_n_0\
    );
\count[8]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \^q\(6),
      I1 => \^q\(7),
      O => \count[8]_i_4_n_0\
    );
\count[8]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \^q\(5),
      I1 => \^q\(6),
      O => \count[8]_i_5_n_0\
    );
\count[8]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \^q\(4),
      I1 => \^q\(5),
      O => \count[8]_i_6_n_0\
    );
\count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \count[0]_i_1_n_0\,
      Q => \^q\(0),
      R => srst
    );
\count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \count_reg[4]_i_1_n_7\,
      Q => \^q\(1),
      R => srst
    );
\count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \count_reg[4]_i_1_n_6\,
      Q => \^q\(2),
      R => srst
    );
\count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \count_reg[4]_i_1_n_5\,
      Q => \^q\(3),
      R => srst
    );
\count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \count_reg[4]_i_1_n_4\,
      Q => \^q\(4),
      R => srst
    );
\count_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \count_reg[4]_i_1_n_0\,
      CO(2) => \count_reg[4]_i_1_n_1\,
      CO(1) => \count_reg[4]_i_1_n_2\,
      CO(0) => \count_reg[4]_i_1_n_3\,
      CYINIT => \^q\(0),
      DI(3 downto 1) => \^q\(3 downto 1),
      DI(0) => \count[4]_i_2_n_0\,
      O(3) => \count_reg[4]_i_1_n_4\,
      O(2) => \count_reg[4]_i_1_n_5\,
      O(1) => \count_reg[4]_i_1_n_6\,
      O(0) => \count_reg[4]_i_1_n_7\,
      S(3) => \count[4]_i_3_n_0\,
      S(2) => \count[4]_i_4_n_0\,
      S(1) => \count[4]_i_5_n_0\,
      S(0) => \count[4]_i_6_n_0\
    );
\count_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \count_reg[8]_i_2_n_7\,
      Q => \^q\(5),
      R => srst
    );
\count_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \count_reg[8]_i_2_n_6\,
      Q => \^q\(6),
      R => srst
    );
\count_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \count_reg[8]_i_2_n_5\,
      Q => \^q\(7),
      R => srst
    );
\count_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \count_reg[8]_i_2_n_4\,
      Q => \^q\(8),
      R => srst
    );
\count_reg[8]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \count_reg[4]_i_1_n_0\,
      CO(3) => \NLW_count_reg[8]_i_2_CO_UNCONNECTED\(3),
      CO(2) => \count_reg[8]_i_2_n_1\,
      CO(1) => \count_reg[8]_i_2_n_2\,
      CO(0) => \count_reg[8]_i_2_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2 downto 0) => \^q\(6 downto 4),
      O(3) => \count_reg[8]_i_2_n_4\,
      O(2) => \count_reg[8]_i_2_n_5\,
      O(1) => \count_reg[8]_i_2_n_6\,
      O(0) => \count_reg[8]_i_2_n_7\,
      S(3) => \count[8]_i_3_n_0\,
      S(2) => \count[8]_i_4_n_0\,
      S(1) => \count[8]_i_5_n_0\,
      S(0) => \count[8]_i_6_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_wr_bin_cntr is
  port (
    \gaf.gaf0.ram_afull_i_reg\ : out STD_LOGIC;
    ram_full_i_reg : out STD_LOGIC;
    \gpr1.dout_i_reg[70]\ : out STD_LOGIC;
    \gpr1.dout_i_reg[70]_0\ : out STD_LOGIC;
    \gpr1.dout_i_reg[70]_1\ : out STD_LOGIC;
    \gpr1.dout_i_reg[70]_2\ : out STD_LOGIC;
    ram_empty_i_reg : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    p_7_out : in STD_LOGIC;
    almost_full : in STD_LOGIC;
    wr_en : in STD_LOGIC;
    \out\ : in STD_LOGIC;
    ram_empty_fb_i_reg : in STD_LOGIC;
    \gc0.count_d1_reg[1]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[0]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[3]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[2]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[5]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[4]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[7]\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \gc0.count_reg[7]\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    srst : in STD_LOGIC;
    clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_wr_bin_cntr : entity is "wr_bin_cntr";
end fwft_sfifo_w71_d256_wr_bin_cntr;

architecture STRUCTURE of fwft_sfifo_w71_d256_wr_bin_cntr is
  signal \^q\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \gaf.gaf0.ram_afull_i_i_10_n_0\ : STD_LOGIC;
  signal \gaf.gaf0.ram_afull_i_i_2_n_0\ : STD_LOGIC;
  signal \gaf.gaf0.ram_afull_i_i_3_n_0\ : STD_LOGIC;
  signal \gaf.gaf0.ram_afull_i_i_5_n_0\ : STD_LOGIC;
  signal \gaf.gaf0.ram_afull_i_i_6_n_0\ : STD_LOGIC;
  signal \gaf.gaf0.ram_afull_i_i_7_n_0\ : STD_LOGIC;
  signal \gaf.gaf0.ram_afull_i_i_8_n_0\ : STD_LOGIC;
  signal \gaf.gaf0.ram_afull_i_i_9_n_0\ : STD_LOGIC;
  signal \gcc0.gc1.gsym.count[7]_i_2_n_0\ : STD_LOGIC;
  signal \gwss.wsts/comp0\ : STD_LOGIC;
  signal \gwss.wsts/comp1\ : STD_LOGIC;
  signal p_11_out : STD_LOGIC_VECTOR ( 7 downto 6 );
  signal p_12_out : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \plusOp__0\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal ram_empty_fb_i_i_2_n_0 : STD_LOGIC;
  signal ram_empty_fb_i_i_3_n_0 : STD_LOGIC;
  signal ram_empty_fb_i_i_4_n_0 : STD_LOGIC;
  signal ram_empty_fb_i_i_5_n_0 : STD_LOGIC;
  signal ram_full_fb_i_i_3_n_0 : STD_LOGIC;
  signal ram_full_fb_i_i_4_n_0 : STD_LOGIC;
  signal ram_full_fb_i_i_5_n_0 : STD_LOGIC;
  signal ram_full_fb_i_i_6_n_0 : STD_LOGIC;
  signal wr_pntr_plus2 : STD_LOGIC_VECTOR ( 7 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gaf.gaf0.ram_afull_i_i_6\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \gcc0.gc1.gsym.count[0]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \gcc0.gc1.gsym.count[1]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \gcc0.gc1.gsym.count[2]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \gcc0.gc1.gsym.count[3]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \gcc0.gc1.gsym.count[4]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \gcc0.gc1.gsym.count[6]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gcc0.gc1.gsym.count[7]_i_1\ : label is "soft_lutpair5";
begin
  Q(5 downto 0) <= \^q\(5 downto 0);
RAM_reg_0_63_0_2_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => \out\,
      I1 => wr_en,
      I2 => p_11_out(6),
      I3 => p_11_out(7),
      O => \gpr1.dout_i_reg[70]\
    );
RAM_reg_128_191_0_2_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
        port map (
      I0 => p_11_out(6),
      I1 => p_11_out(7),
      I2 => wr_en,
      I3 => \out\,
      O => \gpr1.dout_i_reg[70]_1\
    );
RAM_reg_192_255_0_2_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => \out\,
      I1 => wr_en,
      I2 => p_11_out(6),
      I3 => p_11_out(7),
      O => \gpr1.dout_i_reg[70]_2\
    );
RAM_reg_64_127_0_2_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
        port map (
      I0 => p_11_out(7),
      I1 => p_11_out(6),
      I2 => wr_en,
      I3 => \out\,
      O => \gpr1.dout_i_reg[70]_0\
    );
\gaf.gaf0.ram_afull_i_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFFFFF00100010"
    )
        port map (
      I0 => \gaf.gaf0.ram_afull_i_i_2_n_0\,
      I1 => \gaf.gaf0.ram_afull_i_i_3_n_0\,
      I2 => E(0),
      I3 => p_7_out,
      I4 => \gwss.wsts/comp1\,
      I5 => almost_full,
      O => \gaf.gaf0.ram_afull_i_reg\
    );
\gaf.gaf0.ram_afull_i_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => p_12_out(3),
      I1 => \gc0.count_d1_reg[3]_rep__0\,
      I2 => p_12_out(2),
      I3 => \gc0.count_d1_reg[2]_rep__0\,
      O => \gaf.gaf0.ram_afull_i_i_10_n_0\
    );
\gaf.gaf0.ram_afull_i_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF6FF6"
    )
        port map (
      I0 => \gc0.count_d1_reg[7]\(1),
      I1 => wr_pntr_plus2(7),
      I2 => \gc0.count_d1_reg[7]\(0),
      I3 => wr_pntr_plus2(6),
      I4 => \gaf.gaf0.ram_afull_i_i_5_n_0\,
      O => \gaf.gaf0.ram_afull_i_i_2_n_0\
    );
\gaf.gaf0.ram_afull_i_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF6FF6"
    )
        port map (
      I0 => \gc0.count_d1_reg[2]_rep__0\,
      I1 => wr_pntr_plus2(2),
      I2 => \gc0.count_d1_reg[3]_rep__0\,
      I3 => wr_pntr_plus2(3),
      I4 => \gaf.gaf0.ram_afull_i_i_6_n_0\,
      O => \gaf.gaf0.ram_afull_i_i_3_n_0\
    );
\gaf.gaf0.ram_afull_i_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => \gaf.gaf0.ram_afull_i_i_7_n_0\,
      I1 => \gaf.gaf0.ram_afull_i_i_8_n_0\,
      I2 => \gaf.gaf0.ram_afull_i_i_9_n_0\,
      I3 => \gaf.gaf0.ram_afull_i_i_10_n_0\,
      O => \gwss.wsts/comp1\
    );
\gaf.gaf0.ram_afull_i_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => wr_pntr_plus2(5),
      I1 => \gc0.count_d1_reg[5]_rep__0\,
      I2 => wr_pntr_plus2(4),
      I3 => \gc0.count_d1_reg[4]_rep__0\,
      O => \gaf.gaf0.ram_afull_i_i_5_n_0\
    );
\gaf.gaf0.ram_afull_i_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => wr_pntr_plus2(1),
      I1 => \gc0.count_d1_reg[1]_rep__0\,
      I2 => wr_pntr_plus2(0),
      I3 => \gc0.count_d1_reg[0]_rep__0\,
      O => \gaf.gaf0.ram_afull_i_i_6_n_0\
    );
\gaf.gaf0.ram_afull_i_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => p_12_out(5),
      I1 => \gc0.count_d1_reg[5]_rep__0\,
      I2 => p_12_out(4),
      I3 => \gc0.count_d1_reg[4]_rep__0\,
      O => \gaf.gaf0.ram_afull_i_i_7_n_0\
    );
\gaf.gaf0.ram_afull_i_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => p_12_out(6),
      I1 => \gc0.count_d1_reg[7]\(0),
      I2 => p_12_out(7),
      I3 => \gc0.count_d1_reg[7]\(1),
      O => \gaf.gaf0.ram_afull_i_i_8_n_0\
    );
\gaf.gaf0.ram_afull_i_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => p_12_out(1),
      I1 => \gc0.count_d1_reg[1]_rep__0\,
      I2 => p_12_out(0),
      I3 => \gc0.count_d1_reg[0]_rep__0\,
      O => \gaf.gaf0.ram_afull_i_i_9_n_0\
    );
\gcc0.gc1.gsym.count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => wr_pntr_plus2(0),
      O => \plusOp__0\(0)
    );
\gcc0.gc1.gsym.count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => wr_pntr_plus2(0),
      I1 => wr_pntr_plus2(1),
      O => \plusOp__0\(1)
    );
\gcc0.gc1.gsym.count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => wr_pntr_plus2(0),
      I1 => wr_pntr_plus2(1),
      I2 => wr_pntr_plus2(2),
      O => \plusOp__0\(2)
    );
\gcc0.gc1.gsym.count[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => wr_pntr_plus2(1),
      I1 => wr_pntr_plus2(0),
      I2 => wr_pntr_plus2(2),
      I3 => wr_pntr_plus2(3),
      O => \plusOp__0\(3)
    );
\gcc0.gc1.gsym.count[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => wr_pntr_plus2(2),
      I1 => wr_pntr_plus2(0),
      I2 => wr_pntr_plus2(1),
      I3 => wr_pntr_plus2(3),
      I4 => wr_pntr_plus2(4),
      O => \plusOp__0\(4)
    );
\gcc0.gc1.gsym.count[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => wr_pntr_plus2(3),
      I1 => wr_pntr_plus2(1),
      I2 => wr_pntr_plus2(0),
      I3 => wr_pntr_plus2(2),
      I4 => wr_pntr_plus2(4),
      I5 => wr_pntr_plus2(5),
      O => \plusOp__0\(5)
    );
\gcc0.gc1.gsym.count[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \gcc0.gc1.gsym.count[7]_i_2_n_0\,
      I1 => wr_pntr_plus2(6),
      O => \plusOp__0\(6)
    );
\gcc0.gc1.gsym.count[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \gcc0.gc1.gsym.count[7]_i_2_n_0\,
      I1 => wr_pntr_plus2(6),
      I2 => wr_pntr_plus2(7),
      O => \plusOp__0\(7)
    );
\gcc0.gc1.gsym.count[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => wr_pntr_plus2(5),
      I1 => wr_pntr_plus2(3),
      I2 => wr_pntr_plus2(1),
      I3 => wr_pntr_plus2(0),
      I4 => wr_pntr_plus2(2),
      I5 => wr_pntr_plus2(4),
      O => \gcc0.gc1.gsym.count[7]_i_2_n_0\
    );
\gcc0.gc1.gsym.count_d1_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => E(0),
      D => wr_pntr_plus2(0),
      Q => p_12_out(0),
      S => srst
    );
\gcc0.gc1.gsym.count_d1_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => wr_pntr_plus2(1),
      Q => p_12_out(1),
      R => srst
    );
\gcc0.gc1.gsym.count_d1_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => wr_pntr_plus2(2),
      Q => p_12_out(2),
      R => srst
    );
\gcc0.gc1.gsym.count_d1_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => wr_pntr_plus2(3),
      Q => p_12_out(3),
      R => srst
    );
\gcc0.gc1.gsym.count_d1_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => wr_pntr_plus2(4),
      Q => p_12_out(4),
      R => srst
    );
\gcc0.gc1.gsym.count_d1_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => wr_pntr_plus2(5),
      Q => p_12_out(5),
      R => srst
    );
\gcc0.gc1.gsym.count_d1_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => wr_pntr_plus2(6),
      Q => p_12_out(6),
      R => srst
    );
\gcc0.gc1.gsym.count_d1_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => wr_pntr_plus2(7),
      Q => p_12_out(7),
      R => srst
    );
\gcc0.gc1.gsym.count_d2_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_12_out(0),
      Q => \^q\(0),
      R => srst
    );
\gcc0.gc1.gsym.count_d2_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_12_out(1),
      Q => \^q\(1),
      R => srst
    );
\gcc0.gc1.gsym.count_d2_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_12_out(2),
      Q => \^q\(2),
      R => srst
    );
\gcc0.gc1.gsym.count_d2_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_12_out(3),
      Q => \^q\(3),
      R => srst
    );
\gcc0.gc1.gsym.count_d2_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_12_out(4),
      Q => \^q\(4),
      R => srst
    );
\gcc0.gc1.gsym.count_d2_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_12_out(5),
      Q => \^q\(5),
      R => srst
    );
\gcc0.gc1.gsym.count_d2_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_12_out(6),
      Q => p_11_out(6),
      R => srst
    );
\gcc0.gc1.gsym.count_d2_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => p_12_out(7),
      Q => p_11_out(7),
      R => srst
    );
\gcc0.gc1.gsym.count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \plusOp__0\(0),
      Q => wr_pntr_plus2(0),
      R => srst
    );
\gcc0.gc1.gsym.count_reg[1]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \plusOp__0\(1),
      Q => wr_pntr_plus2(1),
      S => srst
    );
\gcc0.gc1.gsym.count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \plusOp__0\(2),
      Q => wr_pntr_plus2(2),
      R => srst
    );
\gcc0.gc1.gsym.count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \plusOp__0\(3),
      Q => wr_pntr_plus2(3),
      R => srst
    );
\gcc0.gc1.gsym.count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \plusOp__0\(4),
      Q => wr_pntr_plus2(4),
      R => srst
    );
\gcc0.gc1.gsym.count_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \plusOp__0\(5),
      Q => wr_pntr_plus2(5),
      R => srst
    );
\gcc0.gc1.gsym.count_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \plusOp__0\(6),
      Q => wr_pntr_plus2(6),
      R => srst
    );
\gcc0.gc1.gsym.count_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => E(0),
      D => \plusOp__0\(7),
      Q => wr_pntr_plus2(7),
      R => srst
    );
ram_empty_fb_i_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44444444CCCCCCFC"
    )
        port map (
      I0 => \gwss.wsts/comp0\,
      I1 => ram_empty_fb_i_reg,
      I2 => p_7_out,
      I3 => ram_empty_fb_i_i_2_n_0,
      I4 => ram_empty_fb_i_i_3_n_0,
      I5 => E(0),
      O => ram_empty_i_reg
    );
ram_empty_fb_i_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF6FF6"
    )
        port map (
      I0 => \gc0.count_reg[7]\(7),
      I1 => p_11_out(7),
      I2 => \gc0.count_reg[7]\(6),
      I3 => p_11_out(6),
      I4 => ram_empty_fb_i_i_4_n_0,
      O => ram_empty_fb_i_i_2_n_0
    );
ram_empty_fb_i_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF6FF6"
    )
        port map (
      I0 => \gc0.count_reg[7]\(2),
      I1 => \^q\(2),
      I2 => \gc0.count_reg[7]\(3),
      I3 => \^q\(3),
      I4 => ram_empty_fb_i_i_5_n_0,
      O => ram_empty_fb_i_i_3_n_0
    );
ram_empty_fb_i_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => \^q\(5),
      I1 => \gc0.count_reg[7]\(5),
      I2 => \^q\(4),
      I3 => \gc0.count_reg[7]\(4),
      O => ram_empty_fb_i_i_4_n_0
    );
ram_empty_fb_i_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => \^q\(1),
      I1 => \gc0.count_reg[7]\(1),
      I2 => \^q\(0),
      I3 => \gc0.count_reg[7]\(0),
      O => ram_empty_fb_i_i_5_n_0
    );
ram_full_fb_i_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FFF0088"
    )
        port map (
      I0 => \gwss.wsts/comp1\,
      I1 => wr_en,
      I2 => \gwss.wsts/comp0\,
      I3 => p_7_out,
      I4 => \out\,
      O => ram_full_i_reg
    );
ram_full_fb_i_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => ram_full_fb_i_i_3_n_0,
      I1 => ram_full_fb_i_i_4_n_0,
      I2 => ram_full_fb_i_i_5_n_0,
      I3 => ram_full_fb_i_i_6_n_0,
      O => \gwss.wsts/comp0\
    );
ram_full_fb_i_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => \^q\(5),
      I1 => \gc0.count_d1_reg[5]_rep__0\,
      I2 => \^q\(4),
      I3 => \gc0.count_d1_reg[4]_rep__0\,
      O => ram_full_fb_i_i_3_n_0
    );
ram_full_fb_i_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => p_11_out(6),
      I1 => \gc0.count_d1_reg[7]\(0),
      I2 => p_11_out(7),
      I3 => \gc0.count_d1_reg[7]\(1),
      O => ram_full_fb_i_i_4_n_0
    );
ram_full_fb_i_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => \^q\(1),
      I1 => \gc0.count_d1_reg[1]_rep__0\,
      I2 => \^q\(0),
      I3 => \gc0.count_d1_reg[0]_rep__0\,
      O => ram_full_fb_i_i_5_n_0
    );
ram_full_fb_i_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => \^q\(3),
      I1 => \gc0.count_d1_reg[3]_rep__0\,
      I2 => \^q\(2),
      I3 => \gc0.count_d1_reg[2]_rep__0\,
      O => ram_full_fb_i_i_6_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_wr_handshaking_flags is
  port (
    overflow : out STD_LOGIC;
    ram_full_fb_i_reg : in STD_LOGIC;
    clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_wr_handshaking_flags : entity is "wr_handshaking_flags";
end fwft_sfifo_w71_d256_wr_handshaking_flags;

architecture STRUCTURE of fwft_sfifo_w71_d256_wr_handshaking_flags is
begin
\gof.gof1.overflow_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => ram_full_fb_i_reg,
      Q => overflow,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_wr_status_flags_ss is
  port (
    \out\ : out STD_LOGIC;
    full : out STD_LOGIC;
    almost_full : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \gof.gof1.overflow_i_reg\ : out STD_LOGIC;
    srst : in STD_LOGIC;
    \gaf.gaf0.ram_afull_i_reg_0\ : in STD_LOGIC;
    clk : in STD_LOGIC;
    ram_full_fb_i_reg_0 : in STD_LOGIC;
    wr_en : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_wr_status_flags_ss : entity is "wr_status_flags_ss";
end fwft_sfifo_w71_d256_wr_status_flags_ss;

architecture STRUCTURE of fwft_sfifo_w71_d256_wr_status_flags_ss is
  signal p_15_out : STD_LOGIC;
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of p_15_out : signal is std.standard.true;
  signal ram_afull_i : STD_LOGIC;
  attribute DONT_TOUCH of ram_afull_i : signal is std.standard.true;
  signal ram_full_fb_i : STD_LOGIC;
  attribute DONT_TOUCH of ram_full_fb_i : signal is std.standard.true;
  signal ram_full_i : STD_LOGIC;
  attribute DONT_TOUCH of ram_full_i : signal is std.standard.true;
  attribute DONT_TOUCH of \gaf.gaf0.ram_afull_i_reg\ : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of \gaf.gaf0.ram_afull_i_reg\ : label is "yes";
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of \gaf.gaf0.ram_afull_i_reg\ : label is "no";
  attribute DONT_TOUCH of ram_full_fb_i_reg : label is std.standard.true;
  attribute KEEP of ram_full_fb_i_reg : label is "yes";
  attribute equivalent_register_removal of ram_full_fb_i_reg : label is "no";
  attribute DONT_TOUCH of ram_full_i_reg : label is std.standard.true;
  attribute KEEP of ram_full_i_reg : label is "yes";
  attribute equivalent_register_removal of ram_full_i_reg : label is "no";
begin
  almost_full <= ram_afull_i;
  full <= ram_full_i;
  \out\ <= ram_full_fb_i;
\gaf.gaf0.ram_afull_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \gaf.gaf0.ram_afull_i_reg_0\,
      Q => ram_afull_i,
      R => srst
    );
\gcc0.gc1.gsym.count_d1[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wr_en,
      I1 => ram_full_fb_i,
      O => E(0)
    );
\gof.gof1.overflow_i_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => wr_en,
      I1 => ram_full_fb_i,
      O => \gof.gof1.overflow_i_reg\
    );
i_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => '0',
      O => p_15_out
    );
ram_full_fb_i_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => ram_full_fb_i_reg_0,
      Q => ram_full_fb_i,
      R => srst
    );
ram_full_i_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => ram_full_fb_i_reg_0,
      Q => ram_full_i,
      R => srst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_dc_ss_fwft is
  port (
    Q : out STD_LOGIC_VECTOR ( 8 downto 0 );
    valid : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    srst : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_dc_ss_fwft : entity is "dc_ss_fwft";
end fwft_sfifo_w71_d256_dc_ss_fwft;

architecture STRUCTURE of fwft_sfifo_w71_d256_dc_ss_fwft is
begin
dc: entity work.fwft_sfifo_w71_d256_updn_cntr
     port map (
      E(0) => E(0),
      Q(8 downto 0) => Q(8 downto 0),
      clk => clk,
      rd_en => rd_en,
      srst => srst,
      valid => valid
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_memory is
  port (
    dout : out STD_LOGIC_VECTOR ( 70 downto 0 );
    clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 70 downto 0 );
    ram_full_fb_i_reg : in STD_LOGIC;
    \gc0.count_d1_reg[7]\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 5 downto 0 );
    \gcc0.gc1.gsym.count_d2_reg[7]\ : in STD_LOGIC;
    \gcc0.gc1.gsym.count_d2_reg[6]\ : in STD_LOGIC;
    ram_full_fb_i_reg_0 : in STD_LOGIC;
    ADDRC : in STD_LOGIC_VECTOR ( 5 downto 0 );
    \gc0.count_d1_reg[5]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[4]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[3]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[2]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[1]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[0]_rep__0\ : in STD_LOGIC;
    srst : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    \gpregsm1.curr_fwft_state_reg[1]\ : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_memory : entity is "memory";
end fwft_sfifo_w71_d256_memory;

architecture STRUCTURE of fwft_sfifo_w71_d256_memory is
  signal dout_i : STD_LOGIC_VECTOR ( 70 downto 0 );
begin
\gdm.dm_gen.dm\: entity work.fwft_sfifo_w71_d256_dmem
     port map (
      ADDRA(5) => \gc0.count_d1_reg[5]_rep__0\,
      ADDRA(4) => \gc0.count_d1_reg[4]_rep__0\,
      ADDRA(3) => \gc0.count_d1_reg[3]_rep__0\,
      ADDRA(2) => \gc0.count_d1_reg[2]_rep__0\,
      ADDRA(1) => \gc0.count_d1_reg[1]_rep__0\,
      ADDRA(0) => \gc0.count_d1_reg[0]_rep__0\,
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      E(0) => E(0),
      Q(5 downto 0) => Q(5 downto 0),
      clk => clk,
      din(70 downto 0) => din(70 downto 0),
      \gc0.count_d1_reg[7]\(7 downto 0) => \gc0.count_d1_reg[7]\(7 downto 0),
      \gcc0.gc1.gsym.count_d2_reg[6]\ => \gcc0.gc1.gsym.count_d2_reg[6]\,
      \gcc0.gc1.gsym.count_d2_reg[7]\ => \gcc0.gc1.gsym.count_d2_reg[7]\,
      \goreg_dm.dout_i_reg[70]\(70 downto 0) => dout_i(70 downto 0),
      ram_full_fb_i_reg => ram_full_fb_i_reg,
      ram_full_fb_i_reg_0 => ram_full_fb_i_reg_0,
      srst => srst
    );
\goreg_dm.dout_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(0),
      Q => dout(0),
      R => srst
    );
\goreg_dm.dout_i_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(10),
      Q => dout(10),
      R => srst
    );
\goreg_dm.dout_i_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(11),
      Q => dout(11),
      R => srst
    );
\goreg_dm.dout_i_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(12),
      Q => dout(12),
      R => srst
    );
\goreg_dm.dout_i_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(13),
      Q => dout(13),
      R => srst
    );
\goreg_dm.dout_i_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(14),
      Q => dout(14),
      R => srst
    );
\goreg_dm.dout_i_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(15),
      Q => dout(15),
      R => srst
    );
\goreg_dm.dout_i_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(16),
      Q => dout(16),
      R => srst
    );
\goreg_dm.dout_i_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(17),
      Q => dout(17),
      R => srst
    );
\goreg_dm.dout_i_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(18),
      Q => dout(18),
      R => srst
    );
\goreg_dm.dout_i_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(19),
      Q => dout(19),
      R => srst
    );
\goreg_dm.dout_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(1),
      Q => dout(1),
      R => srst
    );
\goreg_dm.dout_i_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(20),
      Q => dout(20),
      R => srst
    );
\goreg_dm.dout_i_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(21),
      Q => dout(21),
      R => srst
    );
\goreg_dm.dout_i_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(22),
      Q => dout(22),
      R => srst
    );
\goreg_dm.dout_i_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(23),
      Q => dout(23),
      R => srst
    );
\goreg_dm.dout_i_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(24),
      Q => dout(24),
      R => srst
    );
\goreg_dm.dout_i_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(25),
      Q => dout(25),
      R => srst
    );
\goreg_dm.dout_i_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(26),
      Q => dout(26),
      R => srst
    );
\goreg_dm.dout_i_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(27),
      Q => dout(27),
      R => srst
    );
\goreg_dm.dout_i_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(28),
      Q => dout(28),
      R => srst
    );
\goreg_dm.dout_i_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(29),
      Q => dout(29),
      R => srst
    );
\goreg_dm.dout_i_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(2),
      Q => dout(2),
      R => srst
    );
\goreg_dm.dout_i_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(30),
      Q => dout(30),
      R => srst
    );
\goreg_dm.dout_i_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(31),
      Q => dout(31),
      R => srst
    );
\goreg_dm.dout_i_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(32),
      Q => dout(32),
      R => srst
    );
\goreg_dm.dout_i_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(33),
      Q => dout(33),
      R => srst
    );
\goreg_dm.dout_i_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(34),
      Q => dout(34),
      R => srst
    );
\goreg_dm.dout_i_reg[35]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(35),
      Q => dout(35),
      R => srst
    );
\goreg_dm.dout_i_reg[36]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(36),
      Q => dout(36),
      R => srst
    );
\goreg_dm.dout_i_reg[37]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(37),
      Q => dout(37),
      R => srst
    );
\goreg_dm.dout_i_reg[38]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(38),
      Q => dout(38),
      R => srst
    );
\goreg_dm.dout_i_reg[39]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(39),
      Q => dout(39),
      R => srst
    );
\goreg_dm.dout_i_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(3),
      Q => dout(3),
      R => srst
    );
\goreg_dm.dout_i_reg[40]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(40),
      Q => dout(40),
      R => srst
    );
\goreg_dm.dout_i_reg[41]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(41),
      Q => dout(41),
      R => srst
    );
\goreg_dm.dout_i_reg[42]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(42),
      Q => dout(42),
      R => srst
    );
\goreg_dm.dout_i_reg[43]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(43),
      Q => dout(43),
      R => srst
    );
\goreg_dm.dout_i_reg[44]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(44),
      Q => dout(44),
      R => srst
    );
\goreg_dm.dout_i_reg[45]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(45),
      Q => dout(45),
      R => srst
    );
\goreg_dm.dout_i_reg[46]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(46),
      Q => dout(46),
      R => srst
    );
\goreg_dm.dout_i_reg[47]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(47),
      Q => dout(47),
      R => srst
    );
\goreg_dm.dout_i_reg[48]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(48),
      Q => dout(48),
      R => srst
    );
\goreg_dm.dout_i_reg[49]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(49),
      Q => dout(49),
      R => srst
    );
\goreg_dm.dout_i_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(4),
      Q => dout(4),
      R => srst
    );
\goreg_dm.dout_i_reg[50]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(50),
      Q => dout(50),
      R => srst
    );
\goreg_dm.dout_i_reg[51]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(51),
      Q => dout(51),
      R => srst
    );
\goreg_dm.dout_i_reg[52]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(52),
      Q => dout(52),
      R => srst
    );
\goreg_dm.dout_i_reg[53]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(53),
      Q => dout(53),
      R => srst
    );
\goreg_dm.dout_i_reg[54]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(54),
      Q => dout(54),
      R => srst
    );
\goreg_dm.dout_i_reg[55]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(55),
      Q => dout(55),
      R => srst
    );
\goreg_dm.dout_i_reg[56]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(56),
      Q => dout(56),
      R => srst
    );
\goreg_dm.dout_i_reg[57]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(57),
      Q => dout(57),
      R => srst
    );
\goreg_dm.dout_i_reg[58]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(58),
      Q => dout(58),
      R => srst
    );
\goreg_dm.dout_i_reg[59]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(59),
      Q => dout(59),
      R => srst
    );
\goreg_dm.dout_i_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(5),
      Q => dout(5),
      R => srst
    );
\goreg_dm.dout_i_reg[60]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(60),
      Q => dout(60),
      R => srst
    );
\goreg_dm.dout_i_reg[61]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(61),
      Q => dout(61),
      R => srst
    );
\goreg_dm.dout_i_reg[62]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(62),
      Q => dout(62),
      R => srst
    );
\goreg_dm.dout_i_reg[63]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(63),
      Q => dout(63),
      R => srst
    );
\goreg_dm.dout_i_reg[64]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(64),
      Q => dout(64),
      R => srst
    );
\goreg_dm.dout_i_reg[65]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(65),
      Q => dout(65),
      R => srst
    );
\goreg_dm.dout_i_reg[66]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(66),
      Q => dout(66),
      R => srst
    );
\goreg_dm.dout_i_reg[67]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(67),
      Q => dout(67),
      R => srst
    );
\goreg_dm.dout_i_reg[68]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(68),
      Q => dout(68),
      R => srst
    );
\goreg_dm.dout_i_reg[69]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(69),
      Q => dout(69),
      R => srst
    );
\goreg_dm.dout_i_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(6),
      Q => dout(6),
      R => srst
    );
\goreg_dm.dout_i_reg[70]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(70),
      Q => dout(70),
      R => srst
    );
\goreg_dm.dout_i_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(7),
      Q => dout(7),
      R => srst
    );
\goreg_dm.dout_i_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(8),
      Q => dout(8),
      R => srst
    );
\goreg_dm.dout_i_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \gpregsm1.curr_fwft_state_reg[1]\(0),
      D => dout_i(9),
      Q => dout(9),
      R => srst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_wr_logic is
  port (
    \out\ : out STD_LOGIC;
    full : out STD_LOGIC;
    almost_full : out STD_LOGIC;
    overflow : out STD_LOGIC;
    \gpr1.dout_i_reg[70]\ : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    \gpr1.dout_i_reg[70]_0\ : out STD_LOGIC;
    \gpr1.dout_i_reg[70]_1\ : out STD_LOGIC;
    \gpr1.dout_i_reg[70]_2\ : out STD_LOGIC;
    ram_empty_i_reg : out STD_LOGIC;
    srst : in STD_LOGIC;
    clk : in STD_LOGIC;
    p_7_out : in STD_LOGIC;
    wr_en : in STD_LOGIC;
    ram_empty_fb_i_reg : in STD_LOGIC;
    \gc0.count_d1_reg[1]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[0]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[3]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[2]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[5]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[4]_rep__0\ : in STD_LOGIC;
    \gc0.count_d1_reg[7]\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \gc0.count_reg[7]\ : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_wr_logic : entity is "wr_logic";
end fwft_sfifo_w71_d256_wr_logic;

architecture STRUCTURE of fwft_sfifo_w71_d256_wr_logic is
  signal \^almost_full\ : STD_LOGIC;
  signal \gwss.wsts_n_3\ : STD_LOGIC;
  signal \gwss.wsts_n_4\ : STD_LOGIC;
  signal \^out\ : STD_LOGIC;
  signal wpntr_n_0 : STD_LOGIC;
  signal wpntr_n_1 : STD_LOGIC;
begin
  almost_full <= \^almost_full\;
  \out\ <= \^out\;
\gwhf.whf\: entity work.fwft_sfifo_w71_d256_wr_handshaking_flags
     port map (
      clk => clk,
      overflow => overflow,
      ram_full_fb_i_reg => \gwss.wsts_n_4\
    );
\gwss.wsts\: entity work.fwft_sfifo_w71_d256_wr_status_flags_ss
     port map (
      E(0) => \gwss.wsts_n_3\,
      almost_full => \^almost_full\,
      clk => clk,
      full => full,
      \gaf.gaf0.ram_afull_i_reg_0\ => wpntr_n_0,
      \gof.gof1.overflow_i_reg\ => \gwss.wsts_n_4\,
      \out\ => \^out\,
      ram_full_fb_i_reg_0 => wpntr_n_1,
      srst => srst,
      wr_en => wr_en
    );
wpntr: entity work.fwft_sfifo_w71_d256_wr_bin_cntr
     port map (
      E(0) => \gwss.wsts_n_3\,
      Q(5 downto 0) => Q(5 downto 0),
      almost_full => \^almost_full\,
      clk => clk,
      \gaf.gaf0.ram_afull_i_reg\ => wpntr_n_0,
      \gc0.count_d1_reg[0]_rep__0\ => \gc0.count_d1_reg[0]_rep__0\,
      \gc0.count_d1_reg[1]_rep__0\ => \gc0.count_d1_reg[1]_rep__0\,
      \gc0.count_d1_reg[2]_rep__0\ => \gc0.count_d1_reg[2]_rep__0\,
      \gc0.count_d1_reg[3]_rep__0\ => \gc0.count_d1_reg[3]_rep__0\,
      \gc0.count_d1_reg[4]_rep__0\ => \gc0.count_d1_reg[4]_rep__0\,
      \gc0.count_d1_reg[5]_rep__0\ => \gc0.count_d1_reg[5]_rep__0\,
      \gc0.count_d1_reg[7]\(1 downto 0) => \gc0.count_d1_reg[7]\(1 downto 0),
      \gc0.count_reg[7]\(7 downto 0) => \gc0.count_reg[7]\(7 downto 0),
      \gpr1.dout_i_reg[70]\ => \gpr1.dout_i_reg[70]\,
      \gpr1.dout_i_reg[70]_0\ => \gpr1.dout_i_reg[70]_0\,
      \gpr1.dout_i_reg[70]_1\ => \gpr1.dout_i_reg[70]_1\,
      \gpr1.dout_i_reg[70]_2\ => \gpr1.dout_i_reg[70]_2\,
      \out\ => \^out\,
      p_7_out => p_7_out,
      ram_empty_fb_i_reg => ram_empty_fb_i_reg,
      ram_empty_i_reg => ram_empty_i_reg,
      ram_full_i_reg => wpntr_n_1,
      srst => srst,
      wr_en => wr_en
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_rd_logic is
  port (
    \out\ : out STD_LOGIC;
    empty : out STD_LOGIC;
    valid : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 8 downto 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \gc0.count_d1_reg[7]\ : out STD_LOGIC_VECTOR ( 7 downto 0 );
    p_7_out : out STD_LOGIC;
    \goreg_dm.dout_i_reg[70]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \gpr1.dout_i_reg[70]\ : out STD_LOGIC_VECTOR ( 7 downto 0 );
    ADDRC : out STD_LOGIC_VECTOR ( 5 downto 0 );
    \gpr1.dout_i_reg[70]_0\ : out STD_LOGIC;
    \gpr1.dout_i_reg[70]_1\ : out STD_LOGIC;
    \gpr1.dout_i_reg[70]_2\ : out STD_LOGIC;
    \gpr1.dout_i_reg[70]_3\ : out STD_LOGIC;
    \gpr1.dout_i_reg[70]_4\ : out STD_LOGIC;
    \gpr1.dout_i_reg[70]_5\ : out STD_LOGIC;
    srst : in STD_LOGIC;
    clk : in STD_LOGIC;
    ram_empty_fb_i_reg : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    ram_full_fb_i_reg : in STD_LOGIC;
    wr_en : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_rd_logic : entity is "rd_logic";
end fwft_sfifo_w71_d256_rd_logic;

architecture STRUCTURE of fwft_sfifo_w71_d256_rd_logic is
  signal cntr_en : STD_LOGIC;
  signal \^out\ : STD_LOGIC;
  signal \^p_7_out\ : STD_LOGIC;
  signal \^valid\ : STD_LOGIC;
begin
  \out\ <= \^out\;
  p_7_out <= \^p_7_out\;
  valid <= \^valid\;
\gr1.gdcf.dc\: entity work.fwft_sfifo_w71_d256_dc_ss_fwft
     port map (
      E(0) => cntr_en,
      Q(8 downto 0) => Q(8 downto 0),
      clk => clk,
      rd_en => rd_en,
      srst => srst,
      valid => \^valid\
    );
\gr1.gr1_int.rfwft\: entity work.fwft_sfifo_w71_d256_rd_fwft
     port map (
      E(0) => E(0),
      clk => clk,
      \count_reg[0]\(0) => cntr_en,
      empty => empty,
      \gc0.count_d1_reg[0]_rep__0\(0) => \^p_7_out\,
      \goreg_dm.dout_i_reg[70]\(0) => \goreg_dm.dout_i_reg[70]\(0),
      \out\ => \^out\,
      ram_full_fb_i_reg => ram_full_fb_i_reg,
      rd_en => rd_en,
      srst => srst,
      valid => \^valid\,
      wr_en => wr_en
    );
\grss.rsts\: entity work.fwft_sfifo_w71_d256_rd_status_flags_ss
     port map (
      clk => clk,
      \out\ => \^out\,
      ram_empty_fb_i_reg_0 => ram_empty_fb_i_reg,
      srst => srst
    );
rpntr: entity work.fwft_sfifo_w71_d256_rd_bin_cntr
     port map (
      ADDRC(5 downto 0) => ADDRC(5 downto 0),
      E(0) => \^p_7_out\,
      Q(7 downto 0) => \gc0.count_d1_reg[7]\(7 downto 0),
      clk => clk,
      \gpr1.dout_i_reg[70]\(7 downto 0) => \gpr1.dout_i_reg[70]\(7 downto 0),
      \gpr1.dout_i_reg[70]_0\ => \gpr1.dout_i_reg[70]_0\,
      \gpr1.dout_i_reg[70]_1\ => \gpr1.dout_i_reg[70]_1\,
      \gpr1.dout_i_reg[70]_2\ => \gpr1.dout_i_reg[70]_2\,
      \gpr1.dout_i_reg[70]_3\ => \gpr1.dout_i_reg[70]_3\,
      \gpr1.dout_i_reg[70]_4\ => \gpr1.dout_i_reg[70]_4\,
      \gpr1.dout_i_reg[70]_5\ => \gpr1.dout_i_reg[70]_5\,
      srst => srst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_fifo_generator_ramfifo is
  port (
    data_count : out STD_LOGIC_VECTOR ( 8 downto 0 );
    valid : out STD_LOGIC;
    almost_full : out STD_LOGIC;
    empty : out STD_LOGIC;
    full : out STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 70 downto 0 );
    overflow : out STD_LOGIC;
    rd_en : in STD_LOGIC;
    wr_en : in STD_LOGIC;
    srst : in STD_LOGIC;
    clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 70 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_fifo_generator_ramfifo : entity is "fifo_generator_ramfifo";
end fwft_sfifo_w71_d256_fifo_generator_ramfifo;

architecture STRUCTURE of fwft_sfifo_w71_d256_fifo_generator_ramfifo is
  signal \gntv_or_sync_fifo.gl0.rd_n_12\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.rd_n_31\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.rd_n_32\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.rd_n_33\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.rd_n_34\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.rd_n_35\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.rd_n_36\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.rd_n_37\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.rd_n_38\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.rd_n_39\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.rd_n_40\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.rd_n_41\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.rd_n_42\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.wr_n_0\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.wr_n_11\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.wr_n_12\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.wr_n_13\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.wr_n_14\ : STD_LOGIC;
  signal \gntv_or_sync_fifo.gl0.wr_n_4\ : STD_LOGIC;
  signal p_0_out_0 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal p_11_out : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal p_2_out : STD_LOGIC;
  signal p_5_out : STD_LOGIC;
  signal p_7_out : STD_LOGIC;
  signal rd_pntr_plus1 : STD_LOGIC_VECTOR ( 7 downto 0 );
begin
\gntv_or_sync_fifo.gl0.rd\: entity work.fwft_sfifo_w71_d256_rd_logic
     port map (
      ADDRC(5) => \gntv_or_sync_fifo.gl0.rd_n_31\,
      ADDRC(4) => \gntv_or_sync_fifo.gl0.rd_n_32\,
      ADDRC(3) => \gntv_or_sync_fifo.gl0.rd_n_33\,
      ADDRC(2) => \gntv_or_sync_fifo.gl0.rd_n_34\,
      ADDRC(1) => \gntv_or_sync_fifo.gl0.rd_n_35\,
      ADDRC(0) => \gntv_or_sync_fifo.gl0.rd_n_36\,
      E(0) => \gntv_or_sync_fifo.gl0.rd_n_12\,
      Q(8 downto 0) => data_count(8 downto 0),
      clk => clk,
      empty => empty,
      \gc0.count_d1_reg[7]\(7 downto 0) => rd_pntr_plus1(7 downto 0),
      \goreg_dm.dout_i_reg[70]\(0) => p_5_out,
      \gpr1.dout_i_reg[70]\(7 downto 0) => p_0_out_0(7 downto 0),
      \gpr1.dout_i_reg[70]_0\ => \gntv_or_sync_fifo.gl0.rd_n_37\,
      \gpr1.dout_i_reg[70]_1\ => \gntv_or_sync_fifo.gl0.rd_n_38\,
      \gpr1.dout_i_reg[70]_2\ => \gntv_or_sync_fifo.gl0.rd_n_39\,
      \gpr1.dout_i_reg[70]_3\ => \gntv_or_sync_fifo.gl0.rd_n_40\,
      \gpr1.dout_i_reg[70]_4\ => \gntv_or_sync_fifo.gl0.rd_n_41\,
      \gpr1.dout_i_reg[70]_5\ => \gntv_or_sync_fifo.gl0.rd_n_42\,
      \out\ => p_2_out,
      p_7_out => p_7_out,
      ram_empty_fb_i_reg => \gntv_or_sync_fifo.gl0.wr_n_14\,
      ram_full_fb_i_reg => \gntv_or_sync_fifo.gl0.wr_n_0\,
      rd_en => rd_en,
      srst => srst,
      valid => valid,
      wr_en => wr_en
    );
\gntv_or_sync_fifo.gl0.wr\: entity work.fwft_sfifo_w71_d256_wr_logic
     port map (
      Q(5 downto 0) => p_11_out(5 downto 0),
      almost_full => almost_full,
      clk => clk,
      full => full,
      \gc0.count_d1_reg[0]_rep__0\ => \gntv_or_sync_fifo.gl0.rd_n_42\,
      \gc0.count_d1_reg[1]_rep__0\ => \gntv_or_sync_fifo.gl0.rd_n_41\,
      \gc0.count_d1_reg[2]_rep__0\ => \gntv_or_sync_fifo.gl0.rd_n_40\,
      \gc0.count_d1_reg[3]_rep__0\ => \gntv_or_sync_fifo.gl0.rd_n_39\,
      \gc0.count_d1_reg[4]_rep__0\ => \gntv_or_sync_fifo.gl0.rd_n_38\,
      \gc0.count_d1_reg[5]_rep__0\ => \gntv_or_sync_fifo.gl0.rd_n_37\,
      \gc0.count_d1_reg[7]\(1 downto 0) => p_0_out_0(7 downto 6),
      \gc0.count_reg[7]\(7 downto 0) => rd_pntr_plus1(7 downto 0),
      \gpr1.dout_i_reg[70]\ => \gntv_or_sync_fifo.gl0.wr_n_4\,
      \gpr1.dout_i_reg[70]_0\ => \gntv_or_sync_fifo.gl0.wr_n_11\,
      \gpr1.dout_i_reg[70]_1\ => \gntv_or_sync_fifo.gl0.wr_n_12\,
      \gpr1.dout_i_reg[70]_2\ => \gntv_or_sync_fifo.gl0.wr_n_13\,
      \out\ => \gntv_or_sync_fifo.gl0.wr_n_0\,
      overflow => overflow,
      p_7_out => p_7_out,
      ram_empty_fb_i_reg => p_2_out,
      ram_empty_i_reg => \gntv_or_sync_fifo.gl0.wr_n_14\,
      srst => srst,
      wr_en => wr_en
    );
\gntv_or_sync_fifo.mem\: entity work.fwft_sfifo_w71_d256_memory
     port map (
      ADDRC(5) => \gntv_or_sync_fifo.gl0.rd_n_31\,
      ADDRC(4) => \gntv_or_sync_fifo.gl0.rd_n_32\,
      ADDRC(3) => \gntv_or_sync_fifo.gl0.rd_n_33\,
      ADDRC(2) => \gntv_or_sync_fifo.gl0.rd_n_34\,
      ADDRC(1) => \gntv_or_sync_fifo.gl0.rd_n_35\,
      ADDRC(0) => \gntv_or_sync_fifo.gl0.rd_n_36\,
      E(0) => \gntv_or_sync_fifo.gl0.rd_n_12\,
      Q(5 downto 0) => p_11_out(5 downto 0),
      clk => clk,
      din(70 downto 0) => din(70 downto 0),
      dout(70 downto 0) => dout(70 downto 0),
      \gc0.count_d1_reg[0]_rep__0\ => \gntv_or_sync_fifo.gl0.rd_n_42\,
      \gc0.count_d1_reg[1]_rep__0\ => \gntv_or_sync_fifo.gl0.rd_n_41\,
      \gc0.count_d1_reg[2]_rep__0\ => \gntv_or_sync_fifo.gl0.rd_n_40\,
      \gc0.count_d1_reg[3]_rep__0\ => \gntv_or_sync_fifo.gl0.rd_n_39\,
      \gc0.count_d1_reg[4]_rep__0\ => \gntv_or_sync_fifo.gl0.rd_n_38\,
      \gc0.count_d1_reg[5]_rep__0\ => \gntv_or_sync_fifo.gl0.rd_n_37\,
      \gc0.count_d1_reg[7]\(7 downto 0) => p_0_out_0(7 downto 0),
      \gcc0.gc1.gsym.count_d2_reg[6]\ => \gntv_or_sync_fifo.gl0.wr_n_12\,
      \gcc0.gc1.gsym.count_d2_reg[7]\ => \gntv_or_sync_fifo.gl0.wr_n_11\,
      \gpregsm1.curr_fwft_state_reg[1]\(0) => p_5_out,
      ram_full_fb_i_reg => \gntv_or_sync_fifo.gl0.wr_n_4\,
      ram_full_fb_i_reg_0 => \gntv_or_sync_fifo.gl0.wr_n_13\,
      srst => srst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_fifo_generator_top is
  port (
    DATA_COUNT : out STD_LOGIC_VECTOR ( 8 downto 0 );
    valid : out STD_LOGIC;
    almost_full : out STD_LOGIC;
    empty : out STD_LOGIC;
    full : out STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 70 downto 0 );
    overflow : out STD_LOGIC;
    rd_en : in STD_LOGIC;
    wr_en : in STD_LOGIC;
    srst : in STD_LOGIC;
    clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 70 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_fifo_generator_top : entity is "fifo_generator_top";
end fwft_sfifo_w71_d256_fifo_generator_top;

architecture STRUCTURE of fwft_sfifo_w71_d256_fifo_generator_top is
begin
\grf.rf\: entity work.fwft_sfifo_w71_d256_fifo_generator_ramfifo
     port map (
      almost_full => almost_full,
      clk => clk,
      data_count(8 downto 0) => DATA_COUNT(8 downto 0),
      din(70 downto 0) => din(70 downto 0),
      dout(70 downto 0) => dout(70 downto 0),
      empty => empty,
      full => full,
      overflow => overflow,
      rd_en => rd_en,
      srst => srst,
      valid => valid,
      wr_en => wr_en
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_fifo_generator_v13_1_2_synth is
  port (
    data_count : out STD_LOGIC_VECTOR ( 8 downto 0 );
    valid : out STD_LOGIC;
    almost_full : out STD_LOGIC;
    empty : out STD_LOGIC;
    full : out STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 70 downto 0 );
    overflow : out STD_LOGIC;
    rd_en : in STD_LOGIC;
    wr_en : in STD_LOGIC;
    srst : in STD_LOGIC;
    clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 70 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_fifo_generator_v13_1_2_synth : entity is "fifo_generator_v13_1_2_synth";
end fwft_sfifo_w71_d256_fifo_generator_v13_1_2_synth;

architecture STRUCTURE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2_synth is
begin
\gconvfifo.rf\: entity work.fwft_sfifo_w71_d256_fifo_generator_top
     port map (
      DATA_COUNT(8 downto 0) => data_count(8 downto 0),
      almost_full => almost_full,
      clk => clk,
      din(70 downto 0) => din(70 downto 0),
      dout(70 downto 0) => dout(70 downto 0),
      empty => empty,
      full => full,
      overflow => overflow,
      rd_en => rd_en,
      srst => srst,
      valid => valid,
      wr_en => wr_en
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256_fifo_generator_v13_1_2 is
  port (
    backup : in STD_LOGIC;
    backup_marker : in STD_LOGIC;
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    srst : in STD_LOGIC;
    wr_clk : in STD_LOGIC;
    wr_rst : in STD_LOGIC;
    rd_clk : in STD_LOGIC;
    rd_rst : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 70 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    prog_empty_thresh : in STD_LOGIC_VECTOR ( 7 downto 0 );
    prog_empty_thresh_assert : in STD_LOGIC_VECTOR ( 7 downto 0 );
    prog_empty_thresh_negate : in STD_LOGIC_VECTOR ( 7 downto 0 );
    prog_full_thresh : in STD_LOGIC_VECTOR ( 7 downto 0 );
    prog_full_thresh_assert : in STD_LOGIC_VECTOR ( 7 downto 0 );
    prog_full_thresh_negate : in STD_LOGIC_VECTOR ( 7 downto 0 );
    int_clk : in STD_LOGIC;
    injectdbiterr : in STD_LOGIC;
    injectsbiterr : in STD_LOGIC;
    sleep : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 70 downto 0 );
    full : out STD_LOGIC;
    almost_full : out STD_LOGIC;
    wr_ack : out STD_LOGIC;
    overflow : out STD_LOGIC;
    empty : out STD_LOGIC;
    almost_empty : out STD_LOGIC;
    valid : out STD_LOGIC;
    underflow : out STD_LOGIC;
    data_count : out STD_LOGIC_VECTOR ( 8 downto 0 );
    rd_data_count : out STD_LOGIC_VECTOR ( 8 downto 0 );
    wr_data_count : out STD_LOGIC_VECTOR ( 8 downto 0 );
    prog_full : out STD_LOGIC;
    prog_empty : out STD_LOGIC;
    sbiterr : out STD_LOGIC;
    dbiterr : out STD_LOGIC;
    wr_rst_busy : out STD_LOGIC;
    rd_rst_busy : out STD_LOGIC;
    m_aclk : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    s_aresetn : in STD_LOGIC;
    m_aclk_en : in STD_LOGIC;
    s_aclk_en : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_buser : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    m_axi_awid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_wlast : out STD_LOGIC;
    m_axi_wuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_buser : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_aruser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_ruser : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_arid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_aruser : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rlast : in STD_LOGIC;
    m_axi_ruser : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_aw_injectsbiterr : in STD_LOGIC;
    axi_aw_injectdbiterr : in STD_LOGIC;
    axi_aw_prog_full_thresh : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_aw_prog_empty_thresh : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_aw_data_count : out STD_LOGIC_VECTOR ( 4 downto 0 );
    axi_aw_wr_data_count : out STD_LOGIC_VECTOR ( 4 downto 0 );
    axi_aw_rd_data_count : out STD_LOGIC_VECTOR ( 4 downto 0 );
    axi_aw_sbiterr : out STD_LOGIC;
    axi_aw_dbiterr : out STD_LOGIC;
    axi_aw_overflow : out STD_LOGIC;
    axi_aw_underflow : out STD_LOGIC;
    axi_aw_prog_full : out STD_LOGIC;
    axi_aw_prog_empty : out STD_LOGIC;
    axi_w_injectsbiterr : in STD_LOGIC;
    axi_w_injectdbiterr : in STD_LOGIC;
    axi_w_prog_full_thresh : in STD_LOGIC_VECTOR ( 9 downto 0 );
    axi_w_prog_empty_thresh : in STD_LOGIC_VECTOR ( 9 downto 0 );
    axi_w_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 );
    axi_w_wr_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 );
    axi_w_rd_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 );
    axi_w_sbiterr : out STD_LOGIC;
    axi_w_dbiterr : out STD_LOGIC;
    axi_w_overflow : out STD_LOGIC;
    axi_w_underflow : out STD_LOGIC;
    axi_w_prog_full : out STD_LOGIC;
    axi_w_prog_empty : out STD_LOGIC;
    axi_b_injectsbiterr : in STD_LOGIC;
    axi_b_injectdbiterr : in STD_LOGIC;
    axi_b_prog_full_thresh : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_b_prog_empty_thresh : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_b_data_count : out STD_LOGIC_VECTOR ( 4 downto 0 );
    axi_b_wr_data_count : out STD_LOGIC_VECTOR ( 4 downto 0 );
    axi_b_rd_data_count : out STD_LOGIC_VECTOR ( 4 downto 0 );
    axi_b_sbiterr : out STD_LOGIC;
    axi_b_dbiterr : out STD_LOGIC;
    axi_b_overflow : out STD_LOGIC;
    axi_b_underflow : out STD_LOGIC;
    axi_b_prog_full : out STD_LOGIC;
    axi_b_prog_empty : out STD_LOGIC;
    axi_ar_injectsbiterr : in STD_LOGIC;
    axi_ar_injectdbiterr : in STD_LOGIC;
    axi_ar_prog_full_thresh : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_ar_prog_empty_thresh : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_ar_data_count : out STD_LOGIC_VECTOR ( 4 downto 0 );
    axi_ar_wr_data_count : out STD_LOGIC_VECTOR ( 4 downto 0 );
    axi_ar_rd_data_count : out STD_LOGIC_VECTOR ( 4 downto 0 );
    axi_ar_sbiterr : out STD_LOGIC;
    axi_ar_dbiterr : out STD_LOGIC;
    axi_ar_overflow : out STD_LOGIC;
    axi_ar_underflow : out STD_LOGIC;
    axi_ar_prog_full : out STD_LOGIC;
    axi_ar_prog_empty : out STD_LOGIC;
    axi_r_injectsbiterr : in STD_LOGIC;
    axi_r_injectdbiterr : in STD_LOGIC;
    axi_r_prog_full_thresh : in STD_LOGIC_VECTOR ( 9 downto 0 );
    axi_r_prog_empty_thresh : in STD_LOGIC_VECTOR ( 9 downto 0 );
    axi_r_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 );
    axi_r_wr_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 );
    axi_r_rd_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 );
    axi_r_sbiterr : out STD_LOGIC;
    axi_r_dbiterr : out STD_LOGIC;
    axi_r_overflow : out STD_LOGIC;
    axi_r_underflow : out STD_LOGIC;
    axi_r_prog_full : out STD_LOGIC;
    axi_r_prog_empty : out STD_LOGIC;
    axis_injectsbiterr : in STD_LOGIC;
    axis_injectdbiterr : in STD_LOGIC;
    axis_prog_full_thresh : in STD_LOGIC_VECTOR ( 9 downto 0 );
    axis_prog_empty_thresh : in STD_LOGIC_VECTOR ( 9 downto 0 );
    axis_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 );
    axis_wr_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 );
    axis_rd_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 );
    axis_sbiterr : out STD_LOGIC;
    axis_dbiterr : out STD_LOGIC;
    axis_overflow : out STD_LOGIC;
    axis_underflow : out STD_LOGIC;
    axis_prog_full : out STD_LOGIC;
    axis_prog_empty : out STD_LOGIC
  );
  attribute C_ADD_NGC_CONSTRAINT : integer;
  attribute C_ADD_NGC_CONSTRAINT of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_APPLICATION_TYPE_AXIS : integer;
  attribute C_APPLICATION_TYPE_AXIS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_APPLICATION_TYPE_RACH : integer;
  attribute C_APPLICATION_TYPE_RACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_APPLICATION_TYPE_RDCH : integer;
  attribute C_APPLICATION_TYPE_RDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_APPLICATION_TYPE_WACH : integer;
  attribute C_APPLICATION_TYPE_WACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_APPLICATION_TYPE_WDCH : integer;
  attribute C_APPLICATION_TYPE_WDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_APPLICATION_TYPE_WRCH : integer;
  attribute C_APPLICATION_TYPE_WRCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 8;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_AXIS_TKEEP_WIDTH : integer;
  attribute C_AXIS_TKEEP_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_AXIS_TSTRB_WIDTH : integer;
  attribute C_AXIS_TSTRB_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 4;
  attribute C_AXIS_TYPE : integer;
  attribute C_AXIS_TYPE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_AXI_ADDR_WIDTH : integer;
  attribute C_AXI_ADDR_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 32;
  attribute C_AXI_ARUSER_WIDTH : integer;
  attribute C_AXI_ARUSER_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_AXI_AWUSER_WIDTH : integer;
  attribute C_AXI_AWUSER_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_AXI_BUSER_WIDTH : integer;
  attribute C_AXI_BUSER_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_AXI_DATA_WIDTH : integer;
  attribute C_AXI_DATA_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 64;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_AXI_LEN_WIDTH : integer;
  attribute C_AXI_LEN_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 8;
  attribute C_AXI_LOCK_WIDTH : integer;
  attribute C_AXI_LOCK_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_AXI_RUSER_WIDTH : integer;
  attribute C_AXI_RUSER_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_AXI_TYPE : integer;
  attribute C_AXI_TYPE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_AXI_WUSER_WIDTH : integer;
  attribute C_AXI_WUSER_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_COMMON_CLOCK : integer;
  attribute C_COMMON_CLOCK of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_COUNT_TYPE : integer;
  attribute C_COUNT_TYPE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_DATA_COUNT_WIDTH : integer;
  attribute C_DATA_COUNT_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 9;
  attribute C_DEFAULT_VALUE : string;
  attribute C_DEFAULT_VALUE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is "BlankString";
  attribute C_DIN_WIDTH : integer;
  attribute C_DIN_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 71;
  attribute C_DIN_WIDTH_AXIS : integer;
  attribute C_DIN_WIDTH_AXIS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_DIN_WIDTH_RACH : integer;
  attribute C_DIN_WIDTH_RACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 32;
  attribute C_DIN_WIDTH_RDCH : integer;
  attribute C_DIN_WIDTH_RDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 64;
  attribute C_DIN_WIDTH_WACH : integer;
  attribute C_DIN_WIDTH_WACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_DIN_WIDTH_WDCH : integer;
  attribute C_DIN_WIDTH_WDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 64;
  attribute C_DIN_WIDTH_WRCH : integer;
  attribute C_DIN_WIDTH_WRCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 2;
  attribute C_DOUT_RST_VAL : string;
  attribute C_DOUT_RST_VAL of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is "0";
  attribute C_DOUT_WIDTH : integer;
  attribute C_DOUT_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 71;
  attribute C_ENABLE_RLOCS : integer;
  attribute C_ENABLE_RLOCS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_ENABLE_RST_SYNC : integer;
  attribute C_ENABLE_RST_SYNC of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_EN_SAFETY_CKT : integer;
  attribute C_EN_SAFETY_CKT of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_ERROR_INJECTION_TYPE : integer;
  attribute C_ERROR_INJECTION_TYPE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_ERROR_INJECTION_TYPE_AXIS : integer;
  attribute C_ERROR_INJECTION_TYPE_AXIS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_ERROR_INJECTION_TYPE_RACH : integer;
  attribute C_ERROR_INJECTION_TYPE_RACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_ERROR_INJECTION_TYPE_RDCH : integer;
  attribute C_ERROR_INJECTION_TYPE_RDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_ERROR_INJECTION_TYPE_WACH : integer;
  attribute C_ERROR_INJECTION_TYPE_WACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_ERROR_INJECTION_TYPE_WDCH : integer;
  attribute C_ERROR_INJECTION_TYPE_WDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_ERROR_INJECTION_TYPE_WRCH : integer;
  attribute C_ERROR_INJECTION_TYPE_WRCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_FAMILY : string;
  attribute C_FAMILY of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is "kintex7";
  attribute C_FULL_FLAGS_RST_VAL : integer;
  attribute C_FULL_FLAGS_RST_VAL of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_ALMOST_EMPTY : integer;
  attribute C_HAS_ALMOST_EMPTY of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_ALMOST_FULL : integer;
  attribute C_HAS_ALMOST_FULL of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_HAS_AXIS_TDATA : integer;
  attribute C_HAS_AXIS_TDATA of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_HAS_AXIS_TDEST : integer;
  attribute C_HAS_AXIS_TDEST of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_AXIS_TID : integer;
  attribute C_HAS_AXIS_TID of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_AXIS_TKEEP : integer;
  attribute C_HAS_AXIS_TKEEP of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_AXIS_TLAST : integer;
  attribute C_HAS_AXIS_TLAST of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_AXIS_TREADY : integer;
  attribute C_HAS_AXIS_TREADY of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_HAS_AXIS_TSTRB : integer;
  attribute C_HAS_AXIS_TSTRB of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_AXIS_TUSER : integer;
  attribute C_HAS_AXIS_TUSER of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_HAS_AXI_ARUSER : integer;
  attribute C_HAS_AXI_ARUSER of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_AXI_AWUSER : integer;
  attribute C_HAS_AXI_AWUSER of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_AXI_BUSER : integer;
  attribute C_HAS_AXI_BUSER of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_AXI_ID : integer;
  attribute C_HAS_AXI_ID of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_AXI_RD_CHANNEL : integer;
  attribute C_HAS_AXI_RD_CHANNEL of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_HAS_AXI_RUSER : integer;
  attribute C_HAS_AXI_RUSER of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_AXI_WR_CHANNEL : integer;
  attribute C_HAS_AXI_WR_CHANNEL of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_HAS_AXI_WUSER : integer;
  attribute C_HAS_AXI_WUSER of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_BACKUP : integer;
  attribute C_HAS_BACKUP of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_DATA_COUNT : integer;
  attribute C_HAS_DATA_COUNT of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_HAS_DATA_COUNTS_AXIS : integer;
  attribute C_HAS_DATA_COUNTS_AXIS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_DATA_COUNTS_RACH : integer;
  attribute C_HAS_DATA_COUNTS_RACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_DATA_COUNTS_RDCH : integer;
  attribute C_HAS_DATA_COUNTS_RDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_DATA_COUNTS_WACH : integer;
  attribute C_HAS_DATA_COUNTS_WACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_DATA_COUNTS_WDCH : integer;
  attribute C_HAS_DATA_COUNTS_WDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_DATA_COUNTS_WRCH : integer;
  attribute C_HAS_DATA_COUNTS_WRCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_INT_CLK : integer;
  attribute C_HAS_INT_CLK of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_MASTER_CE : integer;
  attribute C_HAS_MASTER_CE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_MEMINIT_FILE : integer;
  attribute C_HAS_MEMINIT_FILE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_OVERFLOW : integer;
  attribute C_HAS_OVERFLOW of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_HAS_PROG_FLAGS_AXIS : integer;
  attribute C_HAS_PROG_FLAGS_AXIS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_PROG_FLAGS_RACH : integer;
  attribute C_HAS_PROG_FLAGS_RACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_PROG_FLAGS_RDCH : integer;
  attribute C_HAS_PROG_FLAGS_RDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_PROG_FLAGS_WACH : integer;
  attribute C_HAS_PROG_FLAGS_WACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_PROG_FLAGS_WDCH : integer;
  attribute C_HAS_PROG_FLAGS_WDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_PROG_FLAGS_WRCH : integer;
  attribute C_HAS_PROG_FLAGS_WRCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_RD_DATA_COUNT : integer;
  attribute C_HAS_RD_DATA_COUNT of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_RD_RST : integer;
  attribute C_HAS_RD_RST of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_RST : integer;
  attribute C_HAS_RST of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_SLAVE_CE : integer;
  attribute C_HAS_SLAVE_CE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_SRST : integer;
  attribute C_HAS_SRST of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_HAS_UNDERFLOW : integer;
  attribute C_HAS_UNDERFLOW of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_VALID : integer;
  attribute C_HAS_VALID of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_HAS_WR_ACK : integer;
  attribute C_HAS_WR_ACK of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_WR_DATA_COUNT : integer;
  attribute C_HAS_WR_DATA_COUNT of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_HAS_WR_RST : integer;
  attribute C_HAS_WR_RST of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_IMPLEMENTATION_TYPE : integer;
  attribute C_IMPLEMENTATION_TYPE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_IMPLEMENTATION_TYPE_AXIS : integer;
  attribute C_IMPLEMENTATION_TYPE_AXIS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_IMPLEMENTATION_TYPE_RACH : integer;
  attribute C_IMPLEMENTATION_TYPE_RACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_IMPLEMENTATION_TYPE_RDCH : integer;
  attribute C_IMPLEMENTATION_TYPE_RDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_IMPLEMENTATION_TYPE_WACH : integer;
  attribute C_IMPLEMENTATION_TYPE_WACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_IMPLEMENTATION_TYPE_WDCH : integer;
  attribute C_IMPLEMENTATION_TYPE_WDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_IMPLEMENTATION_TYPE_WRCH : integer;
  attribute C_IMPLEMENTATION_TYPE_WRCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_INIT_WR_PNTR_VAL : integer;
  attribute C_INIT_WR_PNTR_VAL of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_INTERFACE_TYPE : integer;
  attribute C_INTERFACE_TYPE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_MEMORY_TYPE : integer;
  attribute C_MEMORY_TYPE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 2;
  attribute C_MIF_FILE_NAME : string;
  attribute C_MIF_FILE_NAME of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is "BlankString";
  attribute C_MSGON_VAL : integer;
  attribute C_MSGON_VAL of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_OPTIMIZATION_MODE : integer;
  attribute C_OPTIMIZATION_MODE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_OVERFLOW_LOW : integer;
  attribute C_OVERFLOW_LOW of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_POWER_SAVING_MODE : integer;
  attribute C_POWER_SAVING_MODE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_PRELOAD_LATENCY : integer;
  attribute C_PRELOAD_LATENCY of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_PRELOAD_REGS : integer;
  attribute C_PRELOAD_REGS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_PRIM_FIFO_TYPE : string;
  attribute C_PRIM_FIFO_TYPE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is "512x72";
  attribute C_PRIM_FIFO_TYPE_AXIS : string;
  attribute C_PRIM_FIFO_TYPE_AXIS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is "1kx18";
  attribute C_PRIM_FIFO_TYPE_RACH : string;
  attribute C_PRIM_FIFO_TYPE_RACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is "512x36";
  attribute C_PRIM_FIFO_TYPE_RDCH : string;
  attribute C_PRIM_FIFO_TYPE_RDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is "1kx36";
  attribute C_PRIM_FIFO_TYPE_WACH : string;
  attribute C_PRIM_FIFO_TYPE_WACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is "512x36";
  attribute C_PRIM_FIFO_TYPE_WDCH : string;
  attribute C_PRIM_FIFO_TYPE_WDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is "1kx36";
  attribute C_PRIM_FIFO_TYPE_WRCH : string;
  attribute C_PRIM_FIFO_TYPE_WRCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is "512x36";
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 4;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1022;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1022;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1022;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1022;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1022;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1022;
  attribute C_PROG_EMPTY_THRESH_NEGATE_VAL : integer;
  attribute C_PROG_EMPTY_THRESH_NEGATE_VAL of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 5;
  attribute C_PROG_EMPTY_TYPE : integer;
  attribute C_PROG_EMPTY_TYPE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_PROG_EMPTY_TYPE_AXIS : integer;
  attribute C_PROG_EMPTY_TYPE_AXIS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_PROG_EMPTY_TYPE_RACH : integer;
  attribute C_PROG_EMPTY_TYPE_RACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_PROG_EMPTY_TYPE_RDCH : integer;
  attribute C_PROG_EMPTY_TYPE_RDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_PROG_EMPTY_TYPE_WACH : integer;
  attribute C_PROG_EMPTY_TYPE_WACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_PROG_EMPTY_TYPE_WDCH : integer;
  attribute C_PROG_EMPTY_TYPE_WDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_PROG_EMPTY_TYPE_WRCH : integer;
  attribute C_PROG_EMPTY_TYPE_WRCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 255;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_AXIS : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_AXIS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1023;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RACH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1023;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RDCH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1023;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WACH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1023;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WDCH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1023;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WRCH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WRCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1023;
  attribute C_PROG_FULL_THRESH_NEGATE_VAL : integer;
  attribute C_PROG_FULL_THRESH_NEGATE_VAL of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 254;
  attribute C_PROG_FULL_TYPE : integer;
  attribute C_PROG_FULL_TYPE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_PROG_FULL_TYPE_AXIS : integer;
  attribute C_PROG_FULL_TYPE_AXIS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_PROG_FULL_TYPE_RACH : integer;
  attribute C_PROG_FULL_TYPE_RACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_PROG_FULL_TYPE_RDCH : integer;
  attribute C_PROG_FULL_TYPE_RDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_PROG_FULL_TYPE_WACH : integer;
  attribute C_PROG_FULL_TYPE_WACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_PROG_FULL_TYPE_WDCH : integer;
  attribute C_PROG_FULL_TYPE_WDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_PROG_FULL_TYPE_WRCH : integer;
  attribute C_PROG_FULL_TYPE_WRCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_RACH_TYPE : integer;
  attribute C_RACH_TYPE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_RDCH_TYPE : integer;
  attribute C_RDCH_TYPE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_RD_DATA_COUNT_WIDTH : integer;
  attribute C_RD_DATA_COUNT_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 9;
  attribute C_RD_DEPTH : integer;
  attribute C_RD_DEPTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 256;
  attribute C_RD_FREQ : integer;
  attribute C_RD_FREQ of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_RD_PNTR_WIDTH : integer;
  attribute C_RD_PNTR_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 8;
  attribute C_REG_SLICE_MODE_AXIS : integer;
  attribute C_REG_SLICE_MODE_AXIS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_REG_SLICE_MODE_RACH : integer;
  attribute C_REG_SLICE_MODE_RACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_REG_SLICE_MODE_RDCH : integer;
  attribute C_REG_SLICE_MODE_RDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_REG_SLICE_MODE_WACH : integer;
  attribute C_REG_SLICE_MODE_WACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_REG_SLICE_MODE_WDCH : integer;
  attribute C_REG_SLICE_MODE_WDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_REG_SLICE_MODE_WRCH : integer;
  attribute C_REG_SLICE_MODE_WRCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_SELECT_XPM : integer;
  attribute C_SELECT_XPM of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_SYNCHRONIZER_STAGE : integer;
  attribute C_SYNCHRONIZER_STAGE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 2;
  attribute C_UNDERFLOW_LOW : integer;
  attribute C_UNDERFLOW_LOW of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_USE_COMMON_OVERFLOW : integer;
  attribute C_USE_COMMON_OVERFLOW of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_USE_COMMON_UNDERFLOW : integer;
  attribute C_USE_COMMON_UNDERFLOW of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_USE_DEFAULT_SETTINGS : integer;
  attribute C_USE_DEFAULT_SETTINGS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_USE_DOUT_RST : integer;
  attribute C_USE_DOUT_RST of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_USE_ECC : integer;
  attribute C_USE_ECC of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_USE_ECC_AXIS : integer;
  attribute C_USE_ECC_AXIS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_USE_ECC_RACH : integer;
  attribute C_USE_ECC_RACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_USE_ECC_RDCH : integer;
  attribute C_USE_ECC_RDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_USE_ECC_WACH : integer;
  attribute C_USE_ECC_WACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_USE_ECC_WDCH : integer;
  attribute C_USE_ECC_WDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_USE_ECC_WRCH : integer;
  attribute C_USE_ECC_WRCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_USE_EMBEDDED_REG : integer;
  attribute C_USE_EMBEDDED_REG of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_USE_FIFO16_FLAGS : integer;
  attribute C_USE_FIFO16_FLAGS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_USE_FWFT_DATA_COUNT : integer;
  attribute C_USE_FWFT_DATA_COUNT of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_USE_PIPELINE_REG : integer;
  attribute C_USE_PIPELINE_REG of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_VALID_LOW : integer;
  attribute C_VALID_LOW of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_WACH_TYPE : integer;
  attribute C_WACH_TYPE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_WDCH_TYPE : integer;
  attribute C_WDCH_TYPE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_WRCH_TYPE : integer;
  attribute C_WRCH_TYPE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_WR_ACK_LOW : integer;
  attribute C_WR_ACK_LOW of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 0;
  attribute C_WR_DATA_COUNT_WIDTH : integer;
  attribute C_WR_DATA_COUNT_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 9;
  attribute C_WR_DEPTH : integer;
  attribute C_WR_DEPTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 256;
  attribute C_WR_DEPTH_AXIS : integer;
  attribute C_WR_DEPTH_AXIS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1024;
  attribute C_WR_DEPTH_RACH : integer;
  attribute C_WR_DEPTH_RACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 16;
  attribute C_WR_DEPTH_RDCH : integer;
  attribute C_WR_DEPTH_RDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1024;
  attribute C_WR_DEPTH_WACH : integer;
  attribute C_WR_DEPTH_WACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 16;
  attribute C_WR_DEPTH_WDCH : integer;
  attribute C_WR_DEPTH_WDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1024;
  attribute C_WR_DEPTH_WRCH : integer;
  attribute C_WR_DEPTH_WRCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 16;
  attribute C_WR_FREQ : integer;
  attribute C_WR_FREQ of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute C_WR_PNTR_WIDTH : integer;
  attribute C_WR_PNTR_WIDTH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 8;
  attribute C_WR_PNTR_WIDTH_AXIS : integer;
  attribute C_WR_PNTR_WIDTH_AXIS of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 10;
  attribute C_WR_PNTR_WIDTH_RACH : integer;
  attribute C_WR_PNTR_WIDTH_RACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 4;
  attribute C_WR_PNTR_WIDTH_RDCH : integer;
  attribute C_WR_PNTR_WIDTH_RDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 10;
  attribute C_WR_PNTR_WIDTH_WACH : integer;
  attribute C_WR_PNTR_WIDTH_WACH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 4;
  attribute C_WR_PNTR_WIDTH_WDCH : integer;
  attribute C_WR_PNTR_WIDTH_WDCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 10;
  attribute C_WR_PNTR_WIDTH_WRCH : integer;
  attribute C_WR_PNTR_WIDTH_WRCH of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 4;
  attribute C_WR_RESPONSE_LATENCY : integer;
  attribute C_WR_RESPONSE_LATENCY of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is 1;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 : entity is "fifo_generator_v13_1_2";
end fwft_sfifo_w71_d256_fifo_generator_v13_1_2;

architecture STRUCTURE of fwft_sfifo_w71_d256_fifo_generator_v13_1_2 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
begin
  almost_empty <= \<const0>\;
  axi_ar_data_count(4) <= \<const0>\;
  axi_ar_data_count(3) <= \<const0>\;
  axi_ar_data_count(2) <= \<const0>\;
  axi_ar_data_count(1) <= \<const0>\;
  axi_ar_data_count(0) <= \<const0>\;
  axi_ar_dbiterr <= \<const0>\;
  axi_ar_overflow <= \<const0>\;
  axi_ar_prog_empty <= \<const1>\;
  axi_ar_prog_full <= \<const0>\;
  axi_ar_rd_data_count(4) <= \<const0>\;
  axi_ar_rd_data_count(3) <= \<const0>\;
  axi_ar_rd_data_count(2) <= \<const0>\;
  axi_ar_rd_data_count(1) <= \<const0>\;
  axi_ar_rd_data_count(0) <= \<const0>\;
  axi_ar_sbiterr <= \<const0>\;
  axi_ar_underflow <= \<const0>\;
  axi_ar_wr_data_count(4) <= \<const0>\;
  axi_ar_wr_data_count(3) <= \<const0>\;
  axi_ar_wr_data_count(2) <= \<const0>\;
  axi_ar_wr_data_count(1) <= \<const0>\;
  axi_ar_wr_data_count(0) <= \<const0>\;
  axi_aw_data_count(4) <= \<const0>\;
  axi_aw_data_count(3) <= \<const0>\;
  axi_aw_data_count(2) <= \<const0>\;
  axi_aw_data_count(1) <= \<const0>\;
  axi_aw_data_count(0) <= \<const0>\;
  axi_aw_dbiterr <= \<const0>\;
  axi_aw_overflow <= \<const0>\;
  axi_aw_prog_empty <= \<const1>\;
  axi_aw_prog_full <= \<const0>\;
  axi_aw_rd_data_count(4) <= \<const0>\;
  axi_aw_rd_data_count(3) <= \<const0>\;
  axi_aw_rd_data_count(2) <= \<const0>\;
  axi_aw_rd_data_count(1) <= \<const0>\;
  axi_aw_rd_data_count(0) <= \<const0>\;
  axi_aw_sbiterr <= \<const0>\;
  axi_aw_underflow <= \<const0>\;
  axi_aw_wr_data_count(4) <= \<const0>\;
  axi_aw_wr_data_count(3) <= \<const0>\;
  axi_aw_wr_data_count(2) <= \<const0>\;
  axi_aw_wr_data_count(1) <= \<const0>\;
  axi_aw_wr_data_count(0) <= \<const0>\;
  axi_b_data_count(4) <= \<const0>\;
  axi_b_data_count(3) <= \<const0>\;
  axi_b_data_count(2) <= \<const0>\;
  axi_b_data_count(1) <= \<const0>\;
  axi_b_data_count(0) <= \<const0>\;
  axi_b_dbiterr <= \<const0>\;
  axi_b_overflow <= \<const0>\;
  axi_b_prog_empty <= \<const1>\;
  axi_b_prog_full <= \<const0>\;
  axi_b_rd_data_count(4) <= \<const0>\;
  axi_b_rd_data_count(3) <= \<const0>\;
  axi_b_rd_data_count(2) <= \<const0>\;
  axi_b_rd_data_count(1) <= \<const0>\;
  axi_b_rd_data_count(0) <= \<const0>\;
  axi_b_sbiterr <= \<const0>\;
  axi_b_underflow <= \<const0>\;
  axi_b_wr_data_count(4) <= \<const0>\;
  axi_b_wr_data_count(3) <= \<const0>\;
  axi_b_wr_data_count(2) <= \<const0>\;
  axi_b_wr_data_count(1) <= \<const0>\;
  axi_b_wr_data_count(0) <= \<const0>\;
  axi_r_data_count(10) <= \<const0>\;
  axi_r_data_count(9) <= \<const0>\;
  axi_r_data_count(8) <= \<const0>\;
  axi_r_data_count(7) <= \<const0>\;
  axi_r_data_count(6) <= \<const0>\;
  axi_r_data_count(5) <= \<const0>\;
  axi_r_data_count(4) <= \<const0>\;
  axi_r_data_count(3) <= \<const0>\;
  axi_r_data_count(2) <= \<const0>\;
  axi_r_data_count(1) <= \<const0>\;
  axi_r_data_count(0) <= \<const0>\;
  axi_r_dbiterr <= \<const0>\;
  axi_r_overflow <= \<const0>\;
  axi_r_prog_empty <= \<const1>\;
  axi_r_prog_full <= \<const0>\;
  axi_r_rd_data_count(10) <= \<const0>\;
  axi_r_rd_data_count(9) <= \<const0>\;
  axi_r_rd_data_count(8) <= \<const0>\;
  axi_r_rd_data_count(7) <= \<const0>\;
  axi_r_rd_data_count(6) <= \<const0>\;
  axi_r_rd_data_count(5) <= \<const0>\;
  axi_r_rd_data_count(4) <= \<const0>\;
  axi_r_rd_data_count(3) <= \<const0>\;
  axi_r_rd_data_count(2) <= \<const0>\;
  axi_r_rd_data_count(1) <= \<const0>\;
  axi_r_rd_data_count(0) <= \<const0>\;
  axi_r_sbiterr <= \<const0>\;
  axi_r_underflow <= \<const0>\;
  axi_r_wr_data_count(10) <= \<const0>\;
  axi_r_wr_data_count(9) <= \<const0>\;
  axi_r_wr_data_count(8) <= \<const0>\;
  axi_r_wr_data_count(7) <= \<const0>\;
  axi_r_wr_data_count(6) <= \<const0>\;
  axi_r_wr_data_count(5) <= \<const0>\;
  axi_r_wr_data_count(4) <= \<const0>\;
  axi_r_wr_data_count(3) <= \<const0>\;
  axi_r_wr_data_count(2) <= \<const0>\;
  axi_r_wr_data_count(1) <= \<const0>\;
  axi_r_wr_data_count(0) <= \<const0>\;
  axi_w_data_count(10) <= \<const0>\;
  axi_w_data_count(9) <= \<const0>\;
  axi_w_data_count(8) <= \<const0>\;
  axi_w_data_count(7) <= \<const0>\;
  axi_w_data_count(6) <= \<const0>\;
  axi_w_data_count(5) <= \<const0>\;
  axi_w_data_count(4) <= \<const0>\;
  axi_w_data_count(3) <= \<const0>\;
  axi_w_data_count(2) <= \<const0>\;
  axi_w_data_count(1) <= \<const0>\;
  axi_w_data_count(0) <= \<const0>\;
  axi_w_dbiterr <= \<const0>\;
  axi_w_overflow <= \<const0>\;
  axi_w_prog_empty <= \<const1>\;
  axi_w_prog_full <= \<const0>\;
  axi_w_rd_data_count(10) <= \<const0>\;
  axi_w_rd_data_count(9) <= \<const0>\;
  axi_w_rd_data_count(8) <= \<const0>\;
  axi_w_rd_data_count(7) <= \<const0>\;
  axi_w_rd_data_count(6) <= \<const0>\;
  axi_w_rd_data_count(5) <= \<const0>\;
  axi_w_rd_data_count(4) <= \<const0>\;
  axi_w_rd_data_count(3) <= \<const0>\;
  axi_w_rd_data_count(2) <= \<const0>\;
  axi_w_rd_data_count(1) <= \<const0>\;
  axi_w_rd_data_count(0) <= \<const0>\;
  axi_w_sbiterr <= \<const0>\;
  axi_w_underflow <= \<const0>\;
  axi_w_wr_data_count(10) <= \<const0>\;
  axi_w_wr_data_count(9) <= \<const0>\;
  axi_w_wr_data_count(8) <= \<const0>\;
  axi_w_wr_data_count(7) <= \<const0>\;
  axi_w_wr_data_count(6) <= \<const0>\;
  axi_w_wr_data_count(5) <= \<const0>\;
  axi_w_wr_data_count(4) <= \<const0>\;
  axi_w_wr_data_count(3) <= \<const0>\;
  axi_w_wr_data_count(2) <= \<const0>\;
  axi_w_wr_data_count(1) <= \<const0>\;
  axi_w_wr_data_count(0) <= \<const0>\;
  axis_data_count(10) <= \<const0>\;
  axis_data_count(9) <= \<const0>\;
  axis_data_count(8) <= \<const0>\;
  axis_data_count(7) <= \<const0>\;
  axis_data_count(6) <= \<const0>\;
  axis_data_count(5) <= \<const0>\;
  axis_data_count(4) <= \<const0>\;
  axis_data_count(3) <= \<const0>\;
  axis_data_count(2) <= \<const0>\;
  axis_data_count(1) <= \<const0>\;
  axis_data_count(0) <= \<const0>\;
  axis_dbiterr <= \<const0>\;
  axis_overflow <= \<const0>\;
  axis_prog_empty <= \<const1>\;
  axis_prog_full <= \<const0>\;
  axis_rd_data_count(10) <= \<const0>\;
  axis_rd_data_count(9) <= \<const0>\;
  axis_rd_data_count(8) <= \<const0>\;
  axis_rd_data_count(7) <= \<const0>\;
  axis_rd_data_count(6) <= \<const0>\;
  axis_rd_data_count(5) <= \<const0>\;
  axis_rd_data_count(4) <= \<const0>\;
  axis_rd_data_count(3) <= \<const0>\;
  axis_rd_data_count(2) <= \<const0>\;
  axis_rd_data_count(1) <= \<const0>\;
  axis_rd_data_count(0) <= \<const0>\;
  axis_sbiterr <= \<const0>\;
  axis_underflow <= \<const0>\;
  axis_wr_data_count(10) <= \<const0>\;
  axis_wr_data_count(9) <= \<const0>\;
  axis_wr_data_count(8) <= \<const0>\;
  axis_wr_data_count(7) <= \<const0>\;
  axis_wr_data_count(6) <= \<const0>\;
  axis_wr_data_count(5) <= \<const0>\;
  axis_wr_data_count(4) <= \<const0>\;
  axis_wr_data_count(3) <= \<const0>\;
  axis_wr_data_count(2) <= \<const0>\;
  axis_wr_data_count(1) <= \<const0>\;
  axis_wr_data_count(0) <= \<const0>\;
  dbiterr <= \<const0>\;
  m_axi_araddr(31) <= \<const0>\;
  m_axi_araddr(30) <= \<const0>\;
  m_axi_araddr(29) <= \<const0>\;
  m_axi_araddr(28) <= \<const0>\;
  m_axi_araddr(27) <= \<const0>\;
  m_axi_araddr(26) <= \<const0>\;
  m_axi_araddr(25) <= \<const0>\;
  m_axi_araddr(24) <= \<const0>\;
  m_axi_araddr(23) <= \<const0>\;
  m_axi_araddr(22) <= \<const0>\;
  m_axi_araddr(21) <= \<const0>\;
  m_axi_araddr(20) <= \<const0>\;
  m_axi_araddr(19) <= \<const0>\;
  m_axi_araddr(18) <= \<const0>\;
  m_axi_araddr(17) <= \<const0>\;
  m_axi_araddr(16) <= \<const0>\;
  m_axi_araddr(15) <= \<const0>\;
  m_axi_araddr(14) <= \<const0>\;
  m_axi_araddr(13) <= \<const0>\;
  m_axi_araddr(12) <= \<const0>\;
  m_axi_araddr(11) <= \<const0>\;
  m_axi_araddr(10) <= \<const0>\;
  m_axi_araddr(9) <= \<const0>\;
  m_axi_araddr(8) <= \<const0>\;
  m_axi_araddr(7) <= \<const0>\;
  m_axi_araddr(6) <= \<const0>\;
  m_axi_araddr(5) <= \<const0>\;
  m_axi_araddr(4) <= \<const0>\;
  m_axi_araddr(3) <= \<const0>\;
  m_axi_araddr(2) <= \<const0>\;
  m_axi_araddr(1) <= \<const0>\;
  m_axi_araddr(0) <= \<const0>\;
  m_axi_arburst(1) <= \<const0>\;
  m_axi_arburst(0) <= \<const0>\;
  m_axi_arcache(3) <= \<const0>\;
  m_axi_arcache(2) <= \<const0>\;
  m_axi_arcache(1) <= \<const0>\;
  m_axi_arcache(0) <= \<const0>\;
  m_axi_arid(0) <= \<const0>\;
  m_axi_arlen(7) <= \<const0>\;
  m_axi_arlen(6) <= \<const0>\;
  m_axi_arlen(5) <= \<const0>\;
  m_axi_arlen(4) <= \<const0>\;
  m_axi_arlen(3) <= \<const0>\;
  m_axi_arlen(2) <= \<const0>\;
  m_axi_arlen(1) <= \<const0>\;
  m_axi_arlen(0) <= \<const0>\;
  m_axi_arlock(0) <= \<const0>\;
  m_axi_arprot(2) <= \<const0>\;
  m_axi_arprot(1) <= \<const0>\;
  m_axi_arprot(0) <= \<const0>\;
  m_axi_arqos(3) <= \<const0>\;
  m_axi_arqos(2) <= \<const0>\;
  m_axi_arqos(1) <= \<const0>\;
  m_axi_arqos(0) <= \<const0>\;
  m_axi_arregion(3) <= \<const0>\;
  m_axi_arregion(2) <= \<const0>\;
  m_axi_arregion(1) <= \<const0>\;
  m_axi_arregion(0) <= \<const0>\;
  m_axi_arsize(2) <= \<const0>\;
  m_axi_arsize(1) <= \<const0>\;
  m_axi_arsize(0) <= \<const0>\;
  m_axi_aruser(0) <= \<const0>\;
  m_axi_arvalid <= \<const0>\;
  m_axi_awaddr(31) <= \<const0>\;
  m_axi_awaddr(30) <= \<const0>\;
  m_axi_awaddr(29) <= \<const0>\;
  m_axi_awaddr(28) <= \<const0>\;
  m_axi_awaddr(27) <= \<const0>\;
  m_axi_awaddr(26) <= \<const0>\;
  m_axi_awaddr(25) <= \<const0>\;
  m_axi_awaddr(24) <= \<const0>\;
  m_axi_awaddr(23) <= \<const0>\;
  m_axi_awaddr(22) <= \<const0>\;
  m_axi_awaddr(21) <= \<const0>\;
  m_axi_awaddr(20) <= \<const0>\;
  m_axi_awaddr(19) <= \<const0>\;
  m_axi_awaddr(18) <= \<const0>\;
  m_axi_awaddr(17) <= \<const0>\;
  m_axi_awaddr(16) <= \<const0>\;
  m_axi_awaddr(15) <= \<const0>\;
  m_axi_awaddr(14) <= \<const0>\;
  m_axi_awaddr(13) <= \<const0>\;
  m_axi_awaddr(12) <= \<const0>\;
  m_axi_awaddr(11) <= \<const0>\;
  m_axi_awaddr(10) <= \<const0>\;
  m_axi_awaddr(9) <= \<const0>\;
  m_axi_awaddr(8) <= \<const0>\;
  m_axi_awaddr(7) <= \<const0>\;
  m_axi_awaddr(6) <= \<const0>\;
  m_axi_awaddr(5) <= \<const0>\;
  m_axi_awaddr(4) <= \<const0>\;
  m_axi_awaddr(3) <= \<const0>\;
  m_axi_awaddr(2) <= \<const0>\;
  m_axi_awaddr(1) <= \<const0>\;
  m_axi_awaddr(0) <= \<const0>\;
  m_axi_awburst(1) <= \<const0>\;
  m_axi_awburst(0) <= \<const0>\;
  m_axi_awcache(3) <= \<const0>\;
  m_axi_awcache(2) <= \<const0>\;
  m_axi_awcache(1) <= \<const0>\;
  m_axi_awcache(0) <= \<const0>\;
  m_axi_awid(0) <= \<const0>\;
  m_axi_awlen(7) <= \<const0>\;
  m_axi_awlen(6) <= \<const0>\;
  m_axi_awlen(5) <= \<const0>\;
  m_axi_awlen(4) <= \<const0>\;
  m_axi_awlen(3) <= \<const0>\;
  m_axi_awlen(2) <= \<const0>\;
  m_axi_awlen(1) <= \<const0>\;
  m_axi_awlen(0) <= \<const0>\;
  m_axi_awlock(0) <= \<const0>\;
  m_axi_awprot(2) <= \<const0>\;
  m_axi_awprot(1) <= \<const0>\;
  m_axi_awprot(0) <= \<const0>\;
  m_axi_awqos(3) <= \<const0>\;
  m_axi_awqos(2) <= \<const0>\;
  m_axi_awqos(1) <= \<const0>\;
  m_axi_awqos(0) <= \<const0>\;
  m_axi_awregion(3) <= \<const0>\;
  m_axi_awregion(2) <= \<const0>\;
  m_axi_awregion(1) <= \<const0>\;
  m_axi_awregion(0) <= \<const0>\;
  m_axi_awsize(2) <= \<const0>\;
  m_axi_awsize(1) <= \<const0>\;
  m_axi_awsize(0) <= \<const0>\;
  m_axi_awuser(0) <= \<const0>\;
  m_axi_awvalid <= \<const0>\;
  m_axi_bready <= \<const0>\;
  m_axi_rready <= \<const0>\;
  m_axi_wdata(63) <= \<const0>\;
  m_axi_wdata(62) <= \<const0>\;
  m_axi_wdata(61) <= \<const0>\;
  m_axi_wdata(60) <= \<const0>\;
  m_axi_wdata(59) <= \<const0>\;
  m_axi_wdata(58) <= \<const0>\;
  m_axi_wdata(57) <= \<const0>\;
  m_axi_wdata(56) <= \<const0>\;
  m_axi_wdata(55) <= \<const0>\;
  m_axi_wdata(54) <= \<const0>\;
  m_axi_wdata(53) <= \<const0>\;
  m_axi_wdata(52) <= \<const0>\;
  m_axi_wdata(51) <= \<const0>\;
  m_axi_wdata(50) <= \<const0>\;
  m_axi_wdata(49) <= \<const0>\;
  m_axi_wdata(48) <= \<const0>\;
  m_axi_wdata(47) <= \<const0>\;
  m_axi_wdata(46) <= \<const0>\;
  m_axi_wdata(45) <= \<const0>\;
  m_axi_wdata(44) <= \<const0>\;
  m_axi_wdata(43) <= \<const0>\;
  m_axi_wdata(42) <= \<const0>\;
  m_axi_wdata(41) <= \<const0>\;
  m_axi_wdata(40) <= \<const0>\;
  m_axi_wdata(39) <= \<const0>\;
  m_axi_wdata(38) <= \<const0>\;
  m_axi_wdata(37) <= \<const0>\;
  m_axi_wdata(36) <= \<const0>\;
  m_axi_wdata(35) <= \<const0>\;
  m_axi_wdata(34) <= \<const0>\;
  m_axi_wdata(33) <= \<const0>\;
  m_axi_wdata(32) <= \<const0>\;
  m_axi_wdata(31) <= \<const0>\;
  m_axi_wdata(30) <= \<const0>\;
  m_axi_wdata(29) <= \<const0>\;
  m_axi_wdata(28) <= \<const0>\;
  m_axi_wdata(27) <= \<const0>\;
  m_axi_wdata(26) <= \<const0>\;
  m_axi_wdata(25) <= \<const0>\;
  m_axi_wdata(24) <= \<const0>\;
  m_axi_wdata(23) <= \<const0>\;
  m_axi_wdata(22) <= \<const0>\;
  m_axi_wdata(21) <= \<const0>\;
  m_axi_wdata(20) <= \<const0>\;
  m_axi_wdata(19) <= \<const0>\;
  m_axi_wdata(18) <= \<const0>\;
  m_axi_wdata(17) <= \<const0>\;
  m_axi_wdata(16) <= \<const0>\;
  m_axi_wdata(15) <= \<const0>\;
  m_axi_wdata(14) <= \<const0>\;
  m_axi_wdata(13) <= \<const0>\;
  m_axi_wdata(12) <= \<const0>\;
  m_axi_wdata(11) <= \<const0>\;
  m_axi_wdata(10) <= \<const0>\;
  m_axi_wdata(9) <= \<const0>\;
  m_axi_wdata(8) <= \<const0>\;
  m_axi_wdata(7) <= \<const0>\;
  m_axi_wdata(6) <= \<const0>\;
  m_axi_wdata(5) <= \<const0>\;
  m_axi_wdata(4) <= \<const0>\;
  m_axi_wdata(3) <= \<const0>\;
  m_axi_wdata(2) <= \<const0>\;
  m_axi_wdata(1) <= \<const0>\;
  m_axi_wdata(0) <= \<const0>\;
  m_axi_wid(0) <= \<const0>\;
  m_axi_wlast <= \<const0>\;
  m_axi_wstrb(7) <= \<const0>\;
  m_axi_wstrb(6) <= \<const0>\;
  m_axi_wstrb(5) <= \<const0>\;
  m_axi_wstrb(4) <= \<const0>\;
  m_axi_wstrb(3) <= \<const0>\;
  m_axi_wstrb(2) <= \<const0>\;
  m_axi_wstrb(1) <= \<const0>\;
  m_axi_wstrb(0) <= \<const0>\;
  m_axi_wuser(0) <= \<const0>\;
  m_axi_wvalid <= \<const0>\;
  m_axis_tdata(7) <= \<const0>\;
  m_axis_tdata(6) <= \<const0>\;
  m_axis_tdata(5) <= \<const0>\;
  m_axis_tdata(4) <= \<const0>\;
  m_axis_tdata(3) <= \<const0>\;
  m_axis_tdata(2) <= \<const0>\;
  m_axis_tdata(1) <= \<const0>\;
  m_axis_tdata(0) <= \<const0>\;
  m_axis_tdest(0) <= \<const0>\;
  m_axis_tid(0) <= \<const0>\;
  m_axis_tkeep(0) <= \<const0>\;
  m_axis_tlast <= \<const0>\;
  m_axis_tstrb(0) <= \<const0>\;
  m_axis_tuser(3) <= \<const0>\;
  m_axis_tuser(2) <= \<const0>\;
  m_axis_tuser(1) <= \<const0>\;
  m_axis_tuser(0) <= \<const0>\;
  m_axis_tvalid <= \<const0>\;
  prog_empty <= \<const0>\;
  prog_full <= \<const0>\;
  rd_data_count(8) <= \<const0>\;
  rd_data_count(7) <= \<const0>\;
  rd_data_count(6) <= \<const0>\;
  rd_data_count(5) <= \<const0>\;
  rd_data_count(4) <= \<const0>\;
  rd_data_count(3) <= \<const0>\;
  rd_data_count(2) <= \<const0>\;
  rd_data_count(1) <= \<const0>\;
  rd_data_count(0) <= \<const0>\;
  rd_rst_busy <= \<const0>\;
  s_axi_arready <= \<const0>\;
  s_axi_awready <= \<const0>\;
  s_axi_bid(0) <= \<const0>\;
  s_axi_bresp(1) <= \<const0>\;
  s_axi_bresp(0) <= \<const0>\;
  s_axi_buser(0) <= \<const0>\;
  s_axi_bvalid <= \<const0>\;
  s_axi_rdata(63) <= \<const0>\;
  s_axi_rdata(62) <= \<const0>\;
  s_axi_rdata(61) <= \<const0>\;
  s_axi_rdata(60) <= \<const0>\;
  s_axi_rdata(59) <= \<const0>\;
  s_axi_rdata(58) <= \<const0>\;
  s_axi_rdata(57) <= \<const0>\;
  s_axi_rdata(56) <= \<const0>\;
  s_axi_rdata(55) <= \<const0>\;
  s_axi_rdata(54) <= \<const0>\;
  s_axi_rdata(53) <= \<const0>\;
  s_axi_rdata(52) <= \<const0>\;
  s_axi_rdata(51) <= \<const0>\;
  s_axi_rdata(50) <= \<const0>\;
  s_axi_rdata(49) <= \<const0>\;
  s_axi_rdata(48) <= \<const0>\;
  s_axi_rdata(47) <= \<const0>\;
  s_axi_rdata(46) <= \<const0>\;
  s_axi_rdata(45) <= \<const0>\;
  s_axi_rdata(44) <= \<const0>\;
  s_axi_rdata(43) <= \<const0>\;
  s_axi_rdata(42) <= \<const0>\;
  s_axi_rdata(41) <= \<const0>\;
  s_axi_rdata(40) <= \<const0>\;
  s_axi_rdata(39) <= \<const0>\;
  s_axi_rdata(38) <= \<const0>\;
  s_axi_rdata(37) <= \<const0>\;
  s_axi_rdata(36) <= \<const0>\;
  s_axi_rdata(35) <= \<const0>\;
  s_axi_rdata(34) <= \<const0>\;
  s_axi_rdata(33) <= \<const0>\;
  s_axi_rdata(32) <= \<const0>\;
  s_axi_rdata(31) <= \<const0>\;
  s_axi_rdata(30) <= \<const0>\;
  s_axi_rdata(29) <= \<const0>\;
  s_axi_rdata(28) <= \<const0>\;
  s_axi_rdata(27) <= \<const0>\;
  s_axi_rdata(26) <= \<const0>\;
  s_axi_rdata(25) <= \<const0>\;
  s_axi_rdata(24) <= \<const0>\;
  s_axi_rdata(23) <= \<const0>\;
  s_axi_rdata(22) <= \<const0>\;
  s_axi_rdata(21) <= \<const0>\;
  s_axi_rdata(20) <= \<const0>\;
  s_axi_rdata(19) <= \<const0>\;
  s_axi_rdata(18) <= \<const0>\;
  s_axi_rdata(17) <= \<const0>\;
  s_axi_rdata(16) <= \<const0>\;
  s_axi_rdata(15) <= \<const0>\;
  s_axi_rdata(14) <= \<const0>\;
  s_axi_rdata(13) <= \<const0>\;
  s_axi_rdata(12) <= \<const0>\;
  s_axi_rdata(11) <= \<const0>\;
  s_axi_rdata(10) <= \<const0>\;
  s_axi_rdata(9) <= \<const0>\;
  s_axi_rdata(8) <= \<const0>\;
  s_axi_rdata(7) <= \<const0>\;
  s_axi_rdata(6) <= \<const0>\;
  s_axi_rdata(5) <= \<const0>\;
  s_axi_rdata(4) <= \<const0>\;
  s_axi_rdata(3) <= \<const0>\;
  s_axi_rdata(2) <= \<const0>\;
  s_axi_rdata(1) <= \<const0>\;
  s_axi_rdata(0) <= \<const0>\;
  s_axi_rid(0) <= \<const0>\;
  s_axi_rlast <= \<const0>\;
  s_axi_rresp(1) <= \<const0>\;
  s_axi_rresp(0) <= \<const0>\;
  s_axi_ruser(0) <= \<const0>\;
  s_axi_rvalid <= \<const0>\;
  s_axi_wready <= \<const0>\;
  s_axis_tready <= \<const0>\;
  sbiterr <= \<const0>\;
  underflow <= \<const0>\;
  wr_ack <= \<const0>\;
  wr_data_count(8) <= \<const0>\;
  wr_data_count(7) <= \<const0>\;
  wr_data_count(6) <= \<const0>\;
  wr_data_count(5) <= \<const0>\;
  wr_data_count(4) <= \<const0>\;
  wr_data_count(3) <= \<const0>\;
  wr_data_count(2) <= \<const0>\;
  wr_data_count(1) <= \<const0>\;
  wr_data_count(0) <= \<const0>\;
  wr_rst_busy <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
inst_fifo_gen: entity work.fwft_sfifo_w71_d256_fifo_generator_v13_1_2_synth
     port map (
      almost_full => almost_full,
      clk => clk,
      data_count(8 downto 0) => data_count(8 downto 0),
      din(70 downto 0) => din(70 downto 0),
      dout(70 downto 0) => dout(70 downto 0),
      empty => empty,
      full => full,
      overflow => overflow,
      rd_en => rd_en,
      srst => srst,
      valid => valid,
      wr_en => wr_en
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fwft_sfifo_w71_d256 is
  port (
    clk : in STD_LOGIC;
    srst : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 70 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 70 downto 0 );
    full : out STD_LOGIC;
    almost_full : out STD_LOGIC;
    overflow : out STD_LOGIC;
    empty : out STD_LOGIC;
    valid : out STD_LOGIC;
    data_count : out STD_LOGIC_VECTOR ( 8 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of fwft_sfifo_w71_d256 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of fwft_sfifo_w71_d256 : entity is "fwft_sfifo_w71_d256,fifo_generator_v13_1_2,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of fwft_sfifo_w71_d256 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of fwft_sfifo_w71_d256 : entity is "fifo_generator_v13_1_2,Vivado 2016.3";
end fwft_sfifo_w71_d256;

architecture STRUCTURE of fwft_sfifo_w71_d256 is
  signal NLW_U0_almost_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_ar_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_ar_overflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_ar_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_ar_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_ar_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_ar_underflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_aw_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_aw_overflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_aw_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_aw_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_aw_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_aw_underflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_b_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_b_overflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_b_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_b_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_b_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_b_underflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_r_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_r_overflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_r_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_r_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_r_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_r_underflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_w_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_w_overflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_w_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_w_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_w_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_w_underflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axis_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axis_overflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axis_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axis_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axis_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axis_underflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_m_axi_arvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_m_axi_awvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_m_axi_bready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_m_axi_rready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_m_axi_wlast_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_m_axi_wvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_m_axis_tlast_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_m_axis_tvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_rd_rst_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_arready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_awready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_bvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_rlast_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_rvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_wready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axis_tready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_underflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_wr_ack_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_wr_rst_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_ar_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_U0_axi_ar_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_U0_axi_ar_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_U0_axi_aw_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_U0_axi_aw_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_U0_axi_aw_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_U0_axi_b_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_U0_axi_b_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_U0_axi_b_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_U0_axi_r_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_axi_r_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_axi_r_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_axi_w_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_axi_w_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_axi_w_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_axis_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_axis_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_axis_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_m_axi_araddr_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_U0_m_axi_arburst_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_m_axi_arcache_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_m_axi_arid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axi_arlen_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_U0_m_axi_arlock_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axi_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_U0_m_axi_arqos_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_m_axi_arregion_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_m_axi_arsize_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_U0_m_axi_aruser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axi_awaddr_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_U0_m_axi_awburst_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_m_axi_awcache_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_m_axi_awid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axi_awlen_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_U0_m_axi_awlock_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axi_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_U0_m_axi_awqos_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_m_axi_awregion_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_m_axi_awsize_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_U0_m_axi_awuser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axi_wdata_UNCONNECTED : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal NLW_U0_m_axi_wid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axi_wstrb_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_U0_m_axi_wuser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axis_tdata_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_U0_m_axis_tdest_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axis_tid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axis_tkeep_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axis_tstrb_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axis_tuser_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal NLW_U0_s_axi_bid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_s_axi_bresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_s_axi_buser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_s_axi_rdata_UNCONNECTED : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal NLW_U0_s_axi_rid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_s_axi_rresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_s_axi_ruser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute C_ADD_NGC_CONSTRAINT : integer;
  attribute C_ADD_NGC_CONSTRAINT of U0 : label is 0;
  attribute C_APPLICATION_TYPE_AXIS : integer;
  attribute C_APPLICATION_TYPE_AXIS of U0 : label is 0;
  attribute C_APPLICATION_TYPE_RACH : integer;
  attribute C_APPLICATION_TYPE_RACH of U0 : label is 0;
  attribute C_APPLICATION_TYPE_RDCH : integer;
  attribute C_APPLICATION_TYPE_RDCH of U0 : label is 0;
  attribute C_APPLICATION_TYPE_WACH : integer;
  attribute C_APPLICATION_TYPE_WACH of U0 : label is 0;
  attribute C_APPLICATION_TYPE_WDCH : integer;
  attribute C_APPLICATION_TYPE_WDCH of U0 : label is 0;
  attribute C_APPLICATION_TYPE_WRCH : integer;
  attribute C_APPLICATION_TYPE_WRCH of U0 : label is 0;
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of U0 : label is 8;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of U0 : label is 1;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of U0 : label is 1;
  attribute C_AXIS_TKEEP_WIDTH : integer;
  attribute C_AXIS_TKEEP_WIDTH of U0 : label is 1;
  attribute C_AXIS_TSTRB_WIDTH : integer;
  attribute C_AXIS_TSTRB_WIDTH of U0 : label is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of U0 : label is 4;
  attribute C_AXIS_TYPE : integer;
  attribute C_AXIS_TYPE of U0 : label is 0;
  attribute C_AXI_ADDR_WIDTH : integer;
  attribute C_AXI_ADDR_WIDTH of U0 : label is 32;
  attribute C_AXI_ARUSER_WIDTH : integer;
  attribute C_AXI_ARUSER_WIDTH of U0 : label is 1;
  attribute C_AXI_AWUSER_WIDTH : integer;
  attribute C_AXI_AWUSER_WIDTH of U0 : label is 1;
  attribute C_AXI_BUSER_WIDTH : integer;
  attribute C_AXI_BUSER_WIDTH of U0 : label is 1;
  attribute C_AXI_DATA_WIDTH : integer;
  attribute C_AXI_DATA_WIDTH of U0 : label is 64;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of U0 : label is 1;
  attribute C_AXI_LEN_WIDTH : integer;
  attribute C_AXI_LEN_WIDTH of U0 : label is 8;
  attribute C_AXI_LOCK_WIDTH : integer;
  attribute C_AXI_LOCK_WIDTH of U0 : label is 1;
  attribute C_AXI_RUSER_WIDTH : integer;
  attribute C_AXI_RUSER_WIDTH of U0 : label is 1;
  attribute C_AXI_TYPE : integer;
  attribute C_AXI_TYPE of U0 : label is 1;
  attribute C_AXI_WUSER_WIDTH : integer;
  attribute C_AXI_WUSER_WIDTH of U0 : label is 1;
  attribute C_COMMON_CLOCK : integer;
  attribute C_COMMON_CLOCK of U0 : label is 1;
  attribute C_COUNT_TYPE : integer;
  attribute C_COUNT_TYPE of U0 : label is 0;
  attribute C_DATA_COUNT_WIDTH : integer;
  attribute C_DATA_COUNT_WIDTH of U0 : label is 9;
  attribute C_DEFAULT_VALUE : string;
  attribute C_DEFAULT_VALUE of U0 : label is "BlankString";
  attribute C_DIN_WIDTH : integer;
  attribute C_DIN_WIDTH of U0 : label is 71;
  attribute C_DIN_WIDTH_AXIS : integer;
  attribute C_DIN_WIDTH_AXIS of U0 : label is 1;
  attribute C_DIN_WIDTH_RACH : integer;
  attribute C_DIN_WIDTH_RACH of U0 : label is 32;
  attribute C_DIN_WIDTH_RDCH : integer;
  attribute C_DIN_WIDTH_RDCH of U0 : label is 64;
  attribute C_DIN_WIDTH_WACH : integer;
  attribute C_DIN_WIDTH_WACH of U0 : label is 1;
  attribute C_DIN_WIDTH_WDCH : integer;
  attribute C_DIN_WIDTH_WDCH of U0 : label is 64;
  attribute C_DIN_WIDTH_WRCH : integer;
  attribute C_DIN_WIDTH_WRCH of U0 : label is 2;
  attribute C_DOUT_RST_VAL : string;
  attribute C_DOUT_RST_VAL of U0 : label is "0";
  attribute C_DOUT_WIDTH : integer;
  attribute C_DOUT_WIDTH of U0 : label is 71;
  attribute C_ENABLE_RLOCS : integer;
  attribute C_ENABLE_RLOCS of U0 : label is 0;
  attribute C_ENABLE_RST_SYNC : integer;
  attribute C_ENABLE_RST_SYNC of U0 : label is 1;
  attribute C_EN_SAFETY_CKT : integer;
  attribute C_EN_SAFETY_CKT of U0 : label is 0;
  attribute C_ERROR_INJECTION_TYPE : integer;
  attribute C_ERROR_INJECTION_TYPE of U0 : label is 0;
  attribute C_ERROR_INJECTION_TYPE_AXIS : integer;
  attribute C_ERROR_INJECTION_TYPE_AXIS of U0 : label is 0;
  attribute C_ERROR_INJECTION_TYPE_RACH : integer;
  attribute C_ERROR_INJECTION_TYPE_RACH of U0 : label is 0;
  attribute C_ERROR_INJECTION_TYPE_RDCH : integer;
  attribute C_ERROR_INJECTION_TYPE_RDCH of U0 : label is 0;
  attribute C_ERROR_INJECTION_TYPE_WACH : integer;
  attribute C_ERROR_INJECTION_TYPE_WACH of U0 : label is 0;
  attribute C_ERROR_INJECTION_TYPE_WDCH : integer;
  attribute C_ERROR_INJECTION_TYPE_WDCH of U0 : label is 0;
  attribute C_ERROR_INJECTION_TYPE_WRCH : integer;
  attribute C_ERROR_INJECTION_TYPE_WRCH of U0 : label is 0;
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "kintex7";
  attribute C_FULL_FLAGS_RST_VAL : integer;
  attribute C_FULL_FLAGS_RST_VAL of U0 : label is 0;
  attribute C_HAS_ALMOST_EMPTY : integer;
  attribute C_HAS_ALMOST_EMPTY of U0 : label is 0;
  attribute C_HAS_ALMOST_FULL : integer;
  attribute C_HAS_ALMOST_FULL of U0 : label is 1;
  attribute C_HAS_AXIS_TDATA : integer;
  attribute C_HAS_AXIS_TDATA of U0 : label is 1;
  attribute C_HAS_AXIS_TDEST : integer;
  attribute C_HAS_AXIS_TDEST of U0 : label is 0;
  attribute C_HAS_AXIS_TID : integer;
  attribute C_HAS_AXIS_TID of U0 : label is 0;
  attribute C_HAS_AXIS_TKEEP : integer;
  attribute C_HAS_AXIS_TKEEP of U0 : label is 0;
  attribute C_HAS_AXIS_TLAST : integer;
  attribute C_HAS_AXIS_TLAST of U0 : label is 0;
  attribute C_HAS_AXIS_TREADY : integer;
  attribute C_HAS_AXIS_TREADY of U0 : label is 1;
  attribute C_HAS_AXIS_TSTRB : integer;
  attribute C_HAS_AXIS_TSTRB of U0 : label is 0;
  attribute C_HAS_AXIS_TUSER : integer;
  attribute C_HAS_AXIS_TUSER of U0 : label is 1;
  attribute C_HAS_AXI_ARUSER : integer;
  attribute C_HAS_AXI_ARUSER of U0 : label is 0;
  attribute C_HAS_AXI_AWUSER : integer;
  attribute C_HAS_AXI_AWUSER of U0 : label is 0;
  attribute C_HAS_AXI_BUSER : integer;
  attribute C_HAS_AXI_BUSER of U0 : label is 0;
  attribute C_HAS_AXI_ID : integer;
  attribute C_HAS_AXI_ID of U0 : label is 0;
  attribute C_HAS_AXI_RD_CHANNEL : integer;
  attribute C_HAS_AXI_RD_CHANNEL of U0 : label is 1;
  attribute C_HAS_AXI_RUSER : integer;
  attribute C_HAS_AXI_RUSER of U0 : label is 0;
  attribute C_HAS_AXI_WR_CHANNEL : integer;
  attribute C_HAS_AXI_WR_CHANNEL of U0 : label is 1;
  attribute C_HAS_AXI_WUSER : integer;
  attribute C_HAS_AXI_WUSER of U0 : label is 0;
  attribute C_HAS_BACKUP : integer;
  attribute C_HAS_BACKUP of U0 : label is 0;
  attribute C_HAS_DATA_COUNT : integer;
  attribute C_HAS_DATA_COUNT of U0 : label is 1;
  attribute C_HAS_DATA_COUNTS_AXIS : integer;
  attribute C_HAS_DATA_COUNTS_AXIS of U0 : label is 0;
  attribute C_HAS_DATA_COUNTS_RACH : integer;
  attribute C_HAS_DATA_COUNTS_RACH of U0 : label is 0;
  attribute C_HAS_DATA_COUNTS_RDCH : integer;
  attribute C_HAS_DATA_COUNTS_RDCH of U0 : label is 0;
  attribute C_HAS_DATA_COUNTS_WACH : integer;
  attribute C_HAS_DATA_COUNTS_WACH of U0 : label is 0;
  attribute C_HAS_DATA_COUNTS_WDCH : integer;
  attribute C_HAS_DATA_COUNTS_WDCH of U0 : label is 0;
  attribute C_HAS_DATA_COUNTS_WRCH : integer;
  attribute C_HAS_DATA_COUNTS_WRCH of U0 : label is 0;
  attribute C_HAS_INT_CLK : integer;
  attribute C_HAS_INT_CLK of U0 : label is 0;
  attribute C_HAS_MASTER_CE : integer;
  attribute C_HAS_MASTER_CE of U0 : label is 0;
  attribute C_HAS_MEMINIT_FILE : integer;
  attribute C_HAS_MEMINIT_FILE of U0 : label is 0;
  attribute C_HAS_OVERFLOW : integer;
  attribute C_HAS_OVERFLOW of U0 : label is 1;
  attribute C_HAS_PROG_FLAGS_AXIS : integer;
  attribute C_HAS_PROG_FLAGS_AXIS of U0 : label is 0;
  attribute C_HAS_PROG_FLAGS_RACH : integer;
  attribute C_HAS_PROG_FLAGS_RACH of U0 : label is 0;
  attribute C_HAS_PROG_FLAGS_RDCH : integer;
  attribute C_HAS_PROG_FLAGS_RDCH of U0 : label is 0;
  attribute C_HAS_PROG_FLAGS_WACH : integer;
  attribute C_HAS_PROG_FLAGS_WACH of U0 : label is 0;
  attribute C_HAS_PROG_FLAGS_WDCH : integer;
  attribute C_HAS_PROG_FLAGS_WDCH of U0 : label is 0;
  attribute C_HAS_PROG_FLAGS_WRCH : integer;
  attribute C_HAS_PROG_FLAGS_WRCH of U0 : label is 0;
  attribute C_HAS_RD_DATA_COUNT : integer;
  attribute C_HAS_RD_DATA_COUNT of U0 : label is 0;
  attribute C_HAS_RD_RST : integer;
  attribute C_HAS_RD_RST of U0 : label is 0;
  attribute C_HAS_RST : integer;
  attribute C_HAS_RST of U0 : label is 0;
  attribute C_HAS_SLAVE_CE : integer;
  attribute C_HAS_SLAVE_CE of U0 : label is 0;
  attribute C_HAS_SRST : integer;
  attribute C_HAS_SRST of U0 : label is 1;
  attribute C_HAS_UNDERFLOW : integer;
  attribute C_HAS_UNDERFLOW of U0 : label is 0;
  attribute C_HAS_VALID : integer;
  attribute C_HAS_VALID of U0 : label is 1;
  attribute C_HAS_WR_ACK : integer;
  attribute C_HAS_WR_ACK of U0 : label is 0;
  attribute C_HAS_WR_DATA_COUNT : integer;
  attribute C_HAS_WR_DATA_COUNT of U0 : label is 0;
  attribute C_HAS_WR_RST : integer;
  attribute C_HAS_WR_RST of U0 : label is 0;
  attribute C_IMPLEMENTATION_TYPE : integer;
  attribute C_IMPLEMENTATION_TYPE of U0 : label is 0;
  attribute C_IMPLEMENTATION_TYPE_AXIS : integer;
  attribute C_IMPLEMENTATION_TYPE_AXIS of U0 : label is 1;
  attribute C_IMPLEMENTATION_TYPE_RACH : integer;
  attribute C_IMPLEMENTATION_TYPE_RACH of U0 : label is 1;
  attribute C_IMPLEMENTATION_TYPE_RDCH : integer;
  attribute C_IMPLEMENTATION_TYPE_RDCH of U0 : label is 1;
  attribute C_IMPLEMENTATION_TYPE_WACH : integer;
  attribute C_IMPLEMENTATION_TYPE_WACH of U0 : label is 1;
  attribute C_IMPLEMENTATION_TYPE_WDCH : integer;
  attribute C_IMPLEMENTATION_TYPE_WDCH of U0 : label is 1;
  attribute C_IMPLEMENTATION_TYPE_WRCH : integer;
  attribute C_IMPLEMENTATION_TYPE_WRCH of U0 : label is 1;
  attribute C_INIT_WR_PNTR_VAL : integer;
  attribute C_INIT_WR_PNTR_VAL of U0 : label is 0;
  attribute C_INTERFACE_TYPE : integer;
  attribute C_INTERFACE_TYPE of U0 : label is 0;
  attribute C_MEMORY_TYPE : integer;
  attribute C_MEMORY_TYPE of U0 : label is 2;
  attribute C_MIF_FILE_NAME : string;
  attribute C_MIF_FILE_NAME of U0 : label is "BlankString";
  attribute C_MSGON_VAL : integer;
  attribute C_MSGON_VAL of U0 : label is 1;
  attribute C_OPTIMIZATION_MODE : integer;
  attribute C_OPTIMIZATION_MODE of U0 : label is 0;
  attribute C_OVERFLOW_LOW : integer;
  attribute C_OVERFLOW_LOW of U0 : label is 0;
  attribute C_POWER_SAVING_MODE : integer;
  attribute C_POWER_SAVING_MODE of U0 : label is 0;
  attribute C_PRELOAD_LATENCY : integer;
  attribute C_PRELOAD_LATENCY of U0 : label is 0;
  attribute C_PRELOAD_REGS : integer;
  attribute C_PRELOAD_REGS of U0 : label is 1;
  attribute C_PRIM_FIFO_TYPE : string;
  attribute C_PRIM_FIFO_TYPE of U0 : label is "512x72";
  attribute C_PRIM_FIFO_TYPE_AXIS : string;
  attribute C_PRIM_FIFO_TYPE_AXIS of U0 : label is "1kx18";
  attribute C_PRIM_FIFO_TYPE_RACH : string;
  attribute C_PRIM_FIFO_TYPE_RACH of U0 : label is "512x36";
  attribute C_PRIM_FIFO_TYPE_RDCH : string;
  attribute C_PRIM_FIFO_TYPE_RDCH of U0 : label is "1kx36";
  attribute C_PRIM_FIFO_TYPE_WACH : string;
  attribute C_PRIM_FIFO_TYPE_WACH of U0 : label is "512x36";
  attribute C_PRIM_FIFO_TYPE_WDCH : string;
  attribute C_PRIM_FIFO_TYPE_WDCH of U0 : label is "1kx36";
  attribute C_PRIM_FIFO_TYPE_WRCH : string;
  attribute C_PRIM_FIFO_TYPE_WRCH of U0 : label is "512x36";
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL of U0 : label is 4;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS of U0 : label is 1022;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH of U0 : label is 1022;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH of U0 : label is 1022;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH of U0 : label is 1022;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH of U0 : label is 1022;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH of U0 : label is 1022;
  attribute C_PROG_EMPTY_THRESH_NEGATE_VAL : integer;
  attribute C_PROG_EMPTY_THRESH_NEGATE_VAL of U0 : label is 5;
  attribute C_PROG_EMPTY_TYPE : integer;
  attribute C_PROG_EMPTY_TYPE of U0 : label is 0;
  attribute C_PROG_EMPTY_TYPE_AXIS : integer;
  attribute C_PROG_EMPTY_TYPE_AXIS of U0 : label is 0;
  attribute C_PROG_EMPTY_TYPE_RACH : integer;
  attribute C_PROG_EMPTY_TYPE_RACH of U0 : label is 0;
  attribute C_PROG_EMPTY_TYPE_RDCH : integer;
  attribute C_PROG_EMPTY_TYPE_RDCH of U0 : label is 0;
  attribute C_PROG_EMPTY_TYPE_WACH : integer;
  attribute C_PROG_EMPTY_TYPE_WACH of U0 : label is 0;
  attribute C_PROG_EMPTY_TYPE_WDCH : integer;
  attribute C_PROG_EMPTY_TYPE_WDCH of U0 : label is 0;
  attribute C_PROG_EMPTY_TYPE_WRCH : integer;
  attribute C_PROG_EMPTY_TYPE_WRCH of U0 : label is 0;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL of U0 : label is 255;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_AXIS : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_AXIS of U0 : label is 1023;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RACH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RACH of U0 : label is 1023;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RDCH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RDCH of U0 : label is 1023;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WACH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WACH of U0 : label is 1023;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WDCH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WDCH of U0 : label is 1023;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WRCH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WRCH of U0 : label is 1023;
  attribute C_PROG_FULL_THRESH_NEGATE_VAL : integer;
  attribute C_PROG_FULL_THRESH_NEGATE_VAL of U0 : label is 254;
  attribute C_PROG_FULL_TYPE : integer;
  attribute C_PROG_FULL_TYPE of U0 : label is 0;
  attribute C_PROG_FULL_TYPE_AXIS : integer;
  attribute C_PROG_FULL_TYPE_AXIS of U0 : label is 0;
  attribute C_PROG_FULL_TYPE_RACH : integer;
  attribute C_PROG_FULL_TYPE_RACH of U0 : label is 0;
  attribute C_PROG_FULL_TYPE_RDCH : integer;
  attribute C_PROG_FULL_TYPE_RDCH of U0 : label is 0;
  attribute C_PROG_FULL_TYPE_WACH : integer;
  attribute C_PROG_FULL_TYPE_WACH of U0 : label is 0;
  attribute C_PROG_FULL_TYPE_WDCH : integer;
  attribute C_PROG_FULL_TYPE_WDCH of U0 : label is 0;
  attribute C_PROG_FULL_TYPE_WRCH : integer;
  attribute C_PROG_FULL_TYPE_WRCH of U0 : label is 0;
  attribute C_RACH_TYPE : integer;
  attribute C_RACH_TYPE of U0 : label is 0;
  attribute C_RDCH_TYPE : integer;
  attribute C_RDCH_TYPE of U0 : label is 0;
  attribute C_RD_DATA_COUNT_WIDTH : integer;
  attribute C_RD_DATA_COUNT_WIDTH of U0 : label is 9;
  attribute C_RD_DEPTH : integer;
  attribute C_RD_DEPTH of U0 : label is 256;
  attribute C_RD_FREQ : integer;
  attribute C_RD_FREQ of U0 : label is 1;
  attribute C_RD_PNTR_WIDTH : integer;
  attribute C_RD_PNTR_WIDTH of U0 : label is 8;
  attribute C_REG_SLICE_MODE_AXIS : integer;
  attribute C_REG_SLICE_MODE_AXIS of U0 : label is 0;
  attribute C_REG_SLICE_MODE_RACH : integer;
  attribute C_REG_SLICE_MODE_RACH of U0 : label is 0;
  attribute C_REG_SLICE_MODE_RDCH : integer;
  attribute C_REG_SLICE_MODE_RDCH of U0 : label is 0;
  attribute C_REG_SLICE_MODE_WACH : integer;
  attribute C_REG_SLICE_MODE_WACH of U0 : label is 0;
  attribute C_REG_SLICE_MODE_WDCH : integer;
  attribute C_REG_SLICE_MODE_WDCH of U0 : label is 0;
  attribute C_REG_SLICE_MODE_WRCH : integer;
  attribute C_REG_SLICE_MODE_WRCH of U0 : label is 0;
  attribute C_SELECT_XPM : integer;
  attribute C_SELECT_XPM of U0 : label is 0;
  attribute C_SYNCHRONIZER_STAGE : integer;
  attribute C_SYNCHRONIZER_STAGE of U0 : label is 2;
  attribute C_UNDERFLOW_LOW : integer;
  attribute C_UNDERFLOW_LOW of U0 : label is 0;
  attribute C_USE_COMMON_OVERFLOW : integer;
  attribute C_USE_COMMON_OVERFLOW of U0 : label is 0;
  attribute C_USE_COMMON_UNDERFLOW : integer;
  attribute C_USE_COMMON_UNDERFLOW of U0 : label is 0;
  attribute C_USE_DEFAULT_SETTINGS : integer;
  attribute C_USE_DEFAULT_SETTINGS of U0 : label is 0;
  attribute C_USE_DOUT_RST : integer;
  attribute C_USE_DOUT_RST of U0 : label is 1;
  attribute C_USE_ECC : integer;
  attribute C_USE_ECC of U0 : label is 0;
  attribute C_USE_ECC_AXIS : integer;
  attribute C_USE_ECC_AXIS of U0 : label is 0;
  attribute C_USE_ECC_RACH : integer;
  attribute C_USE_ECC_RACH of U0 : label is 0;
  attribute C_USE_ECC_RDCH : integer;
  attribute C_USE_ECC_RDCH of U0 : label is 0;
  attribute C_USE_ECC_WACH : integer;
  attribute C_USE_ECC_WACH of U0 : label is 0;
  attribute C_USE_ECC_WDCH : integer;
  attribute C_USE_ECC_WDCH of U0 : label is 0;
  attribute C_USE_ECC_WRCH : integer;
  attribute C_USE_ECC_WRCH of U0 : label is 0;
  attribute C_USE_EMBEDDED_REG : integer;
  attribute C_USE_EMBEDDED_REG of U0 : label is 0;
  attribute C_USE_FIFO16_FLAGS : integer;
  attribute C_USE_FIFO16_FLAGS of U0 : label is 0;
  attribute C_USE_FWFT_DATA_COUNT : integer;
  attribute C_USE_FWFT_DATA_COUNT of U0 : label is 1;
  attribute C_USE_PIPELINE_REG : integer;
  attribute C_USE_PIPELINE_REG of U0 : label is 0;
  attribute C_VALID_LOW : integer;
  attribute C_VALID_LOW of U0 : label is 0;
  attribute C_WACH_TYPE : integer;
  attribute C_WACH_TYPE of U0 : label is 0;
  attribute C_WDCH_TYPE : integer;
  attribute C_WDCH_TYPE of U0 : label is 0;
  attribute C_WRCH_TYPE : integer;
  attribute C_WRCH_TYPE of U0 : label is 0;
  attribute C_WR_ACK_LOW : integer;
  attribute C_WR_ACK_LOW of U0 : label is 0;
  attribute C_WR_DATA_COUNT_WIDTH : integer;
  attribute C_WR_DATA_COUNT_WIDTH of U0 : label is 9;
  attribute C_WR_DEPTH : integer;
  attribute C_WR_DEPTH of U0 : label is 256;
  attribute C_WR_DEPTH_AXIS : integer;
  attribute C_WR_DEPTH_AXIS of U0 : label is 1024;
  attribute C_WR_DEPTH_RACH : integer;
  attribute C_WR_DEPTH_RACH of U0 : label is 16;
  attribute C_WR_DEPTH_RDCH : integer;
  attribute C_WR_DEPTH_RDCH of U0 : label is 1024;
  attribute C_WR_DEPTH_WACH : integer;
  attribute C_WR_DEPTH_WACH of U0 : label is 16;
  attribute C_WR_DEPTH_WDCH : integer;
  attribute C_WR_DEPTH_WDCH of U0 : label is 1024;
  attribute C_WR_DEPTH_WRCH : integer;
  attribute C_WR_DEPTH_WRCH of U0 : label is 16;
  attribute C_WR_FREQ : integer;
  attribute C_WR_FREQ of U0 : label is 1;
  attribute C_WR_PNTR_WIDTH : integer;
  attribute C_WR_PNTR_WIDTH of U0 : label is 8;
  attribute C_WR_PNTR_WIDTH_AXIS : integer;
  attribute C_WR_PNTR_WIDTH_AXIS of U0 : label is 10;
  attribute C_WR_PNTR_WIDTH_RACH : integer;
  attribute C_WR_PNTR_WIDTH_RACH of U0 : label is 4;
  attribute C_WR_PNTR_WIDTH_RDCH : integer;
  attribute C_WR_PNTR_WIDTH_RDCH of U0 : label is 10;
  attribute C_WR_PNTR_WIDTH_WACH : integer;
  attribute C_WR_PNTR_WIDTH_WACH of U0 : label is 4;
  attribute C_WR_PNTR_WIDTH_WDCH : integer;
  attribute C_WR_PNTR_WIDTH_WDCH of U0 : label is 10;
  attribute C_WR_PNTR_WIDTH_WRCH : integer;
  attribute C_WR_PNTR_WIDTH_WRCH of U0 : label is 4;
  attribute C_WR_RESPONSE_LATENCY : integer;
  attribute C_WR_RESPONSE_LATENCY of U0 : label is 1;
begin
U0: entity work.fwft_sfifo_w71_d256_fifo_generator_v13_1_2
     port map (
      almost_empty => NLW_U0_almost_empty_UNCONNECTED,
      almost_full => almost_full,
      axi_ar_data_count(4 downto 0) => NLW_U0_axi_ar_data_count_UNCONNECTED(4 downto 0),
      axi_ar_dbiterr => NLW_U0_axi_ar_dbiterr_UNCONNECTED,
      axi_ar_injectdbiterr => '0',
      axi_ar_injectsbiterr => '0',
      axi_ar_overflow => NLW_U0_axi_ar_overflow_UNCONNECTED,
      axi_ar_prog_empty => NLW_U0_axi_ar_prog_empty_UNCONNECTED,
      axi_ar_prog_empty_thresh(3 downto 0) => B"0000",
      axi_ar_prog_full => NLW_U0_axi_ar_prog_full_UNCONNECTED,
      axi_ar_prog_full_thresh(3 downto 0) => B"0000",
      axi_ar_rd_data_count(4 downto 0) => NLW_U0_axi_ar_rd_data_count_UNCONNECTED(4 downto 0),
      axi_ar_sbiterr => NLW_U0_axi_ar_sbiterr_UNCONNECTED,
      axi_ar_underflow => NLW_U0_axi_ar_underflow_UNCONNECTED,
      axi_ar_wr_data_count(4 downto 0) => NLW_U0_axi_ar_wr_data_count_UNCONNECTED(4 downto 0),
      axi_aw_data_count(4 downto 0) => NLW_U0_axi_aw_data_count_UNCONNECTED(4 downto 0),
      axi_aw_dbiterr => NLW_U0_axi_aw_dbiterr_UNCONNECTED,
      axi_aw_injectdbiterr => '0',
      axi_aw_injectsbiterr => '0',
      axi_aw_overflow => NLW_U0_axi_aw_overflow_UNCONNECTED,
      axi_aw_prog_empty => NLW_U0_axi_aw_prog_empty_UNCONNECTED,
      axi_aw_prog_empty_thresh(3 downto 0) => B"0000",
      axi_aw_prog_full => NLW_U0_axi_aw_prog_full_UNCONNECTED,
      axi_aw_prog_full_thresh(3 downto 0) => B"0000",
      axi_aw_rd_data_count(4 downto 0) => NLW_U0_axi_aw_rd_data_count_UNCONNECTED(4 downto 0),
      axi_aw_sbiterr => NLW_U0_axi_aw_sbiterr_UNCONNECTED,
      axi_aw_underflow => NLW_U0_axi_aw_underflow_UNCONNECTED,
      axi_aw_wr_data_count(4 downto 0) => NLW_U0_axi_aw_wr_data_count_UNCONNECTED(4 downto 0),
      axi_b_data_count(4 downto 0) => NLW_U0_axi_b_data_count_UNCONNECTED(4 downto 0),
      axi_b_dbiterr => NLW_U0_axi_b_dbiterr_UNCONNECTED,
      axi_b_injectdbiterr => '0',
      axi_b_injectsbiterr => '0',
      axi_b_overflow => NLW_U0_axi_b_overflow_UNCONNECTED,
      axi_b_prog_empty => NLW_U0_axi_b_prog_empty_UNCONNECTED,
      axi_b_prog_empty_thresh(3 downto 0) => B"0000",
      axi_b_prog_full => NLW_U0_axi_b_prog_full_UNCONNECTED,
      axi_b_prog_full_thresh(3 downto 0) => B"0000",
      axi_b_rd_data_count(4 downto 0) => NLW_U0_axi_b_rd_data_count_UNCONNECTED(4 downto 0),
      axi_b_sbiterr => NLW_U0_axi_b_sbiterr_UNCONNECTED,
      axi_b_underflow => NLW_U0_axi_b_underflow_UNCONNECTED,
      axi_b_wr_data_count(4 downto 0) => NLW_U0_axi_b_wr_data_count_UNCONNECTED(4 downto 0),
      axi_r_data_count(10 downto 0) => NLW_U0_axi_r_data_count_UNCONNECTED(10 downto 0),
      axi_r_dbiterr => NLW_U0_axi_r_dbiterr_UNCONNECTED,
      axi_r_injectdbiterr => '0',
      axi_r_injectsbiterr => '0',
      axi_r_overflow => NLW_U0_axi_r_overflow_UNCONNECTED,
      axi_r_prog_empty => NLW_U0_axi_r_prog_empty_UNCONNECTED,
      axi_r_prog_empty_thresh(9 downto 0) => B"0000000000",
      axi_r_prog_full => NLW_U0_axi_r_prog_full_UNCONNECTED,
      axi_r_prog_full_thresh(9 downto 0) => B"0000000000",
      axi_r_rd_data_count(10 downto 0) => NLW_U0_axi_r_rd_data_count_UNCONNECTED(10 downto 0),
      axi_r_sbiterr => NLW_U0_axi_r_sbiterr_UNCONNECTED,
      axi_r_underflow => NLW_U0_axi_r_underflow_UNCONNECTED,
      axi_r_wr_data_count(10 downto 0) => NLW_U0_axi_r_wr_data_count_UNCONNECTED(10 downto 0),
      axi_w_data_count(10 downto 0) => NLW_U0_axi_w_data_count_UNCONNECTED(10 downto 0),
      axi_w_dbiterr => NLW_U0_axi_w_dbiterr_UNCONNECTED,
      axi_w_injectdbiterr => '0',
      axi_w_injectsbiterr => '0',
      axi_w_overflow => NLW_U0_axi_w_overflow_UNCONNECTED,
      axi_w_prog_empty => NLW_U0_axi_w_prog_empty_UNCONNECTED,
      axi_w_prog_empty_thresh(9 downto 0) => B"0000000000",
      axi_w_prog_full => NLW_U0_axi_w_prog_full_UNCONNECTED,
      axi_w_prog_full_thresh(9 downto 0) => B"0000000000",
      axi_w_rd_data_count(10 downto 0) => NLW_U0_axi_w_rd_data_count_UNCONNECTED(10 downto 0),
      axi_w_sbiterr => NLW_U0_axi_w_sbiterr_UNCONNECTED,
      axi_w_underflow => NLW_U0_axi_w_underflow_UNCONNECTED,
      axi_w_wr_data_count(10 downto 0) => NLW_U0_axi_w_wr_data_count_UNCONNECTED(10 downto 0),
      axis_data_count(10 downto 0) => NLW_U0_axis_data_count_UNCONNECTED(10 downto 0),
      axis_dbiterr => NLW_U0_axis_dbiterr_UNCONNECTED,
      axis_injectdbiterr => '0',
      axis_injectsbiterr => '0',
      axis_overflow => NLW_U0_axis_overflow_UNCONNECTED,
      axis_prog_empty => NLW_U0_axis_prog_empty_UNCONNECTED,
      axis_prog_empty_thresh(9 downto 0) => B"0000000000",
      axis_prog_full => NLW_U0_axis_prog_full_UNCONNECTED,
      axis_prog_full_thresh(9 downto 0) => B"0000000000",
      axis_rd_data_count(10 downto 0) => NLW_U0_axis_rd_data_count_UNCONNECTED(10 downto 0),
      axis_sbiterr => NLW_U0_axis_sbiterr_UNCONNECTED,
      axis_underflow => NLW_U0_axis_underflow_UNCONNECTED,
      axis_wr_data_count(10 downto 0) => NLW_U0_axis_wr_data_count_UNCONNECTED(10 downto 0),
      backup => '0',
      backup_marker => '0',
      clk => clk,
      data_count(8 downto 0) => data_count(8 downto 0),
      dbiterr => NLW_U0_dbiterr_UNCONNECTED,
      din(70 downto 0) => din(70 downto 0),
      dout(70 downto 0) => dout(70 downto 0),
      empty => empty,
      full => full,
      injectdbiterr => '0',
      injectsbiterr => '0',
      int_clk => '0',
      m_aclk => '0',
      m_aclk_en => '0',
      m_axi_araddr(31 downto 0) => NLW_U0_m_axi_araddr_UNCONNECTED(31 downto 0),
      m_axi_arburst(1 downto 0) => NLW_U0_m_axi_arburst_UNCONNECTED(1 downto 0),
      m_axi_arcache(3 downto 0) => NLW_U0_m_axi_arcache_UNCONNECTED(3 downto 0),
      m_axi_arid(0) => NLW_U0_m_axi_arid_UNCONNECTED(0),
      m_axi_arlen(7 downto 0) => NLW_U0_m_axi_arlen_UNCONNECTED(7 downto 0),
      m_axi_arlock(0) => NLW_U0_m_axi_arlock_UNCONNECTED(0),
      m_axi_arprot(2 downto 0) => NLW_U0_m_axi_arprot_UNCONNECTED(2 downto 0),
      m_axi_arqos(3 downto 0) => NLW_U0_m_axi_arqos_UNCONNECTED(3 downto 0),
      m_axi_arready => '0',
      m_axi_arregion(3 downto 0) => NLW_U0_m_axi_arregion_UNCONNECTED(3 downto 0),
      m_axi_arsize(2 downto 0) => NLW_U0_m_axi_arsize_UNCONNECTED(2 downto 0),
      m_axi_aruser(0) => NLW_U0_m_axi_aruser_UNCONNECTED(0),
      m_axi_arvalid => NLW_U0_m_axi_arvalid_UNCONNECTED,
      m_axi_awaddr(31 downto 0) => NLW_U0_m_axi_awaddr_UNCONNECTED(31 downto 0),
      m_axi_awburst(1 downto 0) => NLW_U0_m_axi_awburst_UNCONNECTED(1 downto 0),
      m_axi_awcache(3 downto 0) => NLW_U0_m_axi_awcache_UNCONNECTED(3 downto 0),
      m_axi_awid(0) => NLW_U0_m_axi_awid_UNCONNECTED(0),
      m_axi_awlen(7 downto 0) => NLW_U0_m_axi_awlen_UNCONNECTED(7 downto 0),
      m_axi_awlock(0) => NLW_U0_m_axi_awlock_UNCONNECTED(0),
      m_axi_awprot(2 downto 0) => NLW_U0_m_axi_awprot_UNCONNECTED(2 downto 0),
      m_axi_awqos(3 downto 0) => NLW_U0_m_axi_awqos_UNCONNECTED(3 downto 0),
      m_axi_awready => '0',
      m_axi_awregion(3 downto 0) => NLW_U0_m_axi_awregion_UNCONNECTED(3 downto 0),
      m_axi_awsize(2 downto 0) => NLW_U0_m_axi_awsize_UNCONNECTED(2 downto 0),
      m_axi_awuser(0) => NLW_U0_m_axi_awuser_UNCONNECTED(0),
      m_axi_awvalid => NLW_U0_m_axi_awvalid_UNCONNECTED,
      m_axi_bid(0) => '0',
      m_axi_bready => NLW_U0_m_axi_bready_UNCONNECTED,
      m_axi_bresp(1 downto 0) => B"00",
      m_axi_buser(0) => '0',
      m_axi_bvalid => '0',
      m_axi_rdata(63 downto 0) => B"0000000000000000000000000000000000000000000000000000000000000000",
      m_axi_rid(0) => '0',
      m_axi_rlast => '0',
      m_axi_rready => NLW_U0_m_axi_rready_UNCONNECTED,
      m_axi_rresp(1 downto 0) => B"00",
      m_axi_ruser(0) => '0',
      m_axi_rvalid => '0',
      m_axi_wdata(63 downto 0) => NLW_U0_m_axi_wdata_UNCONNECTED(63 downto 0),
      m_axi_wid(0) => NLW_U0_m_axi_wid_UNCONNECTED(0),
      m_axi_wlast => NLW_U0_m_axi_wlast_UNCONNECTED,
      m_axi_wready => '0',
      m_axi_wstrb(7 downto 0) => NLW_U0_m_axi_wstrb_UNCONNECTED(7 downto 0),
      m_axi_wuser(0) => NLW_U0_m_axi_wuser_UNCONNECTED(0),
      m_axi_wvalid => NLW_U0_m_axi_wvalid_UNCONNECTED,
      m_axis_tdata(7 downto 0) => NLW_U0_m_axis_tdata_UNCONNECTED(7 downto 0),
      m_axis_tdest(0) => NLW_U0_m_axis_tdest_UNCONNECTED(0),
      m_axis_tid(0) => NLW_U0_m_axis_tid_UNCONNECTED(0),
      m_axis_tkeep(0) => NLW_U0_m_axis_tkeep_UNCONNECTED(0),
      m_axis_tlast => NLW_U0_m_axis_tlast_UNCONNECTED,
      m_axis_tready => '0',
      m_axis_tstrb(0) => NLW_U0_m_axis_tstrb_UNCONNECTED(0),
      m_axis_tuser(3 downto 0) => NLW_U0_m_axis_tuser_UNCONNECTED(3 downto 0),
      m_axis_tvalid => NLW_U0_m_axis_tvalid_UNCONNECTED,
      overflow => overflow,
      prog_empty => NLW_U0_prog_empty_UNCONNECTED,
      prog_empty_thresh(7 downto 0) => B"00000000",
      prog_empty_thresh_assert(7 downto 0) => B"00000000",
      prog_empty_thresh_negate(7 downto 0) => B"00000000",
      prog_full => NLW_U0_prog_full_UNCONNECTED,
      prog_full_thresh(7 downto 0) => B"00000000",
      prog_full_thresh_assert(7 downto 0) => B"00000000",
      prog_full_thresh_negate(7 downto 0) => B"00000000",
      rd_clk => '0',
      rd_data_count(8 downto 0) => NLW_U0_rd_data_count_UNCONNECTED(8 downto 0),
      rd_en => rd_en,
      rd_rst => '0',
      rd_rst_busy => NLW_U0_rd_rst_busy_UNCONNECTED,
      rst => '0',
      s_aclk => '0',
      s_aclk_en => '0',
      s_aresetn => '0',
      s_axi_araddr(31 downto 0) => B"00000000000000000000000000000000",
      s_axi_arburst(1 downto 0) => B"00",
      s_axi_arcache(3 downto 0) => B"0000",
      s_axi_arid(0) => '0',
      s_axi_arlen(7 downto 0) => B"00000000",
      s_axi_arlock(0) => '0',
      s_axi_arprot(2 downto 0) => B"000",
      s_axi_arqos(3 downto 0) => B"0000",
      s_axi_arready => NLW_U0_s_axi_arready_UNCONNECTED,
      s_axi_arregion(3 downto 0) => B"0000",
      s_axi_arsize(2 downto 0) => B"000",
      s_axi_aruser(0) => '0',
      s_axi_arvalid => '0',
      s_axi_awaddr(31 downto 0) => B"00000000000000000000000000000000",
      s_axi_awburst(1 downto 0) => B"00",
      s_axi_awcache(3 downto 0) => B"0000",
      s_axi_awid(0) => '0',
      s_axi_awlen(7 downto 0) => B"00000000",
      s_axi_awlock(0) => '0',
      s_axi_awprot(2 downto 0) => B"000",
      s_axi_awqos(3 downto 0) => B"0000",
      s_axi_awready => NLW_U0_s_axi_awready_UNCONNECTED,
      s_axi_awregion(3 downto 0) => B"0000",
      s_axi_awsize(2 downto 0) => B"000",
      s_axi_awuser(0) => '0',
      s_axi_awvalid => '0',
      s_axi_bid(0) => NLW_U0_s_axi_bid_UNCONNECTED(0),
      s_axi_bready => '0',
      s_axi_bresp(1 downto 0) => NLW_U0_s_axi_bresp_UNCONNECTED(1 downto 0),
      s_axi_buser(0) => NLW_U0_s_axi_buser_UNCONNECTED(0),
      s_axi_bvalid => NLW_U0_s_axi_bvalid_UNCONNECTED,
      s_axi_rdata(63 downto 0) => NLW_U0_s_axi_rdata_UNCONNECTED(63 downto 0),
      s_axi_rid(0) => NLW_U0_s_axi_rid_UNCONNECTED(0),
      s_axi_rlast => NLW_U0_s_axi_rlast_UNCONNECTED,
      s_axi_rready => '0',
      s_axi_rresp(1 downto 0) => NLW_U0_s_axi_rresp_UNCONNECTED(1 downto 0),
      s_axi_ruser(0) => NLW_U0_s_axi_ruser_UNCONNECTED(0),
      s_axi_rvalid => NLW_U0_s_axi_rvalid_UNCONNECTED,
      s_axi_wdata(63 downto 0) => B"0000000000000000000000000000000000000000000000000000000000000000",
      s_axi_wid(0) => '0',
      s_axi_wlast => '0',
      s_axi_wready => NLW_U0_s_axi_wready_UNCONNECTED,
      s_axi_wstrb(7 downto 0) => B"00000000",
      s_axi_wuser(0) => '0',
      s_axi_wvalid => '0',
      s_axis_tdata(7 downto 0) => B"00000000",
      s_axis_tdest(0) => '0',
      s_axis_tid(0) => '0',
      s_axis_tkeep(0) => '0',
      s_axis_tlast => '0',
      s_axis_tready => NLW_U0_s_axis_tready_UNCONNECTED,
      s_axis_tstrb(0) => '0',
      s_axis_tuser(3 downto 0) => B"0000",
      s_axis_tvalid => '0',
      sbiterr => NLW_U0_sbiterr_UNCONNECTED,
      sleep => '0',
      srst => srst,
      underflow => NLW_U0_underflow_UNCONNECTED,
      valid => valid,
      wr_ack => NLW_U0_wr_ack_UNCONNECTED,
      wr_clk => '0',
      wr_data_count(8 downto 0) => NLW_U0_wr_data_count_UNCONNECTED(8 downto 0),
      wr_en => wr_en,
      wr_rst => '0',
      wr_rst_busy => NLW_U0_wr_rst_busy_UNCONNECTED
    );
end STRUCTURE;
