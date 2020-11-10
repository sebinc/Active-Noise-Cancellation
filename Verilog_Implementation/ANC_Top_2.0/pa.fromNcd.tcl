
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name ANC_Top_2.0 -dir "X:/0_xlinx_ISE/ANC_Top_2.0/planAhead_run_1" -part xc6slx9csg324-2
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "X:/0_xlinx_ISE/ANC_Top_2.0/ANCTop_V.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {X:/0_xlinx_ISE/ANC_Top_2.0} {ipcore_dir} }
add_files [list {ipcore_dir/BlockRam.ncf}] -fileset [get_property constrset [current_run]]
set_property target_constrs_file "mimasv2_user_constraints_file.ucf" [current_fileset -constrset]
add_files [list {mimasv2_user_constraints_file.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "X:/0_xlinx_ISE/ANC_Top_2.0/ANCTop_V.ncd"
if {[catch {read_twx -name results_1 -file "X:/0_xlinx_ISE/ANC_Top_2.0/ANCTop_V.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"X:/0_xlinx_ISE/ANC_Top_2.0/ANCTop_V.twx\": $eInfo"
}
