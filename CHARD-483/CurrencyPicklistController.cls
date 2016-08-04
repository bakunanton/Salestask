global class CurrencyPicklistController {
	global List<SelectOption> currencyString {get; set;}
	global String selectedCurrency {get; set;}


	private Apexpages.Standardcontroller std {get; set;}

	global CurrencyPicklistController(ApexPages.StandardController c) {
		std = c;
		sObject obj = new TChargentDynamics.ChargentOOC().queryLimit1(std.getId(), new List<String> {
			'Id',
			'Gateway__c',
			'Currency__c'
		});
		TChargentDynamics.ChargentOOC ooc = new TChargentDynamics.ChargentOOC(obj);
		this.currencyString = getCurrencyString();
		this.selectedCurrency = (ooc.get('Currency__c') == null) ? null : String.ValueOf(ooc.get('Currency__c')).toLowerCase();
		if (ooc.get('Gateway__c') == null) {
			this.selectedCurrency = '';
		}
		else {
			Gateway__c gtw = [select id, CBASE_CM__Available_Currencies__c from CBASE_CM__Gateway__c where id=:String.ValueOf(ooc.get('Gateway__c')) limit 1];
			if (gtw != null && String.IsNotBlank(gtw.CBASE_CM__Available_Currencies__c)) {
				if (String.IsNotBlank(selectedCurrency) && !gtw.CBASE_CM__Available_Currencies__c.containsIgnoreCase(selectedCurrency)) {
					this.selectedCurrency = '';
				}
			}
			else {
				this.selectedCurrency = '';
			}
		}
	}

	global List<SelectOption> getCurrencyString() {
		List<SelectOption> options = new List<SelectOption>();
		options.add(new SelectOption('', '--None--'));
		sObject obj = new TChargentDynamics.ChargentOOC().queryLimit1(std.getId(), new List<String> {
			'Id',
			'Gateway__c',
			'Currency__c'
		});
		TChargentDynamics.ChargentOOC ooc = new TChargentDynamics.ChargentOOC(obj);
		if (ooc.get('Gateway__c') != null) {
			Gateway__c gtw = [select id, CBASE_CM__Available_Currencies__c from CBASE_CM__Gateway__c where id=:String.ValueOf(ooc.get('Gateway__c')) limit 1];
			if (gtw != null && String.IsNotBlank(gtw.CBASE_CM__Available_Currencies__c)) {
				List<String> curr = gtw.CBASE_CM__Available_Currencies__c.split(';');
				for (String c : curr) {
					options.add(new SelectOption(c.toLowerCase(), c));
				}
			}
		}

		return options;
	}

	global void setCurrencyString() {
		sObject obj = new TChargentDynamics.ChargentOOC().queryLimit1(std.getId(), new List<String> {
			'Id',
			'Gateway__c',
			'Currency__c'
		});
		TChargentDynamics.ChargentOOC ooc = new TChargentDynamics.ChargentOOC(obj);

		ooc.set('Currency__c', String.ValueOf(selectedCurrency));
		try {
			update ooc.getSobject();
		} catch (Exception e) {
			List<SelectOption> options = new List<SelectOption>();
			options.add(new SelectOption('', '--None--'));
			this.currencyString = options;
		}
	}

	global void isOrgMultiCurrency(String currensyName, String namePackage){
		Boolean orgIsMultiCurrency = UserInfo.isMultiCurrencyOrganization();
		if (orgIsMultiCurrency) {
			//String currencyCountry = TChargentMapper.MapCurrencyNameByCurrency(currensyName);
			//if ( namePackage.equals('Opportunity')) { 
			//	List<Opportunity> currencyType = [Select ID, CurrencyIsoCode From  Opportunity];// if org multi currensy uncomment
			//	Opportunity currencyIso = new Opportunity();
			//	currencyIso.CurrencyIsoCode = currencyCountry;
			//	currencyType.add(currencyIso);
			//try {
			//	insert  currencyType;
			//} catch (Exception e) {
			//}
			//}
			//if ( namePackage.equals('name package')) { 
			//List<'namePackage'> currencyType = [Select ID, CurrencyIsoCode From  'namePackage'];
			//'namePackage' currencyIso = new 'namePackage'();
			//currencyIso.CurrencyIsoCode = currencyCountry;
			//}
		}
	}

}