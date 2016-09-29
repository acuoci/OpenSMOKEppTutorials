namespace OpenSMOKE
{
	template<typename map>
	class KineticsMap_Surface_CHEMKIN_Lumped : public KineticsMap_Surface_CHEMKIN<map>
	{
		public:

		KineticsMap_Surface_CHEMKIN_Lumped(ThermodynamicsMap_Surface_CHEMKIN<map>& thermo, rapidxml::xml_document<>& doc)
		: KineticsMap_Surface_CHEMKIN<map>(thermo, doc)
		{
			
			//- Homogeneous species
			iC3H8 = this->thermodynamics_.IndexOfSpecies("C3H8");
			
			
			//- Adsorbed species
			iRh = this->thermodynamics_.IndexOfSpecies("Rh(s)") - thermo.number_of_gas_species();
			iO = this->thermodynamics_.IndexOfSpecies("O(s)") - thermo.number_of_gas_species();

			for (unsigned int j = 0; j < this->number_of_lumped_reactions_; j++)
			{
				
				if (this->names_of_lumped_functions_[j] == "OXC3H8dir")
					iOXC3H8dir = this->indices_of_lumped_reactions_[j+1];
				else if (this->names_of_lumped_functions_[j] == "SRC3H8dir")
					iSRC3H8dir = this->indices_of_lumped_reactions_[j+1];
				else if (this->names_of_lumped_functions_[j] == "OXC3H8inv")
					iOXC3H8inv = this->indices_of_lumped_reactions_[j+1];
				else if (this->names_of_lumped_functions_[j] == "SRC3H8inv")
					iSRC3H8inv = this->indices_of_lumped_reactions_[j+1];
				else
				{
					std::cout << "ERROR: " << this->names_of_lumped_functions_[j+1] << " NOT recognized LUMPED name!" << std::endl;
					exit(-1);
				}
			}
		}

		virtual void UserDefinedReactionRates(const OpenSMOKEVectorDouble& c, 
												const OpenSMOKEVectorDouble& z, 
												const OpenSMOKEVectorDouble& a, 
												const OpenSMOKEVectorDouble& gamma)
		{
			OpenSMOKEVectorDouble Ppar(c.Size());
			for (unsigned int i=1;i<=c.Size();i++)
				Ppar[i] = c[i]*1.e03*PhysicalConstants::R_J_mol*this->T_/101325.;							// [atm]
			
			//- Parameters
			double ka;
			double Eatt;
			double T0 = 873.;																				// [K]
			
			//- Oxidation
			ka = 1.99*1.e-05;																				// [mol/(atm*cm2*s)]
			Eatt = 90.*1e03;																				// [J/mol]
			double kOX = ka*std::exp((-Eatt/PhysicalConstants::R_J_mol)*((1./this->T_)-(1./T0)))*z[iO]*z[iRh];			// [mol/(atm*cm2*s)]

			//- Reforming
			ka = 1.34*1.e-05;																				// [mol/(atm*cm2*s)]
			Eatt = 50.*1e03;																				// [J/mol]
			double kSR = ka*std::exp((-Eatt/PhysicalConstants::R_J_mol)*((1./this->T_)-(1./T0)))*std::pow(z[iRh],2.);		// [mol/(atm*cm2*s)]

			//- C3H8
			this->netReactionRates_[iOXC3H8dir] = kOX*Ppar[iC3H8]*1e-03/1.e-04;
			this->netReactionRates_[iOXC3H8inv] = 0.;
			this->netReactionRates_[iSRC3H8dir] = kSR*Ppar[iC3H8]*1e-03/1.e-04;
			this->netReactionRates_[iSRC3H8inv] = 0.;

		}

		private:

		//- Homogeneous species
		unsigned int iC3H8;
		unsigned int iC3H6;
		unsigned int iC2H4;

		//- Adsorbed species
		unsigned int iRh;
		unsigned int iO;

		//- Reactions (DIR)
		unsigned int iOXC3H8dir;
		unsigned int iSRC3H8dir;

		//- Reactions (INV)
		unsigned int iOXC3H8inv;
		unsigned int iSRC3H8inv;

	};

}
