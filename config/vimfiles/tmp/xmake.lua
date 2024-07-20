add_rules("mode.release")

target("rgbslider")
    add_rules("qt.widgetapp")
    add_files("src/*.h")
    add_files("src/*.cpp")
    -- add_files("src/mainwindow.h")