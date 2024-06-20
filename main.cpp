#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include "mydatabase.h"
#include "mytimer.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    MyTimer* myTimer = new MyTimer(&app);
    qmlRegisterSingletonInstance("com.company.mytimer", 1, 0, "MyTimer", myTimer);

    MyDatabase* myDatabase = new MyDatabase(&app);
    qmlRegisterSingletonInstance("com.company.mydatabase", 1, 0, "Database", myDatabase);
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/Workout-Tracker-App/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
