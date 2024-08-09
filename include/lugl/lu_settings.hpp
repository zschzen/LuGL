#ifndef LUGL_SETTINGS_H
#define LUGL_SETTINGS_H

#include "lu_types.hpp"
#include "luapi.hpp"

/// Default allocation functions
LU_API void * luAlloc_Default( int32 size );
LU_API void   luFree_Default( void * mem );

/// Implement this function to use your own memory allocator.
inline void *
luAlloc( int32 size )
{
    return luAlloc_Default( size );
}

/// If you implement luAlloc, you should also implement this function.
inline void
b2Free( void * mem )
{
    luFree_Default( mem );
}

#endif // LUGL_SETTINGS_H
