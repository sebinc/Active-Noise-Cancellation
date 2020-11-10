/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    xilinxcorelib_ver_m_00000000001358910285_1007038503_init();
    xilinxcorelib_ver_m_00000000001687936702_3671873966_init();
    xilinxcorelib_ver_m_00000000000277421008_3140589605_init();
    xilinxcorelib_ver_m_00000000001786246093_1506004959_init();
    work_m_00000000000403262735_2976612627_init();
    work_m_00000000002242508781_1856784803_init();
    work_m_00000000000153180868_0506809809_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000000153180868_0506809809");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
