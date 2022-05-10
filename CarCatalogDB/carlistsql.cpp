#include "carlistsql.h"
#include "QObject"

carListSQL::carListSQL(QObject *parent) :
    QSqlQueryModel(parent)
{
    QSqlDatabase::removeDatabase("myConnection");

    db = QSqlDatabase::addDatabase("QPSQL", "myConnection");
    db.setHostName("localhost");
        db.setPort(5432);
        db.setUserName("postgres");
        db.setPassword("jwpepper");
        db.setDatabaseName("cars");

     _isConnectionOpen = true;

    if(!db.open())
        {
            qDebug() << db.lastError().text();
            _isConnectionOpen = false;
        }

    QString m_schema = QString( "CREATE TABLE IF NOT EXISTS Cars (Id SERIAL PRIMARY KEY, Brand text, Model text, Horsepower text, MaxTorque text, AccelerationTime text);" );
    QSqlQuery qry(m_schema, db);
        qry.exec();
        refresh();
}

QSqlQueryModel* carListSQL::getModel(){
    return this;
}
bool carListSQL::isConnectionOpen(){
    return _isConnectionOpen;
}
QHash<int, QByteArray> carListSQL::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[Qt::UserRole + 2] = "brandOfCar";
    roles[Qt::UserRole + 3] = "modelOfCar";
    roles[Qt::UserRole + 4] = "horsepowerOfCar";
    roles[Qt::UserRole + 5] = "maxTorqueOfCar";
    roles[Qt::UserRole + 6] = "accelerationTimeOfCar";
    roles[Qt::UserRole + 1] = "Id_car";

    return roles;
}

QVariant carListSQL::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);
    if(role < Qt::UserRole-1)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}

const char* carListSQL::SQL_SELECT =
        "SELECT *"
        "FROM cars";

void carListSQL::refresh()
{
    this->setQuery(carListSQL::SQL_SELECT,db);
    qDebug() << db.lastError().text();
}

void carListSQL::add(const QString& brand, const QString& model, const QString& horsepower, const QString& maxTorque, const QString& accelerationTime){

    QSqlQuery query(db);
    QString strQuery= QString("INSERT INTO cars (Brand,Model,Horsepower,MaxTorque,AccelerationTime) VALUES ('%1', '%2', '%3', '%4', '%5')")
            .arg(brand)
            .arg(model)
            .arg(horsepower)
            .arg(maxTorque)
            .arg(accelerationTime);
    bool a = query.exec(strQuery);
    qDebug() << a;

    refresh();
}

void carListSQL::edit(const QString& brand, const QString& model, const QString& horsepower, const QString& maxTorque, const QString& accelerationTime, const int Id_car){

    QSqlQuery query(db);
    QString strQuery= QString("UPDATE cars SET Brand = '%1',Model = '%2',Horsepower = '%3',MaxTorque = '%4', AccelerationTime = '%5'  WHERE Id = %6")
            .arg(brand)
            .arg(model)
            .arg(horsepower)
            .arg(maxTorque)
            .arg(accelerationTime)
            .arg(Id_car);
    bool a = query.exec(strQuery);
    qDebug() << a;

    refresh();
}

void carListSQL::del(const int Id_car){

    QSqlQuery query(db);
    QString strQuery= QString("DELETE FROM cars WHERE Id = %1")
            .arg(Id_car);
    bool a = query.exec(strQuery);
    qDebug() << a;

    refresh();
}
