namespace OpenSMOKE
{
	template<typename map>
	class KineticsMap_Surface_CHEMKIN_Lumped : public KineticsMap_Surface_CHEMKIN<map>
	{
		public:

		KineticsMap_Surface_CHEMKIN_Lumped(ThermodynamicsMap_Surface_CHEMKIN<map>& thermo, rapidxml::xml_document<>& doc)
		: KineticsMap_Surface_CHEMKIN<map>(thermo, doc)
		{

		}


		virtual void UserDefinedReactionRates(const OpenSMOKEVectorDouble& c, 
												const OpenSMOKEVectorDouble& z, 
												const OpenSMOKEVectorDouble& a, 
												const OpenSMOKEVectorDouble& gamma)
		{

		}

		private:


	};

}
