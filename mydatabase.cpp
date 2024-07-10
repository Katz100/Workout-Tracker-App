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

    QSqlQuery enableFK;
    enableFK.prepare("PRAGMA foreign_keys = ON");
    if (enableFK.exec())
    {
        qDebug() << "FK ok";
    }
    else
    {
        qDebug() << "FK error";
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



    QSqlQuery initWeights;
    initWeights.prepare("CREATE TABLE IF NOT EXISTS Weights ("
                        "id INTEGER PRIMARY KEY,"
                        "workout_id INTEGER,"
                        "weight_used INTEGER,"
                        "set_number INTEGER,"
                        "date TEXT,"
                        "FOREIGN KEY(workout_id) REFERENCES Workouts(id) ON DELETE CASCADE)");
    if (initWeights.exec())
    {
        qDebug() << "Weights table init ok";
    }
    else
    {
        qDebug() << "Weights table init error";
        qDebug() << initWeights.lastError().text();
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


void MyDatabase::printWeightsTable()
{
    QSqlQuery query("SELECT * FROM Weights");
    while(query.next())
    {
        qDebug() << "id: " << query.value(0);
        qDebug() << "workout_id: " << query.value(1);
        qDebug() << "weight_used: " << query.value(2);
        qDebug() << "set_number: " << query.value(3);
        qDebug() << "date: " << query.value(4);
        qDebug() << "-------------";
    }
}

void MyDatabase::deleteAllWeights()
{
    QSqlQuery query;
    query.prepare("DELETE FROM Weights");
    if (query.exec())
    {
        qDebug() << "deleteAllWeights() ok";
    }
    else
    {
        qDebug() << "deleteAllWeights() error";
    }
}

int MyDatabase::addWeight(int workout_id, int weight_used, int set_number)
{
    QSqlQuery query;
    query.prepare("INSERT INTO Weights (workout_id, weight_used, set_number, date)"
                  "VALUES (?, ?, ?, date('now'))");
    query.bindValue(0, workout_id);
    query.bindValue(1, weight_used);
    query.bindValue(2, set_number);
    if (query.exec())
    {
        qDebug() << "addWeight() ok";
        return query.lastInsertId().toInt();
    }
    else
    {
        qDebug() << "addWeight() error";
        qDebug() << query.lastError().text();
        return -1;
    }
}

QVariantMap MyDatabase::getWeightById(int id)
{
    QSqlQuery query;
    query.prepare("SELECT * FROM Weights WHERE id = ?");
    query.bindValue(0, id);
    if (query.exec())
    {
        qDebug() << "getWeightsById() ok";
    }
    else
    {
        qDebug() << "getWeightById() error";
        return QVariantMap();
    }

    QVariantMap weight;

    while (query.next())
    {
        weight.insert("id", query.value("id"));
        weight.insert("workout_id", query.value("workout_id"));
        weight.insert("weight_used", query.value("weight_used"));
        weight.insert("set_number", query.value("set_number"));
        weight.insert("date", query.value("date"));
    }

    return weight;
}

QVariantList MyDatabase::getWeightsByWorkoutId(int workout_id)
{
    QSqlQuery query;
    query.prepare("SELECT * FROM Weights WHERE workout_id = ?");
    query.bindValue(0, workout_id);
    if (query.exec())
    {
        qDebug() << "getWeightsByWorkoutId() ok";
    }
    else
    {
        qDebug() << "getWeightsByWorkoutId() error";
        return QVariantList();
    }

    QVariantList weights;

    while (query.next())
    {
        QVariantMap weight;
        weight.insert("id", query.value("id"));
        weight.insert("workout_id", query.value("workout_id"));
        weight.insert("weight_used", query.value("weight_used"));
        weight.insert("set_number", query.value("set_number"));
        weight.insert("date", query.value("date"));
        weights.append(weight);
    }

    return weights;
}

QVariantList MyDatabase::getWeightsByDate(const QString &date)
{

    return QVariantList();
}

QVariantList MyDatabase::getWeightsAndWorkout(int workout_id)
{
    QSqlQuery query;
    query.prepare("SELECT Workouts.workout_name, Weights.weight_used, Weights.set_number, Weights.date "
                  "FROM Workouts "
                  "INNER JOIN Weights ON Weights.workout_id = Workouts.id "
                  "WHERE Workouts.id = ?");
    query.bindValue(0, workout_id);
    if (query.exec())
    {
        qDebug() << "getWeightsAndWorkout() ok";
    }
    else
    {
        qDebug() << "getWeightsAndWorkout() error";
        qDebug() << query.lastError().text();
    }
    QVariantList weights;

    while (query.next())
    {
        QVariantMap weight;
        weight.insert("workout_name", query.value(0));
        weight.insert("weight_used", query.value(1));
        weight.insert("set_number", query.value(2));
        weight.insert("date", query.value(3));
        weights.append(weight);
    }
    return weights;
}

QList<QString> MyDatabase::getRoutines()
{
    QSqlQuery query;
    query.prepare("SELECT DISTINCT day FROM Workouts");
    if (query.exec())
    {
        qDebug() << "getRoutines() ok";
    }
    else
    {
        qDebug() << "getRoutines() error";
    }

    QList<QString> routines;

    while (query.next())
    {
        routines.append(query.value(0).toString());
    }

    return routines;
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

QVariantMap MyDatabase::findWorkout(int id)
{
    QSqlQuery query;
    query.prepare("SELECT * FROM Workouts WHERE id = ?");
    query.bindValue(0, id);

    if (query.exec())
    {
        qDebug() << "findWorkout() ok";
    }
    else
    {
        qDebug() << "findWorkout() error";
    }
    QVariantMap workout;
    while (query.next())
    {
        workout.insert("id", query.value("id"));
        workout.insert("day", query.value("day"));
        workout.insert("workout_name", query.value("workout_name"));
        workout.insert("sets", query.value("sets"));
        workout.insert("rest", query.value("rest"));
    }
    return workout;
}

int MyDatabase::findRest(int id)
{
    QSqlQuery query;
    query.prepare("SELECT rest FROM Workouts WHERE id = ?");
    query.bindValue(0, id);
    if (query.exec())
    {
        qDebug() << "findRest() ok";
    }
    else
    {
        qDebug() << "findRest() error";
    }

    return query.next() ? query.value(0).toInt() : -1;
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
        if (query.next())
        {
            return query.value(0).toInt();
        }
        else
        {
            return -1;
        }
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

int MyDatabase::findAverage(const QString &day)
{
    QSqlQuery query;
    query.prepare("SELECT avg(rest) FROM Workouts WHERE day = ?");
    query.bindValue(0, day);

    if (query.exec())
    {
        qDebug() << "findAverage() ok";
        return query.next() ? query.value(0).toInt() : -1;
    }
    else
    {
        qDebug() << "finAverage() error";
        return -1;
    }
}

