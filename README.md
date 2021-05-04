OpenSMOKE++ Solvers Project!
=====================

The OpenSMOKE++ Solvers Project is a collection of numerical solvers built on the top of the [OpenSMOKE++ framework][1].
The project is managed by the [CRECK Modeling Group][2] at the Department of Chemistry, Materials, and 
Chemical Engineering of the Politecnico di Milano (Italy).


Solvers currently available
---------

 - **CHEMKIN_PreProcessor**: kinetic pre-processor based on the CHEMKIN format
 - **BatchReactor**: solution of constant pressure or constant volume batch reactors in isothermal or adiabatic conditions
 - **PerfectlyStirredReactor**: solution of constant pressure or constant volume perfectly stirred reactors in isothermal or adiabatic conditions
 - **PlugFlowReactor**: solution of constant pressure plug flow reactors in isothermal or adiabatic conditions 
 - **RapidCompressionMachine**: solution of rapid compression machines for the estimation of ignition delay times
 - **ShockTubeReactor**: solution of shock tube reactors
 - **OpenSMOKEpp_PartiallyStirredReactor**: numerical simulation of partially stirred reactor (via stochastic method)
 - **CounterFlowFlame1D**: numerical simulation of laminar counterflow diffusion flames 
 - **PremixedLaminarFlame1D**: numerical simulation of premixed laminar flat flames (burner-stabilized flames and flame speed solver)
 - **LaminarFlamelets**: numerical simulation of non adiabatic steady-state laminar flamelets 
 - **LookUpTables**: generation of look-up tables based on laminar flamelets calculated using the `LaminarFlamelets` solver
 - **MicrogravityDroplet**: numerical simulation of isolated fuel droplets burning in microgravity conditions

  [1]: https://www.opensmokepp.polimi.it/
  [2]: http://creckmodeling.chem.polimi.it/
