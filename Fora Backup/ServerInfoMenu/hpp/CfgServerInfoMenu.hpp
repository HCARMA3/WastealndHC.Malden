class CfgServerInfoMenu
{
   addAction = 0; // Enable/disable action menu item | use 0 to disable | default: 1 (enabled)
//   antiHACK = "infiSTAR + BattlEye";
   antiHACK = "BattlEye";
   hostedBy = "Mgthost1";
   ipPort = "189.1.169.221:2342";
   openKey = "User7"; // https://community.bistudio.com/wiki/inputAction/actions
   openAtLogin = no;
   restart = 4; // Amount of hours before server automatically restarts
   serverName = "HC Corp A3Wasteland Altis";
   class menuItems
   {
      // title AND content accept formatted text ( since update Oct5.2016 )
	  class first
      {
         menuName = "Rules";
         title = "Regras do servidor|Server rules";
         content[] = {
            "<t size='1.70'>Regras do servidor A3Wasteland Altis <t color='#b8870a'>HC Corp</t>|<t color='#b8870a'>HC Corp</t> A3Wasteland Altis server rules</t><br />",
            "1. É proibido o uso de cheats, exploits e/ou hacks. Penalidade: <t color='#ff0000'>banimento</t><br />",
            "1. Using cheats, exploits and/or hacks is forbidden. Penalty: <t color='#ff0000'>ban</t><br />",
            "2. Seja educado. Respeite o servidor, os administradores, os membros da HC Corp e todos os outros jogadores. Penalidades: primeira ofensa; aviso; ofensas seguintes; <t color='#ff0000'>banimento</t><br />",
            "2. Be polite. Respect the server, the administrators, the HC Corp members and all the other players. Penalties: first offense; warning; following offenses; <t color='#ff0000'>ban</t><br />"

         };
      };
      class second
      {
         menuName = "Missions";
         title = "<t color='#b8870a'>Missões do servidor|Server missions</t>";
         content[] = {
            "<br/>• Small Money Shipment: $50,000<br />• Medium Money Shipment: $100,000<br />• Large Money Shipment: $150,000<br />• Heavy Money Shipment: $200,000<br />• Sunken Treasure: $85,000<br /></p>"
         };
      };
      class third
      {
         menuName = "Info";
         title = "<t color='#b8870a'>Informações do Sevidor| Server information</t>";
         content[] = {"<t size='1.75'>Bases e Favela</t><br />• BASE INDEPENDENTE| A Base Independente tem Respawn com chance de 1% de Blackfoot, Nightstalker e Capacete de caça. Ela não é protegida. Nivel: Molezinha<br />• BASE OPFOR| A Base Opfor tem Respawn com chance de 1% de Nightstalker e Capacete de caça. Ela é Protegida por Bots. Nivel: Medio<br />• BASE BLUEFOR| A Base Bluefor tem Respawn com chance de 1% de Blackfoot, Nightstalker e Capacete de caça. Ela é protegida por Bots. Nivel: Muito Difícil<br />• FAVELA| A Favela tem Respawn com chance de 1% de Nightstalker e Capacete de caça. Ela é protegida por Bots. Nivel: Difícil<br />• Ilha ACC| A ilha tem todas as Stores, porem, não há caixa, leve dineheiro. A gun da ilha é a unica protegida, então lá, fique tranquilo <br />"};
      };
      class fourth
      {
         menuName = "Admins";
         title = "<t color='#b8870a'>Administradores|Administrators</t>";
         content[] = {"<t size='1.75'>Admin</t><br /><t color='#b8870a'>• leonbarba<br />• rover047</t><br />"};
//         content[] = {"<t size='1.75'>Admin</t><br /><t color='#b8870a'>• NICK 1<br />• NICK 2 <br />• NICK 3</t><br />",
//            "<t size='1.75'>Editor</t><br /><t color='#b8870a'>• NICK 1<br />• NICK 2</t><br />"};
      };
//      class fifth
//      {
//         menuName = "Rank";
//         title = "<t color='#b8870a'>Top 10</t>";
//         content[] = {"<t size='1.75'>Rank</t><br />• EM BREVE|SOON<br />"};
//      };
//      class sixth
      class fifth
      {
         menuName = "Communication";
         title = "<t color='#b8870a'>Servidor de voz|Voice server</t>"; 
         content[] = {
            "<t size='1.75'>TeamSpeak:</t><br /><t color='#b8870a'><a href='http://www.teamspeak.com/invite/186.228.98.5/?port=9991'>186.228.98.5:9991</a></t><br />"
         };
      };
//      class seventh
//      {
//         menuName = "Updates";
//         title = "<t color='#b8870a'>Atualiza&ccedil;&otilde;es|Updates</t>";
//         content[] = {
//            "<t size='1.75'>Atualiza&ccedil;&otilde;es|Updates</t><br /><t color='#b8870a'><a href='http://www.hccorp.com.br'>www.hccorp.com.br</a></t><br />"
//         };
//      };
   };
};
