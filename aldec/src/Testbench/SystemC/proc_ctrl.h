/**
 *  @file proc_ctrl.h
 *  Header file for main() function.
 *  
 *  For SystemC, it defines that the main() function is a thread.
 *  
 *  $Rev$
 *  $Author$
 *  $LastChangedDate$
 *  $Id$
 *  $URL$
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
