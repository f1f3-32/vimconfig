# %s/widget/
cmake_minimum_required(VERSION 3.0)
project(widget VERSION 1.0.0 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 REQUIRED COMPONENTS Widgets Gui Core)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

add_executable(widget
            main.cpp
            widget.cpp
            widget.qrc
                    )

target_link_libraries(widget PRIVATE Qt5::Widgets  Qt5::Gui Qt5::Core)
