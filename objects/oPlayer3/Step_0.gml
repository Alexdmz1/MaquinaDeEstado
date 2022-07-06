/// @description 

#region//Players Inputs
/// Get players inputs
//var _move;
disparo = keyboard_check_pressed(ord("X"));
//cambio = keyboard_check(ord("X"));
acelerar = keyboard_check(ord("X"));
key_left = keyboard_check(vk_left);
key_right= keyboard_check(vk_right);
key_jump = keyboard_check_pressed(ord("C"));
key_down = keyboard_check(vk_down);

#endregion



//implementation of FSM
switch (estado)
{
	case ESTADO_JUGADOR.REPOSO:
	{
		if (estadoInterno == 0) //entrar
		{
			estadoInterno = 1;
			sprite_index = sReposo;
			vsp = 0;
		}
		
		
		if (estadoInterno == 1) //actualizar
		{
			var movimientoHorizontal = -key_left + key_right;
			
			if (!estaEnTierra())
			{
				
				cambiarEstado(ESTADO_JUGADOR.CALLENDO);
			}
			else if (key_jump)
			{
				
				cambiarEstado(ESTADO_JUGADOR.BRINCAR);
			}
			else if (abs(movimientoHorizontal) > 0)
			{
				cambiarEstado(ESTADO_JUGADOR.CORRER);
			}
			else if(estaEnTierra() && disparo)
			{
				cambiarEstado(ESTADO_JUGADOR.DISPARAR);

				var inst =instance_create_layer(x,y,"Instances",oShuriken);
				inst.speed *= image_xscale*walksp;
			}
			else if(estaEnTierra() && key_down)
			{
				cambiarEstado(ESTADO_JUGADOR.AGACHARSE);
			}
		}
		
		
		if (estadoInterno == 2) //exit
		{
			estado = siguienteEstado;
			estadoInterno = 0;
		}
	}
	break;
	
	
	case ESTADO_JUGADOR.CORRER:
	{
		if (estadoInterno == 0) //enter
		{
			estadoInterno = 1;
			sprite_index = sCorrer;
		}
		if (estadoInterno == 1) //update
		{
			var movimientoHorizontal = -key_left + key_right;
			hsp = movimientoHorizontal *walksp;
			if (movimientoHorizontal != 0)
			{
				
				image_xscale = sign(movimientoHorizontal);
			}
				
			if (!estaEnTierra())
			{
				cambiarEstado(ESTADO_JUGADOR.CALLENDO);
			}
			else if (key_jump){
				cambiarEstado(ESTADO_JUGADOR.BRINCAR);
			}
			else if (movimientoHorizontal == 0)
			{
				cambiarEstado(ESTADO_JUGADOR.REPOSO);
			}
		}
		if (estadoInterno == 2) //exit
		{
			estado = siguienteEstado;
			estadoInterno = 0;
		}
	}
	break;
	
	
	case ESTADO_JUGADOR.BRINCAR:
	{
		if (estadoInterno == 0) //entrar
		{
			estadoInterno = 1; //cambiar el estado a 1
			sprite_index = sSaltar;
			vsp = jumpsp;
			//audio_play_sound(snd_Jump, 500, false);
		}
		if (estadoInterno == 1) //actualizar
		{
			//cambiar la direccion de la imagen
			var movimientoHorizontal = -key_left + key_right;
			hsp = movimientoHorizontal * walksp;
			if (movimientoHorizontal != 0)
			{
				image_xscale = sign(movimientoHorizontal);
			}
				
			if (vsp >= 0)
			{
				cambiarEstado(ESTADO_JUGADOR.CALLENDO);
			}
		}
		if (estadoInterno == 2) //salir
		{
			estado = siguienteEstado;
			estadoInterno = 0;
		}
	}
	break;
	
	
	case ESTADO_JUGADOR.CALLENDO:
	{
		if (estadoInterno == 0) //entrar
		{
			estadoInterno = 1;
			sprite_index = sCallendo;
			image_index = 0;
		}
		if (estadoInterno == 1) //actualizar
		{
			var movimientoHorizontal = -key_left + key_right;
			hsp = movimientoHorizontal *walksp;
			if (movimientoHorizontal != 0)
			{
				
				image_xscale = sign(movimientoHorizontal);
			}
			else if(!estaEnTierra() && disparo)
			{
				cambiarEstado(ESTADO_JUGADOR.DISPARAR);

				var inst =instance_create_layer(x,y,"Instances",oShuriken);
				inst.speed *= image_xscale*walksp;
			}	
			if (estaEnTierra())
			{
				cambiarEstado(ESTADO_JUGADOR.REPOSO);
			}

		}
		
		if (estadoInterno == 2) //salir
		{
			estado = siguienteEstado;
			estadoInterno = 0;
		}
	}
	break;
	
	
	case ESTADO_JUGADOR.AGACHARSE:
	{
		if(estadoInterno==0)
		{
			estadoInterno = 1;
			sprite_index = sAgacharse;
		
		}
		
		if(estadoInterno==1)
		{
			
			if (estaEnTierra() && !key_down)
			{
				
				cambiarEstado(ESTADO_JUGADOR.REPOSO); // esta funcion tiene la variable estadoInterno=2;
			}

			
		}
		
		
		
		if (estadoInterno == 2) //salir
		{
			estado = siguienteEstado;
			estadoInterno = 0;
		}
	}
	break;
	
	case ESTADO_JUGADOR.DISPARAR:
	{
		if (estadoInterno == 0) //entrar
		{
			estadoInterno = 1;
			sprite_index = sDisparo2;
			
		}
		
		if(estadoInterno==1)
		{
	
			var movimientoHorizontal = -key_left + key_right;
			hsp = movimientoHorizontal *walksp;
			if (movimientoHorizontal != 0)
			{
				
				image_xscale = sign(movimientoHorizontal);
			}	
			
			
			if (estaEnTierra()&&distance_to_object(oShuriken)>150)//  && hsp==0 quiza usarse
			{
				
				cambiarEstado(ESTADO_JUGADOR.REPOSO);
				
			}
			if(!estaEnTierra && !disparo)
			{
				cambiarEstado(ESTADO_JUGADOR.REPOSO);
			}
			


					
				
				
				//estadoInterno =2;
			
		
		}
		

		
		if (estadoInterno == 2) //salir
		{
			estado = siguienteEstado;
			estadoInterno = 0;
		}
	}
	break;
}


actualizarMovimiento();














#region//Disparos, comentados por el momento
/*
if disparo {

	create_bullet(0,image_xscale*walksp,faction,guns);
	//var inst =instance_create_layer(x,y,"Instances",obj_bullet);
	//inst.speed *= image_xscale*walksp;
	
}

*/

/*
if key_down{
	if disparo{
		
		if (distance_to_object(obj_bullet)<30 && hsp==0){ sprite_index =spr_disparo;  }

		
	}

}
*/

//mejorar!!
/*

if key_down && (hsp>0 or hsp<0){
	if (distance_to_object(obj_block)>0){ sprite_index =spr_rovot_run; image_index = 0; image_speed =1; }

}
*/

#endregion


#region//Acelerar
if acelerar && walksp==4{
	walksp+=4;
}else{walksp=4;}
#endregion
move_wrap(true, false, sprite_width/2);


/*
if key_down
{
	sprite_index =spr_rovot_abajo;
	image_index =0;
	image_speed =0;
}
*/

/* animacion disparo
if (distance_to_object(obj_bullet)<30 && hsp==0){ sprite_index =spr_disparo;  }
if (distance_to_object(obj_bullet)<30 && vsp<0){ sprite_index =spr_disparo;  }
*/