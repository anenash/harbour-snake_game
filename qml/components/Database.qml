import QtQuick 2.6
import QtQuick.LocalStorage 2.0 as Sql

Item {
    // reference to the database object
    property var _db

    property string record: "0"

    function initDatabase() {
        // initialize the database object
        console.log('initDatabase()')
        _db = Sql.LocalStorage.openDatabaseSync("BrickGame_DB", "1.0", "Brick game SQL database", 1000000)
        _db.transaction( function(tx) {
            // Create the database if it doesn't already exist
            console.log("Create the database if it doesn't already exist")
            tx.executeSql('CREATE TABLE IF NOT EXISTS gameHightScore(gameType TEXT, hightScore TEXT)')
        })
    }

    function storeData(gameType, hightScore) {
        // stores data to _db
        console.log('storeData()')
        if(!_db) { return }
        _db.transaction( function(tx) {
            console.log('check if a record exists')
            var result = tx.executeSql('SELECT * from gameHightScore WHERE gameType=?', [gameType])
            if(result.rows.length === 1) {// use update
                console.log('record exists, update it')
                result = tx.executeSql('UPDATE gameHightScore SET hightScore=? where gameType=?', [hightScore, gameType])
            } else { // use insert
                console.log('record does not exist, create it', gameType, hightScore)
                result = tx.executeSql('INSERT INTO gameHightScore VALUES (?,?)', [gameType, hightScore])
                console.log('record does not exist, create it result', JSON.stringify(result))
            }
        })
    }

    function readRecord(gameType) {
        // reads and applies data from _db
        console.log('readData()')
        if (!_db) { return }
        _db.transaction( function(tx) {
            var result = tx.executeSql('SELECT * from gameHightScore WHERE gameType=?', [gameType])
            console.log("Get data from the gameHightScore table result\n", JSON.stringify(result))
            if (result.rows.length === 1) {
                console.log("database result", result.rows.item(0).gameType, result.rows.item(0).hightScore)
                record = result.rows.item(0).hightScore
            }
        })
    }

    function deleteRecord(gameType) {
        // reads and applies data from _db
        console.log('readData()')
        if (!_db) { return }
        _db.transaction( function(tx) {
            var result = tx.executeSql('DELETE from gameHightScore WHERE gameType=?', [gameType])
            console.log("Delete data from the gameHightScore table result\n", JSON.stringify(result))
        })
    }

    Component.onCompleted: {
        initDatabase()
//        readData()
    }

    Component.onDestruction: {
//        storeData()
    }
}

