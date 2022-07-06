/// @description 

#region//Players Inputs
/// Get players inputs
var _move;
//disparo = keyboard_check_pressed(ord("X"));
//cambio = keyboard_check(ord("X"));
acelerar = keyboard_check(ord("X"));
key_left = keyboard_check(vk_left);
key_right= keyboard_check(vk_right);
key_jump = keyboard_check_pressed(ord("C"));
//key_down = keyboard_check(vk_down);

#endregion

#region//Calculo de Movimientos
/// Calculate Movement

 _move = key_right - key_left;

hsp = _move * walksp;

vsp = vsp + grv;
 if place_meeting(x,y+1,oBlock) && (key_jump)
 {
	 vsp = -jumpsp;
 }
 #endregion

#region//Colision Horizontal.
/// Horizontal collision
if place_meeting(x+hsp,y-1,oBlock)
{
	while (!place_meeting(x+sign(hsp),y-1,oBlock))
	{
		x = x + sign(hsp);
	}
	
	hsp=0;
}
x = x + hsp;
#endregion

#region//Colision Vertical.
/// Vertical collision
if place_meeting(x,y+vsp,oBlock)
{
	while (!place_meeting(x,y+sign(vsp),oBlock))
	{
		y = y + sign(vsp);
	}
	
	vsp=0;
}
y = y + vsp;
#endregion

#region//Animacion  salto, caer, izquierda, derecha,  abajo, y disparo.

	
if (!place_meeting(x,y+5,oBlock))
{

	if (vsp > 0) sprite_index = sCallendo; else sprite_index=sSaltar;
}
else
{
	image_speed = 1;
	if (hsp==0)
	{
		sprite_index =sReposo;	
	}
	else
	{
		sprite_index = sCorrer;
	}
}

if (hsp != 0) image_xscale= sign(hsp);

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
#endregion

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
