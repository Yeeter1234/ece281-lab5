----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:50:18 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;   
--use UNISIM.VComponents.all;

entity ALU is
    Port ( i_A : in STD_LOGIC_VECTOR (7 downto 0);
           i_B : in STD_LOGIC_VECTOR (7 downto 0);
           i_op : in STD_LOGIC_VECTOR (2 downto 0);
           o_result : out STD_LOGIC_VECTOR (7 downto 0);
           o_flags : out STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is

    component cpa_adder is
    Port ( i_val_a : in STD_LOGIC_VECTOR (7 downto 0);
           i_val_b : in STD_LOGIC_VECTOR (7 downto 0);
           i_val_c_in : in STD_LOGIC;
           o_val_sum : out STD_LOGIC_VECTOR (7 downto 0);
           o_val_cout : out STD_LOGIC);
    end component cpa_adder;
    
    signal w_val_b : std_logic_vector (7 downto 0);
    signal w_val_c_in : std_logic;
    signal w_val_cout : std_logic;
    signal w_val_sum : std_logic_vector (7 downto 0);
    signal w_val_result : std_logic_vector (7 downto 0);
    signal w_flag_n : std_logic;
    signal w_flag_z : std_logic;
    signal w_flag_c : std_logic;
    signal w_flag_v : std_logic;

begin

    w_val_c_in <= '0' when (i_op = "000") else
                  '1' when (i_op = "001") else
                  '0';
                  
    w_val_b <= i_B when (i_op = "000") else
               not i_B when (i_op = "001") else
               i_B;
                        

    cpa_adder_inst : cpa_adder port map (
        i_val_a => i_A,
        i_val_b => w_val_b,
        i_val_c_in => w_val_c_in,
        o_val_sum => w_val_sum,
        o_val_cout => w_val_cout
    );
    
    w_val_result <= i_A and i_B when (i_op = "010") else
                 i_A or i_B when (i_op = "011") else
                 w_val_sum;  
    
    w_flag_c <= w_val_cout and not (i_op(1));
    
    w_flag_n <= w_val_result(7);
    
    w_flag_z <= '1' when (w_val_result = "00000000") else '0';
    
    w_flag_v <= ((not(i_A(7)) and not(w_val_b(7)) and w_val_result(7)) or 
                (i_A(7) and w_val_b(7) and not(w_val_result(7)))) and not (i_op(1));
                
    o_result <= w_val_result;
    
    o_flags <= w_flag_n & w_flag_z & w_flag_c & w_flag_v;

end Behavioral;
