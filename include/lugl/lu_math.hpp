#ifndef LUGL_MATH_HPP
#define LUGL_MATH_HPP

#include "lu_settings.hpp"
#include "luapi.hpp"

#include <cfloat>
#include <cmath> /** sqrtf(), atan2f(), floor() */

//----------------------------------------------------------------------------------
// Macros
//----------------------------------------------------------------------------------
#ifndef MAX_FLOAT
#    define MAX_FLOAT FLT_MAX
#endif

#ifndef EPSILON
#    define EPSILON FLT_EPSILON
#endif

#ifndef SQRT
#    define SQRT( x ) sqrtf( x )
#endif

#ifndef ATAN2
#    define ATAN2( y, x ) atan2f( y, x )
#endif

#ifndef ABS
#    define ABS( x ) ( x ) > 0.0F ? ( x ) : -( x )
#endif

#ifndef PI
#    define PI ( real )( 3.14159265358979323846 )
#endif

#ifndef TAU
#    define TAU ( real )( 6.283185307179586476925 )
#endif

#ifndef EPSILON
#    define EPSILON 0.000001
#endif

#ifndef DEG2RAD
#    define DEG2RAD 0.01745329251 /** ( TAU / 360.0F ) */
#endif

#ifndef RAD2DEG
#    define RAD2DEG 57.2957795131 /** ( 360.0F / TAU ) */
#endif

//----------------------------------------------------------------------------------
// Structs
//----------------------------------------------------------------------------------


//----------------------------------------------------------------------------------
// Math Functions Definition
//----------------------------------------------------------------------------------
template < typename T >
inline LU_API T
Min( T a, T b )
{
    return a < b ? a : b;
}

template < typename T >
inline LU_API T
Max( T a, T b )
{
    return a > b ? a : b;
}

template < typename T >
inline LU_API T
Clamp( T value, T lower, T upper )
{
    return Max( lower, Min( value, upper ) );
}

/// Linear interpolated value. Unclamped
inline LU_API real
Lerp( real a, real b, real t )
{
    return ( 1.0F - t ) * a + b * t;
}

/// Inverse linear interpolated value. Unclamped
inline LU_API real
InvLerp( real a, real b, real v )
{
    return ( v - a ) / ( b - a );
}

/// Remap a value from one range to another. Unclamped
inline LU_API real
Remap( real iMin, real iMax, real oMin, real oMax, real v )
{
    const real t = InvLerp( iMin, iMax, v );
    return Lerp( oMin, oMax, t );
}

// Wrap input value from min to max
inline LU_API real
Wrap( real a, real b, real v )
{
    return v - ( b - a ) * floorf( ( v - a ) / ( b - a ) );
}

#endif /* LUGL_MATH_HPP */
