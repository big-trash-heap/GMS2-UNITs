/// @description  angle_limit_speed( AngArc , CentrArc , CurAng , ReqAng , SpdAng ) ;
/// @function  angle_limit_speed
/// @param  AngArc 
/// @param  CentrArc 
/// @param  CurAng 
/// @param  ReqAng 
/// @param  SpdAng 
function angle_limit_speed(argument0, argument1, argument2, argument3, argument4) {

	// by PKG AMES

	/* Get the correct speed for the rotation in the arc ;

	    argument0 : AngArc - arc direction
	    argument1 : CentrArc is the center of the arc
        
	    argument2 : CurAng - current direction
	    argument3 : ReqAng - required direction
	    argument4 : SpdAng - rotation speed
	*/

	// If the current direction matches the required
	if ( argument2 == argument3 ) return ( 0 ) ; // Wow the brackets!

	// Center of the angle + rotation
	var angle_rotation = argument0 + argument1 ;

	// Direction towards the center of the arc
	var ArcSign = sign( angle_difference( angle_rotation , argument3 ) ) ;

	// Return the finished value
	if ( ( sign( angle_difference( angle_rotation , argument2 ) ) == ArcSign ) or ( ArcSign == 0 ) )
	    return ( -clamp( angle_difference( argument2 , argument3 ) , -argument4 , argument4 ) ) else
	        return ( -argument4 * ArcSign ) ;

	/*
	    if ( ( sign( angle_difference( angle_rotation , argument2 ) ) == ArcSign ) ...
	    If the current direction is on the same side of the center as required, then "rotate" as in angle_smooth
	    Do the same ... or ( ArcSign == 0 ) ), if the required direction lies on the central
    
	    Otherwise, we "rotate" towards the central arc
	*/



}
