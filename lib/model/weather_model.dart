class Weather {
  final String cityName;
  final double temperature;
  final String mainWeather;
  final String country;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainWeather,
    required this.country,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    //using map since json file is generated in key-value pairs
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp']
          .toDouble(), //since json values are dynamic they need explicit casting i.e in this case conversion to double
      mainWeather: json['weather'][0]['main'],
      country: json['sys']['country'],
    );
    //these key value pairs are generated using the data returned by the weather api in json file
  }
}

/*
In Dart, a factory constructor is a special type of constructor that is used to control the instantiation process of an object. Unlike a regular constructor, which always returns a new instance of the class, a factory constructor is responsible for creating an instance but is not required to return a new object.

Key characteristics of a factory constructor include:

1. **Creation Logic Control:**
   - A factory constructor allows you to control the process of object creation. Instead of always creating a new instance, a factory constructor can choose to return an existing instance or a different subtype of the class.

2. **Return Type:**
   - The return type of a factory constructor doesn't have to be an instance of the class itself. It can return an instance of a subtype or even an instance of a completely different class.

3. **Named with `factory` Keyword:**
   - Factory constructors are named and use the `factory` keyword followed by the constructor's name.

Here's a simple example to illustrate the concept:

```dart
class MyClass {
  final int value;

  // Regular constructor
  MyClass(this.value);

  // Factory constructor
  factory MyClass.fromValue(int value) {
    // Custom logic can be applied here before creating an instance
    if (value > 10) {
      return MyClass(value);
    } else {
      return AnotherClass(value);
    }
  }
}

class AnotherClass extends MyClass {
  AnotherClass(int value) : super(value * 2);
}

void main() {
  var instance1 = MyClass(5); // Regular constructor
  var instance2 = MyClass.fromValue(15); // Factory constructor

  print(instance1.value); // Output: 5
  print(instance2.value); // Output: 30 (AnotherClass constructor modifies the value)
}
```

In this example, `MyClass.fromValue` is a factory constructor that decides whether to create an instance of `MyClass` or `AnotherClass` based on a condition. Factory constructors are particularly useful in scenarios where the exact type of the returned object depends on some conditions or additional logic.
*/ 