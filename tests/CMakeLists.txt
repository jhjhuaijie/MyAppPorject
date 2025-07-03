find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

add_executable(test_main test_main.cpp)
target_link_libraries(test_main app ${GTEST_LIBRARIES} pthread)
add_test(NAME MyTest COMMAND test_main)