----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2026 07:29:06 PM
-- Design Name: 
-- Module Name: cpa_adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cpa_adder is
    Port ( i_val_a : in STD_LOGIC_VECTOR (7 downto 0);
           i_val_b : in STD_LOGIC_VECTOR (7 downto 0);
           i_val_c_in : in STD_LOGIC;
           o_val_sum : out STD_LOGIC_VECTOR (7 downto 0);
           o_val_cout : out STD_LOGIC);
end cpa_adder;

architecture Behavioral of cpa_adder is

    signal w_result : unsigned (8 downto 0);

begin

    w_result <= unsigned('0' & i_val_a) + unsigned('0' & i_val_b) + (0 => i_val_c_in);
    o_val_sum <= std_logic_vector(w_result(7 downto 0));
    o_val_cout <= w_result(8);

end Behavioral;