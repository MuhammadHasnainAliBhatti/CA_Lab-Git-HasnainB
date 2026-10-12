/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
IKI_DLLESPEC extern void execute_1063(char*, char *);
IKI_DLLESPEC extern void execute_1064(char*, char *);
IKI_DLLESPEC extern void execute_1066(char*, char *);
IKI_DLLESPEC extern void execute_1911(char*, char *);
IKI_DLLESPEC extern void execute_1912(char*, char *);
IKI_DLLESPEC extern void execute_1913(char*, char *);
IKI_DLLESPEC extern void execute_1914(char*, char *);
IKI_DLLESPEC extern void execute_1915(char*, char *);
IKI_DLLESPEC extern void execute_1916(char*, char *);
IKI_DLLESPEC extern void execute_1917(char*, char *);
IKI_DLLESPEC extern void execute_3(char*, char *);
IKI_DLLESPEC extern void execute_4(char*, char *);
IKI_DLLESPEC extern void execute_5(char*, char *);
IKI_DLLESPEC extern void execute_1072(char*, char *);
IKI_DLLESPEC extern void execute_1905(char*, char *);
IKI_DLLESPEC extern void execute_1906(char*, char *);
IKI_DLLESPEC extern void execute_1907(char*, char *);
IKI_DLLESPEC extern void execute_1908(char*, char *);
IKI_DLLESPEC extern void execute_1909(char*, char *);
IKI_DLLESPEC extern void execute_1910(char*, char *);
IKI_DLLESPEC extern void execute_1098(char*, char *);
IKI_DLLESPEC extern void execute_1073(char*, char *);
IKI_DLLESPEC extern void execute_1075(char*, char *);
IKI_DLLESPEC extern void execute_1077(char*, char *);
IKI_DLLESPEC extern void execute_1068(char*, char *);
IKI_DLLESPEC extern void execute_1069(char*, char *);
IKI_DLLESPEC extern void execute_1070(char*, char *);
IKI_DLLESPEC extern void execute_1071(char*, char *);
IKI_DLLESPEC extern void execute_1918(char*, char *);
IKI_DLLESPEC extern void execute_1919(char*, char *);
IKI_DLLESPEC extern void execute_1920(char*, char *);
IKI_DLLESPEC extern void execute_1921(char*, char *);
IKI_DLLESPEC extern void execute_1922(char*, char *);
IKI_DLLESPEC extern void execute_1923(char*, char *);
IKI_DLLESPEC extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[35] = {(funcp)execute_1063, (funcp)execute_1064, (funcp)execute_1066, (funcp)execute_1911, (funcp)execute_1912, (funcp)execute_1913, (funcp)execute_1914, (funcp)execute_1915, (funcp)execute_1916, (funcp)execute_1917, (funcp)execute_3, (funcp)execute_4, (funcp)execute_5, (funcp)execute_1072, (funcp)execute_1905, (funcp)execute_1906, (funcp)execute_1907, (funcp)execute_1908, (funcp)execute_1909, (funcp)execute_1910, (funcp)execute_1098, (funcp)execute_1073, (funcp)execute_1075, (funcp)execute_1077, (funcp)execute_1068, (funcp)execute_1069, (funcp)execute_1070, (funcp)execute_1071, (funcp)execute_1918, (funcp)execute_1919, (funcp)execute_1920, (funcp)execute_1921, (funcp)execute_1922, (funcp)execute_1923, (funcp)vlog_transfunc_eventcallback};
const int NumRelocateId= 35;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/fsm_alu_tb_behav/xsim.reloc",  (void **)funcTab, 35);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/fsm_alu_tb_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void wrapper_func_0(char *dp)

{

}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/fsm_alu_tb_behav/xsim.reloc");
	wrapper_func_0(dp);

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/fsm_alu_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/fsm_alu_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/fsm_alu_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
