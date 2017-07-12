// infoPage.sqf
// by CRE4MPIE
// ver 0.1
// 2015-02-01 01:20pm
// contributions from BIStudio Forums, by CRE4MPIE


sleep 20;   //delay before message is displayed after logging in
	
_text = "
<t align='center'><t shadow= 1 shadowColor='#000000'><t size='1.2'><t color='#c08f30'>HCCorp Wasteland Altis</t>
<br />
<br />
<t align='center'><t size='1.2'><t shadow= 1 shadowColor='#000000'>Atalhos</t><br />
<br />
<t align='left'><img size='2' shadow = 0 image='addons\InfoPage\img\windows.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Nomes Jogadores</t><br />
<t align='left'><img size='2' shadow = 0 image='addons\InfoPage\img\end.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Inserir/Remover Earplugs</t><br />
<t align='left'><img size='2' shadow = 0 image='addons\InfoPage\img\v.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Abrir/Fechar Paraquedas</t><br />
<t align='left'><img size='2' shadow = 0 image='addons\InfoPage\img\h.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Guardar arma</t><br />
<t align='left'><img size='2' shadow = 0 image='addons\InfoPage\img\del.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Ejeção de Emergência</t><br />
<br />
<t align='center'><t size='1.2'><t shadow= 0 shadowColor='#bc752f'>Divirta-se e respeite os outros jogadores. Team Kill ou uso de bugs/exploits resultara em banimento</t><br />
<br />";

hint parseText format ["<t align='center'>Bem vindo(a) %2 ao</t><br />%1",_text, name player];
 
 
