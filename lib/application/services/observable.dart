class Observable {
  List<Observer> observers = [];

  Observable();

  register(Observer observer) {
    observers.add(observer);
  }

  notify(String event, data) {
    for (var observer in observers) {
      if (observer.event == event) {
        observer.callback(data);
      }
    }
  }
}

class Observer {
  String event;
  Function callback;
  Observer(this.event, this.callback);
}
