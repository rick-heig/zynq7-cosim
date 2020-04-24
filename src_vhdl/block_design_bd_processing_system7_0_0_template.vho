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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity __BD_PROCESSING_SYSTEM7_0_0_NAME__ is
    generic(
        QEMU_PATH_TO_SOCKET_G    : string  := "__QEMU_PATH_TO_SOCKET__";
        QEMU_SYNC_QUANTUM_G      : integer := __QEMU_SYNC_QUANTUM__;
        --
        FCLK_CLK0_PERIOD_IN_NS_G : integer := __FCLK_CLK0_PERIOD_IN_NS__;
        FCLK_CLK1_PERIOD_IN_NS_G : integer := __FCLK_CLK1_PERIOD_IN_NS__;
        FCLK_CLK2_PERIOD_IN_NS_G : integer := __FCLK_CLK2_PERIOD_IN_NS__;
        FCLK_CLK3_PERIOD_IN_NS_G : integer := __FCLK_CLK3_PERIOD_IN_NS__;
        --
        M_AXI_GP0_ENABLE_G       : integer := __M_AXI_GP0_ENABLE__;
        M_AXI_GP1_ENABLE_G       : integer := __M_AXI_GP1_ENABLE__;
        --
        S_AXI_GP0_ENABLE_G       : integer := __S_AXI_GP0_ENABLE__;
        S_AXI_GP1_ENABLE_G       : integer := __S_AXI_GP1_ENABLE__;
        S_AXI_HP0_ENABLE_G       : integer := __S_AXI_HP0_ENABLE__;
        S_AXI_HP1_ENABLE_G       : integer := __S_AXI_HP1_ENABLE__;
        S_AXI_HP2_ENABLE_G       : integer := __S_AXI_HP2_ENABLE__;
        S_AXI_HP3_ENABLE_G       : integer := __S_AXI_HP3_ENABLE__;
        --
        M_AXI_GP0_ADDR_WIDTH_G   : integer := __M_AXI_GP0_ADDR_WIDTH__;
        M_AXI_GP0_DATA_WIDTH_G   : integer := __M_AXI_GP0_DATA_WIDTH__;
        M_AXI_GP0_ID_WIDTH_G     : integer := __M_AXI_GP0_ID_WIDTH__;
        M_AXI_GP0_AXLEN_WIDTH_G  : integer := __M_AXI_GP0_AXLEN_WIDTH__;
        M_AXI_GP0_AXLOCK_WIDTH_G : integer := __M_AXI_GP0_AXLOCK_WIDTH__;
        --
        M_AXI_GP1_ADDR_WIDTH_G   : integer := __M_AXI_GP1_ADDR_WIDTH__;
        M_AXI_GP1_DATA_WIDTH_G   : integer := __M_AXI_GP1_DATA_WIDTH__;
        M_AXI_GP1_ID_WIDTH_G     : integer := __M_AXI_GP1_ID_WIDTH__;
        M_AXI_GP1_AXLEN_WIDTH_G  : integer := __M_AXI_GP1_AXLEN_WIDTH__;
        M_AXI_GP1_AXLOCK_WIDTH_G : integer := __M_AXI_GP1_AXLOCK_WIDTH__;
        --
        S_AXI_GP0_ADDR_WIDTH_G   : integer := __S_AXI_GP0_ADDR_WIDTH__;
        S_AXI_GP0_DATA_WIDTH_G   : integer := __S_AXI_GP0_DATA_WIDTH__;
        S_AXI_GP0_ID_WIDTH_G     : integer := __S_AXI_GP0_ID_WIDTH__;
        S_AXI_GP0_AXLEN_WIDTH_G  : integer := __S_AXI_GP0_AXLEN_WIDTH__;
        S_AXI_GP0_AXLOCK_WIDTH_G : integer := __S_AXI_GP0_AXLOCK_WIDTH__;
        --
        S_AXI_GP1_ADDR_WIDTH_G   : integer := __S_AXI_GP1_ADDR_WIDTH__;
        S_AXI_GP1_DATA_WIDTH_G   : integer := __S_AXI_GP1_DATA_WIDTH__;
        S_AXI_GP1_ID_WIDTH_G     : integer := __S_AXI_GP1_ID_WIDTH__;
        S_AXI_GP1_AXLEN_WIDTH_G  : integer := __S_AXI_GP1_AXLEN_WIDTH__;
        S_AXI_GP1_AXLOCK_WIDTH_G : integer := __S_AXI_GP1_AXLOCK_WIDTH__;
        --
        S_AXI_HP0_ADDR_WIDTH_G   : integer := __S_AXI_HP0_ADDR_WIDTH__;
        S_AXI_HP0_DATA_WIDTH_G   : integer := __S_AXI_HP0_DATA_WIDTH__;
        S_AXI_HP0_ID_WIDTH_G     : integer := __S_AXI_HP0_ID_WIDTH__;
        S_AXI_HP0_AXLEN_WIDTH_G  : integer := __S_AXI_HP0_AXLEN_WIDTH__;
        S_AXI_HP0_AXLOCK_WIDTH_G : integer := __S_AXI_HP0_AXLOCK_WIDTH__;
        --
        S_AXI_HP1_ADDR_WIDTH_G   : integer := __S_AXI_HP1_ADDR_WIDTH__;
        S_AXI_HP1_DATA_WIDTH_G   : integer := __S_AXI_HP1_DATA_WIDTH__;
        S_AXI_HP1_ID_WIDTH_G     : integer := __S_AXI_HP1_ID_WIDTH__;
        S_AXI_HP1_AXLEN_WIDTH_G  : integer := __S_AXI_HP1_AXLEN_WIDTH__;
        S_AXI_HP1_AXLOCK_WIDTH_G : integer := __S_AXI_HP1_AXLOCK_WIDTH__;
        --
        S_AXI_HP2_ADDR_WIDTH_G   : integer := __S_AXI_HP2_ADDR_WIDTH__;
        S_AXI_HP2_DATA_WIDTH_G   : integer := __S_AXI_HP2_DATA_WIDTH__;
        S_AXI_HP2_ID_WIDTH_G     : integer := __S_AXI_HP2_ID_WIDTH__;
        S_AXI_HP2_AXLEN_WIDTH_G  : integer := __S_AXI_HP2_AXLEN_WIDTH__;
        S_AXI_HP2_AXLOCK_WIDTH_G : integer := __S_AXI_HP2_AXLOCK_WIDTH__;
        --
        S_AXI_HP3_ADDR_WIDTH_G   : integer := __S_AXI_HP3_ADDR_WIDTH__;
        S_AXI_HP3_DATA_WIDTH_G   : integer := __S_AXI_HP3_DATA_WIDTH__;
        S_AXI_HP3_ID_WIDTH_G     : integer := __S_AXI_HP3_ID_WIDTH__;
        S_AXI_HP3_AXLEN_WIDTH_G  : integer := __S_AXI_HP3_AXLEN_WIDTH__;
        S_AXI_HP3_AXLOCK_WIDTH_G : integer := __S_AXI_HP3_AXLOCK_WIDTH__
        );
    --__BD_PROCESSING_SYSTEM7_0_0_PORTS__

end entity __BD_PROCESSING_SYSTEM7_0_0_NAME__;

architecture struct of __BD_PROCESSING_SYSTEM7_0_0_NAME__ is

    signal rst_s               : std_logic;
    signal m_axi_gp0_aresetn_s : std_logic;
    signal m_axi_gp1_aresetn_s : std_logic;
    signal s_axi_gp0_aresetn_s : std_logic;
    signal s_axi_gp1_aresetn_s : std_logic;
    signal s_axi_hp0_aresetn_s : std_logic;
    signal s_axi_hp1_aresetn_s : std_logic;
    signal s_axi_hp2_aresetn_s : std_logic;
    signal s_axi_hp3_aresetn_s : std_logic;

begin

    zynq7_ps_wrapper_inst : entity work.zynq7_ps_wrapper
        generic map (
            QEMU_PATH_TO_SOCKET_G    => QEMU_PATH_TO_SOCKET_G,
            QEMU_SYNC_QUANTUM_G      => QEMU_SYNC_QUANTUM_G,
            --
            FCLK_CLK0_PERIOD_IN_NS_G => FCLK_CLK0_PERIOD_IN_NS_G,
            FCLK_CLK1_PERIOD_IN_NS_G => FCLK_CLK1_PERIOD_IN_NS_G,
            FCLK_CLK2_PERIOD_IN_NS_G => FCLK_CLK2_PERIOD_IN_NS_G,
            FCLK_CLK3_PERIOD_IN_NS_G => FCLK_CLK3_PERIOD_IN_NS_G,
            --
            M_AXI_GP0_ENABLE_G       => M_AXI_GP0_ENABLE_G,
            M_AXI_GP1_ENABLE_G       => M_AXI_GP1_ENABLE_G,
            --
            S_AXI_GP0_ENABLE_G       => S_AXI_GP0_ENABLE_G,
            S_AXI_GP1_ENABLE_G       => S_AXI_GP1_ENABLE_G,
            --
            S_AXI_HP0_ENABLE_G       => S_AXI_HP0_ENABLE_G,
            S_AXI_HP1_ENABLE_G       => S_AXI_HP1_ENABLE_G,
            S_AXI_HP2_ENABLE_G       => S_AXI_HP2_ENABLE_G,
            S_AXI_HP3_ENABLE_G       => S_AXI_HP3_ENABLE_G,
            --
            M_AXI_GP0_ADDR_WIDTH_G   => M_AXI_GP0_ADDR_WIDTH_G,
            M_AXI_GP0_DATA_WIDTH_G   => M_AXI_GP0_DATA_WIDTH_G,
            M_AXI_GP0_ID_WIDTH_G     => M_AXI_GP0_ID_WIDTH_G,
            M_AXI_GP0_AXLEN_WIDTH_G  => M_AXI_GP0_AXLEN_WIDTH_G,
            M_AXI_GP0_AXLOCK_WIDTH_G => M_AXI_GP0_AXLOCK_WIDTH_G,
            --
            M_AXI_GP1_ADDR_WIDTH_G   => M_AXI_GP1_ADDR_WIDTH_G,
            M_AXI_GP1_DATA_WIDTH_G   => M_AXI_GP1_DATA_WIDTH_G,
            M_AXI_GP1_ID_WIDTH_G     => M_AXI_GP1_ID_WIDTH_G,
            M_AXI_GP1_AXLEN_WIDTH_G  => M_AXI_GP1_AXLEN_WIDTH_G,
            M_AXI_GP1_AXLOCK_WIDTH_G => M_AXI_GP1_AXLOCK_WIDTH_G,
            --
            S_AXI_GP0_ADDR_WIDTH_G   => S_AXI_GP0_ADDR_WIDTH_G,
            S_AXI_GP0_DATA_WIDTH_G   => S_AXI_GP0_DATA_WIDTH_G,
            S_AXI_GP0_ID_WIDTH_G     => S_AXI_GP0_ID_WIDTH_G,
            S_AXI_GP0_AXLEN_WIDTH_G  => S_AXI_GP0_AXLEN_WIDTH_G,
            S_AXI_GP0_AXLOCK_WIDTH_G => S_AXI_GP0_AXLOCK_WIDTH_G,
            --
            S_AXI_GP1_ADDR_WIDTH_G   => S_AXI_GP1_ADDR_WIDTH_G,
            S_AXI_GP1_DATA_WIDTH_G   => S_AXI_GP1_DATA_WIDTH_G,
            S_AXI_GP1_ID_WIDTH_G     => S_AXI_GP1_ID_WIDTH_G,
            S_AXI_GP1_AXLEN_WIDTH_G  => S_AXI_GP1_AXLEN_WIDTH_G,
            S_AXI_GP1_AXLOCK_WIDTH_G => S_AXI_GP1_AXLOCK_WIDTH_G,
            --
            S_AXI_HP0_ADDR_WIDTH_G   => S_AXI_HP0_ADDR_WIDTH_G,
            S_AXI_HP0_DATA_WIDTH_G   => S_AXI_HP0_DATA_WIDTH_G,
            S_AXI_HP0_ID_WIDTH_G     => S_AXI_HP0_ID_WIDTH_G,
            S_AXI_HP0_AXLEN_WIDTH_G  => S_AXI_HP0_AXLEN_WIDTH_G,
            S_AXI_HP0_AXLOCK_WIDTH_G => S_AXI_HP0_AXLOCK_WIDTH_G,
            --
            S_AXI_HP1_ADDR_WIDTH_G   => S_AXI_HP1_ADDR_WIDTH_G,
            S_AXI_HP1_DATA_WIDTH_G   => S_AXI_HP1_DATA_WIDTH_G,
            S_AXI_HP1_ID_WIDTH_G     => S_AXI_HP1_ID_WIDTH_G,
            S_AXI_HP1_AXLEN_WIDTH_G  => S_AXI_HP1_AXLEN_WIDTH_G,
            S_AXI_HP1_AXLOCK_WIDTH_G => S_AXI_HP1_AXLOCK_WIDTH_G,
            --
            S_AXI_HP2_ADDR_WIDTH_G   => S_AXI_HP2_ADDR_WIDTH_G,
            S_AXI_HP2_DATA_WIDTH_G   => S_AXI_HP2_DATA_WIDTH_G,
            S_AXI_HP2_ID_WIDTH_G     => S_AXI_HP2_ID_WIDTH_G,
            S_AXI_HP2_AXLEN_WIDTH_G  => S_AXI_HP2_AXLEN_WIDTH_G,
            S_AXI_HP2_AXLOCK_WIDTH_G => S_AXI_HP2_AXLOCK_WIDTH_G,
            --
            S_AXI_HP3_ADDR_WIDTH_G   => S_AXI_HP3_ADDR_WIDTH_G,
            S_AXI_HP3_DATA_WIDTH_G   => S_AXI_HP3_DATA_WIDTH_G,
            S_AXI_HP3_ID_WIDTH_G     => S_AXI_HP3_ID_WIDTH_G,
            S_AXI_HP3_AXLEN_WIDTH_G  => S_AXI_HP3_AXLEN_WIDTH_G,
            S_AXI_HP3_AXLOCK_WIDTH_G => S_AXI_HP3_AXLOCK_WIDTH_G)
        port map (
            --__CONNECT_FCLK_CLK0__
            --fclk_clk0         => FCLK_CLK0,
            --__CONNECT_FCLK_CLK1__
            --fclk_clk1         => FCLK_CLK1,
            --__CONNECT_FCLK_CLK2__
            --fclk_clk2         => FCLK_CLK2,
            --__CONNECT_FCLK_CLK3__
            --fclk_clk3         => FCLK_CLK3,
            --__CONNECT_M_AXI_GP0__
            --m_axi_gp0_aclk    => M_AXI_GP0_ACLK,
            --m_axi_gp0_aresetn => m_axi_gp0_aresetn_s,
            --m_axi_gp0_awvalid => M_AXI_GP0_AWVALID,
            --m_axi_gp0_awready => M_AXI_GP0_AWREADY,
            --m_axi_gp0_awaddr  => M_AXI_GP0_AWADDR,
            --m_axi_gp0_awprot  => M_AXI_GP0_AWPROT,
            --m_axi_gp0_awqos   => M_AXI_GP0_AWQOS,
            --m_axi_gp0_awcache => M_AXI_GP0_AWCACHE,
            --m_axi_gp0_awburst => M_AXI_GP0_AWBURST,
            --m_axi_gp0_awsize  => M_AXI_GP0_AWSIZE,
            --m_axi_gp0_awlen   => M_AXI_GP0_AWLEN,
            --m_axi_gp0_awid    => M_AXI_GP0_AWID,
            --m_axi_gp0_awlock  => M_AXI_GP0_AWLOCK,
            --m_axi_gp0_wid     => M_AXI_GP0_WID,
            --m_axi_gp0_wvalid  => M_AXI_GP0_WVALID,
            --m_axi_gp0_wready  => M_AXI_GP0_WREADY,
            --m_axi_gp0_wdata   => M_AXI_GP0_WDATA,
            --m_axi_gp0_wstrb   => M_AXI_GP0_WSTRB,
            --m_axi_gp0_wlast   => M_AXI_GP0_WLAST,
            --m_axi_gp0_bvalid  => M_AXI_GP0_BVALID,
            --m_axi_gp0_bready  => M_AXI_GP0_BREADY,
            --m_axi_gp0_bresp   => M_AXI_GP0_BRESP,
            --m_axi_gp0_bid     => M_AXI_GP0_BID,
            --m_axi_gp0_arvalid => M_AXI_GP0_ARVALID,
            --m_axi_gp0_arready => M_AXI_GP0_ARREADY,
            --m_axi_gp0_araddr  => M_AXI_GP0_ARADDR,
            --m_axi_gp0_arprot  => M_AXI_GP0_ARPROT,
            --m_axi_gp0_arqos   => M_AXI_GP0_ARQOS,
            --m_axi_gp0_arcache => M_AXI_GP0_ARCACHE,
            --m_axi_gp0_arburst => M_AXI_GP0_ARBURST,
            --m_axi_gp0_arsize  => M_AXI_GP0_ARSIZE,
            --m_axi_gp0_arlen   => M_AXI_GP0_ARLEN,
            --m_axi_gp0_arid    => M_AXI_GP0_ARID,
            --m_axi_gp0_arlock  => M_AXI_GP0_ARLOCK,
            --m_axi_gp0_rvalid  => M_AXI_GP0_RVALID,
            --m_axi_gp0_rready  => M_AXI_GP0_RREADY,
            --m_axi_gp0_rdata   => M_AXI_GP0_RDATA,
            --m_axi_gp0_rresp   => M_AXI_GP0_RRESP,
            --m_axi_gp0_rid     => M_AXI_GP0_RID,
            --m_axi_gp0_rlast   => M_AXI_GP0_RLAST,
            --__CONNECT_M_AXI_GP1__
            --m_axi_gp1_aclk    => M_AXI_GP1_ACLK,
            --m_axi_gp1_aresetn => m_axi_gp1_aresetn_s,
            --m_axi_gp1_awvalid => M_AXI_GP1_AWVALID,
            --m_axi_gp1_awready => M_AXI_GP1_AWREADY,
            --m_axi_gp1_awaddr  => M_AXI_GP1_AWADDR,
            --m_axi_gp1_awprot  => M_AXI_GP1_AWPROT,
            --m_axi_gp1_awqos   => M_AXI_GP1_AWQOS,
            --m_axi_gp1_awcache => M_AXI_GP1_AWCACHE,
            --m_axi_gp1_awburst => M_AXI_GP1_AWBURST,
            --m_axi_gp1_awsize  => M_AXI_GP1_AWSIZE,
            --m_axi_gp1_awlen   => M_AXI_GP1_AWLEN,
            --m_axi_gp1_awid    => M_AXI_GP1_AWID,
            --m_axi_gp1_awlock  => M_AXI_GP1_AWLOCK,
            --m_axi_gp1_wid     => M_AXI_GP1_WID,
            --m_axi_gp1_wvalid  => M_AXI_GP1_WVALID,
            --m_axi_gp1_wready  => M_AXI_GP1_WREADY,
            --m_axi_gp1_wdata   => M_AXI_GP1_WDATA,
            --m_axi_gp1_wstrb   => M_AXI_GP1_WSTRB,
            --m_axi_gp1_wlast   => M_AXI_GP1_WLAST,
            --m_axi_gp1_bvalid  => M_AXI_GP1_BVALID,
            --m_axi_gp1_bready  => M_AXI_GP1_BREADY,
            --m_axi_gp1_bresp   => M_AXI_GP1_BRESP,
            --m_axi_gp1_bid     => M_AXI_GP1_BID,
            --m_axi_gp1_arvalid => M_AXI_GP1_ARVALID,
            --m_axi_gp1_arready => M_AXI_GP1_ARREADY,
            --m_axi_gp1_araddr  => M_AXI_GP1_ARADDR,
            --m_axi_gp1_arprot  => M_AXI_GP1_ARPROT,
            --m_axi_gp1_arqos   => M_AXI_GP1_ARQOS,
            --m_axi_gp1_arcache => M_AXI_GP1_ARCACHE,
            --m_axi_gp1_arburst => M_AXI_GP1_ARBURST,
            --m_axi_gp1_arsize  => M_AXI_GP1_ARSIZE,
            --m_axi_gp1_arlen   => M_AXI_GP1_ARLEN,
            --m_axi_gp1_arid    => M_AXI_GP1_ARID,
            --m_axi_gp1_arlock  => M_AXI_GP1_ARLOCK,
            --m_axi_gp1_rvalid  => M_AXI_GP1_RVALID,
            --m_axi_gp1_rready  => M_AXI_GP1_RREADY,
            --m_axi_gp1_rdata   => M_AXI_GP1_RDATA,
            --m_axi_gp1_rresp   => M_AXI_GP1_RRESP,
            --m_axi_gp1_rid     => M_AXI_GP1_RID,
            --m_axi_gp1_rlast   => M_AXI_GP1_RLAST,
            --__CONNECT_S_AXI_GP0__
            --s_axi_gp0_aclk    => S_AXI_GP0_ACLK,
            --s_axi_gp0_aresetn => s_axi_gp0_aresetn_s,
            --s_axi_gp0_awvalid => S_AXI_GP0_AWVALID,
            --s_axi_gp0_awready => S_AXI_GP0_AWREADY,
            --s_axi_gp0_awaddr  => S_AXI_GP0_AWADDR,
            --s_axi_gp0_awprot  => S_AXI_GP0_AWPROT,
            --s_axi_gp0_awqos   => S_AXI_GP0_AWQOS,
            --s_axi_gp0_awcache => S_AXI_GP0_AWCACHE,
            --s_axi_gp0_awburst => S_AXI_GP0_AWBURST,
            --s_axi_gp0_awsize  => S_AXI_GP0_AWSIZE,
            --s_axi_gp0_awlen   => S_AXI_GP0_AWLEN,
            --s_axi_gp0_awid    => S_AXI_GP0_AWID,
            --s_axi_gp0_awlock  => S_AXI_GP0_AWLOCK,
            --s_axi_gp0_wvalid  => S_AXI_GP0_WVALID,
            --s_axi_gp0_wready  => S_AXI_GP0_WREADY,
            --s_axi_gp0_wdata   => S_AXI_GP0_WDATA,
            --s_axi_gp0_wstrb   => S_AXI_GP0_WSTRB,
            --s_axi_gp0_wlast   => S_AXI_GP0_WLAST,
            --s_axi_gp0_bvalid  => S_AXI_GP0_BVALID,
            --s_axi_gp0_bready  => S_AXI_GP0_BREADY,
            --s_axi_gp0_bresp   => S_AXI_GP0_BRESP,
            --s_axi_gp0_bid     => S_AXI_GP0_BID,
            --s_axi_gp0_arvalid => S_AXI_GP0_ARVALID,
            --s_axi_gp0_arready => S_AXI_GP0_ARREADY,
            --s_axi_gp0_araddr  => S_AXI_GP0_ARADDR,
            --s_axi_gp0_arprot  => S_AXI_GP0_ARPROT,
            --s_axi_gp0_arqos   => S_AXI_GP0_ARQOS,
            --s_axi_gp0_arcache => S_AXI_GP0_ARCACHE,
            --s_axi_gp0_arburst => S_AXI_GP0_ARBURST,
            --s_axi_gp0_arsize  => S_AXI_GP0_ARSIZE,
            --s_axi_gp0_arlen   => S_AXI_GP0_ARLEN,
            --s_axi_gp0_arid    => S_AXI_GP0_ARID,
            --s_axi_gp0_arlock  => S_AXI_GP0_ARLOCK,
            --s_axi_gp0_rvalid  => S_AXI_GP0_RVALID,
            --s_axi_gp0_rready  => S_AXI_GP0_RREADY,
            --s_axi_gp0_rdata   => S_AXI_GP0_RDATA,
            --s_axi_gp0_rresp   => S_AXI_GP0_RRESP,
            --s_axi_gp0_rid     => S_AXI_GP0_RID,
            --s_axi_gp0_rlast   => S_AXI_GP0_RLAST,
            --__CONNECT_S_AXI_GP1__
            --s_axi_gp1_aclk    => S_AXI_GP1_ACLK,
            --s_axi_gp1_aresetn => s_axi_gp1_aresetn_s,
            --s_axi_gp1_awvalid => S_AXI_GP1_AWVALID,
            --s_axi_gp1_awready => S_AXI_GP1_AWREADY,
            --s_axi_gp1_awaddr  => S_AXI_GP1_AWADDR,
            --s_axi_gp1_awprot  => S_AXI_GP1_AWPROT,
            --s_axi_gp1_awqos   => S_AXI_GP1_AWQOS,
            --s_axi_gp1_awcache => S_AXI_GP1_AWCACHE,
            --s_axi_gp1_awburst => S_AXI_GP1_AWBURST,
            --s_axi_gp1_awsize  => S_AXI_GP1_AWSIZE,
            --s_axi_gp1_awlen   => S_AXI_GP1_AWLEN,
            --s_axi_gp1_awid    => S_AXI_GP1_AWID,
            --s_axi_gp1_awlock  => S_AXI_GP1_AWLOCK,
            --s_axi_gp1_wvalid  => S_AXI_GP1_WVALID,
            --s_axi_gp1_wready  => S_AXI_GP1_WREADY,
            --s_axi_gp1_wdata   => S_AXI_GP1_WDATA,
            --s_axi_gp1_wstrb   => S_AXI_GP1_WSTRB,
            --s_axi_gp1_wlast   => S_AXI_GP1_WLAST,
            --s_axi_gp1_bvalid  => S_AXI_GP1_BVALID,
            --s_axi_gp1_bready  => S_AXI_GP1_BREADY,
            --s_axi_gp1_bresp   => S_AXI_GP1_BRESP,
            --s_axi_gp1_bid     => S_AXI_GP1_BID,
            --s_axi_gp1_arvalid => S_AXI_GP1_ARVALID,
            --s_axi_gp1_arready => S_AXI_GP1_ARREADY,
            --s_axi_gp1_araddr  => S_AXI_GP1_ARADDR,
            --s_axi_gp1_arprot  => S_AXI_GP1_ARPROT,
            --s_axi_gp1_arqos   => S_AXI_GP1_ARQOS,
            --s_axi_gp1_arcache => S_AXI_GP1_ARCACHE,
            --s_axi_gp1_arburst => S_AXI_GP1_ARBURST,
            --s_axi_gp1_arsize  => S_AXI_GP1_ARSIZE,
            --s_axi_gp1_arlen   => S_AXI_GP1_ARLEN,
            --s_axi_gp1_arid    => S_AXI_GP1_ARID,
            --s_axi_gp1_arlock  => S_AXI_GP1_ARLOCK,
            --s_axi_gp1_rvalid  => S_AXI_GP1_RVALID,
            --s_axi_gp1_rready  => S_AXI_GP1_RREADY,
            --s_axi_gp1_rdata   => S_AXI_GP1_RDATA,
            --s_axi_gp1_rresp   => S_AXI_GP1_RRESP,
            --s_axi_gp1_rid     => S_AXI_GP1_RID,
            --s_axi_gp1_rlast   => S_AXI_GP1_RLAST,
            --__CONNECT_S_AXI_HP0__
            --s_axi_hp0_aclk    => S_AXI_HP0_ACLK,
            --s_axi_hp0_aresetn => s_axi_hp0_aresetn_s,
            --s_axi_hp0_awvalid => S_AXI_HP0_AWVALID,
            --s_axi_hp0_awready => S_AXI_HP0_AWREADY,
            --s_axi_hp0_awaddr  => S_AXI_HP0_AWADDR,
            --s_axi_hp0_awprot  => S_AXI_HP0_AWPROT,
            --s_axi_hp0_awqos   => S_AXI_HP0_AWQOS,
            --s_axi_hp0_awcache => S_AXI_HP0_AWCACHE,
            --s_axi_hp0_awburst => S_AXI_HP0_AWBURST,
            --s_axi_hp0_awsize  => S_AXI_HP0_AWSIZE,
            --s_axi_hp0_awlen   => S_AXI_HP0_AWLEN,
            --s_axi_hp0_awid    => S_AXI_HP0_AWID,
            --s_axi_hp0_awlock  => S_AXI_HP0_AWLOCK,
            --s_axi_hp0_wvalid  => S_AXI_HP0_WVALID,
            --s_axi_hp0_wready  => S_AXI_HP0_WREADY,
            --s_axi_hp0_wdata   => S_AXI_HP0_WDATA,
            --s_axi_hp0_wstrb   => S_AXI_HP0_WSTRB,
            --s_axi_hp0_wlast   => S_AXI_HP0_WLAST,
            --s_axi_hp0_bvalid  => S_AXI_HP0_BVALID,
            --s_axi_hp0_bready  => S_AXI_HP0_BREADY,
            --s_axi_hp0_bresp   => S_AXI_HP0_BRESP,
            --s_axi_hp0_bid     => S_AXI_HP0_BID,
            --s_axi_hp0_arvalid => S_AXI_HP0_ARVALID,
            --s_axi_hp0_arready => S_AXI_HP0_ARREADY,
            --s_axi_hp0_araddr  => S_AXI_HP0_ARADDR,
            --s_axi_hp0_arprot  => S_AXI_HP0_ARPROT,
            --s_axi_hp0_arqos   => S_AXI_HP0_ARQOS,
            --s_axi_hp0_arcache => S_AXI_HP0_ARCACHE,
            --s_axi_hp0_arburst => S_AXI_HP0_ARBURST,
            --s_axi_hp0_arsize  => S_AXI_HP0_ARSIZE,
            --s_axi_hp0_arlen   => S_AXI_HP0_ARLEN,
            --s_axi_hp0_arid    => S_AXI_HP0_ARID,
            --s_axi_hp0_arlock  => S_AXI_HP0_ARLOCK,
            --s_axi_hp0_rvalid  => S_AXI_HP0_RVALID,
            --s_axi_hp0_rready  => S_AXI_HP0_RREADY,
            --s_axi_hp0_rdata   => S_AXI_HP0_RDATA,
            --s_axi_hp0_rresp   => S_AXI_HP0_RRESP,
            --s_axi_hp0_rid     => S_AXI_HP0_RID,
            --s_axi_hp0_rlast   => S_AXI_HP0_RLAST,
            --__CONNECT_S_AXI_HP1__
            --s_axi_hp1_aclk    => S_AXI_HP1_ACLK,
            --s_axi_hp1_aresetn => s_axi_hp1_aresetn_s,
            --s_axi_hp1_awvalid => S_AXI_HP1_AWVALID,
            --s_axi_hp1_awready => S_AXI_HP1_AWREADY,
            --s_axi_hp1_awaddr  => S_AXI_HP1_AWADDR,
            --s_axi_hp1_awprot  => S_AXI_HP1_AWPROT,
            --s_axi_hp1_awqos   => S_AXI_HP1_AWQOS,
            --s_axi_hp1_awcache => S_AXI_HP1_AWCACHE,
            --s_axi_hp1_awburst => S_AXI_HP1_AWBURST,
            --s_axi_hp1_awsize  => S_AXI_HP1_AWSIZE,
            --s_axi_hp1_awlen   => S_AXI_HP1_AWLEN,
            --s_axi_hp1_awid    => S_AXI_HP1_AWID,
            --s_axi_hp1_awlock  => S_AXI_HP1_AWLOCK,
            --s_axi_hp1_wvalid  => S_AXI_HP1_WVALID,
            --s_axi_hp1_wready  => S_AXI_HP1_WREADY,
            --s_axi_hp1_wdata   => S_AXI_HP1_WDATA,
            --s_axi_hp1_wstrb   => S_AXI_HP1_WSTRB,
            --s_axi_hp1_wlast   => S_AXI_HP1_WLAST,
            --s_axi_hp1_bvalid  => S_AXI_HP1_BVALID,
            --s_axi_hp1_bready  => S_AXI_HP1_BREADY,
            --s_axi_hp1_bresp   => S_AXI_HP1_BRESP,
            --s_axi_hp1_bid     => S_AXI_HP1_BID,
            --s_axi_hp1_arvalid => S_AXI_HP1_ARVALID,
            --s_axi_hp1_arready => S_AXI_HP1_ARREADY,
            --s_axi_hp1_araddr  => S_AXI_HP1_ARADDR,
            --s_axi_hp1_arprot  => S_AXI_HP1_ARPROT,
            --s_axi_hp1_arqos   => S_AXI_HP1_ARQOS,
            --s_axi_hp1_arcache => S_AXI_HP1_ARCACHE,
            --s_axi_hp1_arburst => S_AXI_HP1_ARBURST,
            --s_axi_hp1_arsize  => S_AXI_HP1_ARSIZE,
            --s_axi_hp1_arlen   => S_AXI_HP1_ARLEN,
            --s_axi_hp1_arid    => S_AXI_HP1_ARID,
            --s_axi_hp1_arlock  => S_AXI_HP1_ARLOCK,
            --s_axi_hp1_rvalid  => S_AXI_HP1_RVALID,
            --s_axi_hp1_rready  => S_AXI_HP1_RREADY,
            --s_axi_hp1_rdata   => S_AXI_HP1_RDATA,
            --s_axi_hp1_rresp   => S_AXI_HP1_RRESP,
            --s_axi_hp1_rid     => S_AXI_HP1_RID,
            --s_axi_hp1_rlast   => S_AXI_HP1_RLAST,
            --__CONNECT_S_AXI_HP2__
            --s_axi_hp2_aclk    => S_AXI_HP2_ACLK,
            --s_axi_hp2_aresetn => s_axi_hp2_aresetn_s,
            --s_axi_hp2_awvalid => S_AXI_HP2_AWVALID,
            --s_axi_hp2_awready => S_AXI_HP2_AWREADY,
            --s_axi_hp2_awaddr  => S_AXI_HP2_AWADDR,
            --s_axi_hp2_awprot  => S_AXI_HP2_AWPROT,
            --s_axi_hp2_awqos   => S_AXI_HP2_AWQOS,
            --s_axi_hp2_awcache => S_AXI_HP2_AWCACHE,
            --s_axi_hp2_awburst => S_AXI_HP2_AWBURST,
            --s_axi_hp2_awsize  => S_AXI_HP2_AWSIZE,
            --s_axi_hp2_awlen   => S_AXI_HP2_AWLEN,
            --s_axi_hp2_awid    => S_AXI_HP2_AWID,
            --s_axi_hp2_awlock  => S_AXI_HP2_AWLOCK,
            --s_axi_hp2_wvalid  => S_AXI_HP2_WVALID,
            --s_axi_hp2_wready  => S_AXI_HP2_WREADY,
            --s_axi_hp2_wdata   => S_AXI_HP2_WDATA,
            --s_axi_hp2_wstrb   => S_AXI_HP2_WSTRB,
            --s_axi_hp2_wlast   => S_AXI_HP2_WLAST,
            --s_axi_hp2_bvalid  => S_AXI_HP2_BVALID,
            --s_axi_hp2_bready  => S_AXI_HP2_BREADY,
            --s_axi_hp2_bresp   => S_AXI_HP2_BRESP,
            --s_axi_hp2_bid     => S_AXI_HP2_BID,
            --s_axi_hp2_arvalid => S_AXI_HP2_ARVALID,
            --s_axi_hp2_arready => S_AXI_HP2_ARREADY,
            --s_axi_hp2_araddr  => S_AXI_HP2_ARADDR,
            --s_axi_hp2_arprot  => S_AXI_HP2_ARPROT,
            --s_axi_hp2_arqos   => S_AXI_HP2_ARQOS,
            --s_axi_hp2_arcache => S_AXI_HP2_ARCACHE,
            --s_axi_hp2_arburst => S_AXI_HP2_ARBURST,
            --s_axi_hp2_arsize  => S_AXI_HP2_ARSIZE,
            --s_axi_hp2_arlen   => S_AXI_HP2_ARLEN,
            --s_axi_hp2_arid    => S_AXI_HP2_ARID,
            --s_axi_hp2_arlock  => S_AXI_HP2_ARLOCK,
            --s_axi_hp2_rvalid  => S_AXI_HP2_RVALID,
            --s_axi_hp2_rready  => S_AXI_HP2_RREADY,
            --s_axi_hp2_rdata   => S_AXI_HP2_RDATA,
            --s_axi_hp2_rresp   => S_AXI_HP2_RRESP,
            --s_axi_hp2_rid     => S_AXI_HP2_RID,
            --s_axi_hp2_rlast   => S_AXI_HP2_RLAST,
            --__CONNECT_S_AXI_HP3__
            --s_axi_hp3_aclk    => S_AXI_HP3_ACLK,
            --s_axi_hp3_aresetn => s_axi_hp3_aresetn_s,
            --s_axi_hp3_awvalid => S_AXI_HP3_AWVALID,
            --s_axi_hp3_awready => S_AXI_HP3_AWREADY,
            --s_axi_hp3_awaddr  => S_AXI_HP3_AWADDR,
            --s_axi_hp3_awprot  => S_AXI_HP3_AWPROT,
            --s_axi_hp3_awqos   => S_AXI_HP3_AWQOS,
            --s_axi_hp3_awcache => S_AXI_HP3_AWCACHE,
            --s_axi_hp3_awburst => S_AXI_HP3_AWBURST,
            --s_axi_hp3_awsize  => S_AXI_HP3_AWSIZE,
            --s_axi_hp3_awlen   => S_AXI_HP3_AWLEN,
            --s_axi_hp3_awid    => S_AXI_HP3_AWID,
            --s_axi_hp3_awlock  => S_AXI_HP3_AWLOCK,
            --s_axi_hp3_wvalid  => S_AXI_HP3_WVALID,
            --s_axi_hp3_wready  => S_AXI_HP3_WREADY,
            --s_axi_hp3_wdata   => S_AXI_HP3_WDATA,
            --s_axi_hp3_wstrb   => S_AXI_HP3_WSTRB,
            --s_axi_hp3_wlast   => S_AXI_HP3_WLAST,
            --s_axi_hp3_bvalid  => S_AXI_HP3_BVALID,
            --s_axi_hp3_bready  => S_AXI_HP3_BREADY,
            --s_axi_hp3_bresp   => S_AXI_HP3_BRESP,
            --s_axi_hp3_bid     => S_AXI_HP3_BID,
            --s_axi_hp3_arvalid => S_AXI_HP3_ARVALID,
            --s_axi_hp3_arready => S_AXI_HP3_ARREADY,
            --s_axi_hp3_araddr  => S_AXI_HP3_ARADDR,
            --s_axi_hp3_arprot  => S_AXI_HP3_ARPROT,
            --s_axi_hp3_arqos   => S_AXI_HP3_ARQOS,
            --s_axi_hp3_arcache => S_AXI_HP3_ARCACHE,
            --s_axi_hp3_arburst => S_AXI_HP3_ARBURST,
            --s_axi_hp3_arsize  => S_AXI_HP3_ARSIZE,
            --s_axi_hp3_arlen   => S_AXI_HP3_ARLEN,
            --s_axi_hp3_arid    => S_AXI_HP3_ARID,
            --s_axi_hp3_arlock  => S_AXI_HP3_ARLOCK,
            --s_axi_hp3_rvalid  => S_AXI_HP3_RVALID,
            --s_axi_hp3_rready  => S_AXI_HP3_RREADY,
            --s_axi_hp3_rdata   => S_AXI_HP3_RDATA,
            --s_axi_hp3_rresp   => S_AXI_HP3_RRESP,
            --s_axi_hp3_rid     => S_AXI_HP3_RID,
            --s_axi_hp3_rlast   => S_AXI_HP3_RLAST,
            --__CONNECT_IRQ_F2P__
            --irq_f2p           => std_logic_vector(resize(unsigned(IRQ_F2P), 16)),
            --__
            --
            rst_o             => rst_s);

    --
    m_axi_gp0_aresetn_s <= not rst_s;
    m_axi_gp1_aresetn_s <= not rst_s;
    --
    s_axi_gp0_aresetn_s <= not rst_s;
    s_axi_gp1_aresetn_s <= not rst_s;
    --
    s_axi_hp0_aresetn_s <= not rst_s;
    s_axi_hp1_aresetn_s <= not rst_s;
    s_axi_hp2_aresetn_s <= not rst_s;
    s_axi_hp3_aresetn_s <= not rst_s;
    --

    --__CONNECT_FCLK_RESET0_N__
    --FCLK_RESET0_N <= not rst_s;
    --__CONNECT_FCLK_RESET1_N__
    --FCLK_RESET1_N <= not rst_s;
    --__CONNECT_FCLK_RESET2_N__
    --FCLK_RESET2_N <= not rst_s;
    --__CONNECT_FCLK_RESET3_N__
    --FCLK_RESET3_N <= not rst_s;
    --__

    -- Other inputs and outputs are left unconnected because they are not
    -- needed for this design and will therefore stay in an 'U' or 'X' state in
    -- simulation. They should not connected to anything meaningful in the top
    -- design.

end architecture struct;

  