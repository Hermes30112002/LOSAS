import 'dart:html';
import '../Generator.dart';
import 'GenericFormHelper.dart';

abstract class NumGeneratorFormHelper {

    static TextAreaElement dataStringElement;
    static InputElement keyElement;
    static NumGenerator generator;
    static InputElement minElement;
    static InputElement maxElement;


    static void makeBuilder(Element parent) async {
        DivElement formHolder = new DivElement()
            ..classes.add("formHolder");
        parent.append(formHolder);
        generator = new NumGenerator("sampleKey",-13,13);
        DivElement instructions = new DivElement()..setInnerHtml("A number generator is how an individual entity handles random numbers. <br><br>Example uses include 'generate a random number between 0 and 1 for the key 'chanceSuccess' or 'generate a random number between  and 13 for 'attack'.  <br><br>Since each entity has their own generators for a value they can produce very different behavior. A high strength character might generate an attack between 10 and 30, while a low strength might generate one between 1 and 3. <br><br>An entity can have multiple generators for the same value, in which case all have an equal chance of being used to generate a value." )..classes.add("instructions");
        formHolder.append(instructions);
        dataStringElement = attachAreaElement(formHolder, "DataString:", "${generator.toDataString()}", (e) => syncDataStringToGenerator(e));
        keyElement = attachInputElement(formHolder, "Key:", "${generator.key}", (e)
        {
            generator.key = e.target.value;
            syncDataStringToGen();
        });

        minElement = attachNumberInputElement(formHolder, "Min:", generator.min, (e)
        {
            generator.min = num.parse(e.target.value);
            syncDataStringToGen();
        });

        maxElement = attachNumberInputElement(formHolder, "Max:", generator.max, (e)
        {
            generator.max = num.parse(e.target.value);
            syncDataStringToGen();
        });
    }

    static void syncDataStringToGen() {
        print("syncing datastring to generator");
        dataStringElement.value = generator.toDataString();
    }

    static void syncDataStringToGenerator(e) {
        print("syncing gen to datastring");
        try {
            generator.loadFromDataString(e.target.value);
        }catch(e) {
            window.alert("Look. Don't waste this. Either copy and paste in a valid datastring, or don't touch this.");
        }
        keyElement.value = generator.key;
        minElement.value = "${generator.min}";
        maxElement.value = "${generator.max}";

    }

}