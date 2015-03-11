if (local player) then { 
   player enableFatigue false; 
   player addMPEventhandler ["MPRespawn", {player enableFatigue false}]; 
};