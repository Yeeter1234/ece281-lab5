----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:42:49 PM
-- Design Name: 
-- Module Name: controller_fsm - FSM
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller_fsm is
    Port ( i_reset : in STD_LOGIC;
           i_adv : in STD_LOGIC;
           o_cycle : out STD_LOGIC_VECTOR (3 downto 0));
end controller_fsm;

architecture FSM of controller_fsm is

    type sm_action is (load_A, load_B, load_op, execute);
    signal f_Q, f_Q_next : sm_action;

begin

    process(i_adv, i_reset)
    begin
        if i_reset = '1' then 
            f_Q <= load_A;
        elsif rising_edge(i_adv) then 
            f_Q <= f_Q_next;
        end if;
    end process;
    
    f_Q_next <= load_B when (f_Q = load_A) else
                load_op when (f_Q = load_B) else
                execute when (f_Q = load_op) else
                load_A;
                
    o_cycle <= "0010" when (f_Q = load_B) else
               "0100" when (f_Q = load_op) else
               "1000" when (f_Q = execute) else
               "0001";

end FSM;
