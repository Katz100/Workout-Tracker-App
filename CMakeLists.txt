cmake_minimum_required(VERSION 3.16)

project(Workout-Tracker-App VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(ANDROID_EXTRA_LIBS
    ${CMAKE_CURRENT_SOURCE_DIR}/ssl_1.1/arm64-v8a/libcrypto_1_1.so
    ${CMAKE_CURRENT_SOURCE_DIR}/ssl_1.1/arm64-v8a/libssl_1_1.so
CACHE INTERNAL "")

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core Gui QuickControls2 Network)

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
        QML_FILES CircularSlider.qml
        RESOURCES
        images/edit.png
        images/trashcan.jpg
        images/icons8-play-48.png
        images/icons8-pause-button-64.png
        images/icons8-add-50.png
        images/icons8-edit-50.png
        images/icons8-start-50.png
        images/icons8-home-24.png
        images/icons8-settings-24.png
        images/icons8-dumbell-100.png
        images/magnifying-glass.png
        images/icons8-plus-24.png
        audio/timer-sound.mp3
        QML_FILES EditDialog.qml
        QML_FILES StartWorkoutMenu.qml
        QML_FILES StartWorkoutPage.qml
        QML_FILES SettingsMenu.qml
        SOURCES exercisedata.h exercisedata.cpp
        QML_FILES DataMenu.qml
        SOURCES config.h
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
    PRIVATE Qt6::Core
    PRIVATE Qt6::Gui
    PRIVATE Qt6::QuickControls2
    PRIVATE Qt6::Network
)


include(GNUInstallDirs)
install(TARGETS appWorkout-Tracker-App
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)


if(ANDROID)
  set_property(TARGET appWorkout-Tracker-App APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android)


endif()

if (ANDROID)
    include(FetchContent)

    FetchContent_Declare(
        android_openssl
        DOWNLOAD_EXTRACT_TIMESTAMP true
        URL https://github.com/KDAB/android_openssl/archive/refs/heads/master.zip
    )
    FetchContent_MakeAvailable(android_openssl)
    include(${android_openssl_SOURCE_DIR}/android_openssl.cmake)

    set_target_properties(appWorkout-Tracker-App PROPERTIES QT_ANDROID_EXTRA_LIBS "${ANDROID_EXTRA_LIBS}")



endif()

