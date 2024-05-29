cmake_minimum_required(VERSION 3.16)

project(Workout-Tracker-App VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()
find_package(Qt6 REQUIRED COMPONENTS Sql Multimedia)
find_package(Qt6 REQUIRED COMPONENTS Multimedia)

qt_add_executable(appWorkout-Tracker-App
    main.cpp
)

target_link_libraries(appWorkout-Tracker-App PRIVATE Qt6::Sql)
target_link_libraries(appWorkout-Tracker-App PRIVATE Qt6::Multimedia)


qt_add_qml_module(appWorkout-Tracker-App
    URI Workout-Tracker-App
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES mydatabase.h mydatabase.cpp
        SOURCES mytimer.h mytimer.cpp
        QML_FILES Home.qml
        QML_FILES TopBar.qml
        QML_FILES AddWorkoutMenu.qml
        QML_FILES EditWorkoutMenu.qml
        QML_FILES EditWorkoutPage.qml
        QML_FILES ListModelFunctions.js
        RESOURCES
        images/edit.png
        images/trashcan.jpg
        audio/timer-sound.mp3
        QML_FILES EditDialog.qml
        QML_FILES StartWorkoutMenu.qml
        QML_FILES StartWorkoutPage.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appWorkout-Tracker-App PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appWorkout-Tracker-App
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appWorkout-Tracker-App
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appWorkout-Tracker-App
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
