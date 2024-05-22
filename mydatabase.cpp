#include "mydatabase.h"

MyDatabase::MyDatabase(QObject *parent)
    : QObject{parent}
{
    db_connection = QSqlDatabase::addDatabase("QSQLITE");
    db_connection.setHostName("dbHost");
    db_connection.setDatabaseName("Workouts");
    db_connection.setUserName("Katz");
    db_connection.setPassword("1234");
    bool ok = db_connection.open();

    if (ok){
        qDebug() << "Database connection ok";
    }
    else
    {
        qDebug() << "Database connection error";
    }

    QSqlQuery init;
    init.prepare("CREATE TABLE IF NOT EXISTS Workouts (id INTEGER PRIMARY KEY, day TEXT, workout_name TEXT, sets INTEGER, rest INTEGER)");
    if (init.exec())
    {
        qDebug() << "Table init ok";
    }
    else
    {
        qDebug() << "Table init error";
    }


    connect(this, &MyDatabase::workoutsChanged, this, &MyDatabase::printTable);

}

void MyDatabase::printTable()
{
    QSqlQuery query("SELECT * FROM Workouts");
    while(query.next())
    {
        qDebug() << "id: " << query.value(0);
        qDebug() << "day: " << query.value(1);
        qDebug() << "workout_name: " << query.value(2);
        qDebug() << "sets: " << query.value(3);
        qDebug() << "rest: " << query.value(4);
        qDebug() << "-------------";
    }
}

QVariantList MyDatabase::getWorkouts(const QString& day)
{
    QSqlQuery query;
    query.prepare("SELECT * FROM Workouts WHERE day = ?");
    query.addBindValue(day);

    if (query.exec())
    {
        qDebug() << "getWorkouts ok";
    }
    else
    {
        qDebug() << "getWorkouts() error";
        return QVariantList();
    }

    QVariantList workouts;

    while (query.next())
    {
        QVariantMap workout;
        workout.insert("id", query.value("id"));
        workout.insert("day", query.value("day"));
        workout.insert("workout_name", query.value("workout_name"));
        workout.insert("sets", query.value("sets"));
        workout.insert("rest", query.value("rest"));
        workouts.append(workout);
    }

    return workouts;
}

void MyDatabase::deleteWorkouts()
{
    QSqlQuery query;
    query.prepare("DELETE FROM Workouts");
    if (query.exec())
    {
        qDebug() << "deleteWorkouts() ok";
    }
    else
    {
        qDebug() << "deleteWorkouts() error";
    }
}

int MyDatabase::addWorkout(const QString &day, const QString &workout_name, int sets, int rest)
{
    QSqlQuery query;
    query.prepare("INSERT INTO Workouts (day, workout_name, sets, rest)"
                  "VALUES (?, ?, ?, ?)");
    query.bindValue(0, day);
    query.bindValue(1, workout_name);
    query.bindValue(2, sets);
    query.bindValue(3, rest);
    if (query.exec())
    {
        qDebug() << "addWorkout() ok";
        emit workoutsChanged();
        return query.lastInsertId().toInt();
    }
    else
    {
        qDebug() << "addWorkout() error";
        return -1;
    }
}

bool MyDatabase::deleteWorkoutAt(int index)
{
    QSqlQuery query;
    query.prepare("DELETE FROM Workouts WHERE id = ?");
    query.bindValue(0, index);
    if (query.exec())
    {
        qDebug() << "deleteWorkoutIndex() ok";
        emit workoutsChanged();
        return true;
    }
    else
    {
        qDebug() << "deleteWorkoutIndex() error";
        return false;
    }
}

bool MyDatabase::deleteWorkoutsOnDay(const QString &day)
{
    QSqlQuery query;
    query.prepare("DELETE FROM Workouts WHERE day = ?");
    query.bindValue(0, day);

    if (query.exec())
    {
        qDebug() << "deleteWorkoutsOnDay() ok";
        emit workoutsChanged();
        return true;
    }
    else
    {
        qDebug() << "deleteWorkoutsOnDay() error";
        return false;
    }

}

bool MyDatabase::editWorkout(int id, const QString &day, const QString &workout_name, int sets, int rest)
{
    QSqlQuery query;
    query.prepare("UPDATE Workouts SET day = ?, workout_name = ?, sets = ?, rest = ? WHERE id = ?");
    query.bindValue(0, day);
    query.bindValue(1, workout_name);
    query.bindValue(2, sets);
    query.bindValue(3, rest);
    query.bindValue(4, id);

    if (query.exec())
    {
        qDebug() << "editWorkout() ok";
        emit workoutsChanged();
        return true;
    }
    else
    {
        qDebug() << "editWorkout() error";
        return false;
    }
}

int MyDatabase::countSets(const QString &day)
{
    QSqlQuery query;
    query.prepare("SELECT SUM(sets) FROM Workouts WHERE day = ?");
    query.bindValue(0, day);

    if(query.exec())
    {
        qDebug() << "countSets() ok";
        return query.next() ? query.value(0).toInt() : -1;
    }
    else
    {
        qDebug() << "countSets() error";
        return -1;
    }
}

int MyDatabase::countRest(const QString &day)
{
    QSqlQuery query;
    query.prepare("SELECT SUM(rest) FROM Workouts WHERE day = ?");
    query.bindValue(0, day);
    if (query.exec())
    {
        qDebug() << "countRest() ok";
        return query.next() ? query.value(0).toInt() : -1;
    }
    else
    {
        qDebug() << "countRest() error";
        return -1;
    }
}

