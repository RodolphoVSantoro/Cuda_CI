#include <tuple>

#define CATCH_CONFIG_MAIN
#include "catch.hpp"

#include "../src/lib.h"

TEST_CASE("Ex1", "[example]")
{
    REQUIRE(soma(1,1) == 2);
}

TEST_CASE("Ex2", "[example]")
{
    REQUIRE(soma(3,3) == 6);
}
