import 'package:mongo_dart/mongo_dart.dart';
import 'package:redux_demo/redux_demo.dart';

class TodoCollection {

  final DbCollection _collection;
  TodoCollection(this._collection);

 Future createTodo(Map<String, dynamic> data) async {

    // verify keys
    if (!data.containsKey('text')) return false;
    var todo = Todo.fromJson(data).toJson();
    
    // verify value in key
    if (todo['text'] == null) return false;

    // var todoCollection = await DB.todoCollection;

    // user already existing ??

    var todoExisting = await _collection.findOne({'id': todo['id']});
    if(todoExisting != null){
      todoExisting['id'] = todo['id'] ?? todoExisting['id'];
      todoExisting['text'] = todo['text'] ?? todoExisting['text'];
      todoExisting['completed'] = todo['completed'] ?? todoExisting['completed'];
      await _collection.save(todoExisting);
    }else{
      await _collection.insert(todo);
    }


    // await todoCollection.insert(todo).catchError((_) async {
    //   // If we have a duplicate, update it with new data
    //   var todoExisting = await todoCollection.findOne({'id': todo['id']});
    //   todoExisting['id'] = todo['id'] ?? todoExisting['id'];
    //   todoExisting['text'] = todo['text'] ?? todoExisting['text'];
    //   todoExisting['completed'] = todo['completed'] ?? todoExisting['completed'];
    //   await todoCollection.save(todoExisting);
    // });
    
    // await DB.close();
    //return true;
  }

 Future<List<Todo>> todos() async {
    //var todoCollection = await DB.todoCollection;
    var todoList = await _collection.find().map((event) => Todo.fromJson(event)).toList();
    //var todoList = await todoCollection.find().toList()
    // await DB.close();
    return todoList;
  }

 Future<Map<String, dynamic>> getUser(String id) async {
    //var todoCollection = await DB.todoCollection;
    var user = await _collection.findOne({'id': id});
    // await DB.close();
    return user;
  }

 Future<void> delete({String id}) async {
    if (id == null) return;
    //var usersCollection = await DB.todoCollection;
    await _collection.remove({'id': id});
    // await DB.close();
  }
}
