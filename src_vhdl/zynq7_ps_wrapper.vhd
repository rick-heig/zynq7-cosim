-------------------------------------------------------------------------------
--
-- Copyright (c) 2020 REDS, Rick Wertenbroek <rick.wertenbroek@heig-vd.ch>
-- All rights reserved.
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- 1. Redistributions of source code must retain the above copyright notice,
-- this list of conditions and the following disclaimer.
--
-- 2. Redistributions in binary form must reproduce the above copyright notice,
-- this list of conditions and the following disclaimer in the documentation
-- and/or other materials provided with the distribution.
--
-- 3. Neither the name of the copyright holder nor the names of its
-- contributors may be used to endorse or promote products derived from this
-- software without specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-- IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
-- ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
--
-------------------------------------------------------------------------------
-- File         : zynq7_ps_wrapper.vhd
-- Description  : This is a wrapper for zynq7_ps_wrapper with default values
--                for input ports (to avoid writing all the ports connections
--                if not needed, e.g., not enabled).
--
-- Author       : Rick Wertenbroek
-- Date         : 16.04.20
-- Version      : 0.0
--
-- VHDL std     : 2008
-- Dependencies :
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity zynq7_ps_wrapper is
    generic(
        QEMU_PATH_TO_SOCKET_G    : string  := "unix:/opt/pkg/projects/zynq_project/qemu-tmp/qemu-rport-_cosim@0";
        QEMU_SYNC_QUANTUM_G      : integer := 10000;
        FCLK_CLK0_PERIOD_IN_NS_G : integer := 10000;
        FCLK_CLK1_PERIOD_IN_NS_G : integer := -1;
        FCLK_CLK2_PERIOD_IN_NS_G : integer := -1;
        FCLK_CLK3_PERIOD_IN_NS_G : integer := -1;
        M_AXI_GP0_ENABLE_G       : integer := 0;
        M_AXI_GP1_ENABLE_G       : integer := 0;
        S_AXI_GP0_ENABLE_G       : integer := 0;
        S_AXI_GP1_ENABLE_G       : integer := 0;
        S_AXI_HP0_ENABLE_G       : integer := 0;
        S_AXI_HP1_ENABLE_G       : integer := 0;
        S_AXI_HP2_ENABLE_G       : integer := 0;
        S_AXI_HP3_ENABLE_G       : integer := 0;
        --
        -- If the generics below change values, the constants in zynq_ps.h must
        -- be changed accordingly (because SystemC (C++) templates cannot take
        -- generic values and constants must be known at compilation time)
        --
        M_AXI_GP0_ADDR_WIDTH_G   : integer := 32;
        M_AXI_GP0_DATA_WIDTH_G   : integer := 32;
        M_AXI_GP0_ID_WIDTH_G     : integer := 12;
        M_AXI_GP0_AXLEN_WIDTH_G  : integer := 4;
        M_AXI_GP0_AXLOCK_WIDTH_G : integer := 2;
        --
        M_AXI_GP1_ADDR_WIDTH_G   : integer := 32;
        M_AXI_GP1_DATA_WIDTH_G   : integer := 32;
        M_AXI_GP1_ID_WIDTH_G     : integer := 12;
        M_AXI_GP1_AXLEN_WIDTH_G  : integer := 4;
        M_AXI_GP1_AXLOCK_WIDTH_G : integer := 2;
        --
        S_AXI_GP0_ADDR_WIDTH_G   : integer := 32;
        S_AXI_GP0_DATA_WIDTH_G   : integer := 32;
        S_AXI_GP0_ID_WIDTH_G     : integer := 6;
        S_AXI_GP0_AXLEN_WIDTH_G  : integer := 4;
        S_AXI_GP0_AXLOCK_WIDTH_G : integer := 2;
        --
        S_AXI_GP1_ADDR_WIDTH_G   : integer := 32;
        S_AXI_GP1_DATA_WIDTH_G   : integer := 32;
        S_AXI_GP1_ID_WIDTH_G     : integer := 6;
        S_AXI_GP1_AXLEN_WIDTH_G  : integer := 4;
        S_AXI_GP1_AXLOCK_WIDTH_G : integer := 2;
        --
        S_AXI_HP0_ADDR_WIDTH_G   : integer := 32;
        S_AXI_HP0_DATA_WIDTH_G   : integer := 64;
        S_AXI_HP0_ID_WIDTH_G     : integer := 6;
        S_AXI_HP0_AXLEN_WIDTH_G  : integer := 4;
        S_AXI_HP0_AXLOCK_WIDTH_G : integer := 2;
        --
        S_AXI_HP1_ADDR_WIDTH_G   : integer := 32;
        S_AXI_HP1_DATA_WIDTH_G   : integer := 64;
        S_AXI_HP1_ID_WIDTH_G     : integer := 6;
        S_AXI_HP1_AXLEN_WIDTH_G  : integer := 4;
        S_AXI_HP1_AXLOCK_WIDTH_G : integer := 2;
        --
        S_AXI_HP2_ADDR_WIDTH_G   : integer := 32;
        S_AXI_HP2_DATA_WIDTH_G   : integer := 64;
        S_AXI_HP2_ID_WIDTH_G     : integer := 6;
        S_AXI_HP2_AXLEN_WIDTH_G  : integer := 4;
        S_AXI_HP2_AXLOCK_WIDTH_G : integer := 2;
        --
        S_AXI_HP3_ADDR_WIDTH_G   : integer := 32;
        S_AXI_HP3_DATA_WIDTH_G   : integer := 64;
        S_AXI_HP3_ID_WIDTH_G     : integer := 6;
        S_AXI_HP3_AXLEN_WIDTH_G  : integer := 4;
        S_AXI_HP3_AXLOCK_WIDTH_G : integer := 2
        );

    port(
        -- Clocks
        fclk_clk0         : out std_logic;
        fclk_clk1         : out std_logic;
        fclk_clk2         : out std_logic;
        fclk_clk3         : out std_logic;
        -- M AXI GP0
        m_axi_gp0_aclk    : in  std_logic := '0';
        m_axi_gp0_aresetn : in  std_logic := '0';
        m_axi_gp0_awvalid : out std_logic;
        m_axi_gp0_awready : in  std_logic := '0';
        m_axi_gp0_awaddr  : out std_logic_vector(M_AXI_GP0_ADDR_WIDTH_G-1 downto 0);
        m_axi_gp0_awprot  : out std_logic_vector(2 downto 0);
        m_axi_gp0_awqos   : out std_logic_vector(3 downto 0);
        m_axi_gp0_awcache : out std_logic_vector(3 downto 0);
        m_axi_gp0_awburst : out std_logic_vector(1 downto 0);
        m_axi_gp0_awsize  : out std_logic_vector(2 downto 0);
        m_axi_gp0_awlen   : out std_logic_vector(M_AXI_GP0_AXLEN_WIDTH_G-1 downto 0);
        m_axi_gp0_awid    : out std_logic_vector(M_AXI_GP0_ID_WIDTH_G-1 downto 0);
        m_axi_gp0_awlock  : out std_logic_vector(M_AXI_GP0_AXLOCK_WIDTH_G-1 downto 0);
        m_axi_gp0_wid     : out std_logic_vector(M_AXI_GP0_ID_WIDTH_G-1 downto 0);
        m_axi_gp0_wvalid  : out std_logic;
        m_axi_gp0_wready  : in  std_logic := '0';
        m_axi_gp0_wdata   : out std_logic_vector(M_AXI_GP0_DATA_WIDTH_G-1 downto 0);
        m_axi_gp0_wstrb   : out std_logic_vector(M_AXI_GP0_DATA_WIDTH_G/8-1 downto 0);
        m_axi_gp0_wlast   : out std_logic;
        m_axi_gp0_bvalid  : in  std_logic := '0';
        m_axi_gp0_bready  : out std_logic;
        m_axi_gp0_bresp   : in  std_logic_vector(1 downto 0) := (others => '0');
        m_axi_gp0_bid     : in  std_logic_vector(M_AXI_GP0_ID_WIDTH_G-1 downto 0) := (others => '0');
        m_axi_gp0_arvalid : out std_logic;
        m_axi_gp0_arready : in  std_logic := '0';
        m_axi_gp0_araddr  : out std_logic_vector(M_AXI_GP0_ADDR_WIDTH_G-1 downto 0);
        m_axi_gp0_arprot  : out std_logic_vector(2 downto 0);
        m_axi_gp0_arqos   : out std_logic_vector(3 downto 0);
        m_axi_gp0_arcache : out std_logic_vector(3 downto 0);
        m_axi_gp0_arburst : out std_logic_vector(1 downto 0);
        m_axi_gp0_arsize  : out std_logic_vector(2 downto 0);
        m_axi_gp0_arlen   : out std_logic_vector(M_AXI_GP0_AXLEN_WIDTH_G-1 downto 0);
        m_axi_gp0_arid    : out std_logic_vector(M_AXI_GP0_ID_WIDTH_G-1 downto 0);
        m_axi_gp0_arlock  : out std_logic_vector(M_AXI_GP0_AXLOCK_WIDTH_G-1 downto 0);
        m_axi_gp0_rvalid  : in  std_logic := '0';
        m_axi_gp0_rready  : out std_logic;
        m_axi_gp0_rdata   : in  std_logic_vector(M_AXI_GP0_DATA_WIDTH_G-1 downto 0) := (others => '0');
        m_axi_gp0_rresp   : in  std_logic_vector(1 downto 0) := (others => '0');
        m_axi_gp0_rid     : in  std_logic_vector(M_AXI_GP0_ID_WIDTH_G-1 downto 0) := (others => '0');
        m_axi_gp0_rlast   : in  std_logic := '0';
        -- M AXI GP1
        m_axi_gp1_aclk    : in  std_logic := '0';
        m_axi_gp1_aresetn : in  std_logic := '0';
        m_axi_gp1_awvalid : out std_logic;
        m_axi_gp1_awready : in  std_logic := '0';
        m_axi_gp1_awaddr  : out std_logic_vector(M_AXI_GP1_ADDR_WIDTH_G-1 downto 0);
        m_axi_gp1_awprot  : out std_logic_vector(2 downto 0);
        m_axi_gp1_awqos   : out std_logic_vector(3 downto 0);
        m_axi_gp1_awcache : out std_logic_vector(3 downto 0);
        m_axi_gp1_awburst : out std_logic_vector(1 downto 0);
        m_axi_gp1_awsize  : out std_logic_vector(2 downto 0);
        m_axi_gp1_awlen   : out std_logic_vector(M_AXI_GP1_AXLEN_WIDTH_G-1 downto 0);
        m_axi_gp1_awid    : out std_logic_vector(M_AXI_GP1_ID_WIDTH_G-1 downto 0);
        m_axi_gp1_awlock  : out std_logic_vector(M_AXI_GP1_AXLOCK_WIDTH_G-1 downto 0);
        m_axi_gp1_wid     : out std_logic_vector(M_AXI_GP1_ID_WIDTH_G-1 downto 0);
        m_axi_gp1_wvalid  : out std_logic;
        m_axi_gp1_wready  : in  std_logic := '0';
        m_axi_gp1_wdata   : out std_logic_vector(M_AXI_GP1_DATA_WIDTH_G-1 downto 0);
        m_axi_gp1_wstrb   : out std_logic_vector(M_AXI_GP1_DATA_WIDTH_G/8-1 downto 0);
        m_axi_gp1_wlast   : out std_logic;
        m_axi_gp1_bvalid  : in  std_logic := '0';
        m_axi_gp1_bready  : out std_logic;
        m_axi_gp1_bresp   : in  std_logic_vector(1 downto 0) := (others => '0');
        m_axi_gp1_bid     : in  std_logic_vector(M_AXI_GP1_ID_WIDTH_G-1 downto 0) := (others => '0');
        m_axi_gp1_arvalid : out std_logic;
        m_axi_gp1_arready : in  std_logic := '0';
        m_axi_gp1_araddr  : out std_logic_vector(M_AXI_GP1_ADDR_WIDTH_G-1 downto 0);
        m_axi_gp1_arprot  : out std_logic_vector(2 downto 0);
        m_axi_gp1_arqos   : out std_logic_vector(3 downto 0);
        m_axi_gp1_arcache : out std_logic_vector(3 downto 0);
        m_axi_gp1_arburst : out std_logic_vector(1 downto 0);
        m_axi_gp1_arsize  : out std_logic_vector(2 downto 0);
        m_axi_gp1_arlen   : out std_logic_vector(M_AXI_GP1_AXLEN_WIDTH_G-1 downto 0);
        m_axi_gp1_arid    : out std_logic_vector(M_AXI_GP1_ID_WIDTH_G-1 downto 0);
        m_axi_gp1_arlock  : out std_logic_vector(M_AXI_GP1_AXLOCK_WIDTH_G-1 downto 0);
        m_axi_gp1_rvalid  : in  std_logic := '0';
        m_axi_gp1_rready  : out std_logic;
        m_axi_gp1_rdata   : in  std_logic_vector(M_AXI_GP1_DATA_WIDTH_G-1 downto 0) := (others => '0');
        m_axi_gp1_rresp   : in  std_logic_vector(1 downto 0) := (others => '0');
        m_axi_gp1_rid     : in  std_logic_vector(M_AXI_GP1_ID_WIDTH_G-1 downto 0) := (others => '0');
        m_axi_gp1_rlast   : in  std_logic := '0';
        -- S AXI GP0
        s_axi_gp0_aclk    : in  std_logic := '0';
        s_axi_gp0_aresetn : in  std_logic := '0';
        s_axi_gp0_awvalid : in  std_logic := '0';
        s_axi_gp0_awready : out std_logic;
        s_axi_gp0_awaddr  : in  std_logic_vector(S_AXI_GP0_ADDR_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp0_awprot  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_gp0_awqos   : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_gp0_awcache : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_gp0_awburst : in  std_logic_vector(1 downto 0) := (others => '0');
        s_axi_gp0_awsize  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_gp0_awlen   : in  std_logic_vector(S_AXI_GP0_AXLEN_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp0_awid    : in  std_logic_vector(S_AXI_GP0_ID_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp0_awlock  : in  std_logic_vector(S_AXI_GP0_AXLOCK_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp0_wid     : in  std_logic_vector(S_AXI_GP0_ID_WIDTH_G-1 downto 0) := (others => '0');  -- Unconnected and unused
        s_axi_gp0_wvalid  : in  std_logic := '0';
        s_axi_gp0_wready  : out std_logic;
        s_axi_gp0_wdata   : in  std_logic_vector(S_AXI_GP0_DATA_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp0_wstrb   : in  std_logic_vector(S_AXI_GP0_DATA_WIDTH_G/8-1 downto 0) := (others => '0');
        s_axi_gp0_wlast   : in  std_logic := '0';
        s_axi_gp0_bvalid  : out std_logic;
        s_axi_gp0_bready  : in  std_logic := '0';
        s_axi_gp0_bresp   : out std_logic_vector(1 downto 0);
        s_axi_gp0_bid     : out std_logic_vector(S_AXI_GP0_ID_WIDTH_G-1 downto 0);
        s_axi_gp0_arvalid : in  std_logic := '0';
        s_axi_gp0_arready : out std_logic;
        s_axi_gp0_araddr  : in  std_logic_vector(S_AXI_GP0_ADDR_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp0_arprot  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_gp0_arqos   : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_gp0_arcache : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_gp0_arburst : in  std_logic_vector(1 downto 0) := (others => '0');
        s_axi_gp0_arsize  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_gp0_arlen   : in  std_logic_vector(S_AXI_GP0_AXLEN_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp0_arid    : in  std_logic_vector(S_AXI_GP0_ID_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp0_arlock  : in  std_logic_vector(S_AXI_GP0_AXLOCK_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp0_rvalid  : out std_logic;
        s_axi_gp0_rready  : in  std_logic := '0';
        s_axi_gp0_rdata   : out std_logic_vector(S_AXI_GP0_DATA_WIDTH_G-1 downto 0);
        s_axi_gp0_rresp   : out std_logic_vector(1 downto 0);
        s_axi_gp0_rid     : out std_logic_vector(S_AXI_GP0_ID_WIDTH_G-1 downto 0);
        s_axi_gp0_rlast   : out std_logic;
        -- S AXI GP1
        s_axi_gp1_aclk    : in  std_logic := '0';
        s_axi_gp1_aresetn : in  std_logic := '0';
        s_axi_gp1_awvalid : in  std_logic := '0';
        s_axi_gp1_awready : out std_logic;
        s_axi_gp1_awaddr  : in  std_logic_vector(S_AXI_GP1_ADDR_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp1_awprot  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_gp1_awqos   : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_gp1_awcache : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_gp1_awburst : in  std_logic_vector(1 downto 0) := (others => '0');
        s_axi_gp1_awsize  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_gp1_awlen   : in  std_logic_vector(S_AXI_GP1_AXLEN_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp1_awid    : in  std_logic_vector(S_AXI_GP1_ID_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp1_awlock  : in  std_logic_vector(S_AXI_GP1_AXLOCK_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp1_wid     : in  std_logic_vector(S_AXI_GP1_ID_WIDTH_G-1 downto 0) := (others => '0');  -- Unconnected and unused
        s_axi_gp1_wvalid  : in  std_logic := '0';
        s_axi_gp1_wready  : out std_logic;
        s_axi_gp1_wdata   : in  std_logic_vector(S_AXI_GP1_DATA_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp1_wstrb   : in  std_logic_vector(S_AXI_GP1_DATA_WIDTH_G/8-1 downto 0) := (others => '0');
        s_axi_gp1_wlast   : in  std_logic := '0';
        s_axi_gp1_bvalid  : out std_logic;
        s_axi_gp1_bready  : in  std_logic := '0';
        s_axi_gp1_bresp   : out std_logic_vector(1 downto 0);
        s_axi_gp1_bid     : out std_logic_vector(S_AXI_GP1_ID_WIDTH_G-1 downto 0);
        s_axi_gp1_arvalid : in  std_logic := '0';
        s_axi_gp1_arready : out std_logic;
        s_axi_gp1_araddr  : in  std_logic_vector(S_AXI_GP1_ADDR_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp1_arprot  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_gp1_arqos   : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_gp1_arcache : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_gp1_arburst : in  std_logic_vector(1 downto 0) := (others => '0');
        s_axi_gp1_arsize  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_gp1_arlen   : in  std_logic_vector(S_AXI_GP1_AXLEN_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp1_arid    : in  std_logic_vector(S_AXI_GP1_ID_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp1_arlock  : in  std_logic_vector(S_AXI_GP1_AXLOCK_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_gp1_rvalid  : out std_logic;
        s_axi_gp1_rready  : in  std_logic := '0';
        s_axi_gp1_rdata   : out std_logic_vector(S_AXI_GP1_DATA_WIDTH_G-1 downto 0);
        s_axi_gp1_rresp   : out std_logic_vector(1 downto 0);
        s_axi_gp1_rid     : out std_logic_vector(S_AXI_GP1_ID_WIDTH_G-1 downto 0);
        s_axi_gp1_rlast   : out std_logic;
        -- S AXI HP0
        s_axi_hp0_aclk    : in  std_logic := '0';
        s_axi_hp0_aresetn : in  std_logic := '0';
        s_axi_hp0_awvalid : in  std_logic := '0';
        s_axi_hp0_awready : out std_logic;
        s_axi_hp0_awaddr  : in  std_logic_vector(S_AXI_HP0_ADDR_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp0_awprot  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp0_awqos   : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp0_awcache : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp0_awburst : in  std_logic_vector(1 downto 0) := (others => '0');
        s_axi_hp0_awsize  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp0_awlen   : in  std_logic_vector(S_AXI_HP0_AXLEN_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp0_awid    : in  std_logic_vector(S_AXI_HP0_ID_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp0_awlock  : in  std_logic_vector(S_AXI_HP0_AXLOCK_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp0_wid     : in  std_logic_vector(S_AXI_HP0_ID_WIDTH_G-1 downto 0) := (others => '0');  -- Unconnected and unused
        s_axi_hp0_wvalid  : in  std_logic := '0';
        s_axi_hp0_wready  : out std_logic;
        s_axi_hp0_wdata   : in  std_logic_vector(S_AXI_HP0_DATA_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp0_wstrb   : in  std_logic_vector(S_AXI_HP0_DATA_WIDTH_G/8-1 downto 0) := (others => '0');
        s_axi_hp0_wlast   : in  std_logic := '0';
        s_axi_hp0_bvalid  : out std_logic;
        s_axi_hp0_bready  : in  std_logic := '0';
        s_axi_hp0_bresp   : out std_logic_vector(1 downto 0);
        s_axi_hp0_bid     : out std_logic_vector(S_AXI_HP0_ID_WIDTH_G-1 downto 0);
        s_axi_hp0_arvalid : in  std_logic := '0';
        s_axi_hp0_arready : out std_logic;
        s_axi_hp0_araddr  : in  std_logic_vector(S_AXI_HP0_ADDR_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp0_arprot  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp0_arqos   : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp0_arcache : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp0_arburst : in  std_logic_vector(1 downto 0) := (others => '0');
        s_axi_hp0_arsize  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp0_arlen   : in  std_logic_vector(S_AXI_HP0_AXLEN_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp0_arid    : in  std_logic_vector(S_AXI_HP0_ID_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp0_arlock  : in  std_logic_vector(S_AXI_HP0_AXLOCK_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp0_rvalid  : out std_logic;
        s_axi_hp0_rready  : in  std_logic := '0';
        s_axi_hp0_rdata   : out std_logic_vector(S_AXI_HP0_DATA_WIDTH_G-1 downto 0);
        s_axi_hp0_rresp   : out std_logic_vector(1 downto 0);
        s_axi_hp0_rid     : out std_logic_vector(S_AXI_HP0_ID_WIDTH_G-1 downto 0);
        s_axi_hp0_rlast   : out std_logic;
        -- S AXI HP1
        s_axi_hp1_aclk    : in  std_logic := '0';
        s_axi_hp1_aresetn : in  std_logic := '0';
        s_axi_hp1_awvalid : in  std_logic := '0';
        s_axi_hp1_awready : out std_logic;
        s_axi_hp1_awaddr  : in  std_logic_vector(S_AXI_HP1_ADDR_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp1_awprot  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp1_awqos   : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp1_awcache : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp1_awburst : in  std_logic_vector(1 downto 0) := (others => '0');
        s_axi_hp1_awsize  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp1_awlen   : in  std_logic_vector(S_AXI_HP1_AXLEN_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp1_awid    : in  std_logic_vector(S_AXI_HP1_ID_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp1_awlock  : in  std_logic_vector(S_AXI_HP1_AXLOCK_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp1_wid     : in  std_logic_vector(S_AXI_HP1_ID_WIDTH_G-1 downto 0) := (others => '0');  -- Unconnected and unused
        s_axi_hp1_wvalid  : in  std_logic := '0';
        s_axi_hp1_wready  : out std_logic;
        s_axi_hp1_wdata   : in  std_logic_vector(S_AXI_HP1_DATA_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp1_wstrb   : in  std_logic_vector(S_AXI_HP1_DATA_WIDTH_G/8-1 downto 0) := (others => '0');
        s_axi_hp1_wlast   : in  std_logic := '0';
        s_axi_hp1_bvalid  : out std_logic;
        s_axi_hp1_bready  : in  std_logic := '0';
        s_axi_hp1_bresp   : out std_logic_vector(1 downto 0);
        s_axi_hp1_bid     : out std_logic_vector(S_AXI_HP1_ID_WIDTH_G-1 downto 0);
        s_axi_hp1_arvalid : in  std_logic := '0';
        s_axi_hp1_arready : out std_logic;
        s_axi_hp1_araddr  : in  std_logic_vector(S_AXI_HP1_ADDR_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp1_arprot  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp1_arqos   : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp1_arcache : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp1_arburst : in  std_logic_vector(1 downto 0) := (others => '0');
        s_axi_hp1_arsize  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp1_arlen   : in  std_logic_vector(S_AXI_HP1_AXLEN_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp1_arid    : in  std_logic_vector(S_AXI_HP1_ID_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp1_arlock  : in  std_logic_vector(S_AXI_HP1_AXLOCK_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp1_rvalid  : out std_logic;
        s_axi_hp1_rready  : in  std_logic := '0';
        s_axi_hp1_rdata   : out std_logic_vector(S_AXI_HP1_DATA_WIDTH_G-1 downto 0);
        s_axi_hp1_rresp   : out std_logic_vector(1 downto 0);
        s_axi_hp1_rid     : out std_logic_vector(S_AXI_HP1_ID_WIDTH_G-1 downto 0);
        s_axi_hp1_rlast   : out std_logic;
        -- S AXI HP2
        s_axi_hp2_aclk    : in  std_logic := '0';
        s_axi_hp2_aresetn : in  std_logic := '0';
        s_axi_hp2_awvalid : in  std_logic := '0';
        s_axi_hp2_awready : out std_logic;
        s_axi_hp2_awaddr  : in  std_logic_vector(S_AXI_HP2_ADDR_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp2_awprot  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp2_awqos   : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp2_awcache : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp2_awburst : in  std_logic_vector(1 downto 0) := (others => '0');
        s_axi_hp2_awsize  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp2_awlen   : in  std_logic_vector(S_AXI_HP2_AXLEN_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp2_awid    : in  std_logic_vector(S_AXI_HP2_ID_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp2_awlock  : in  std_logic_vector(S_AXI_HP2_AXLOCK_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp2_wid     : in  std_logic_vector(S_AXI_HP2_ID_WIDTH_G-1 downto 0) := (others => '0');  -- Unconnected and unused
        s_axi_hp2_wvalid  : in  std_logic := '0';
        s_axi_hp2_wready  : out std_logic;
        s_axi_hp2_wdata   : in  std_logic_vector(S_AXI_HP2_DATA_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp2_wstrb   : in  std_logic_vector(S_AXI_HP2_DATA_WIDTH_G/8-1 downto 0) := (others => '0');
        s_axi_hp2_wlast   : in  std_logic := '0';
        s_axi_hp2_bvalid  : out std_logic;
        s_axi_hp2_bready  : in  std_logic := '0';
        s_axi_hp2_bresp   : out std_logic_vector(1 downto 0);
        s_axi_hp2_bid     : out std_logic_vector(S_AXI_HP2_ID_WIDTH_G-1 downto 0);
        s_axi_hp2_arvalid : in  std_logic := '0';
        s_axi_hp2_arready : out std_logic;
        s_axi_hp2_araddr  : in  std_logic_vector(S_AXI_HP2_ADDR_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp2_arprot  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp2_arqos   : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp2_arcache : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp2_arburst : in  std_logic_vector(1 downto 0) := (others => '0');
        s_axi_hp2_arsize  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp2_arlen   : in  std_logic_vector(S_AXI_HP2_AXLEN_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp2_arid    : in  std_logic_vector(S_AXI_HP2_ID_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp2_arlock  : in  std_logic_vector(S_AXI_HP2_AXLOCK_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp2_rvalid  : out std_logic;
        s_axi_hp2_rready  : in  std_logic := '0';
        s_axi_hp2_rdata   : out std_logic_vector(S_AXI_HP2_DATA_WIDTH_G-1 downto 0);
        s_axi_hp2_rresp   : out std_logic_vector(1 downto 0);
        s_axi_hp2_rid     : out std_logic_vector(S_AXI_HP2_ID_WIDTH_G-1 downto 0);
        s_axi_hp2_rlast   : out std_logic;
        -- S AXI HP3
        s_axi_hp3_aclk    : in  std_logic := '0';
        s_axi_hp3_aresetn : in  std_logic := '0';
        s_axi_hp3_awvalid : in  std_logic := '0';
        s_axi_hp3_awready : out std_logic;
        s_axi_hp3_awaddr  : in  std_logic_vector(S_AXI_HP3_ADDR_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp3_awprot  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp3_awqos   : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp3_awcache : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp3_awburst : in  std_logic_vector(1 downto 0) := (others => '0');
        s_axi_hp3_awsize  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp3_awlen   : in  std_logic_vector(S_AXI_HP3_AXLEN_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp3_awid    : in  std_logic_vector(S_AXI_HP3_ID_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp3_awlock  : in  std_logic_vector(S_AXI_HP3_AXLOCK_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp3_wid     : in  std_logic_vector(S_AXI_HP3_ID_WIDTH_G-1 downto 0) := (others => '0');  -- Unconnected and unused
        s_axi_hp3_wvalid  : in  std_logic := '0';
        s_axi_hp3_wready  : out std_logic;
        s_axi_hp3_wdata   : in  std_logic_vector(S_AXI_HP3_DATA_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp3_wstrb   : in  std_logic_vector(S_AXI_HP3_DATA_WIDTH_G/8-1 downto 0) := (others => '0');
        s_axi_hp3_wlast   : in  std_logic := '0';
        s_axi_hp3_bvalid  : out std_logic;
        s_axi_hp3_bready  : in  std_logic := '0';
        s_axi_hp3_bresp   : out std_logic_vector(1 downto 0);
        s_axi_hp3_bid     : out std_logic_vector(S_AXI_HP3_ID_WIDTH_G-1 downto 0);
        s_axi_hp3_arvalid : in  std_logic := '0';
        s_axi_hp3_arready : out std_logic;
        s_axi_hp3_araddr  : in  std_logic_vector(S_AXI_HP3_ADDR_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp3_arprot  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp3_arqos   : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp3_arcache : in  std_logic_vector(3 downto 0) := (others => '0');
        s_axi_hp3_arburst : in  std_logic_vector(1 downto 0) := (others => '0');
        s_axi_hp3_arsize  : in  std_logic_vector(2 downto 0) := (others => '0');
        s_axi_hp3_arlen   : in  std_logic_vector(S_AXI_HP3_AXLEN_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp3_arid    : in  std_logic_vector(S_AXI_HP3_ID_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp3_arlock  : in  std_logic_vector(S_AXI_HP3_AXLOCK_WIDTH_G-1 downto 0) := (others => '0');
        s_axi_hp3_rvalid  : out std_logic;
        s_axi_hp3_rready  : in  std_logic := '0';
        s_axi_hp3_rdata   : out std_logic_vector(S_AXI_HP3_DATA_WIDTH_G-1 downto 0);
        s_axi_hp3_rresp   : out std_logic_vector(1 downto 0);
        s_axi_hp3_rid     : out std_logic_vector(S_AXI_HP3_ID_WIDTH_G-1 downto 0);
        s_axi_hp3_rlast   : out std_logic;
        -- IRQs
        irq_f2p           : in  std_logic_vector(15 downto 0) := (others => '0');
        -- Reset
        rst_o             : out std_logic
        );
end entity zynq7_ps_wrapper;

architecture struct of zynq7_ps_wrapper is

begin

    -- This entity is a SystemC entity
    zynq7_ps_inst : entity work.zynq7_ps
        generic map (
            QEMU_PATH_TO_SOCKET_G    => QEMU_PATH_TO_SOCKET_G,
            QEMU_SYNC_QUANTUM_G      => QEMU_SYNC_QUANTUM_G,
            FCLK_CLK0_PERIOD_IN_NS_G => FCLK_CLK0_PERIOD_IN_NS_G,
            FCLK_CLK1_PERIOD_IN_NS_G => FCLK_CLK1_PERIOD_IN_NS_G,
            FCLK_CLK2_PERIOD_IN_NS_G => FCLK_CLK2_PERIOD_IN_NS_G,
            FCLK_CLK3_PERIOD_IN_NS_G => FCLK_CLK3_PERIOD_IN_NS_G,
            M_AXI_GP0_ENABLE_G       => M_AXI_GP0_ENABLE_G,
            M_AXI_GP1_ENABLE_G       => M_AXI_GP1_ENABLE_G,
            S_AXI_GP0_ENABLE_G       => S_AXI_GP0_ENABLE_G,
            S_AXI_GP1_ENABLE_G       => S_AXI_GP1_ENABLE_G,
            S_AXI_HP0_ENABLE_G       => S_AXI_HP0_ENABLE_G,
            S_AXI_HP1_ENABLE_G       => S_AXI_HP1_ENABLE_G,
            S_AXI_HP2_ENABLE_G       => S_AXI_HP2_ENABLE_G,
            S_AXI_HP3_ENABLE_G       => S_AXI_HP3_ENABLE_G)
        port map (
            -- Clocks
            fclk_clk0          => fclk_clk0,
            fclk_clk1          => fclk_clk1,
            fclk_clk2          => fclk_clk2,
            fclk_clk3          => fclk_clk3,
            -- M AXI GP0
            m_axi_gp0_aclk     => m_axi_gp0_aclk,
            m_axi_gp0_aresetn  => m_axi_gp0_aresetn,
            m_axi_gp0_awvalid  => m_axi_gp0_awvalid,
            m_axi_gp0_awready  => m_axi_gp0_awready,
            m_axi_gp0_awaddr   => m_axi_gp0_awaddr,
            m_axi_gp0_awprot   => m_axi_gp0_awprot,
            m_axi_gp0_awqos    => m_axi_gp0_awqos,
            m_axi_gp0_awcache  => m_axi_gp0_awcache,
            m_axi_gp0_awburst  => m_axi_gp0_awburst,
            m_axi_gp0_awsize   => m_axi_gp0_awsize,
            m_axi_gp0_awlen    => m_axi_gp0_awlen,
            m_axi_gp0_awid     => m_axi_gp0_awid,
            m_axi_gp0_awlock   => m_axi_gp0_awlock,
            --m_axi_gp0_wid      => m_axi_gp0_wid, -- Only in AXI3 on BFM (tlm2axi-bridge)
            m_axi_gp0_wvalid   => m_axi_gp0_wvalid,
            m_axi_gp0_wready   => m_axi_gp0_wready,
            m_axi_gp0_wdata    => m_axi_gp0_wdata,
            m_axi_gp0_wstrb    => m_axi_gp0_wstrb,
            m_axi_gp0_wlast    => m_axi_gp0_wlast,
            m_axi_gp0_bvalid   => m_axi_gp0_bvalid,
            m_axi_gp0_bready   => m_axi_gp0_bready,
            m_axi_gp0_bresp    => m_axi_gp0_bresp,
            m_axi_gp0_bid      => m_axi_gp0_bid,
            m_axi_gp0_arvalid  => m_axi_gp0_arvalid,
            m_axi_gp0_arready  => m_axi_gp0_arready,
            m_axi_gp0_araddr   => m_axi_gp0_araddr,
            m_axi_gp0_arprot   => m_axi_gp0_arprot,
            m_axi_gp0_arqos    => m_axi_gp0_arqos,
            m_axi_gp0_arcache  => m_axi_gp0_arcache,
            m_axi_gp0_arburst  => m_axi_gp0_arburst,
            m_axi_gp0_arsize   => m_axi_gp0_arsize,
            m_axi_gp0_arlen    => m_axi_gp0_arlen,
            m_axi_gp0_arid     => m_axi_gp0_arid,
            m_axi_gp0_arlock   => m_axi_gp0_arlock,
            m_axi_gp0_rvalid   => m_axi_gp0_rvalid,
            m_axi_gp0_rready   => m_axi_gp0_rready,
            m_axi_gp0_rdata    => m_axi_gp0_rdata,
            m_axi_gp0_rresp    => m_axi_gp0_rresp,
            m_axi_gp0_rid      => m_axi_gp0_rid,
            m_axi_gp0_rlast    => m_axi_gp0_rlast,
            -- M AXI GP1
            m_axi_gp1_aclk     => m_axi_gp1_aclk,
            m_axi_gp1_aresetn  => m_axi_gp1_aresetn,
            m_axi_gp1_awvalid  => m_axi_gp1_awvalid,
            m_axi_gp1_awready  => m_axi_gp1_awready,
            m_axi_gp1_awaddr   => m_axi_gp1_awaddr,
            m_axi_gp1_awprot   => m_axi_gp1_awprot,
            m_axi_gp1_awqos    => m_axi_gp1_awqos,
            m_axi_gp1_awcache  => m_axi_gp1_awcache,
            m_axi_gp1_awburst  => m_axi_gp1_awburst,
            m_axi_gp1_awsize   => m_axi_gp1_awsize,
            m_axi_gp1_awlen    => m_axi_gp1_awlen,
            m_axi_gp1_awid     => m_axi_gp1_awid,
            m_axi_gp1_awlock   => m_axi_gp1_awlock,
            --m_axi_gp1_wid      => m_axi_gp1_wid, -- Only in AXI3 on BFM (tlm2axi-bridge)
            m_axi_gp1_wvalid   => m_axi_gp1_wvalid,
            m_axi_gp1_wready   => m_axi_gp1_wready,
            m_axi_gp1_wdata    => m_axi_gp1_wdata,
            m_axi_gp1_wstrb    => m_axi_gp1_wstrb,
            m_axi_gp1_wlast    => m_axi_gp1_wlast,
            m_axi_gp1_bvalid   => m_axi_gp1_bvalid,
            m_axi_gp1_bready   => m_axi_gp1_bready,
            m_axi_gp1_bresp    => m_axi_gp1_bresp,
            m_axi_gp1_bid      => m_axi_gp1_bid,
            m_axi_gp1_arvalid  => m_axi_gp1_arvalid,
            m_axi_gp1_arready  => m_axi_gp1_arready,
            m_axi_gp1_araddr   => m_axi_gp1_araddr,
            m_axi_gp1_arprot   => m_axi_gp1_arprot,
            m_axi_gp1_arqos    => m_axi_gp1_arqos,
            m_axi_gp1_arcache  => m_axi_gp1_arcache,
            m_axi_gp1_arburst  => m_axi_gp1_arburst,
            m_axi_gp1_arsize   => m_axi_gp1_arsize,
            m_axi_gp1_arlen    => m_axi_gp1_arlen,
            m_axi_gp1_arid     => m_axi_gp1_arid,
            m_axi_gp1_arlock   => m_axi_gp1_arlock,
            m_axi_gp1_rvalid   => m_axi_gp1_rvalid,
            m_axi_gp1_rready   => m_axi_gp1_rready,
            m_axi_gp1_rdata    => m_axi_gp1_rdata,
            m_axi_gp1_rresp    => m_axi_gp1_rresp,
            m_axi_gp1_rid      => m_axi_gp1_rid,
            m_axi_gp1_rlast    => m_axi_gp1_rlast,
            -- S AXI GP0
            s_axi_gp0_aclk     => s_axi_gp0_aclk,
            s_axi_gp0_aresetn  => s_axi_gp0_aresetn,
            s_axi_gp0_awvalid  => s_axi_gp0_awvalid,
            s_axi_gp0_awready  => s_axi_gp0_awready,
            s_axi_gp0_awaddr   => s_axi_gp0_awaddr,
            s_axi_gp0_awprot   => s_axi_gp0_awprot,
            s_axi_gp0_awregion => (others => '0'),
            s_axi_gp0_awqos    => s_axi_gp0_awqos,
            s_axi_gp0_awcache  => s_axi_gp0_awcache,
            s_axi_gp0_awburst  => s_axi_gp0_awburst,
            s_axi_gp0_awsize   => s_axi_gp0_awsize,
            s_axi_gp0_awlen    => s_axi_gp0_awlen,
            s_axi_gp0_awid     => s_axi_gp0_awid,
            s_axi_gp0_awlock   => s_axi_gp0_awlock,
            -- s_axi_gp0_wid => s_axi_gp0_wid, -- Only in AXI3 on BFM (axi2tlm-bridge)
            s_axi_gp0_wvalid   => s_axi_gp0_wvalid,
            s_axi_gp0_wready   => s_axi_gp0_wready,
            s_axi_gp0_wdata    => s_axi_gp0_wdata,
            s_axi_gp0_wstrb    => s_axi_gp0_wstrb,
            s_axi_gp0_wlast    => s_axi_gp0_wlast,
            s_axi_gp0_bvalid   => s_axi_gp0_bvalid,
            s_axi_gp0_bready   => s_axi_gp0_bready,
            s_axi_gp0_bresp    => s_axi_gp0_bresp,
            s_axi_gp0_bid      => s_axi_gp0_bid,
            s_axi_gp0_arvalid  => s_axi_gp0_arvalid,
            s_axi_gp0_arready  => s_axi_gp0_arready,
            s_axi_gp0_araddr   => s_axi_gp0_araddr,
            s_axi_gp0_arprot   => s_axi_gp0_arprot,
            s_axi_gp0_arregion => (others => '0'),
            s_axi_gp0_arqos    => s_axi_gp0_arqos,
            s_axi_gp0_arcache  => s_axi_gp0_arcache,
            s_axi_gp0_arburst  => s_axi_gp0_arburst,
            s_axi_gp0_arsize   => s_axi_gp0_arsize,
            s_axi_gp0_arlen    => s_axi_gp0_arlen,
            s_axi_gp0_arid     => s_axi_gp0_arid,
            s_axi_gp0_arlock   => s_axi_gp0_arlock,
            s_axi_gp0_rvalid   => s_axi_gp0_rvalid,
            s_axi_gp0_rready   => s_axi_gp0_rready,
            s_axi_gp0_rdata    => s_axi_gp0_rdata,
            s_axi_gp0_rresp    => s_axi_gp0_rresp,
            s_axi_gp0_rid      => s_axi_gp0_rid,
            s_axi_gp0_rlast    => s_axi_gp0_rlast,
            -- S AXI GP1
            s_axi_gp1_aclk     => s_axi_gp1_aclk,
            s_axi_gp1_aresetn  => s_axi_gp1_aresetn,
            s_axi_gp1_awvalid  => s_axi_gp1_awvalid,
            s_axi_gp1_awready  => s_axi_gp1_awready,
            s_axi_gp1_awaddr   => s_axi_gp1_awaddr,
            s_axi_gp1_awprot   => s_axi_gp1_awprot,
            s_axi_gp1_awregion => (others => '0'),
            s_axi_gp1_awqos    => s_axi_gp1_awqos,
            s_axi_gp1_awcache  => s_axi_gp1_awcache,
            s_axi_gp1_awburst  => s_axi_gp1_awburst,
            s_axi_gp1_awsize   => s_axi_gp1_awsize,
            s_axi_gp1_awlen    => s_axi_gp1_awlen,
            s_axi_gp1_awid     => s_axi_gp1_awid,
            s_axi_gp1_awlock   => s_axi_gp1_awlock,
            -- s_axi_gp1_wid => s_axi_gp1_wid, -- Only in AXI3 on BFM (axi2tlm-bridge)
            s_axi_gp1_wvalid   => s_axi_gp1_wvalid,
            s_axi_gp1_wready   => s_axi_gp1_wready,
            s_axi_gp1_wdata    => s_axi_gp1_wdata,
            s_axi_gp1_wstrb    => s_axi_gp1_wstrb,
            s_axi_gp1_wlast    => s_axi_gp1_wlast,
            s_axi_gp1_bvalid   => s_axi_gp1_bvalid,
            s_axi_gp1_bready   => s_axi_gp1_bready,
            s_axi_gp1_bresp    => s_axi_gp1_bresp,
            s_axi_gp1_bid      => s_axi_gp1_bid,
            s_axi_gp1_arvalid  => s_axi_gp1_arvalid,
            s_axi_gp1_arready  => s_axi_gp1_arready,
            s_axi_gp1_araddr   => s_axi_gp1_araddr,
            s_axi_gp1_arprot   => s_axi_gp1_arprot,
            s_axi_gp1_arregion => (others => '0'),
            s_axi_gp1_arqos    => s_axi_gp1_arqos,
            s_axi_gp1_arcache  => s_axi_gp1_arcache,
            s_axi_gp1_arburst  => s_axi_gp1_arburst,
            s_axi_gp1_arsize   => s_axi_gp1_arsize,
            s_axi_gp1_arlen    => s_axi_gp1_arlen,
            s_axi_gp1_arid     => s_axi_gp1_arid,
            s_axi_gp1_arlock   => s_axi_gp1_arlock,
            s_axi_gp1_rvalid   => s_axi_gp1_rvalid,
            s_axi_gp1_rready   => s_axi_gp1_rready,
            s_axi_gp1_rdata    => s_axi_gp1_rdata,
            s_axi_gp1_rresp    => s_axi_gp1_rresp,
            s_axi_gp1_rid      => s_axi_gp1_rid,
            s_axi_gp1_rlast    => s_axi_gp1_rlast,
            -- S AXI HP0
            s_axi_hp0_aclk     => s_axi_hp0_aclk,
            s_axi_hp0_aresetn  => s_axi_hp0_aresetn,
            s_axi_hp0_awvalid  => s_axi_hp0_awvalid,
            s_axi_hp0_awready  => s_axi_hp0_awready,
            s_axi_hp0_awaddr   => s_axi_hp0_awaddr,
            s_axi_hp0_awprot   => s_axi_hp0_awprot,
            s_axi_hp0_awregion => (others => '0'),
            s_axi_hp0_awqos    => s_axi_hp0_awqos,
            s_axi_hp0_awcache  => s_axi_hp0_awcache,
            s_axi_hp0_awburst  => s_axi_hp0_awburst,
            s_axi_hp0_awsize   => s_axi_hp0_awsize,
            s_axi_hp0_awlen    => s_axi_hp0_awlen,
            s_axi_hp0_awid     => s_axi_hp0_awid,
            s_axi_hp0_awlock   => s_axi_hp0_awlock,
            -- s_axi_hp0_wid => s_axi_hp0_wid, -- Only in AXI3 on BFM (axi2tlm-bridge)
            s_axi_hp0_wvalid   => s_axi_hp0_wvalid,
            s_axi_hp0_wready   => s_axi_hp0_wready,
            s_axi_hp0_wdata    => s_axi_hp0_wdata,
            s_axi_hp0_wstrb    => s_axi_hp0_wstrb,
            s_axi_hp0_wlast    => s_axi_hp0_wlast,
            s_axi_hp0_bvalid   => s_axi_hp0_bvalid,
            s_axi_hp0_bready   => s_axi_hp0_bready,
            s_axi_hp0_bresp    => s_axi_hp0_bresp,
            s_axi_hp0_bid      => s_axi_hp0_bid,
            s_axi_hp0_arvalid  => s_axi_hp0_arvalid,
            s_axi_hp0_arready  => s_axi_hp0_arready,
            s_axi_hp0_araddr   => s_axi_hp0_araddr,
            s_axi_hp0_arprot   => s_axi_hp0_arprot,
            s_axi_hp0_arregion => (others => '0'),
            s_axi_hp0_arqos    => s_axi_hp0_arqos,
            s_axi_hp0_arcache  => s_axi_hp0_arcache,
            s_axi_hp0_arburst  => s_axi_hp0_arburst,
            s_axi_hp0_arsize   => s_axi_hp0_arsize,
            s_axi_hp0_arlen    => s_axi_hp0_arlen,
            s_axi_hp0_arid     => s_axi_hp0_arid,
            s_axi_hp0_arlock   => s_axi_hp0_arlock,
            s_axi_hp0_rvalid   => s_axi_hp0_rvalid,
            s_axi_hp0_rready   => s_axi_hp0_rready,
            s_axi_hp0_rdata    => s_axi_hp0_rdata,
            s_axi_hp0_rresp    => s_axi_hp0_rresp,
            s_axi_hp0_rid      => s_axi_hp0_rid,
            s_axi_hp0_rlast    => s_axi_hp0_rlast,
            -- S AXI HP1
            s_axi_hp1_aclk     => s_axi_hp1_aclk,
            s_axi_hp1_aresetn  => s_axi_hp1_aresetn,
            s_axi_hp1_awvalid  => s_axi_hp1_awvalid,
            s_axi_hp1_awready  => s_axi_hp1_awready,
            s_axi_hp1_awaddr   => s_axi_hp1_awaddr,
            s_axi_hp1_awprot   => s_axi_hp1_awprot,
            s_axi_hp1_awregion => (others => '0'),
            s_axi_hp1_awqos    => s_axi_hp1_awqos,
            s_axi_hp1_awcache  => s_axi_hp1_awcache,
            s_axi_hp1_awburst  => s_axi_hp1_awburst,
            s_axi_hp1_awsize   => s_axi_hp1_awsize,
            s_axi_hp1_awlen    => s_axi_hp1_awlen,
            s_axi_hp1_awid     => s_axi_hp1_awid,
            s_axi_hp1_awlock   => s_axi_hp1_awlock,
            -- s_axi_hp1_wid => s_axi_hp1_wid, -- Only in AXI3 on BFM (axi2tlm-bridge)
            s_axi_hp1_wvalid   => s_axi_hp1_wvalid,
            s_axi_hp1_wready   => s_axi_hp1_wready,
            s_axi_hp1_wdata    => s_axi_hp1_wdata,
            s_axi_hp1_wstrb    => s_axi_hp1_wstrb,
            s_axi_hp1_wlast    => s_axi_hp1_wlast,
            s_axi_hp1_bvalid   => s_axi_hp1_bvalid,
            s_axi_hp1_bready   => s_axi_hp1_bready,
            s_axi_hp1_bresp    => s_axi_hp1_bresp,
            s_axi_hp1_bid      => s_axi_hp1_bid,
            s_axi_hp1_arvalid  => s_axi_hp1_arvalid,
            s_axi_hp1_arready  => s_axi_hp1_arready,
            s_axi_hp1_araddr   => s_axi_hp1_araddr,
            s_axi_hp1_arprot   => s_axi_hp1_arprot,
            s_axi_hp1_arregion => (others => '0'),
            s_axi_hp1_arqos    => s_axi_hp1_arqos,
            s_axi_hp1_arcache  => s_axi_hp1_arcache,
            s_axi_hp1_arburst  => s_axi_hp1_arburst,
            s_axi_hp1_arsize   => s_axi_hp1_arsize,
            s_axi_hp1_arlen    => s_axi_hp1_arlen,
            s_axi_hp1_arid     => s_axi_hp1_arid,
            s_axi_hp1_arlock   => s_axi_hp1_arlock,
            s_axi_hp1_rvalid   => s_axi_hp1_rvalid,
            s_axi_hp1_rready   => s_axi_hp1_rready,
            s_axi_hp1_rdata    => s_axi_hp1_rdata,
            s_axi_hp1_rresp    => s_axi_hp1_rresp,
            s_axi_hp1_rid      => s_axi_hp1_rid,
            s_axi_hp1_rlast    => s_axi_hp1_rlast,
            -- S AXI HP2
            s_axi_hp2_aclk     => s_axi_hp2_aclk,
            s_axi_hp2_aresetn  => s_axi_hp2_aresetn,
            s_axi_hp2_awvalid  => s_axi_hp2_awvalid,
            s_axi_hp2_awready  => s_axi_hp2_awready,
            s_axi_hp2_awaddr   => s_axi_hp2_awaddr,
            s_axi_hp2_awprot   => s_axi_hp2_awprot,
            s_axi_hp2_awregion => (others => '0'),
            s_axi_hp2_awqos    => s_axi_hp2_awqos,
            s_axi_hp2_awcache  => s_axi_hp2_awcache,
            s_axi_hp2_awburst  => s_axi_hp2_awburst,
            s_axi_hp2_awsize   => s_axi_hp2_awsize,
            s_axi_hp2_awlen    => s_axi_hp2_awlen,
            s_axi_hp2_awid     => s_axi_hp2_awid,
            s_axi_hp2_awlock   => s_axi_hp2_awlock,
            -- s_axi_hp2_wid => s_axi_hp2_wid, -- Only in AXI3 on BFM (axi2tlm-bridge)
            s_axi_hp2_wvalid   => s_axi_hp2_wvalid,
            s_axi_hp2_wready   => s_axi_hp2_wready,
            s_axi_hp2_wdata    => s_axi_hp2_wdata,
            s_axi_hp2_wstrb    => s_axi_hp2_wstrb,
            s_axi_hp2_wlast    => s_axi_hp2_wlast,
            s_axi_hp2_bvalid   => s_axi_hp2_bvalid,
            s_axi_hp2_bready   => s_axi_hp2_bready,
            s_axi_hp2_bresp    => s_axi_hp2_bresp,
            s_axi_hp2_bid      => s_axi_hp2_bid,
            s_axi_hp2_arvalid  => s_axi_hp2_arvalid,
            s_axi_hp2_arready  => s_axi_hp2_arready,
            s_axi_hp2_araddr   => s_axi_hp2_araddr,
            s_axi_hp2_arprot   => s_axi_hp2_arprot,
            s_axi_hp2_arregion => (others => '0'),
            s_axi_hp2_arqos    => s_axi_hp2_arqos,
            s_axi_hp2_arcache  => s_axi_hp2_arcache,
            s_axi_hp2_arburst  => s_axi_hp2_arburst,
            s_axi_hp2_arsize   => s_axi_hp2_arsize,
            s_axi_hp2_arlen    => s_axi_hp2_arlen,
            s_axi_hp2_arid     => s_axi_hp2_arid,
            s_axi_hp2_arlock   => s_axi_hp2_arlock,
            s_axi_hp2_rvalid   => s_axi_hp2_rvalid,
            s_axi_hp2_rready   => s_axi_hp2_rready,
            s_axi_hp2_rdata    => s_axi_hp2_rdata,
            s_axi_hp2_rresp    => s_axi_hp2_rresp,
            s_axi_hp2_rid      => s_axi_hp2_rid,
            s_axi_hp2_rlast    => s_axi_hp2_rlast,
            -- S AXI HP3
            s_axi_hp3_aclk     => s_axi_hp3_aclk,
            s_axi_hp3_aresetn  => s_axi_hp3_aresetn,
            s_axi_hp3_awvalid  => s_axi_hp3_awvalid,
            s_axi_hp3_awready  => s_axi_hp3_awready,
            s_axi_hp3_awaddr   => s_axi_hp3_awaddr,
            s_axi_hp3_awprot   => s_axi_hp3_awprot,
            s_axi_hp3_awregion => (others => '0'),
            s_axi_hp3_awqos    => s_axi_hp3_awqos,
            s_axi_hp3_awcache  => s_axi_hp3_awcache,
            s_axi_hp3_awburst  => s_axi_hp3_awburst,
            s_axi_hp3_awsize   => s_axi_hp3_awsize,
            s_axi_hp3_awlen    => s_axi_hp3_awlen,
            s_axi_hp3_awid     => s_axi_hp3_awid,
            s_axi_hp3_awlock   => s_axi_hp3_awlock,
            -- s_axi_hp3_wid => s_axi_hp3_wid, -- Only in AXI3 on BFM (axi2tlm-bridge)
            s_axi_hp3_wvalid   => s_axi_hp3_wvalid,
            s_axi_hp3_wready   => s_axi_hp3_wready,
            s_axi_hp3_wdata    => s_axi_hp3_wdata,
            s_axi_hp3_wstrb    => s_axi_hp3_wstrb,
            s_axi_hp3_wlast    => s_axi_hp3_wlast,
            s_axi_hp3_bvalid   => s_axi_hp3_bvalid,
            s_axi_hp3_bready   => s_axi_hp3_bready,
            s_axi_hp3_bresp    => s_axi_hp3_bresp,
            s_axi_hp3_bid      => s_axi_hp3_bid,
            s_axi_hp3_arvalid  => s_axi_hp3_arvalid,
            s_axi_hp3_arready  => s_axi_hp3_arready,
            s_axi_hp3_araddr   => s_axi_hp3_araddr,
            s_axi_hp3_arprot   => s_axi_hp3_arprot,
            s_axi_hp3_arregion => (others => '0'),
            s_axi_hp3_arqos    => s_axi_hp3_arqos,
            s_axi_hp3_arcache  => s_axi_hp3_arcache,
            s_axi_hp3_arburst  => s_axi_hp3_arburst,
            s_axi_hp3_arsize   => s_axi_hp3_arsize,
            s_axi_hp3_arlen    => s_axi_hp3_arlen,
            s_axi_hp3_arid     => s_axi_hp3_arid,
            s_axi_hp3_arlock   => s_axi_hp3_arlock,
            s_axi_hp3_rvalid   => s_axi_hp3_rvalid,
            s_axi_hp3_rready   => s_axi_hp3_rready,
            s_axi_hp3_rdata    => s_axi_hp3_rdata,
            s_axi_hp3_rresp    => s_axi_hp3_rresp,
            s_axi_hp3_rid      => s_axi_hp3_rid,
            s_axi_hp3_rlast    => s_axi_hp3_rlast,
            -- IRQs
            irq_f2p            => irq_f2p,
            -- Resets
            rst_o              => rst_o);

    assert irq_f2p'length <= 16 report "IRQ_F2P port cannot have more than 16 lines" severity warning;

    m_axi_gp0_wid <= (others => '0');
    m_axi_gp1_wid <= (others => '0');

end architecture struct;
