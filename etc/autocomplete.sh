_script()
{
  _script_commands=$(/home/chimica2/ecipriano/OpenSMOKE/OpenSMOKEppTutorials/Alltest.sh)

  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  opts="OpenSMOKEpp_CounterFlowFlame1D.sh OpenSMOKEpp_PlugFlowReactor.sh OpenSMOKEpp_BatchReactor.sh OpenSMOKEpp_CHEMKIN_PreProcessor.sh OpenSMOKEpp_LaminarFlamelet.sh OpenSMOKEpp_LookUpTables.sh OpenSMOKEpp_PerfectlyStirredReactor.sh OpenSMOKEpp_PremixedLaminarFlame1D.sh OpenSMOKEpp_ShockTubeReactor.sh OpenSMOKEpp_SurfaceBatchReactor.sh OpenSMOKEpp_SurfacePlugFlowReactor.sh OpenSMOKEpp_SurfacePerfectlyStirredReactor.sh OpenSMOKEpp_ThermodynamicEquilibrium.sh OpenSMOKEpp_MicrogravityDroplet.sh OpenSMOKEpp_PartiallyStirredReactor.sh"

  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
}
complete -F _script ./Alltest.sh

