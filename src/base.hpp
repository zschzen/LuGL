#ifndef LUGL_BASE_HPP
#define LUGL_BASE_HPP

#include <memory>

template < typename T > using Scope = std::unique_ptr< T >;
/**
 * Create a unique pointer (Scope) to an instance of type T.
 * @tparam T The type of object to create.
 * @tparam Args The argument types for constructing the object.
 * @param args The arguments to forward to the constructor.
 * @return A unique pointer (Scope) to the created object.
 */
template < typename T, typename... Args >
constexpr Scope< T >
CreateScope( Args &&... args )
{
    return std::make_unique< T >( std::forward< Args >( args )... );
}

template < typename T > using Ref = std::shared_ptr< T >;
/**
 * Create a shared pointer (Ref) to an instance of type T.
 * @tparam T The type of object to create.
 * @tparam Args The argument types for constructing the object.
 * @param args The arguments to forward to the constructor.
 * @return A shared pointer (Ref) to the created object.
 */
template < typename T, typename... Args >
constexpr Ref< T >
CreateRef( Args &&... args )
{
    return std::make_shared< T >( std::forward< Args >( args )... );
}

#endif /** LUGL_BASE_HPP */
