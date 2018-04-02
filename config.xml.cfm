<?xml version="1.0" encoding="UTF-8"?>
    <mura name="MuraAuthenticator" contenttypes="" xmlns="">
		<extensions xmlns="">
			<extension adminonly="0" availablesubtypes="" basekeyfield="userID" basetable="tusers" datatable="tclassextenddatauseractivity" description="" hasassocfile="1" hasbody="1" hasconfigurator="0" hassummary="1" iconclass="" subtype="Default" type="2" xmlns="">
				<attributeset categoryid="" container="Custom" name="MuraAuthenticator" orderno="1" xmlns="">
					<attribute adminonly="0" defaultvalue="" hint="" label="muraauthkey" message="" name="muraauthkey" optionlabellist="" optionlist="" orderno="1" regex="" required="false" type="Hidden" validation="" xmlns=""/>
					<attribute adminonly="0" defaultvalue="" hint="" label="muraauthverificationcode" message="" name="muraauthverificationcode" optionlabellist="" optionlist="" orderno="2" regex="" required="false" type="Hidden" validation="" xmlns=""/>
					<attribute adminonly="0" defaultvalue="" hint="" label="muraauthscratchcodes" message="" name="muraauthscratchcodes" optionlabellist="" optionlist="" orderno="3" regex="" required="false" type="Hidden" validation="" xmlns=""/>
					<attribute adminonly="0" defaultvalue="false" hint="" label="muraauthdeviceverified" message="" name="muraauthdeviceverified" optionlabellist="True^False" optionlist="true^false" orderno="4" regex="" required="false" type="RadioGroup" validation="" xmlns=""/>
					<attribute adminonly="0" defaultvalue="" hint="" label="muraauthdatelastverified" message="" name="muraauthdatelastverified" optionlabellist="" optionlist="" orderno="5" regex="" required="false" type="Hidden" validation="" xmlns=""/>
				</attributeset>
			</extension>
		</extensions>
	</mura>