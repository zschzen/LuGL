#ifndef LUGL_LUAPI_HPP
#define LUGL_LUAPI_HPP

#ifdef LU_SHARED
#if defined _WIN32 || defined __CYGWIN__
    #ifdef lugl_EXPORTS
      #ifdef __GNUC__
        #define LU_API __attribute__ ((dllexport))
      #else
        #define LU_API __declspec(dllexport)
      #endif
    #else
      #ifdef __GNUC__
        #define LU_API __attribute__ ((dllimport))
      #else
        #define LU_API __declspec(dllimport)
      #endif
    #endif
  #else
    #if __GNUC__ >= 4
      #define LU_API __attribute__ ((visibility ("default")))
    #else
      #define LU_API
    #endif
  #endif
#else
#define LU_API
#endif

#endif /** LUGL_LUAPI_HPP */
