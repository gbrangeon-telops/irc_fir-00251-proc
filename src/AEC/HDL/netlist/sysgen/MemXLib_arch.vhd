--  (c) Copyright 1999-2011 Xilinx, Inc. All rights reserved.
--
--  This file contains confidential and proprietary information
--  of Xilinx, Inc. and is protected under U.S. and
--  international copyright and other intellectual property
--  laws.
--
--  DISCLAIMER
--  This disclaimer is not a license and does not grant any
--  rights to the materials distributed herewith. Except as
--  otherwise provided in a valid license issued to you by
--  Xilinx, and to the maximum extent permitted by applicable
--  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
--  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
--  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
--  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
--  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
--  (2) Xilinx shall not be liable (whether in contract or tort,
--  including negligence, or under any other theory of
--  liability) for any loss or damage of any kind or nature
--  related to, arising under or in connection with these
--  materials, including for any direct, or any indirect,
--  special, incidental, or consequential loss or damage
--  (including loss of data, profits, goodwill, or any type of
--  loss or damage suffered as a result of any action brought
--  by a third party) even if such damage or loss was
--  reasonably foreseeable or Xilinx had been advised of the
--  possibility of the same.
--
--  CRITICAL APPLICATIONS
--  Xilinx products are not designed or intended to be fail-
--  safe, or for use in any application requiring fail-safe
--  performance, such as life-support or safety devices or
--  systems, Class III medical devices, nuclear facilities,
--  applications related to the deployment of airbags, or any
--  other applications that could lead to death, personal
--  injury, or severe property or environmental damage
--  (individually and collectively, "Critical
--  Applications"). Customer assumes the sole risk and
--  liability of any use of Xilinx products in Critical
--  Applications, subject only to applicable laws and
--  regulations governing limitations on product liability.
--
--  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
--  PART OF THIS FILE AT ALL TIMES. 
-- ************************************************************************
--
-- Filename: MemXlib_arch.vhd
--
-- Description: Architectures for behavioral and structural use in
--              Memory Xilinx library
--
--
--                  Authors: Robert Turney
--                           Paul Schumacher
--
--                  Xilinx Research Labs
--                  Xilinx, Inc.
--

--
-- $RCSfile: MemXLib_arch.vhd,v $
-- $Revision: 14388 $
-- $Date: 2014-12-03 10:17:50 -0500 (mer., 03 déc. 2014) $
--
-- Revision:
--      02/23/06  ACR  Original File. Clean up from MPEG4 xlib
--      04/26/06  CJM  Fixed dp_ram and ObjFIFO to allow writes from
--           both ports (not at the same time).
--      06/15/06  CJM  Removed dp_ram
--
-- ************************************************************************
--
-- INDEX
--
--  001 dp_ram              --  Dual-port RAM (with common clock; BlockRAM, Dist RAM, or Registers)
--  002 sp_ram              --  single-port RAM (with common clock; BlockRAM, Dist RAM, or Registers)
--  003 synch_fifo          --  Synchronous FIFO
--  004 ObjFifo             --  Synchronous Object FIFO
--  005 dp_ram_async        --  Dual-port RAM (with dual clocks; BlockRAM, Dist RAM, or Registers)
--  006 ObjFifoAsync        --  Asynchronous Object FIFO
--  007 FIFO2ObjFifo        --  Synchronous FIFO        to Object FIFO Translator
--  008 ObjFifo2FIFO        --  Synchronous Object FIFO to FIFO        Translator
--  009 async_fifo          --  Asynchronous FIFO
--
-- ************************************************************************

-- *********************************************
--
--  *001*   Dual-Port RAM Macro (with common clock)
--
-- Description: Dual-Port RAM
-- Technology: RTL
--
-- Author: Bob Turney
-- Extensive Mods: Chris Martin
-- Revision: 1.2
--
-- *********************************************
--
-- NOTE: option for the "mem_type" generic:
--
-- Value                Description
-- -----                -----------
-- registers            Registers and combinational logic
-- block_ram            Block SelectRAM plus read/write address conflict logic
-- no_rw_check          Block SelectRAM without read/write address conflict (glue) logic
-- select_ram           Distributed RAM
-- block_ram, area      Same as block_ram, but with wider, more area-efficient block RAMs
--                      instead of the default deeper block RAMs.
-- no_rw_check, area    Same as no_rw_check, but with wider, more area-efficient block
--                      SelectRAM instead of the default deeper block SelectRAMs.
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.CONV_STD_LOGIC_VECTOR;

--LIBRARY memxlib;
--USE memxlib.memxlib_utils.ALL;
library v_ccm_v6_0;
USE v_ccm_v6_0.memxlib_utils.ALL;

entity dp_ram is
    generic( input_reg     :  integer  := 0;
             dwidth        :  integer  := 32;
             mem_size      :  integer  := 256;
             mem_type      :  string   := BLOCK_RAMSTYLE;
             write_mode_a  :  string   := "WRITE_FIRST";
             write_mode_b  :  string   := "WRITE_FIRST";
             mem_init      :  mem_slv_array := (MEM_ZERO,MEM_ZERO)
    );
    port (
            da          :  in    std_logic_vector(dwidth-1 downto 0);
            db          :  in    std_logic_vector(dwidth-1 downto 0);
            addra       :  in    std_logic_vector(log_base2(mem_size-1)-1 downto 0);
            addrb       :  in    std_logic_vector(log_base2(mem_size-1)-1 downto 0);
            clk         :  in    std_logic;
            wea         :  in    std_logic; -- web removed until 2 write inputs supported
            web         :  in    std_logic; -- CJM web removed until 2 write inputs supported
            ena         :  in    std_logic := '1'; 
            enb         :  in    std_logic := '1'; 
            qa          :  out   std_logic_vector(dwidth-1 downto 0);
            qb          :  out   std_logic_vector(dwidth-1 downto 0)
    );
end dp_ram;

architecture rtl of dp_ram is

constant awidth     : integer := log_base2(mem_size-1);
type mem_array is array (mem_size-1 downto 0) of std_logic_vector (dwidth-1 downto 0);
--signal mem : mem_array;

--   function conv_slv_array(data : integer_array) return mem_array is
--     variable output: mem_array;
--   begin
--     for I in 0 to mem_size-1 loop
--         if(i <= data'high) then
--           output(i) := CONV_STD_LOGIC_VECTOR(data(i),dwidth);
--         else
--           output(i) := CONV_STD_LOGIC_VECTOR(0,dwidth);
--         end if;
--     end loop;
--   
--     return output;
--   
--   end;

   function conv_mem_array(data : mem_slv_array) return mem_array is
     variable output: mem_array;
   begin
     for I in 0 to mem_size-1 loop
         if(i <= data'high) then
           output(i) := data(i)(dwidth-1 downto 0);
         else
           output(i) := (others => '0');
         end if;
     end loop;
   
     return output;
   
   end;
   

shared variable mem : mem_array := conv_mem_array(mem_init);

signal addra_int : std_logic_vector(awidth-1 downto 0);
signal addrb_int : std_logic_vector(awidth-1 downto 0);
signal addra_int2 : std_logic_vector(awidth-1 downto 0);
signal addrb_int2 : std_logic_vector(awidth-1 downto 0);
signal da_int : std_logic_vector(dwidth-1 downto 0);
signal da_guard : std_logic_vector(dwidth-1 downto 0);
signal wea_int : std_logic;
signal db_int : std_logic_vector(dwidth-1 downto 0);
signal db_guard : std_logic_vector(dwidth-1 downto 0);
--signal d_mux : std_logic_vector(dwidth-1 downto 0); -- CJM
signal web_int : std_logic;

signal addra_guard : std_logic_vector(awidth-1 downto 0);
signal addrb_guard : std_logic_vector(awidth-1 downto 0);
constant mem_size_slv : std_logic_vector(awidth-1 downto 0) := CONV_STD_LOGIC_VECTOR(mem_size-1,awidth);
constant dead : std_logic_vector(255 downto 0) := x"deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef";
signal   t_qa, t_qb  : std_logic_vector(dwidth-1 downto 0);

attribute syn_ramstyle : string;
attribute syn_ramstyle of mem : variable is syn_mem_type(mem_type);
attribute ram_style : string;
attribute ram_style of mem : variable is mem_type;

begin

--   guard:process(addra,addrb,da,db)
--   begin
--      addra_guard <= addra;
--      addrb_guard <= addrb;
--      da_guard    <= da;
--      db_guard    <= db;
----      synopsys translate_off
--      if addra > mem_size_slv then
--         addra_guard <= (others => '0');
--         da_guard    <= dead(dwidth-1 downto 0);
----         assert false report "Address outside range on port A." severity warning;
--      end if;
--      if addrb > mem_size_slv then
--         addrb_guard <= (others => '0');
--         db_guard    <= dead(dwidth-1 downto 0);
----         assert false report "Address outside range on port B." severity warning;
--      end if;
----      synopsys translate_on
--   end process;

   GenerateDoutReadFirstA  : if (write_mode_a = "READ_FIRST") generate
      process (clk) 
      begin
      if (clk'event) and (clk = '1') then
         if (ena = '1') then
           t_qa <= mem(conv_integer(addra));
            if (wea = '1') then 
               mem(conv_integer(addra)) := da;
            end if;
         end if;
      end if;
      end process;
   end generate;      

   GenerateDoutWriteFirstA : if (write_mode_a = "WRITE_FIRST") generate
      process (clk) 
      begin
      if (rising_edge(clk)) then
         addra_int  <= addra;
         if (ena = '1') then
            if (wea = '1') then
               mem(conv_integer(addra)) := da;
               t_qa <= da;
            else
               t_qa <= mem(conv_integer(addra));
            end if;
         end if;
      end if;
      end process;
   end generate;

   GenerateDoutNoChangeA : if (write_mode_a = "NO_CHANGE") generate
      process (clk) 
      begin
      if (clk'event) and (clk = '1') then
         if (ena = '1') then
            if (wea = '1') then
               mem(conv_integer(addra)) := da;
            else
               t_qa <= mem(conv_integer(addra));
            end if;
         end if;
      end if;
      end process;
   end generate;

   GenerateDoutReadFirstB  : if (write_mode_b = "READ_FIRST") generate
      process (clk) 
      begin
      if (clk'event) and (clk = '1') then
         if (enb = '1') then 
            t_qb <= mem(conv_integer(addrb));
            if (web = '1') then
               if (mem_type /= DIST_RAMSTYLE) then
                  mem(conv_integer(addrb)) := db;
               end if;
            end if;
         end if;
      end if;
      end process;
   end generate; 
   
   GenerateDoutWriteFirstB : if (write_mode_b = "WRITE_FIRST") generate
      process (clk) 
      begin
      if (rising_edge(clk)) then
         if (enb = '1') then
            if (web = '1') then
               if (mem_type /= DIST_RAMSTYLE) then
                  mem(conv_integer(addrb)) := db;
               end if;
               t_qb <= db;
            else
               t_qb <= mem(conv_integer(addrb));
            end if;
         end if;
      end if;
      end process;
   end generate;

   GenerateDoutNoChangeB : if (write_mode_b = "NO_CHANGE") generate
      process (clk) 
      begin
      if (clk'event) and (clk = '1') then
         if (enb = '1') then
            if (web = '1') then
               if (mem_type /= DIST_RAMSTYLE) then
                  mem(conv_integer(addrb)) := db;
               end if;
            else
               t_qb <= mem(conv_integer(addrb));
            end if;
         end if;
      end if;
      end process;
   end generate;
  
----------------------------------------------------
-- Register if desired
-- Note: Name "input_regs" is a little misleading since register is at output of memory! - CW
   no_input_regs: if input_reg = 0 generate
      process (t_qa)
      begin
         qa <= t_qa;
      end process;
      process (t_qb)
      begin
         qb <= t_qb;
      end process;
  end generate;

   yes_input_regs: if input_reg = 1 generate
      process (clk)
      begin
      if (clk'event) and (clk = '1') then
         if (ena = '1') then
            qa <= t_qa;
         end if;
      end if;
      end process;
      process (clk)
      begin
      if (clk'event) and (clk = '1') then
         if (enb = '1') then
            qb <= t_qb;
         end if;
      end if;
      end process;
  end generate;

--    -- Register all Inputs to the Memory
--    yes_memory_reg: process (clk)
--    begin
--        if (clk = '1' and clk'event) then
--            addra_int <= addra_guard;
--            da_int <= da_guard;
--            wea_int <= wea;
--
--            addrb_int <= addrb_guard;
--            db_int <= db_guard;
--            web_int <= web;
--        end if;
--    end process;
--
--
--    process (wea, web, da_guard, db_guard, addra_int2, addrb_int2) begin
--      qa <= mem(CONV_INTEGER(addra_int2));  -- not register outputs
--      qb <= mem(CONV_INTEGER(addrb_int2));  -- not register outputs
--    end process;
--   
--    -- A Side
--    dpmem_access_a: process (clk) begin
--        if (clk = '1' and clk'event) then
--            addra_int2 <= addra_int; 
--            if (wea_int = '1') then
--              mem(CONV_INTEGER(addra_int)) := da_int; -- Register inputs
--            end if;
--        end if;
--    end process;
--
--    -- B Side
--    GEN_WEB1: if(mem_type /= DIST_RAMSTYLE) generate
--      dpmem_access_b: process (clk) begin
--          if (clk = '1' and clk'event) then
--              addrb_int2 <= addrb_int; 
--              if (web_int = '1') then
--                mem(CONV_INTEGER(addrb_int)) := db_int;
--              end if;
--          end if;
--      end process;
--    end generate;
--    GEN_NO_WEB1: if(mem_type = DIST_RAMSTYLE) generate
--      dpmem_access_b: process (clk) begin
--          if (clk = '1' and clk'event) then
--              addrb_int2 <= addrb_int; 
--          end if;
--      end process;
--    end generate;
--
--
--
--  end generate;

end rtl;


-- *********************************************
--
--  *002*   Single-Port RAM Macro
--
-- Description: Single-Port RAM
-- Technology: RTL
--
-- Author: Bob Turney
-- Revision: 1.0
--
-- *********************************************
--
-- NOTE: option for the "mem_type" generic:
--
-- Value                Description
-- -----                -----------
-- registers            Registers and combinational logic
-- block_ram            Block SelectRAM plus read/write address conflict logic
-- no_rw_check          Block SelectRAM without read/write address conflict (glue) logic
-- select_ram           Distributed RAM
-- block_ram, area      Same as block_ram, but with wider, more area-efficient block RAMs
--                      instead of the default deeper block RAMs.
-- no_rw_check, area    Same as no_rw_check, but with wider, more area-efficient block
--                      SelectRAM instead of the default deeper block SelectRAMs.
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--LIBRARY memxlib;
--USE memxlib.memxlib_utils.ALL;
library v_ccm_v6_0;
USE v_ccm_v6_0.memxlib_utils.ALL;

entity sp_ram is
    generic( input_reg  : integer := 1;
             dwidth     : integer := 8;
             mem_size   : integer := 256;
             mem_type   : string := BLOCK_RAMSTYLE;
             write_mode : string := "WRITE_FIRST"

    );
    port (d         : in std_logic_vector(dwidth-1 downto 0);
          addr      : in std_logic_vector(log_base2(mem_size-1)-1 downto 0);
          clk       : in std_logic;
          we        : in std_logic;
          q         : out std_logic_vector(dwidth-1 downto 0)
    );
end sp_ram;

architecture rtl of sp_ram is
constant awidth     : integer := log_base2(mem_size-1);
type mem_array is array (mem_size-1 downto 0) of std_logic_vector (dwidth-1 downto 0);
signal mem : mem_array;
signal addr_int : std_logic_vector(awidth-1 downto 0);
signal d_int : std_logic_vector(dwidth-1 downto 0);
signal we_int : std_logic;

attribute syn_ramstyle : string;
attribute syn_ramstyle of mem : signal is syn_mem_type(mem_type);
attribute ram_style : string;
attribute ram_style of mem : signal is mem_type;
begin

GenerateReadFirst : if write_mode = "READ_FIRST" generate
   no_input_regs: if input_reg = 0 generate
   no_memory_access: process (clk)
   begin
   if (clk = '1' and clk'event) then
      if (we = '1') then
         mem(CONV_INTEGER(addr)) <= d;
      end if;
      q <= mem(CONV_INTEGER(addr));
   end if;
   end process;
   end generate;
   yes_input_regs: if input_reg = 1 generate
   yes_memory_access: process (clk)
   begin
   if (clk = '1' and clk'event) then
      addr_int <= addr;
      d_int <= d;
      we_int <= we;
      if (we_int = '1') then
         mem(CONV_INTEGER(addr_int)) <= d_int;
      end if;
      q <= mem(CONV_INTEGER(addr_int));
   end if;
   end process;
   end generate;
end generate;

GenerateWriteFirst : if write_mode = "WRITE_FIRST" generate
   no_input_regs: if input_reg = 0 generate
   no_memory_access: process (clk)
   begin
   if (clk = '1' and clk'event) then
      if (we = '1') then
         mem(CONV_INTEGER(addr)) <= d;
         q <= d;
      else
         q <= mem(CONV_INTEGER(addr));
      end if;
   end if;
   end process;
   end generate;
   yes_input_regs: if input_reg = 1 generate
   yes_memory_access: process (clk)
   begin
   if (clk = '1' and clk'event) then
      addr_int <= addr;
      d_int <= d;
      we_int <= we;
      if (we_int = '1') then
         mem(CONV_INTEGER(addr_int)) <= d_int;
         q <= d_int;
      else
         q <= mem(CONV_INTEGER(addr_int));
      end if;
   end if;
   end process;
   end generate;
end generate;

GenerateNoChange : if write_mode = "NO_CHANGE" generate
   no_input_regs: if input_reg = 0 generate
   no_memory_access: process (clk)
   begin
   if (clk = '1' and clk'event) then
      if (we = '1') then
         mem(CONV_INTEGER(addr)) <= d;
      else
         q <= mem(CONV_INTEGER(addr));
      end if;
   end if;
   end process;
   end generate;
   yes_input_regs: if input_reg = 1 generate
   yes_memory_access: process (clk)
   begin
   if (clk = '1' and clk'event) then
      addr_int <= addr;
      d_int <= d;
      we_int <= we;
      if (we_int = '1') then
         mem(CONV_INTEGER(addr_int)) <= d_int;
      else
         q <= mem(CONV_INTEGER(addr_int));
      end if;
   end if;
   end process;
   end generate;
end generate;
end rtl;


-- *********************************************
--
--  *003*   Synchronous FIFO
--
-- Description: Standard synchronous FIFO
-- Technology: RTL
--
-- Author: Bob Turney
-- Revision: 1.0
--
-- *********************************************
--
-- NOTE: option for the "mem_type" generic:
--
-- Value                Description
-- -----                -----------
-- registers            Registers and combinational logic
-- block_ram            Block SelectRAM plus read/write address conflict logic
-- no_rw_check          Block SelectRAM without read/write address conflict (glue) logic
-- select_ram           Distributed RAM
-- block_ram, area      Same as block_ram, but with wider, more area-efficient block RAMs
--                      instead of the default deeper block RAMs.
-- no_rw_check, area    Same as no_rw_check, but with wider, more area-efficient block
--                      SelectRAM instead of the default deeper block SelectRAMs.
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

--library memxlib;
--use memxlib.memxlib_utils.all;
library v_ccm_v6_0;
USE v_ccm_v6_0.memxlib_utils.ALL;

entity synch_fifo is
    generic( input_reg      : integer :=   1;
             fallthru       : integer :=   0;
             dwidth         : integer :=   8;
             depth          : integer := 256; -- Will be rounded up to a power of 2
             aempty_count   : integer :=   1;
             afull_count    : integer :=   1;
             mem_type       : string := BLOCK_RAMSTYLE
    );
    port (d         : in std_logic_vector(dwidth-1 downto 0);
          clk       : in std_logic;
          re        : in std_logic;
          we        : in std_logic;
          sclr      : in std_logic;
          q         : out std_logic_vector(dwidth-1 downto 0);
          empty     : out std_logic;
          full      : out std_logic;
          aempty    : out std_logic;
          afull     : out std_logic;
          count     : out std_logic_vector(log_base2(depth-1) downto 0)
    );
end synch_fifo;

architecture rtl of synch_fifo is
constant awidth         : integer :=   log_base2(depth-1);
constant depth_pwr2     : integer :=   2**log_base2(depth-1);

type mem_array is array (depth_pwr2-1 downto 0) of std_logic_vector (dwidth-1 downto 0);
signal mem : mem_array;
signal read_addr : std_logic_vector(awidth-1 downto 0);
signal read_ptr : std_logic_vector(awidth-1 downto 0);
signal write_ptr : std_logic_vector(awidth-1 downto 0);
signal word_count : std_logic_vector(awidth downto 0);
signal depth_match : std_logic;
signal depth_vector : std_logic_vector(awidth downto 0);
signal depth_vector_minus_one : std_logic_vector(awidth downto 0);
signal depth_vector_minus_two : std_logic_vector(awidth downto 0);
signal aempty_vector : std_logic_vector(awidth downto 0);
signal afull_vector : std_logic_vector(awidth downto 0);
signal full_int : std_logic;
signal wen  : std_logic;
signal ren  : std_logic;
signal empty_int : std_logic;
signal empty_match : std_logic;
signal zero_vector: std_logic_vector(awidth downto 0);
signal one_vector: std_logic_vector(awidth downto 0);

attribute syn_ramstyle : string;
attribute syn_ramstyle of mem : signal is syn_mem_type(mem_type);
attribute ram_style : string;
attribute ram_style of mem : signal is mem_type;
begin
-- Combination logic
zero_vector <= (others => '0');
one_vector <= conv_std_logic_vector(1, awidth+1);
wen <= we and not full_int;
ren <= re and not empty_int;
count <= word_count;
depth_vector <= conv_std_logic_vector(depth_pwr2, awidth+1);
depth_vector_minus_one <= conv_std_logic_vector(depth_pwr2-1, awidth+1);
depth_vector_minus_two <= conv_std_logic_vector(depth_pwr2-2, awidth+1);
aempty_vector <= conv_std_logic_vector(aempty_count, awidth+1);
afull_vector <= conv_std_logic_vector(depth_pwr2 - afull_count, awidth+1);

-- Read address counter
read_address_proc: process(clk)
begin
    if (clk = '1' and clk'event) then
        if (sclr = '1') then
          if(fallthru = 0) then
            read_ptr <= (others => '1');
          else
            read_ptr <= (others => '0');
          end if;     
        else
            if (ren = '1') then
                read_ptr <= read_ptr + 1;
            end if;
        end if;
    end if;
end process;

-- Write address counter
write_address_proc: process(clk)
begin
    if (clk = '1' and clk'event) then
        if (sclr = '1') then
            write_ptr <= (others => '0');
        else
            if (wen = '1') then
                write_ptr <= write_ptr + 1;
            end if;
        end if;
    end if;
end process;

-- Word count process
count_proc: process(clk)
begin
    if (clk = '1' and clk'event) then
        if (sclr = '1') then
            word_count <= (others => '0');
        else if (wen ='1' and ren = '0') then
          word_count <= word_count + '1';
        else if (wen = '0' and ren = '1') then
          word_count <= word_count - '1';
          end if;
        end if;
        end if;
    end if;
end process;

-- Full flag
full_proc: process(clk)
begin
    if(clk = '1' and clk'event) then
        if (sclr = '1') then
            depth_match <= '0';
        else if (word_count = depth_vector_minus_one and re = '1') then
          depth_match <= '0';
         else if (word_count = depth_vector_minus_two and re = '0' and we = '1') then
         --2011.07.12 else if (word_count = depth_vector_minus_one and re = '0' and we = '1') then
           depth_match <= '1';
          end if;
         end if;
         end if;
    end if;
end process;
full_int <= depth_match;
full <= full_int;

-- Empty flag
empty_proc: process(clk)
begin
    if (clk = '1' and clk'event) then
        if (sclr = '1') then
           empty_match <= '1';
        else if (word_count = zero_vector and we = '1') then
           empty_match <= '0';
        else if (word_count = one_vector and re = '1' and we = '0') then
           empty_match <= '1';
           end if;
        end if;
        end if;
     end if;
end process;
empty_int <= empty_match;
empty <= empty_int;

-- "Almost" flags
almost_flags: process(word_count, aempty_vector, afull_vector)
begin
    if (word_count <= aempty_vector) then
        aempty <= '1';
    else
        aempty <= '0';
    end if;

    if (word_count >= afull_vector) then
        afull <= '1';
    else
        afull <= '0';
    end if;
end process;

-- One or two clock cycle delay for reads
no_input_reg: if (fallthru = 0) and (input_reg = 0) generate
addr_gen: process(read_ptr, ren)
begin
    if (ren = '1') then
        read_addr <= read_ptr + 1;
    else
        read_addr <= read_ptr;
    end if;
end process;
end generate;
yes_input_reg: if (input_reg = 1) or (fallthru = 1) generate
    read_addr <= read_ptr;
end generate;

-- Memory used for FIFO
--mem1 : entity memxlib.dp_ram(rtl)
mem1 : entity v_ccm_v6_0.dp_ram(rtl)
    generic map ( input_reg => 0, dwidth => dwidth, mem_size => depth_pwr2, mem_type => mem_type)
    port map (
        clk     => clk,
        da      => d,
        db      => d, --CJM Not really used
        qa      => open,
        addra   => write_ptr,
        addrb   => read_addr,
        qb      => q,
        wea     => wen,
       web    => '0', --CJM: tie low; only read from port B
       ena    => '1',
       enb    => '1'
         );

end rtl;


-- *********************************************
--
--  *004*   Synchronous Object FIFO
--
-- Description: FIFO with flags for Object control
-- Technology: RTL
--
-- Author: Adrian Chirila-Rus
-- Revision: 1.0
--
-- *********************************************
--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

--LIBRARY memxlib;
--USE memxlib.memxlib_utils.ALL;
library v_ccm_v6_0;
USE v_ccm_v6_0.memxlib_utils.ALL;

--------------------------------------------------------

entity ObjFifo_cons_ctl is
  generic(
      OBJ_SIZE         : integer := 64;
      NO_OBJS          : integer := 2
  );
  port(
    sclr : in std_logic
      ; clk : in std_logic
      ; AddrIn : in std_logic_vector (log_base2(OBJ_SIZE-1)-1 downto 0)
      ; ModeVal : in std_logic_vector (1 downto 0)
      ; ClrAckIn : in std_logic
      ; SetReqIn : in std_logic
      ; RamAddr : out std_logic_vector (log_base2(OBJ_SIZE*NO_OBJS-1)-1 downto 0)
      ; RamMode : out std_logic_vector (1 downto 0)
      ; Enab : out std_logic
      ; ClrReq : out std_logic
      ; SetAck : out std_logic
  );
end ObjFifo_cons_ctl;
--------------------------------------------------------
architecture structure of ObjFifo_cons_ctl is

  constant MEM_ADDR_BITS    : integer := log_base2(OBJ_SIZE*NO_OBJS-1);
  constant OBJ_ADDR_BITS    : integer := log_base2(OBJ_SIZE-1);
  constant NO_OBJS_BITS     : integer := log_base2(NO_OBJS);

  -- State Declaration
  signal ObjPtr_at1 : std_logic_vector (MEM_ADDR_BITS-1 downto 0);
  signal ObjPtr : std_logic_vector (MEM_ADDR_BITS-1 downto 0);
  signal ModeValReg_at1 : std_logic_vector (1 downto 0);
  signal ModeValReg : std_logic_vector (1 downto 0);
  signal ClrAck_at1 : std_logic;
  signal ClrAck : std_logic;
  signal ClrReq_reg_at1 : std_logic;
  signal ClrReq_reg : std_logic;
  signal SetAck_reg_at1 : std_logic;
  signal SetAck_reg : std_logic;
  signal SetReq_at1 : std_logic;
  signal SetReq : std_logic;
  signal Produced_at1 : std_logic_vector (NO_OBJS_BITS downto 0);
  signal Produced : std_logic_vector (NO_OBJS_BITS downto 0);
  type STATE_TYPE is (
    Execute);
  signal current_state, next_state: STATE_TYPE;

  begin
    ClrReq <= ClrReq_reg_at1;
    SetAck <= SetAck_reg_at1;
    -- Register clocking
    SYNC : process (clk, sclr)

    begin

      if (clk'event and clk = '1') then
        if (sclr = '1') then
          current_state <= Execute;
          ObjPtr_at1 <= (others => '0');
          ModeValReg_at1 <= (others => '0');
          ClrAck_at1 <= '0';
          ClrReq_reg_at1 <= '0';
          SetAck_reg_at1 <= '0';
          SetReq_at1 <= '0';
          Produced_at1 <= (others => '0');
  
        else
          -- state update
          current_state <= next_state;
          -- tick all registers
          ObjPtr_at1 <= ObjPtr;
          ModeValReg_at1 <= ModeValReg;
          ClrAck_at1 <= ClrAck;
          ClrReq_reg_at1 <= ClrReq_reg;
          SetAck_reg_at1 <= SetAck_reg;
          SetReq_at1 <= SetReq;
          Produced_at1 <= Produced;
        end if;
      end if;

    end process;

    -- SFG evaluation
    COMB : process
      ( current_state
      , AddrIn
      , ModeVal
      , ClrAckIn
      , SetReqIn
      , ObjPtr_at1
      , ModeValReg_at1
      , ClrAck_at1
      , ClrReq_reg_at1
      , SetAck_reg_at1
      , SetReq_at1
      , Produced_at1
      )

      -- intermediate variables
      variable ClrReqUpd : std_logic;
      variable NewProd : std_logic_vector (NO_OBJS_BITS downto 0);
    begin

      -- default update of all registers + outputs
      RamAddr <= (others => '0');
      ObjPtr <= ObjPtr_at1;
      ModeValReg <= ModeValReg_at1;
      RamMode <= (others => '0');
      ClrAck <= ClrAck_at1;
      ClrReq_reg <= ClrReq_reg_at1;
      SetAck_reg <= SetAck_reg_at1;
      SetReq <= SetReq_at1;
      Produced <= Produced_at1;
      Enab <= '0';

      -- default update state register
      next_state <= current_state;

      case current_state is

        when Execute =>
          --if(true) then
            RamAddr <= ObjPtr_at1 + EXT(AddrIn,MEM_ADDR_BITS);
            ModeValReg <= ModeVal;

            if ModeVal = "01" then
              RamMode <= "01";
            else
              if ModeVal = "10" then
                RamMode <= "10";
              else
                RamMode <= "00";
              end if;
            end if;

            if ModeVal = "11" then
              ClrReqUpd := '1';
            elsif ClrAck_at1 = '1' then
              ClrReqUpd := '0';
            else
              ClrReqUpd := ClrReq_reg_at1;
            end if;

            ClrReq_reg <= ClrReqUpd;
            SetAck_reg <= SetReq_at1;

            if ModeVal = "11" then
              NewProd := Produced_at1 - 1;
            else
              NewProd := Produced_at1;
            end if;

            if SetReq_at1 = '1' and SetAck_reg_at1 = '0' then
              Produced <= NewProd + 1;
            else
              Produced <= NewProd;
            end if;

            if ModeVal = "11" then
              if ObjPtr_at1 >= OBJ_SIZE*(NO_OBJS-1) then
                ObjPtr <= (others => '0');
              else
                ObjPtr <= ObjPtr_at1 + OBJ_SIZE;
              end if;
            else
              ObjPtr <= ObjPtr_at1;
            end if;

            SetReq <= SetReqIn;
            ClrAck <= ClrAckIn;

--            Enab <= (((Produced_at1 > "00") and (not ClrReqUpd)) and (not ClrAck_at1));
            if (Produced_at1 > CONV_STD_LOGIC_VECTOR(0,NO_OBJS_BITS)) and (ClrReqUpd = '0') and (ClrAck_at1 = '0') then
              Enab <= '1';
            else
              Enab <= '0';
            end if;

            next_state <= Execute;
          --end if;
        when others =>
          -- NULL
          next_state <= current_state;

      end case;

    end process;

  end structure;

--------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

--LIBRARY memxlib;
--USE memxlib.memxlib_utils.ALL;
library v_ccm_v6_0;
USE v_ccm_v6_0.memxlib_utils.ALL;

--------------------------------------------------------

entity ObjFifo_prod_ctl is
    generic(
      OBJ_SIZE         : integer := 64;
      NO_OBJS          : integer := 2
    );
    port(
      sclr : in std_logic
      ; clk : in std_logic
      ; AddrIn : in std_logic_vector (log_base2(OBJ_SIZE-1)-1 downto 0)
      ; ModeVal : in std_logic_vector (1 downto 0)
      ; ClrReqIn : in std_logic
      ; SetAckIn : in std_logic
      ; RamAddr : out std_logic_vector (log_base2(OBJ_SIZE*NO_OBJS-1)-1 downto 0)
      ; RamMode : out std_logic_vector (1 downto 0)
      ; Enab : out std_logic
      ; SetReq : out std_logic
      ; ClrAck : out std_logic
    );
end ObjFifo_prod_ctl;

--------------------------------------------------------

architecture structure of ObjFifo_prod_ctl is

  constant MEM_ADDR_BITS    : integer := log_base2(OBJ_SIZE*NO_OBJS-1);
  constant OBJ_ADDR_BITS    : integer := log_base2(OBJ_SIZE-1);
  constant NO_OBJS_BITS     : integer := log_base2(NO_OBJS);

  -- State Declaration
  signal ObjPtr_at1 : std_logic_vector (MEM_ADDR_BITS-1 downto 0);
  signal ObjPtr : std_logic_vector (MEM_ADDR_BITS-1 downto 0);
  signal ModeValReg_at1 : std_logic_vector (1 downto 0);
  signal ModeValReg : std_logic_vector (1 downto 0);
  signal SetAck_at1 : std_logic;
  signal SetAck : std_logic;
  signal SetReq_reg_at1 : std_logic;
  signal SetReq_reg : std_logic;
  signal ClrAck_reg_at1 : std_logic;
  signal ClrAck_reg : std_logic;
  signal ClrReq_at1 : std_logic;
  signal ClrReq : std_logic;
  signal Produced_at1 : std_logic_vector (NO_OBJS_BITS downto 0);
  signal Produced : std_logic_vector (NO_OBJS_BITS downto 0);
  type STATE_TYPE is (
    Execute);
  signal current_state, next_state: STATE_TYPE;

  begin
    SetReq <= SetReq_reg_at1;
    ClrAck <= ClrAck_reg_at1;
    -- Register clocking
    SYNC : process (clk, sclr)

    begin

      if (clk'event and clk = '1') then
        if (sclr = '1') then
          current_state <= Execute;
          ObjPtr_at1 <= (others => '0');
          ModeValReg_at1 <= (others => '0');
          SetAck_at1 <= '0';
          SetReq_reg_at1 <= '0';
          ClrAck_reg_at1 <= '0';
          ClrReq_at1 <= '0';
          Produced_at1 <= (others => '0');
  
        else
          -- state update
          current_state <= next_state;
          -- tick all registers
          ObjPtr_at1 <= ObjPtr;
          ModeValReg_at1 <= ModeValReg;
          SetAck_at1 <= SetAck;
          SetReq_reg_at1 <= SetReq_reg;
          ClrAck_reg_at1 <= ClrAck_reg;
          ClrReq_at1 <= ClrReq;
          Produced_at1 <= Produced;
        end if;
      end if;

    end process;

    -- SFG evaluation
    COMB : process
      ( current_state
      , AddrIn
      , ModeVal
      , ClrReqIn
      , SetAckIn
      , ObjPtr_at1
      , ModeValReg_at1
      , SetAck_at1
      , SetReq_reg_at1
      , ClrAck_reg_at1
      , ClrReq_at1
      , Produced_at1
      )

      -- intermediate variables
      variable SetReqUpd : std_logic;
      variable NewProd : std_logic_vector (NO_OBJS_BITS downto 0);
    begin

      -- default update of all registers + outputs
      RamAddr <= (others => '0');
      ObjPtr <= ObjPtr_at1;
      ModeValReg <= ModeValReg_at1;
      RamMode <= (others => '0');
      SetAck <= SetAck_at1;
      SetReq_reg <= SetReq_reg_at1;
      ClrAck_reg <= ClrAck_reg_at1;
      ClrReq <= ClrReq_at1;
      Produced <= Produced_at1;
      Enab <= '0';

      -- default update state register
      next_state <= current_state;

      case current_state is

        when Execute =>
          --if(true) then
            RamAddr <= ObjPtr_at1 +  EXT(AddrIn,MEM_ADDR_BITS);
            ModeValReg <= ModeVal;

            if ModeVal = "01" then
              RamMode <= "01";
            else
              if ModeVal = "10" then
                RamMode <= "10";
              else
                RamMode <= "00";
              end if;
            end if;

            if ModeVal = "11" then
              SetReqUpd := '1';
            elsif SetAck_at1 = '1' then
              SetReqUpd := '0';
            else
              SetReqUpd := SetReq_reg_at1;
            end if;

            SetReq_reg <= SetReqUpd;
            ClrAck_reg <= ClrReq_at1;

            if ModeVal = "11" then
              NewProd := Produced_at1 + 1;
            else
              NewProd := Produced_at1;
            end if;

            if ClrReq_at1 = '1' and ClrAck_reg_at1 = '0' then
              Produced <= NewProd - 1;
            else
              Produced <= NewProd;
            end if;

            if ModeVal = "11" then
              if ObjPtr_at1 >= OBJ_SIZE*(NO_OBJS-1) then
                ObjPtr <= (others => '0');
              else
                ObjPtr <= ObjPtr_at1 + OBJ_SIZE;
              end if;
            else
              ObjPtr <= ObjPtr_at1;
            end if;

            ClrReq <= ClrReqIn;
            SetAck <= SetAckIn;

--            Enab <= (((Produced_at1 < "10") and (not SetReqUpd)) and (not SetAck_at1));
--            if (Produced_at1 < "10") and (SetReqUpd = '0') and (SetAck_at1 = '0') then
            if (Produced_at1 < CONV_STD_LOGIC_VECTOR(NO_OBJS, NO_OBJS_BITS)) and (SetReqUpd = '0') and (SetAck_at1 = '0') then
              Enab <= '1';
            else
              Enab <= '0';
            end if;

            next_state <= Execute;
          --end if;
        when others =>
          -- NULL
          next_state <= current_state;

      end case;

    end process;

  end structure;

--------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

--LIBRARY memxlib;
--USE memxlib.memxlib_utils.ALL;
library v_ccm_v6_0;
USE v_ccm_v6_0.memxlib_utils.ALL;

entity ObjFifo is
  generic(
    DATA_BITS  : integer := 8;
    NO_OBJS    : integer := 2;
    OBJ_SIZE   : integer := 64;
    MEM_TYPE   : string := BLOCK_RAMSTYLE  -- "no_rw_check" = Block Ram, "select_ram" = Distributed RAM, "registers" = Register RAM, "no_rw_check, area" = Block Ram, area optimized
  );
  port(
    sclr : in std_logic;
    Clk    : in std_logic;

    qInputE : out std_logic;
    qInputM : in std_logic_vector (1 downto 0);
    qInputA : in std_logic_vector (log_base2(OBJ_SIZE-1)-1 downto 0);
    qInputD : in std_logic_vector (DATA_BITS-1 downto 0);
    qInputQ : out std_logic_vector (DATA_BITS-1 downto 0);

    qOutputE : out std_logic;
    qOutputM : in std_logic_vector (1 downto 0);
    qOutputA : in std_logic_vector (log_base2(OBJ_SIZE-1)-1 downto 0);
    qOutputD : in std_logic_vector (DATA_BITS-1 downto 0);
    qOutputQ : out std_logic_vector (DATA_BITS-1 downto 0)
  );
end ObjFifo;

--------------------------------------------------------

architecture structure of ObjFifo is

  constant MEM_ADDR_BITS    : integer := log_base2(OBJ_SIZE*NO_OBJS-1);
  constant OBJ_ADDR_BITS    : integer := log_base2(OBJ_SIZE-1);

  signal ObjFifo_ram_M1 : std_logic_vector (1 downto 0) ;
  signal ObjFifo_ram_A1 : std_logic_vector (MEM_ADDR_BITS-1 downto 0) ;
  signal ObjFifo_ram_M2 : std_logic_vector (1 downto 0) ;
  signal ObjFifo_ram_A2 : std_logic_vector (MEM_ADDR_BITS-1 downto 0) ;
  signal ObjFifo_ClrReq : std_logic ;
  signal ObjFifo_SetAck : std_logic ;
  signal ObjFifo_SetReq : std_logic ;
  signal ObjFifo_ClrAck : std_logic ;

  signal addra,addrb    : std_logic_vector(MEM_ADDR_BITS-1 downto 0);
  signal da,db,qa,qb    : std_logic_vector(DATA_BITS-1 downto 0);
  signal ena,enb,wea,web: std_logic;


  begin

  -- conversion of left port
  ena <= '1' when ObjFifo_ram_M1 = "01" else
         '1' when ObjFifo_ram_M1 = "10" else
         '0';

  wea <= '1' when ObjFifo_ram_M1 = "10" else
         '0';
  addra  <= ObjFifo_ram_A1;
  da  <= qInputD;
  qInputQ <= qa;

  -- conversion of right port
  enb <= '1' when ObjFifo_ram_M2 = "01" else
         '1' when ObjFifo_ram_M2 = "10" else
         '0';

  web <= '1' when ObjFifo_ram_M2 = "10" else
         '0';
  addrb  <= ObjFifo_ram_A2;
  db  <= qOutputD;
  qOutputQ <= qb;

  --memory: entity memxlib.dp_ram(rtl)
  memory: entity v_ccm_v6_0.dp_ram(rtl)
    generic map( dwidth => DATA_BITS, input_reg => 0,
                 mem_size => NO_OBJS*OBJ_SIZE, mem_type => MEM_TYPE )
    port map(
        -- Port A (copy controller)
        da => da,
        addra => addra,
        wea => wea,
        qa => qa,
        -- Port B (motion comp)
        db => db,
        addrb => addrb,
        web => web,
        qb => qb,
        clk => Clk,
        ena => '1',
        enb => '1'
        );

    --ObjFifo_prod_ctl_comp : entity memxlib.ObjFifo_prod_ctl(structure)
    ObjFifo_prod_ctl_comp : entity v_ccm_v6_0.ObjFifo_prod_ctl(structure)
      generic map(
          OBJ_SIZE       => OBJ_SIZE,
          NO_OBJS        => NO_OBJS
      )
      port map (
        sclr => sclr  
    , clk => Clk
    , AddrIn => qInputA
    , ModeVal => qInputM
    , ClrReqIn => ObjFifo_ClrReq
    , SetAckIn => ObjFifo_SetAck
    , RamAddr => ObjFifo_ram_A1
    , RamMode => ObjFifo_ram_M1
    , Enab => qInputE
    , SetReq => ObjFifo_SetReq
    , ClrAck => ObjFifo_ClrAck
    );

    --ObjFifo_cons_ctl_comp : entity memxlib.ObjFifo_cons_ctl(structure)
    ObjFifo_cons_ctl_comp : entity v_ccm_v6_0.ObjFifo_cons_ctl(structure)
      generic map(
          OBJ_SIZE       => OBJ_SIZE,
          NO_OBJS        => NO_OBJS
      )
      port map (
        sclr => sclr  
    , clk => Clk
    , AddrIn => qOutputA
    , ModeVal => qOutputM
    , ClrAckIn => ObjFifo_ClrAck
    , SetReqIn => ObjFifo_SetReq
    , RamAddr => ObjFifo_ram_A2
    , RamMode => ObjFifo_ram_M2
    , Enab => qOutputE
    , ClrReq => ObjFifo_ClrReq
    , SetAck => ObjFifo_SetAck
    );

  end structure;


-- *********************************************
--
--  *005*   Dual-Port RAM Macro (with dual clock)
--
-- Description: Dual-Port RAM
-- Technology: RTL
--
-- Author: Bob Turney
-- Revision: 1.0
--
-- *********************************************
--
-- NOTE: option for the "mem_type" generic:
--
-- Value                Description
-- -----                -----------
-- registers            Registers and combinational logic
-- block_ram            Block SelectRAM plus read/write address conflict logic
-- no_rw_check          Block SelectRAM without read/write address conflict (glue) logic
-- select_ram           Distributed RAM
-- block_ram, area      Same as block_ram, but with wider, more area-efficient block RAMs
--                      instead of the default deeper block RAMs.
-- no_rw_check, area    Same as no_rw_check, but with wider, more area-efficient block
--                      SelectRAM instead of the default deeper block SelectRAMs.
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.CONV_STD_LOGIC_VECTOR;

--LIBRARY memxlib;
--USE memxlib.memxlib_utils.ALL;
library v_ccm_v6_0;
USE v_ccm_v6_0.memxlib_utils.ALL;

--entity dp_ram_async is
--    generic( input_reg  : integer := 0;
--             dwidth     : integer := 8;
--             mem_size   : integer := 256;
--             mem_type   : string := BLOCK_RAMSTYLE
--    );
--    port (da        : in std_logic_vector(dwidth-1 downto 0);
--          db        : in std_logic_vector(dwidth-1 downto 0);  
--          addra     : in std_logic_vector(log_base2(mem_size-1)-1 downto 0);
--          addrb     : in std_logic_vector(log_base2(mem_size-1)-1 downto 0);
--          clka      : in std_logic;
--          clkb      : in std_logic;
--          wea       : in std_logic; 
--          web       : in std_logic; 
--          qa        : out std_logic_vector(dwidth-1 downto 0);
--          qb        : out std_logic_vector(dwidth-1 downto 0)
--    );
--end dp_ram_async;
--
--
--architecture rtl of dp_ram_async is
--
--constant awidth     : integer := log_base2(mem_size-1);
--type mem_array is array (mem_size-1 downto 0) of std_logic_vector (dwidth-1 downto 0);
----signal mem : mem_array;
--shared variable mem : mem_array;
--signal addra_int : std_logic_vector(awidth-1 downto 0);
--signal addrb_int : std_logic_vector(awidth-1 downto 0);
--signal addra_int2 : std_logic_vector(awidth-1 downto 0);
--signal addrb_int2 : std_logic_vector(awidth-1 downto 0);
--signal da_int : std_logic_vector(dwidth-1 downto 0);
--signal da_guard : std_logic_vector(dwidth-1 downto 0);
--signal wea_int : std_logic;
--signal db_int : std_logic_vector(dwidth-1 downto 0);
--signal db_guard : std_logic_vector(dwidth-1 downto 0);
----signal d_mux : std_logic_vector(dwidth-1 downto 0); -- CJM
--signal web_int : std_logic;
--
--signal addra_guard : std_logic_vector(awidth-1 downto 0);
--signal addrb_guard : std_logic_vector(awidth-1 downto 0);
--constant mem_size_slv : std_logic_vector(awidth-1 downto 0) := CONV_STD_LOGIC_VECTOR(mem_size-1,awidth);
--constant dead : std_logic_vector(255 downto 0) := x"deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef";
--
--attribute syn_ramstyle : string;
--attribute syn_ramstyle of mem : variable is syn_mem_type(mem_type);
--attribute ram_style : string;
--attribute ram_style of mem : variable is mem_type;
--
--begin
--
--    guard:process(addra,addrb,da,db)
--    begin
--        addra_guard <= addra;
--        addrb_guard <= addrb;
--        da_guard    <= da;
--        db_guard    <= db;
--    -- synopsys translate_off
--        if addra > mem_size_slv then
--            addra_guard <= (others => '0');
--      da_guard    <= dead(dwidth-1 downto 0);
--    --        assert false report "Address outside range on port A." severity warning;
--        end if;
--        if addrb > mem_size_slv then
--            addrb_guard <= (others => '0');
--      db_guard    <= dead(dwidth-1 downto 0);
--    --        assert false report "Address outside range on port B." severity warning;
--        end if;
--    -- synopsys translate_on
--    end process;
--
--
--  no_input_regs: if input_reg = 0 generate
--    process (wea, web, da_guard, db_guard, addra_int, addrb_int) begin
--      qa <= mem(CONV_INTEGER(addra_int));  -- register outputs
--    end process;
--
--    -- A Side
--    dpmem_access_a: process (clka) begin
--        if (clka = '1' and clka'event) then
--            addra_int <= addra_guard; -- DO NOT REMOVE: Not really used, but allows Synplify to infer a dp dw ram
--            if (wea = '1') then
--              mem(CONV_INTEGER(addra_guard)) := da_guard;
--      end if;
--            --qa <= mem(CONV_INTEGER(addra_guard));  -- register outputs
--        end if;
--    end process;
-- 
--    -- B Side
--    process (wea, web, da_guard, db_guard, addra_int, addrb_int) begin
--      qb <= mem(CONV_INTEGER(addrb_int));  -- register outputsS
--    end process;
--
--    dpmem_access_b: process (clkb) begin
--        if (clkb = '1' and clkb'event) then
--            addrb_int <= addrb_guard; -- DO NOT REMOVE: Not really used, but allows Synplify to infer a dp dw ram
--            if (web = '1') then
--              mem(CONV_INTEGER(addrb_guard)) := db_guard;
--            end if;
--            --qb <= mem(CONV_INTEGER(addrb_guard));  -- register outputs
--        end if;
--    end process;
--
--  end generate;
-- 
--  yes_input_regs: if input_reg = 1 generate
--
--    -- Register all Inputs to the Memory
--    yes_memory_reg_a: process (clka)
--    begin
--        if (clka = '1' and clka'event) then
--            addra_int <= addra_guard;
--            da_int <= da_guard;
--            wea_int <= wea;
--        end if;
--    end process;
--
--    yes_memory_reg_b: process (clkb)
--    begin
--        if (clkb = '1' and clkb'event) then
--            addrb_int <= addrb_guard;
--            db_int <= db_guard;
--            web_int <= web;
--        end if;
--    end process;
--
--
--    process (wea, web, da_guard, db_guard, addra_int2, addrb_int2) begin
--      qa <= mem(CONV_INTEGER(addra_int2));  -- not register outputs
--      qb <= mem(CONV_INTEGER(addrb_int2));  -- not register outputs
--    end process;
--   
--    -- A Side
--    dpmem_access_a: process (clka) begin
--        if (clka = '1' and clka'event) then
--            addra_int2 <= addra_int; 
--            if (wea_int = '1') then
--              mem(CONV_INTEGER(addra_int)) := da_int; -- Register inputs
--            end if;
--        end if;
--    end process;
--
--    -- B Side
--    dpmem_access_b: process (clkb) begin
--        if (clkb = '1' and clkb'event) then
--            addrb_int2 <= addrb_int; 
--            if (web_int = '1') then
--              mem(CONV_INTEGER(addrb_int)) := db_int;
--            end if;
--        end if;
--    end process;
--
--
--
--  end generate;
--
--end rtl;

entity dp_ram_async is
    generic( input_reg     :  integer  := 0;
             dwidth        :  integer  := 32;
             mem_size      :  integer  := 256;
             mem_type      :  string   := BLOCK_RAMSTYLE;
             write_mode_a  :  string   := "WRITE_FIRST";
             write_mode_b  :  string   := "WRITE_FIRST"
    );
    port (
            clka        :  in    std_logic;
            clkb        :  in    std_logic;
            da          :  in    std_logic_vector(dwidth-1 downto 0);
            db          :  in    std_logic_vector(dwidth-1 downto 0);
            addra       :  in    std_logic_vector(log_base2(mem_size-1)-1 downto 0);
            addrb       :  in    std_logic_vector(log_base2(mem_size-1)-1 downto 0);
            wea         :  in    std_logic; -- web removed until 2 write inputs supported
            web         :  in    std_logic; -- CJM web removed until 2 write inputs supported
            ena         :  in    std_logic := '1'; 
            enb         :  in    std_logic := '1'; 
            qa          :  out   std_logic_vector(dwidth-1 downto 0);
            qb          :  out   std_logic_vector(dwidth-1 downto 0)
    );
end dp_ram_async;

architecture rtl of dp_ram_async is

constant awidth     : integer := log_base2(mem_size-1);
type mem_array is array (mem_size-1 downto 0) of std_logic_vector (dwidth-1 downto 0);
--signal mem : mem_array;
shared variable mem : mem_array;

signal addra_int : std_logic_vector(awidth-1 downto 0);
signal addrb_int : std_logic_vector(awidth-1 downto 0);
signal addra_int2 : std_logic_vector(awidth-1 downto 0);
signal addrb_int2 : std_logic_vector(awidth-1 downto 0);
signal da_int : std_logic_vector(dwidth-1 downto 0);
signal da_guard : std_logic_vector(dwidth-1 downto 0);
signal wea_int : std_logic;
signal db_int : std_logic_vector(dwidth-1 downto 0);
signal db_guard : std_logic_vector(dwidth-1 downto 0);
--signal d_mux : std_logic_vector(dwidth-1 downto 0); -- CJM
signal web_int : std_logic;

signal addra_guard : std_logic_vector(awidth-1 downto 0);
signal addrb_guard : std_logic_vector(awidth-1 downto 0);
constant mem_size_slv : std_logic_vector(awidth-1 downto 0) := CONV_STD_LOGIC_VECTOR(mem_size-1,awidth);
constant dead : std_logic_vector(255 downto 0) := x"deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef";
signal   t_qa, t_qb  : std_logic_vector(dwidth-1 downto 0);

attribute syn_ramstyle : string;
attribute syn_ramstyle of mem : variable is syn_mem_type(mem_type);
attribute ram_style : string;
attribute ram_style of mem : variable is mem_type;

begin

--   guard:process(addra,addrb,da,db)
--   begin
--      addra_guard <= addra;
--      addrb_guard <= addrb;
--      da_guard    <= da;
--      db_guard    <= db;
----      synopsys translate_off
--      if addra > mem_size_slv then
--         addra_guard <= (others => '0');
--         da_guard    <= dead(dwidth-1 downto 0);
----         assert false report "Address outside range on port A." severity warning;
--      end if;
--      if addrb > mem_size_slv then
--         addrb_guard <= (others => '0');
--         db_guard    <= dead(dwidth-1 downto 0);
----         assert false report "Address outside range on port B." severity warning;
--      end if;
----      synopsys translate_on
--   end process;

   GenerateDoutReadFirstA  : if (write_mode_a = "READ_FIRST") generate
      process (clka) 
      begin
      if (clka'event) and (clka = '1') then
         if (ena = '1') then
           t_qa <= mem(conv_integer(addra));
            if (wea = '1') then 
               mem(conv_integer(addra)) := da;
            end if;
         end if;
      end if;
      end process;
   end generate;      

   GenerateDoutWriteFirstA : if (write_mode_a = "WRITE_FIRST") generate
      process (clka) 
      begin
      if (rising_edge(clka)) then
         addra_int  <= addra;
         if (ena = '1') then
            if (wea = '1') then
               mem(conv_integer(addra)) := da;
               t_qa <= da;
            else
               t_qa <= mem(conv_integer(addra));
            end if;
         end if;
      end if;
      end process;
   end generate;

   GenerateDoutNoChangeA : if (write_mode_a = "NO_CHANGE") generate
      process (clka) 
      begin
      if (clka'event) and (clka = '1') then
         if (ena = '1') then
            if (wea = '1') then
               mem(conv_integer(addra)) := da;
            else
               t_qa <= mem(conv_integer(addra));
            end if;
         end if;
      end if;
      end process;
   end generate;

   GenerateDoutReadFirstB  : if (write_mode_b = "READ_FIRST") generate
      process (clkb) 
      begin
      if (clkb'event) and (clkb = '1') then
         if (enb = '1') then 
            t_qb <= mem(conv_integer(addrb));
            if (web = '1') then
               if (mem_type /= DIST_RAMSTYLE) then
                  mem(conv_integer(addrb)) := db;
               end if;
            end if;
         end if;
      end if;
      end process;
   end generate; 
   
   GenerateDoutWriteFirstB : if (write_mode_b = "WRITE_FIRST") generate
      process (clkb) 
      begin
      if (rising_edge(clkb)) then
         if (enb = '1') then
            if (web = '1') then
               if (mem_type /= DIST_RAMSTYLE) then
                  mem(conv_integer(addrb)) := db;
               end if;
               t_qb <= db;
            else
               t_qb <= mem(conv_integer(addrb));
            end if;
         end if;
      end if;
      end process;
   end generate;

   GenerateDoutNoChangeB : if (write_mode_b = "NO_CHANGE") generate
      process (clkb) 
      begin
      if (clkb'event) and (clkb = '1') then
         if (enb = '1') then
            if (web = '1') then
               if (mem_type /= DIST_RAMSTYLE) then
                  mem(conv_integer(addrb)) := db;
               end if;
            else
               t_qb <= mem(conv_integer(addrb));
            end if;
         end if;
      end if;
      end process;
   end generate;
  
----------------------------------------------------
-- Register if desired
-- Note: Name "input_regs" is a little misleading since register is at output of memory! - CW
   no_input_regs: if input_reg = 0 generate
      process (t_qa)
      begin
         qa <= t_qa;
      end process;
      process (t_qb)
      begin
         qb <= t_qb;
      end process;
  end generate;

   yes_input_regs: if input_reg = 1 generate
      process (clka)
      begin
      if (clka'event) and (clka = '1') then
         if (ena = '1') then
            qa <= t_qa;
         end if;
      end if;
      end process;
      process (clkb)
      begin
      if (clkb'event) and (clkb = '1') then
         if (enb = '1') then
            qb <= t_qb;
         end if;
      end if;
      end process;
  end generate;

--    -- Register all Inputs to the Memory
--    yes_memory_reg: process (clk)
--    begin
--        if (clk = '1' and clk'event) then
--            addra_int <= addra_guard;
--            da_int <= da_guard;
--            wea_int <= wea;
--
--            addrb_int <= addrb_guard;
--            db_int <= db_guard;
--            web_int <= web;
--        end if;
--    end process;
--
--
--    process (wea, web, da_guard, db_guard, addra_int2, addrb_int2) begin
--      qa <= mem(CONV_INTEGER(addra_int2));  -- not register outputs
--      qb <= mem(CONV_INTEGER(addrb_int2));  -- not register outputs
--    end process;
--   
--    -- A Side
--    dpmem_access_a: process (clk) begin
--        if (clk = '1' and clk'event) then
--            addra_int2 <= addra_int; 
--            if (wea_int = '1') then
--              mem(CONV_INTEGER(addra_int)) := da_int; -- Register inputs
--            end if;
--        end if;
--    end process;
--
--    -- B Side
--    GEN_WEB1: if(mem_type /= DIST_RAMSTYLE) generate
--      dpmem_access_b: process (clk) begin
--          if (clk = '1' and clk'event) then
--              addrb_int2 <= addrb_int; 
--              if (web_int = '1') then
--                mem(CONV_INTEGER(addrb_int)) := db_int;
--              end if;
--          end if;
--      end process;
--    end generate;
--    GEN_NO_WEB1: if(mem_type = DIST_RAMSTYLE) generate
--      dpmem_access_b: process (clk) begin
--          if (clk = '1' and clk'event) then
--              addrb_int2 <= addrb_int; 
--          end if;
--      end process;
--    end generate;
--
--
--
--  end generate;

end rtl;



-- *********************************************
--
--  *006*   Asynchronous Object FIFO
--
-- Description: FIFO with flags for Object control
-- Technology: RTL
--
-- Original Author: Adrian Chirila-Rus
-- Modifications: Chris Martin
-- Revision: 1.0
--
-- *********************************************
--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

--LIBRARY memxlib;
--USE memxlib.memxlib_utils.ALL;
library v_ccm_v6_0;
USE v_ccm_v6_0.memxlib_utils.ALL;

entity ObjFifoAsync is
  generic(
    DATA_BITS  : integer := 8;
    NO_OBJS    : integer := 2;
    OBJ_SIZE   : integer := 64;
    ASYNC_CLOCK : boolean := TRUE; -- FALSE to remove metastability logic;
    MEM_TYPE   : string := BLOCK_RAMSTYLE  -- "no_rw_check" = Block Ram, "select_ram" = Distributed RAM, "registers" = Register RAM, "no_rw_check, area" = Block Ram, area optimized
  );
  port(
    sclr : in std_logic;
    Prod_Clk : in std_logic;
    Cons_Clk : in std_logic;

    Prod_E : out std_logic;
    Prod_M : in std_logic_vector (1 downto 0);
    Prod_A : in std_logic_vector (log_base2(OBJ_SIZE-1)-1 downto 0);
    Prod_D : in std_logic_vector (DATA_BITS-1 downto 0);
    Prod_Q : out std_logic_vector (DATA_BITS-1 downto 0);

    Cons_E : out std_logic;
    Cons_M : in std_logic_vector (1 downto 0);
    Cons_A : in std_logic_vector (log_base2(OBJ_SIZE-1)-1 downto 0);
    Cons_D : in std_logic_vector (DATA_BITS-1 downto 0);
    Cons_Q : out std_logic_vector (DATA_BITS-1 downto 0)
  );
end ObjFifoAsync;

--------------------------------------------------------

architecture structure of ObjFifoAsync is

  constant MEM_ADDR_BITS    : integer := log_base2(OBJ_SIZE*NO_OBJS-1);
  constant OBJ_ADDR_BITS    : integer := log_base2(OBJ_SIZE-1);

  signal ObjFifo_ram_M1 : std_logic_vector (1 downto 0) ;
  signal ObjFifo_ram_A1 : std_logic_vector (MEM_ADDR_BITS-1 downto 0) ;
  signal ObjFifo_ram_M2 : std_logic_vector (1 downto 0) ;
  signal ObjFifo_ram_A2 : std_logic_vector (MEM_ADDR_BITS-1 downto 0) ;
  signal ObjFifo_ClrReq : std_logic ;
  signal ObjFifo_SetAck : std_logic ;
  signal ObjFifo_SetReq : std_logic ;
  signal ObjFifo_ClrAck : std_logic ;

  type sync_array is array (1 downto 0) of std_logic ;
  signal ObjFifo_ClrReq_int : sync_array ;
  signal ObjFifo_SetAck_int : sync_array ;
  signal ObjFifo_SetReq_int : sync_array ;
  signal ObjFifo_ClrAck_int : sync_array ;

  signal addra,addrb    : std_logic_vector(MEM_ADDR_BITS-1 downto 0);
  signal da,qa          : std_logic_vector(DATA_BITS-1 downto 0);
  signal db,qb          : std_logic_vector(DATA_BITS-1 downto 0);
  signal ena,enb,wea,web: std_logic;

  begin

  -- conversion of left port
  ena <= '1' when ObjFifo_ram_M1 = "01" else
         '1' when ObjFifo_ram_M1 = "10" else
         '0';

  wea <= '1' when ObjFifo_ram_M1 = "10" else
         '0';
  addra  <= ObjFifo_ram_A1;
  da  <= Prod_D;
  Prod_Q <= qa;

  -- conversion of right port
  enb <= '1' when ObjFifo_ram_M2 = "01" else
         '1' when ObjFifo_ram_M2 = "10" else
         '0';

  web <= '1' when ObjFifo_ram_M2 = "10" else
         '0';
  addrb  <= ObjFifo_ram_A2;
  db  <= Cons_D;
  Cons_Q <= qb;

  --memory0: entity memxlib.dp_ram_async(rtl)
  memory0: entity v_ccm_v6_0.dp_ram_async(rtl)
    generic map( dwidth    => DATA_BITS, 
     input_reg => 0,
                 mem_size  => NO_OBJS*OBJ_SIZE, 
     mem_type  => MEM_TYPE )
    port map(
        -- Port A 
        ena   => '1',
        da    => da,
        addra => addra,
        wea   => wea,
        qa    => qa,
        clka  => Prod_Clk,
        -- Port B 
        enb   => '1',
        db    => db,
        addrb => addrb,
        web   => web,
        qb    => qb,
        clkb  => Cons_Clk
        );

    --ObjFifo_prod_ctl_comp : entity memxlib.ObjFifo_prod_ctl(structure)
    ObjFifo_prod_ctl_comp : entity v_ccm_v6_0.ObjFifo_prod_ctl(structure)
      generic map(
          OBJ_SIZE       => OBJ_SIZE,
          NO_OBJS        => NO_OBJS
      )
      port map (
        sclr => sclr 
    , clk => Prod_Clk
    , AddrIn => Prod_A
    , ModeVal => Prod_M
    , ClrReqIn => ObjFifo_ClrReq_int(ObjFifo_ClrReq_int'length-1)
    , SetAckIn => ObjFifo_SetAck_int(ObjFifo_SetAck_int'length-1)
    , RamAddr => ObjFifo_ram_A1
    , RamMode => ObjFifo_ram_M1
    , Enab => Prod_E
    , SetReq => ObjFifo_SetReq
    , ClrAck => ObjFifo_ClrAck
    );

    async_gen: if(ASYNC_CLOCK) generate 
      sync_to_cons: process (Cons_Clk)
      begin
        if(Cons_Clk'event and Cons_Clk = '1') then
          ObjFifo_SetReq_int <= ObjFifo_SetReq_int(ObjFifo_SetReq_int'length-2 downto 0) & ObjFifo_SetReq;
    ObjFifo_ClrAck_int <= ObjFifo_ClrAck_int(ObjFifo_ClrAck_int'length-2 downto 0) & ObjFifo_ClrAck;
        end if;
      end process;
  
      sync_to_prod: process (Prod_Clk)
      begin
        if(Prod_Clk'event and Prod_Clk = '1') then
      ObjFifo_ClrReq_int <= ObjFifo_ClrReq_int(ObjFifo_ClrReq_int'length-2 downto 0) & ObjFifo_ClrReq;
    ObjFifo_SetAck_int <= ObjFifo_SetAck_int(ObjFifo_SetAck_int'length-2 downto 0) & ObjFifo_SetAck;
        end if;
  
      end process;
    end generate async_gen;

    sync_gen: if(not ASYNC_CLOCK) generate 
        ObjFifo_SetReq_int(ObjFifo_SetReq_int'length-1) <= ObjFifo_SetReq;
        ObjFifo_ClrAck_int(ObjFifo_ClrAck_int'length-1) <= ObjFifo_ClrAck;
  
        ObjFifo_ClrReq_int(ObjFifo_ClrReq_int'length-1) <= ObjFifo_ClrReq;
        ObjFifo_SetAck_int(ObjFifo_SetAck_int'length-1) <= ObjFifo_SetAck;
    end generate sync_gen;
   

    --ObjFifo_cons_ctl_comp : entity memxlib.ObjFifo_cons_ctl(structure)
    ObjFifo_cons_ctl_comp : entity v_ccm_v6_0.ObjFifo_cons_ctl(structure)
      generic map(
          OBJ_SIZE       => OBJ_SIZE,
          NO_OBJS        => NO_OBJS
      )
      port map (
        sclr => sclr 
    , clk => Cons_Clk
    , AddrIn => Cons_A
    , ModeVal => Cons_M
    , ClrAckIn => ObjFifo_ClrAck_int(ObjFifo_ClrAck_int'length-1)
    , SetReqIn => ObjFifo_SetReq_int(ObjFifo_SetReq_int'length-1)
    , RamAddr => ObjFifo_ram_A2
    , RamMode => ObjFifo_ram_M2
    , Enab => Cons_E
    , ClrReq => ObjFifo_ClrReq
    , SetAck => ObjFifo_SetAck
    );

  end structure;

-- *********************************************
--
--  *007*   Synchronous FIFO to Object FIFO
--
-- Description: FIFO Input Interface to 
--              ObjFIFO Output Interface
-- Technology: RTL
--
-- Original Author: Adrian Chirila-Rus
-- Modifications: Chris Martin
-- Revision: 1.1
--
-- *********************************************
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--LIBRARY memxlib;
--USE memxlib.memxlib_utils.ALL;
library v_ccm_v6_0;
USE v_ccm_v6_0.memxlib_utils.ALL;

entity FIFO2ObjFifo is
generic (
  WORDS_IN_OBJECT : in integer := 256;
  DATA_BITS : in integer := 8
);
port (
  sclr : in std_logic;
  clk : in std_logic;
  
  -- FIFO Interface
  FIFO_empty : in std_logic;
  FIFO_read : out std_logic;
  FIFO_data_in : in std_logic_vector(DATA_BITS-1 downto 0);
  
  -- ObjFifo Interface
  ObjFifo_Enable : in std_logic;
  ObjFifo_Mode : out std_logic_vector(1 downto 0);
  ObjFifo_Address : out std_logic_vector(log_base2(WORDS_IN_OBJECT-1)-1 downto 0);
  ObjFifo_Data_In : out std_logic_vector(DATA_BITS-1 downto 0)
);
end FIFO2ObjFifo;

architecture RTL of FIFO2ObjFifo is
  constant awidth     : integer := log_base2(WORDS_IN_OBJECT-1);

  type STATE is (
    WaitForObjFifo,
    ReadFIFO,
    TransferData,
    SwitchObjFifo,
    WaitForSwitch
  );
  signal current_state : STATE;
  signal address_counter_reg : std_logic_vector(awidth downto 0);
  signal data_reg : std_logic_vector(DATA_BITS-1 downto 0);
  signal mode_reg : std_logic_vector(1 downto 0);
  signal read_reg : std_logic;
begin
  clocked:process(clk)
  begin
   if rising_edge(clk) then
    if sclr = '1' then
      address_counter_reg <= (others => '1');
      data_reg <= (others => '0');
      mode_reg <= "00";
      read_reg <= '0';
      current_state <= WaitForObjFifo;
    else
      case current_state is
      when WaitForObjFifo =>
      
        read_reg <= '0';
        mode_reg <= "00";
      
        if ObjFifo_enable = '1' then
          current_state <= ReadFIFO;
        end if;
        
      when ReadFIFO => 
      
        read_reg <= '0';
        mode_reg <= "00";
      
        if FIFO_empty = '0' then
          
          read_reg <= '1';
          
          -- prepare next address
          address_counter_reg <= address_counter_reg + 1;
          
          current_state <= TransferData;
        else 
          read_reg <= '0';
        end if;
        
      
      when TransferData =>
      
        mode_reg <= "10";
        read_reg <= '0';

        current_state <= ReadFIFO;
        
        if address_counter_reg = WORDS_IN_OBJECT-1 then
          current_state <= SwitchObjFifo;
        end if;
        
      when SwitchObjFifo =>
        mode_reg <= "11";
        current_state <= WaitForSwitch;
      when WaitForSwitch =>
        mode_reg <= "00";
        current_state <= WaitForObjFifo;
        address_counter_reg <= (others => '1');
      when others =>
        current_state <= WaitForObjFifo;
        
      end case;
    end if;
   end if;
  end process;
  
  -- outputs
  ObjFifo_Data_In <= FIFO_data_in;
  ObjFifo_Address <= address_counter_reg(awidth -1 downto 0);
  ObjFifo_Mode <= mode_reg;
  FIFO_read <= read_reg;

end RTL;

architecture RTL_fast of FIFO2ObjFifo is
  constant awidth     : integer := log_base2(WORDS_IN_OBJECT-1);

  type STATE is (
    WaitForObjFifo,
    TransferData,
    SwitchObjFifo
  );
  signal current_state : STATE;
  signal address_counter_reg : std_logic_vector(awidth downto 0);
  signal data_reg : std_logic_vector(DATA_BITS-1 downto 0);
  signal mode_reg : std_logic_vector(1 downto 0);
  signal read_reg : std_logic;
begin
  clocked:process(clk)
  begin
   if rising_edge(clk) then
    if sclr = '1' then
      address_counter_reg <= (others => '0');
      data_reg <= (others => '0');
      mode_reg <= "00";
      read_reg <= '0';
      current_state <= WaitForObjFifo;
    else
     
     -- defaut values
     read_reg <= '0';
     mode_reg <= "00"; --nop
    
      case current_state is
      when WaitForObjFifo =>
      
        if ObjFifo_enable = '1' then
          current_state <= TransferData;
        end if;
        
      when TransferData =>
 
        if FIFO_empty = '0' then
          read_reg <= '1';
        end if;
        
        if read_reg = '1' and FIFO_empty = '0' then
          mode_reg <= "10"; -- write
        end if;
        
        if mode_reg = "10" then
          address_counter_reg <= address_counter_reg + 1;
        end if;
        
        if address_counter_reg = WORDS_IN_OBJECT-2 then
          read_reg <= '0';
        end if;
        
        if address_counter_reg = WORDS_IN_OBJECT-1 then
          read_reg <= '0';
          mode_reg <= "11"; -- switch
          current_state <= SwitchObjFifo;
        end if;
        
      when SwitchObjFifo =>
      
        address_counter_reg <= (others => '0');
      
        current_state <= WaitForObjFifo;
        
      when others =>
        current_state <= WaitForObjFifo;
      end case;
    end if;
   end if;
  end process;
  
  -- outputs
  ObjFifo_Data_In <= FIFO_data_in;
  ObjFifo_Address <= address_counter_reg(awidth -1 downto 0);
  ObjFifo_Mode <= mode_reg;
  FIFO_read <= read_reg;
  
  
end RTL_fast;
-- *********************************************
--
--  *008*   Synchronous Object FIFO to FIFO
--
-- Description: ObjFIFO Input Interface to 
--              FIFO Output Interface
-- Technology: RTL
--
-- Original Author: Adrian Chirila-Rus
-- Modifications: Chris Martin
-- Revision: 1.0
--
-- *********************************************
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--LIBRARY memxlib;
--USE memxlib.memxlib_utils.ALL;
library v_ccm_v6_0;
USE v_ccm_v6_0.memxlib_utils.ALL;

entity ObjFifo2FIFO is
   generic(
     WORDS_IN_OBJECT      : in integer := 256;
     DATA_BITS            : in integer := 8
   );
   port (
         sclr             : in std_logic;
         clk              : in std_logic;
         -- Interface FIFO
         FIFO_afull       : in std_logic;
         FIFO_write       : out std_logic;
         FIFO_data        : out std_logic_vector(DATA_BITS-1 downto 0);
         -- Interface ObjFIFO
         ObjFifo_Enable   : in std_logic;
         ObjFifo_Mode     : out std_logic_vector(1 downto 0);
         ObjFifo_Address  : out std_logic_vector(log_base2(WORDS_IN_OBJECT-1)-1 downto 0);
         ObjFifo_Data     : in std_logic_vector(DATA_BITS-1 downto 0)
        );
end ObjFifo2FIFO;

architecture RTL of ObjFifo2FIFO is
  constant awidth     : integer := log_base2(WORDS_IN_OBJECT-1);

  type STATE is (
      WaitForObjFifo,
      ReadData,
      TransferData,
      doWrite,
      SwitchObjFifo,
      WaitForSwitch
  );
  signal current_state : STATE;
  
  signal FIFO_write_reg       : std_logic;
  signal ObjFifo_Mode_reg     : std_logic_vector(1 downto 0);
  signal ObjFifo_Address_reg  : std_logic_vector(awidth downto 0);

begin
  clocked_process:process(clk)
  begin
   if rising_edge(clk) then
    if sclr = '1' then
      FIFO_write_reg      <= '0';
      ObjFifo_Mode_reg    <= (others => '0');
      ObjFifo_Address_reg <= (others => '0');
      current_state <= WaitForObjFifo;
    else
      
      case current_state is
        when WaitForObjFifo =>
        
          ObjFifo_Mode_reg <= "00";
          FIFO_write_reg <= '0';
          
          if ObjFifo_Enable = '1' then
            ObjFifo_Address_reg <= (others => '0');
            current_state <= ReadData;
          end if;
          
        when ReadData => 
        
          FIFO_write_reg <= '0';
        
          if FIFO_afull = '0' then
            ObjFifo_Mode_reg <= "01";
            current_state <= TransferData;
          end if;
        
        when TransferData =>
        
          FIFO_write_reg <= '1';
          ObjFifo_Mode_reg <= "00";
          
          ObjFifo_Address_reg <= ObjFifo_Address_reg + 1;
          
          if ObjFifo_Address_reg = WORDS_IN_OBJECT - 1 then
            current_state <= SwitchObjFifo;
          else
            current_state <= doWrite;
          end if;
          
        when doWrite =>

          FIFO_write_reg <= '0';
          ObjFifo_Mode_reg <= "00";
          current_state <= ReadData;
        
        when SwitchObjFifo =>
          FIFO_write_reg <= '0';
          ObjFifo_Mode_reg <= "11";
          current_state <= WaitForSwitch;
        
        when WaitForSwitch =>
          FIFO_write_reg <= '0';
          ObjFifo_Mode_reg <= "00";
          current_state <= WaitForObjFifo;
        
        when others =>
          current_state <= WaitForObjFifo;
            
      end case;
      
    end if;
   end if;
  end process;
  
  -- put outputs
  FIFO_write       <= FIFO_write_reg;
  FIFO_data        <= ObjFifo_Data;
  ObjFifo_Mode     <= ObjFifo_Mode_reg;
  ObjFifo_Address  <= ObjFifo_Address_reg(awidth-1 downto 0);

end RTL;

architecture RTL_fast of ObjFifo2FIFO is
  constant awidth     : integer := log_base2(WORDS_IN_OBJECT-1);

  type STATE is (
      WaitForObjFifo,
      TransferData,
      SwitchObjFifo
  );
  signal current_state : STATE;
  
  signal FIFO_write_reg       : std_logic;
  signal ObjFifo_Mode_reg     : std_logic_vector(1 downto 0);
  signal ObjFifo_Address_reg  : std_logic_vector(awidth-1 downto 0);
  signal ObjFifo_Address_reg_reg : std_logic_vector(awidth-1 downto 0);

begin
  clocked_process:process(clk)
  begin
   if rising_edge(clk) then
    if sclr = '1' then
      FIFO_write_reg      <= '0';
      ObjFifo_Mode_reg    <= (others => '0');
      ObjFifo_Address_reg <= (others => '0');
      ObjFifo_Address_reg_reg <= (others => '0');
      current_state <= WaitForObjFifo;
    else
      
      ObjFifo_Address_reg_reg <= ObjFifo_Address_reg;
      
      case current_state is
        when WaitForObjFifo =>
          -- Reset address
          ObjFifo_Address_reg <= (others => '0');
          -- Check if an object is available
          if ObjFifo_Enable = '1' and FIFO_afull = '0' then
            current_state <= TransferData;
            ObjFifo_Mode_reg <= "01"; -- read
          end if;
          
        when TransferData =>
          -- do the transfer
          FIFO_write_reg <= '1';
          ObjFifo_Address_reg <= ObjFifo_Address_reg + 1;
          
          if ObjFifo_Address_reg = WORDS_IN_OBJECT-1 then
            ObjFifo_Mode_reg <= "11"; -- switch
            current_state <= SwitchObjFifo;
          end if;
          
        when SwitchObjFifo =>
          FIFO_write_reg <= '0'; 
          ObjFifo_Mode_reg <= "00"; -- idle
          ObjFifo_Address_reg <= (others => '0');
          current_state <= WaitForObjFifo;
          
        when others =>
          current_state <= WaitForObjFifo;
      end case;
    end if;
   end if;
  end process;
  
  -- put outputs
  FIFO_write       <= FIFO_write_reg;
  FIFO_data        <= ObjFifo_Data;
  ObjFifo_Mode     <= ObjFifo_Mode_reg;
  ObjFifo_Address  <= ObjFifo_Address_reg;
  
end RTL_fast;


-- *********************************************
--
--  *009*   Asynchronous FIFO
--
-- Description: Standard asynchronous FIFO
-- Technology: RTL
--
-- Original Author: Bob Turney
-- Modifications: Chris Martin
-- Revision: 1.1
--
-- *********************************************
--
-- NOTE: option for the "mem_type" generic:
--
-- Value                Description
-- -----                -----------
-- registers            Registers and combinational logic
-- block_ram            Block SelectRAM plus read/write address conflict logic
-- no_rw_check          Block SelectRAM without read/write address conflict (glue) logic
-- select_ram           Distributed RAM
-- block_ram, area      Same as block_ram, but with wider, more area-efficient block RAMs
--                      instead of the default deeper block RAMs.
-- no_rw_check, area    Same as no_rw_check, but with wider, more area-efficient block
--                      SelectRAM instead of the default deeper block SelectRAMs.
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

--library memxlib;
--use memxlib.memxlib_utils.all;
library v_ccm_v6_0;
use v_ccm_v6_0.memxlib_utils.all;

entity async_fifo is
    generic( input_reg      : integer :=   1;
             dwidth         : integer :=   8;
             depth          : integer := 256; -- Will be rounded up to a power of 2
             aempty_count   : integer :=   1;
             afull_count    : integer :=   1;
             mem_type       : string := BLOCK_RAMSTYLE
    );
    port (
          clk_wr    : in std_logic;
          clk_rd    : in std_logic;
          sclr      : in std_logic;
          d         : in std_logic_vector(dwidth-1 downto 0);
          re        : in std_logic;
          we        : in std_logic;
          q         : out std_logic_vector(dwidth-1 downto 0);
          empty     : out std_logic;
          full      : out std_logic;
          aempty    : out std_logic;
          afull     : out std_logic;
          count     : out std_logic_vector(log_base2(depth-1) downto 0)
    );
end async_fifo;

architecture rtl of async_fifo is
constant awidth         : integer :=   log_base2(depth-1);
constant depth_pwr2     : integer :=   2**log_base2(depth-1);

signal read_addr : std_logic_vector(awidth downto 0);
signal read_ptr_cmp : std_logic_vector(awidth downto 0);
signal read_ptr : std_logic_vector(awidth downto 0);
signal read_ptr_int : std_logic_vector(awidth downto 0);
signal write_ptr : std_logic_vector(awidth downto 0);
signal write_ptr_int : std_logic_vector(awidth downto 0);
signal gray_read_ptr            : std_logic_vector(awidth downto 0);
signal gray_write_ptr           : std_logic_vector(awidth downto 0);

signal gray_read_ptr_int        : std_logic_vector(awidth downto 0);
signal gray_write_ptr_int       : std_logic_vector(awidth downto 0);

type sync_array is array (1 downto 0) of std_logic_vector(awidth downto 0) ;
signal gray_read_ptr_s2w        : sync_array;
signal gray_write_ptr_s2r       : sync_array;

signal read_ptr_s2w            : std_logic_vector(awidth downto 0);
signal write_ptr_s2r           : std_logic_vector(awidth downto 0);

signal depth_match : std_logic;
signal depth_vector : std_logic_vector(awidth downto 0);
signal depth_vector_minus_one : std_logic_vector(awidth downto 0);
signal depth_vector_minus_two : std_logic_vector(awidth downto 0);
signal aempty_vector : std_logic_vector(awidth downto 0);
signal afull_vector : std_logic_vector(awidth downto 0);
signal full_int : std_logic;
signal wen  : std_logic;
signal ren  : std_logic;
signal empty_int : std_logic;
signal zero_vector: std_logic_vector(awidth downto 0);
signal one_vector: std_logic_vector(awidth downto 0);

begin
-- Combination logic
zero_vector <= (others => '0');
one_vector <= conv_std_logic_vector(1, awidth+1);
wen <= we and not full_int;
ren <= re and not empty_int;
--count <= word_count; -- Calculated differently below
depth_vector <= conv_std_logic_vector(depth_pwr2, awidth+1);
depth_vector_minus_one <= conv_std_logic_vector(depth_pwr2-1, awidth+1);
depth_vector_minus_two <= conv_std_logic_vector(depth_pwr2-2, awidth+1);
aempty_vector <= conv_std_logic_vector(aempty_count, awidth+1);
afull_vector <= conv_std_logic_vector(depth_pwr2 - afull_count, awidth+1);

-- Read address counter
read_ptr <= read_ptr_int + ren;
gray_read_ptr <= read_ptr xor ('0' & read_ptr(awidth downto 1));

read_address_proc: process(clk_rd)
begin
    if (clk_rd = '1' and clk_rd'event) then
        if (sclr = '1') then
            read_ptr_int <= (others => '0'); 
            gray_read_ptr_int <= (others => '0');
        else
            --if (ren = '1') then
                read_ptr_int <= read_ptr;
                gray_read_ptr_int <= gray_read_ptr;
            --end if;
        end if;
    end if;
end process;

-- Write address counter
write_ptr <= write_ptr_int + wen;
gray_write_ptr <= write_ptr xor ('0' & write_ptr(awidth downto 1));

write_address_proc: process(clk_wr)
begin
    if (clk_wr = '1' and clk_wr'event) then
        if (sclr = '1') then
            write_ptr_int <= (others => '0');
            gray_write_ptr_int <= (others => '0');
        else
            --if (wen = '1') then
                write_ptr_int <= write_ptr;
                gray_write_ptr_int <= gray_write_ptr;
            --end if;
        end if;
    end if;
end process;

-- Sync write pointer to read clock domain
  write_address_sync: process(clk_rd)
  begin
    if(clk_rd = '1' and clk_rd'event) then
      gray_write_ptr_s2r <= gray_write_ptr_s2r(gray_write_ptr_s2r'length-2 downto 0) & gray_write_ptr_int;
    end if;
  end process;


-- Sync read pointer to write clock domain
  read_address_sync: process(clk_wr)
  begin
    if(clk_wr = '1' and clk_wr'event) then
      gray_read_ptr_s2w <= gray_read_ptr_s2w(gray_read_ptr_s2w'length-2 downto 0) & gray_read_ptr_int;
    end if;
  end process;


-- Full flag
read_ptr_cmp <= 
                  not gray_read_ptr_s2w(gray_read_ptr_s2w'length-1)(awidth)
                & not gray_read_ptr_s2w(gray_read_ptr_s2w'length-1)(awidth-1)
                & gray_read_ptr_s2w(gray_read_ptr_s2w'length-1)(awidth-2 downto 0);

full_proc: process(clk_wr)
begin
    if(clk_wr = '1' and clk_wr'event) then
        if (sclr = '1') then
            full_int <= '0';
        elsif (gray_write_ptr = read_ptr_cmp) then
          full_int <= '1';
        else
          full_int <= '0';
        end if;
    end if;
end process;
full <= full_int;

-- Empty flag
empty_proc: process(clk_rd)
begin
    if (clk_rd = '1' and clk_rd'event) then
        if (sclr = '1') then
           empty_int <= '1';
        elsif (gray_read_ptr = gray_write_ptr_s2r(gray_write_ptr_s2r'length-1)) then
           empty_int <= '1';
        else
           empty_int <= '0';
        end if;
    end if;
end process;
empty <= empty_int;

-- "Almost" flags
--read_ptr_s2w <= gray_read_ptr_s2w(gray_read_ptr_s2w'length-1) xor ('0' & gray_read_ptr_s2w(gray_read_ptr_s2w'length-1)(awidth-1 downto 0));
        read_ptr_s2w(read_ptr_s2w'length-1) <= gray_read_ptr_s2w(gray_read_ptr_s2w'length-1)(awidth);
        GRAY2BIN_GEN0: for i in awidth-1 downto 0 generate
          read_ptr_s2w(i) <= gray_read_ptr_s2w(gray_read_ptr_s2w'length-1)(i) xor read_ptr_s2w(i+1);
        end generate GRAY2BIN_GEN0;

almost_full: process(read_ptr_s2w, write_ptr, afull_vector)
begin
    if (    (write_ptr(awidth) = read_ptr_s2w(awidth)) 
        and (write_ptr - read_ptr_s2w) >= afull_vector) then
        afull <= '1';
    elsif ( (write_ptr(awidth) = '1')
        and (read_ptr_s2w(awidth) = '0') 
        and (write_ptr - read_ptr_s2w) >= afull_vector) then
        afull <= '1';
    elsif ( (write_ptr(awidth) = '0')
        and (read_ptr_s2w(awidth) = '1') 
        and (('1' & write_ptr(awidth-1 downto 0)) - ('0' & read_ptr_s2w(awidth - 1 downto 0)) >= afull_vector)) then 
        afull <= '1';
    else
        afull <= '0';
    end if;
end process;

--write_ptr_s2r <= gray_write_ptr_s2r(gray_write_ptr_s2r'length-1) xor ('0' & gray_write_ptr_s2r(gray_write_ptr_s2r'length-1)(awidth-1 downto 0));
        write_ptr_s2r(write_ptr_s2r'length-1) <= gray_write_ptr_s2r(gray_write_ptr_s2r'length-1)(awidth);
        GRAY2BIN_GEN1: for i in awidth-1 downto 0 generate
          write_ptr_s2r(i) <= gray_write_ptr_s2r(gray_write_ptr_s2r'length-1)(i) xor write_ptr_s2r(i+1);
        end generate GRAY2BIN_GEN1;

almost_empty: process(write_ptr_s2r, read_ptr, aempty_vector)
begin
    count <= write_ptr_s2r - read_ptr;
    if (    (write_ptr_s2r(awidth) = read_ptr(awidth)) 
        and (write_ptr_s2r - read_ptr) <= aempty_vector) then
        aempty <= '1';
    elsif ( (write_ptr_s2r(awidth) = '1')
        and (read_ptr(awidth) = '0') 
        and (write_ptr_s2r - read_ptr) <= aempty_vector) then
        aempty <= '1';
    elsif ( (write_ptr_s2r(awidth) = '0')
        and (read_ptr(awidth) = '1') 
        and (('1' & write_ptr_s2r(awidth-1 downto 0)) - ('0' & read_ptr(awidth - 1 downto 0)) <= aempty_vector)) then
        aempty <= '1';
        count <= ('1' & write_ptr_s2r(awidth-1 downto 0)) - ('0' & read_ptr(awidth - 1 downto 0));

    else
        aempty <= '0';
    end if;

end process;
--count <= (write_ptr_s2r - read_ptr);

-- One or two clock cycle delay for reads
no_input_reg: if input_reg = 0 generate
addr_gen: process(read_ptr_int, ren)
begin
    if (ren = '1') then
        read_addr <= read_ptr_int + 1;
    else
        read_addr <= read_ptr_int;
    end if;
end process;
end generate;
yes_input_reg: if input_reg = 1 generate
    read_addr <= read_ptr_int;
end generate;

-- Memory used for FIFO
--mem1 : entity memxlib.dp_ram_async(rtl)
mem1 : entity v_ccm_v6_0.dp_ram_async(rtl)
    generic map ( input_reg => 0, dwidth => dwidth, mem_size => depth_pwr2, mem_type => mem_type)
    port map (
        ena     => '1',
        clka    => clk_wr,
        addra   => write_ptr_int(awidth-1 downto 0),
        da      => d,
        wea     => wen,
        qa      => open,

        enb     => '1',
        clkb    => clk_rd,
        addrb   => read_addr(awidth-1 downto 0),
        db      => d, --CJM Not really used
        qb      => q,
  web    => '0' --CJM: tie low; only read from port B
         );

end rtl;





-- *********************************************
--
--  *010*   synchronous FIFO 1st-word data fallthru
--
-- Description: Standard asynchronous FIFO
-- Technology: RTL
--
-- Original Author: Bob Turney
-- Modifications: Chris Martin
-- Revision: 1.1
--
-- *********************************************
--
-- NOTE: option for the "mem_type" generic:
--
-- Value                Description
-- -----                -----------
-- registers            Registers and combinational logic
-- block_ram            Block SelectRAM plus read/write address conflict logic
-- no_rw_check          Block SelectRAM without read/write address conflict (glue) logic
-- select_ram           Distributed RAM
-- block_ram, area      Same as block_ram, but with wider, more area-efficient block RAMs
--                      instead of the default deeper block RAMs.
-- no_rw_check, area    Same as no_rw_check, but with wider, more area-efficient block
--                      SelectRAM instead of the default deeper block SelectRAMs.
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

library v_ccm_v6_0;
use v_ccm_v6_0.memxlib_utils.all;

entity synch_fifo_fallthru is
    generic( input_reg      : integer :=   0;
             dwidth         : integer :=  32;
             depth          : integer := 4; -- Will be rounded up to a power of 2
             aempty_count   : integer :=   1;
             afull_count    : integer :=   1;
             mem_type       : string := "registers"
    );
    port (
          clk       : in std_logic;
          sclr      : in std_logic;
          d         : in std_logic_vector(dwidth-1 downto 0);
          re        : in std_logic;
          we        : in std_logic;
          q         : out std_logic_vector(dwidth-1 downto 0);
          empty     : out std_logic;
          full      : out std_logic;
          aempty    : out std_logic;
          afull     : out std_logic;
          count     : out std_logic_vector(log_base2(depth-1) downto 0)
    );
end synch_fifo_fallthru;

architecture rtl of synch_fifo_fallthru is
constant awidth         : integer :=   log_base2(depth-1);
constant depth_pwr2     : integer :=   2**log_base2(depth-1);

signal read_addr : std_logic_vector(awidth downto 0);
signal read_ptr_cmp : std_logic_vector(awidth downto 0);
signal read_ptr : std_logic_vector(awidth downto 0);
signal read_ptr_int : std_logic_vector(awidth downto 0);
signal write_ptr : std_logic_vector(awidth downto 0);
signal write_ptr_int : std_logic_vector(awidth downto 0);

signal depth_match : std_logic;
signal depth_vector : std_logic_vector(awidth downto 0);
signal depth_vector_minus_one : std_logic_vector(awidth downto 0);
signal depth_vector_minus_two : std_logic_vector(awidth downto 0);
signal aempty_vector : std_logic_vector(awidth downto 0);
signal afull_vector : std_logic_vector(awidth downto 0);
signal full_int : std_logic;
signal wen  : std_logic;
signal ren  : std_logic;
signal empty_int : std_logic;
signal zero_vector: std_logic_vector(awidth downto 0);
signal one_vector: std_logic_vector(awidth downto 0);

begin
-- Combination logic
zero_vector <= (others => '0');
one_vector <= conv_std_logic_vector(1, awidth+1);
wen <= we and not full_int;
ren <= re and not empty_int;
--count <= word_count; -- Calculated differently below
depth_vector <= conv_std_logic_vector(depth_pwr2, awidth+1);
depth_vector_minus_one <= conv_std_logic_vector(depth_pwr2-1, awidth+1);
depth_vector_minus_two <= conv_std_logic_vector(depth_pwr2-2, awidth+1);
aempty_vector <= conv_std_logic_vector(aempty_count, awidth+1);
afull_vector <= conv_std_logic_vector(depth_pwr2 - afull_count, awidth+1);

-- Read address counter
read_ptr <= read_ptr_int + ren;

read_address_proc: process(clk)
begin
    if (clk = '1' and clk'event) then
        if (sclr = '1') then
            read_ptr_int <= (others => '0'); 
        else
            --if (ren = '1') then
                read_ptr_int <= read_ptr;
            --end if;
        end if;
    end if;
end process;

-- Write address counter
write_ptr <= write_ptr_int + wen;

write_address_proc: process(clk)
begin
    if (clk = '1' and clk'event) then
        if (sclr = '1') then
            write_ptr_int <= (others => '0');
        else
            --if (wen = '1') then
                write_ptr_int <= write_ptr;
            --end if;
        end if;
    end if;
end process;

-- Full flag
read_ptr_cmp <= 
                  not read_ptr_int(read_ptr_int'high)
                & read_ptr_int(read_ptr_int'high-1 downto 0);

full_proc: process(clk)
begin
    if(clk = '1' and clk'event) then
        if (sclr = '1') then
            full_int <= '0';
        elsif (write_ptr = read_ptr_cmp) then
          full_int <= '1';
        else
          full_int <= '0';
        end if;
    end if;
end process;
full <= full_int;

-- Empty flag
empty_proc: process(clk)
begin
    if (clk = '1' and clk'event) then
        if (sclr = '1') then
           empty_int <= '1';
        elsif (read_ptr = write_ptr_int) then
           empty_int <= '1';
        else
           empty_int <= '0';
        end if;
    end if;
end process;
empty <= empty_int;

-- "Almost" flags
almost_full: process(read_ptr_int, write_ptr, afull_vector)
begin
    if (    (write_ptr(awidth) = read_ptr_int(awidth)) 
        and (write_ptr - read_ptr_int) >= afull_vector) then
        afull <= '1';
    elsif ( (write_ptr(awidth) = '1')
        and (read_ptr_int(awidth) = '0') 
        and (write_ptr - read_ptr_int) >= afull_vector) then
        afull <= '1';
    elsif ( (write_ptr(awidth) = '0')
        and (read_ptr_int(awidth) = '1') 
        and (('1' & write_ptr(awidth-1 downto 0)) - ('0' & read_ptr_int(awidth - 1 downto 0)) >= afull_vector)) then 
        afull <= '1';
    else
        afull <= '0';
    end if;
end process;


almost_empty: process(write_ptr_int, read_ptr, aempty_vector)
begin
    count <= write_ptr_int - read_ptr;
    if (    (write_ptr_int(awidth) = read_ptr(awidth)) 
        and (write_ptr_int - read_ptr) <= aempty_vector) then
        aempty <= '1';
    elsif ( (write_ptr_int(awidth) = '1')
        and (read_ptr(awidth) = '0') 
        and (write_ptr_int - read_ptr) <= aempty_vector) then
        aempty <= '1';
    elsif ( (write_ptr_int(awidth) = '0')
        and (read_ptr(awidth) = '1') 
        and (('1' & write_ptr_int(awidth-1 downto 0)) - ('0' & read_ptr(awidth - 1 downto 0)) <= aempty_vector)) then
        aempty <= '1';
        count <= ('1' & write_ptr_int(awidth-1 downto 0)) - ('0' & read_ptr(awidth - 1 downto 0));

    else
        aempty <= '0';
    end if;

end process;
--count <= (write_ptr_int - read_ptr);

-- One or two clock cycle delay for reads
no_input_reg: if input_reg = 0 generate
addr_gen: process(read_ptr_int, ren)
begin
    if (ren = '1') then
        read_addr <= read_ptr_int + 1;
    else
        read_addr <= read_ptr_int;
    end if;
end process;
end generate;
yes_input_reg: if input_reg = 1 generate
    read_addr <= read_ptr_int;
end generate;

-- Memory used for FIFO
--mem1 : entity v_ccm_v6_0.dp_ram_async(rtl)
mem1 : entity v_ccm_v6_0.dp_ram(rtl)
    generic map ( input_reg => 0, dwidth => dwidth, mem_size => depth_pwr2, mem_type => mem_type)
    port map (
        ena     => '1',
        clk     => clk,
        --clka    => clk,
        addra   => write_ptr_int(awidth-1 downto 0),
        da      => d,
        wea     => wen,
        qa      => open,

        enb     => '1',
        --clkb    => clk,
        addrb   => read_addr(awidth-1 downto 0),
        db      => d, --CJM Not really used
        qb      => q,
        web     => '0' --CJM: tie low; only read from port B
         );

end rtl;

-- *********************************************
--  *011* add_your_new_macro  Macro
--
-- *********************************************



--**********************************************************************
-- Revision History:
--**********************************************************************
-- $Log: MemXLib_arch.vhd,v $
-- Revision 1.2  2007/06/11 15:37:09  chrisma
-- Sync to codec dir
--
-- Revision 1.26  2007/05/10 20:32:38  chrisma
-- Updated the dp_ram_async to reflect the dp_ram changes by our good
-- gentleman Clive.
--
-- Revision 1.25  2007/04/05 01:34:42  walker
-- Re-wrote sp_ram and dp_ram to fully support read_first, write_first, no_change modes.
--
-- Revision 1.24  2007/03/29 18:57:01  walker
-- Changed default sp_ram write_mode parameter to "WRITE_FIRST"
--
-- Revision 1.23  2007/03/29 18:53:48  walker
-- Added write_mode parameter to sp_ram
--
-- Revision 1.22  2006/10/26 15:38:12  chrisma
-- Added generate to disable the web on select ram mem type.
--
-- Revision 1.21  2006/09/19 17:09:02  chrisma
-- Fix for simulation for the async_fifo.
--
-- Revision 1.20  2006/08/04 18:40:46  chrisma
-- Updated dp_ram to axi_ccm_v6_0 in simulation and synthesis.
-- DP_RAM QA and QB processes now depend on the registered address
--   instead of the non-registered address which was causing the data miss-
--   matches.
--
-- Revision 1.19  2006/07/27 19:43:40  chrisma
-- Added address, data and write enables to process sensitivity list
-- for the shared variable, mem, in the dp_ram.
--
-- Revision 1.18  2006/07/26 15:09:28  chrisma
-- Made mem in dp_ram update on wea and web.
--
-- Revision 1.17  2006/06/27 22:56:18  chrisma
-- Added Async FIFO!
--
-- Revision 1.16  2006/06/27 22:27:19  chrisma
-- Added Async FIFO!
--
-- Revision 1.15  2006/06/23 21:06:49  chrisma
   -- FIFO2ObjFIFO and ObjFIFO2FIFO: changed reset to sclr and removed ADDR_BITS generic.
--
-- Revision 1.14  2006/06/23 20:57:31  chrisma
-- Added FIFO2ObjFIFO and ObjFIFO2FIFO blocks.
-- These are the initial versions; direct copy from previous project.
--
-- Revision 1.13  2006/06/16 23:11:12  chrisma
-- Merged dp_ram rtl and synth versions.
--
-- Revision 1.12  2006/06/15 20:43:26  chrisma
-- Update for dp_ram.
--
-- Revision 1.11  2006/06/15 16:58:28  chrisma
-- OBJFIFOASYNC: Added ASYNC_CLOCK generic to remove or add synchronization
-- logic across clock boundaries.
--
-- Revision 1.10  2006/06/09 22:56:40  chrisma
-- Changed reset to sclr
--
-- Revision 1.9  2006/06/05 19:01:56  chrisma
-- Changed synch_fifo depth to round up to nearest power of 2:
--   depth_pwr2 = 2**log_base2(depth-1) = 2**ceil(log_base2(depth))
--
-- Revision 1.8  2006/05/23 20:41:36  chrisma
-- SIMULATION MODEL ONLY!  THIS WILL NOT SYNTHESIZE A DPDWRAM.
--
-- Revision 1.7  2006/05/16 20:11:16  chrisma
-- Updated sync_fifo dp_ram instance.
-- Updated ObjFifoAsync listing in the header.
--
-- Revision 1.6  2006/05/15 16:37:31  chrisma
-- Aded dp_ram_async and ObjFifoAsync
--
-- Revision 1.5  2006/05/12 20:42:25  chrisma
-- Added True Dual-Port Dual-Write Inferrence Code.
--
-- Revision 1.4  2006/04/26 15:23:47  chrisma
-- Added dual write to dp_ram.  Currently creates twice as many RAMs as needed.
-- Cons cannot write while Prod is writing (A port has prio over B).
--
