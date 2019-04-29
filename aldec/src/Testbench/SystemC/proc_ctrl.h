/**
 *  @file proc_ctrl.h
 *  Header file for main() function.
 *  
 *  For SystemC, it defines that the main() function is a thread.
 *  
 *  $Rev: 12770 $
 *  $Author: pdaraiche $
 *  $LastChangedDate: 2013-12-20 12:01:34 -0500 (ven., 20 déc. 2013) $
 *  $Id: proc_ctrl.h 12770 2013-12-20 17:01:34Z pdaraiche $
 *  $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/aldec/src/Testbench/SystemC/proc_ctrl.h $
 */
#ifndef __PROC_CTRL_H__
#define __PROC_CTRL_H__

#include <systemc.h>
#include "mb_transactor.h"
#include "xbasic_types.h"	

#define NO_INST_DELAY // No microblaze added instruction delays

/**
 *  Processing controller class.
 *  Here is the call for a SystemC module and it defines main() as a SC_THREAD 
 */
class proc_ctrl : public sc_module
{
public:
   sc_port<mb_transactor_task_if> transactor_interface; /*< Transactor Interface for SystemC simulation*/

   //Constructor
   SC_CTOR(proc_ctrl)
   {
      // Define main() as a SC_THREAD for SystemC simulation
      SC_THREAD(main);
   }

   void main();  /*< Function main() for SystemC simulation */

};

//void sim_print(char *ptr);
//void sim_printf(const char *format, ...);


#endif //__PROC_CTRL_H__
