#include <tuple>

#define CATCH_CONFIG_MAIN
#include "catch.hpp"

#include "../src/lib.h"

TEST_CASE("Ex1", "[example]")
{
    int m1[2] = {1,1},
    m2[2] = {2,2}, m3[2];
    soma(m1,m2,m3);
    for(int i=0;i<2;i++)
        REQUIRE(m3[i]==m1[i]+m2[i]);
}
