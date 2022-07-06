/// @description 

#region//Velocidad gravedad ysalto.
hsp=0;
vsp =0;
grv =0.3;
walksp=4;
jumpsp=-11;
#endregion




#region//UpdaetMovement
actualizarMovimiento = function()
{
	vsp += grv;
	
	//collision horizontal
	//lugar_de_contacto
	if (place_meeting(x + hsp , y-10, oBlock))
	{
		while (!place_meeting(x + sign(hsp), y+1, oBlock))
		{
			x += sign(hsp);
		}
		hsp = 0;
	}
	x += hsp ;
	//collision vertical
	if (place_meeting(x, y + vsp, oBlock))
	{
		while (!place_meeting(x, y + sign(vsp), oBlock))
		{
			y += sign(vsp);
		}
		vsp = 0;
	}
	y += vsp ;
}
#endregion

#region//IsOnGround
estaEnTierra = function()
{
	return place_meeting(x, y+1, oBlock);
}
#endregion

#region//FSM
enum ESTADO_JUGADOR
{
	REPOSO,
	CORRER,
	BRINCAR,
	CALLENDO,
	AGACHARSE,
	DISPARAR
}
#endregion


estado = ESTADO_JUGADOR.REPOSO; // estado inicial
estadoInterno = 0; //0-entrar, 1-actualizar, 2-salir
siguienteEstado = estado;

#region//ChangeState
cambiarEstado = function(estadoSiguiente)
{
	siguienteEstado = estadoSiguiente;
	estadoInterno = 2;
}
#endregion