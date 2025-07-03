cmake_minimum_required(VERSION 3.10)
project(MyCppProject)

set(CMAKE_CXX_STANDARD 17)

enable_testing()

# 添加主程序
add_executable(app src/main.cpp)

# 添加 GoogleTest
include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/refs/heads/main.zip
)
FetchContent_MakeAvailable(googletest)

# 添加测试
add_executable(unit_tests tests/test_main.cpp)
target_link_libraries(unit_tests gtest gtest_main)
include(GoogleTest)
gtest_discover_tests(unit_tests)