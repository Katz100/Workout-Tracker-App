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

    QSqlQuery q;
    q.prepare("INSERT INTO Workouts (id, day, workout_name, sets, rest) "
              "VALUES (NULL, 'Monday', 'Benchpress', 4, 120)");
    if (q.exec())
    {
        qDebug() << "Table pop ok";
    }
    else
    {
        qDebug() << "Table pop error";
    }

    deleteWorkoutAt(1);

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

void MyDatabase::deleteWorkoutAt(int index)
{
    QSqlQuery query;
    query.prepare("DELETE FROM Workouts WHERE id = ?");
    query.bindValue(0, index);
    if (query.exec())
    {
        qDebug() << "deleteWorkoutIndex() ok";
        emit workoutsChanged();
    }
    else
    {
        qDebug() << "deleteWorkoutIndex() error";
    }
}

void MyDatabase::editWorkout(int id, const QString &day, const QString &workout_name, int sets, int rest)
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
    }
    else
    {
        qDebug() << "editWorkout() error";
    }
}

