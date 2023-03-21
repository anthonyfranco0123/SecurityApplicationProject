import 'mysql.dart';
//test

class SQLTest {
  Future<List<String>> getmySQLData() async {
    var db = Mysql();
    String sql = 'select * from user_compliances limit 100';
    final List<String> myList = [];

    await db.getConnection().then((conn) async {
      await conn.query(sql).then((results) {
        for (var res in results) {
          print(res);
          myList.add('');
        }
      }).onError((error, stackTrace) {
        print(error);
        return null;
      });
      conn.close();
    });
    return myList;
  }
}
