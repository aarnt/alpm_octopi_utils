add_executable(search search.c)
target_link_libraries(search alpm_octopi_utils)
# install(TARGETS search RUNTIME DESTINATION bin)
