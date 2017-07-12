//Grass Cutting Script added to all players when they join the server, JIP works.
waitUntil {!isNull player};

_unit = _this select 0;

_unit addAction [("<t color=""#00FF00"">Cortar grama</t>"), {["Cutting Grass",5];
_cutter= "Land_ClutterCutter_large_F" createVehicle [0,0,0]; _cutter setPos (getPos player);
sleep 5; deleteVehicle _cutter},[],1,false,true,"","_this == _target"];