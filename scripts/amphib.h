#ifndef AMPHIB_H
#define AMPHIB_H
WaterCheck()
{
	var GroundHeight;
	while(TRUE)
	{
		GroundHeight=get GROUND_WATER_HEIGHT(get PIECE_XZ(hull));
		if (GroundHeight<=FLOAT_DEPTH)
		{
			bFloating = TRUE;
			move hull to y-axis FLOAT_DEPTH speed [5];
			turn hull to x-axis 0 speed <90>;
			turn hull to z-axis 0 speed <90>;
			if(bMoving)
			{
				emit-sfx SFXTYPE_WAKE1 from wake;
			}
			set MAX_SPEED to WaterSpeed;
			set UPRIGHT to 1;
		}
		else
		{
			bFloating = FALSE;
			if (GroundHeight<0)
			{
				move hull to y-axis GroundHeight now;
			}
			else
			{
				move hull to y-axis [0] now;
			}
			//call-script SlopeCheck();
			set MAX_SPEED to LandSpeed;
			set UPRIGHT to 0;
		}
		sleep 150;
	}
}
#endif