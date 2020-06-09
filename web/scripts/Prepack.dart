//TODO a prepack consists of a lot of generators (which can include datastrings of scenes or dolls or whatever) and a description and  a list of scenes (that aren't tied to generators)
//TODO it should also have an image that does NOT get serialized. instead it is the datapng the datastring gets saved to on export.
//TODO on import of a prepack it stores the datapng it came with so it can be displayed
import 'dart:async';
import 'dart:html';

import 'package:ImageLib/Encoding.dart';

import 'DataObject.dart';
import 'DataStringHelper.dart';
import 'Game.dart';
import 'Generator.dart';
import 'Scene.dart';

class Prepack extends ArchivePNGObject {
    static String dataPngFile = "prepack.txt";
    //keep this around so you can render yourself as a black box
    ArchivePng externalForm;
    @override
    String fileKey = "${GameUI.dataPngFolder}${Prepack.dataPngFile}";

    List<Generator> generators;
    //an entity given this prepack is going to have these scenes at a prioritization based on what order you give the prepacks to em
    List<Scene> scenes;
    //when an entity slurps this prepack it keeps track of unique initial keys and generates shit based on them
    List<String> initialKeysToGenerate;
    String name;
    String description = "This prepack has a default description";
    String author = "???";
    ImageElement cardImage;

    Set<String> get allGeneratorMemoryKeys {
        Set<String> ret = new Set.from(initialKeysToGenerate);
        for(Generator g in generators) {
            ret.add(g.key);
        }
        return ret;
    }

    //don't forget intro/outro
    Set<String> get allMemoryKeysRefScenes {
        Set<String> ret = new Set.from(initialKeysToGenerate);
        for(Scene s in scenes) {
            ret.addAll(s.allMemoryKeys);
        }
        return ret;
    }

    Prepack(this.name, this.description, this.author, this.initialKeysToGenerate,this.generators, this.scenes);
    Prepack.empty();

    Prepack.fromDataString(String dataString){
        loadFromDataString(dataString);
    }

    Prepack.fromSerialization(Map<String, dynamic> serialization){
        loadFromSerialization(serialization);
    }

  @override
  Future<void> loadFromSerialization(Map<String, dynamic> serialization) async {
      author = serialization["author"];
      name = serialization["name"];
      description = serialization["description"];
      initialKeysToGenerate = new List<String>.from(serialization["initialKeysToGenerate"]);
      scenes = new List.from((serialization["scenes"] as List).map((subserialization) => new Scene.fromSerialization(subserialization)));
      generators = new List.from((serialization["generators"] as List).map((subserialization) => Generator.fromSerialization(subserialization)));
      await loadImage(serialization);

  }


  @override
  Map<String, dynamic> getSerialization() {
      Map<String,dynamic> ret = new Map<String,dynamic>();
      ret["author"] = author;
      ret["name"] = name;
      ret["description"] = description;
      ret["initialKeysToGenerate"] = initialKeysToGenerate;
      ret["scenes"] = scenes.map((Scene scene) => scene.getSerialization()).toList();
      ret["generators"] = generators.map((Generator gen) => gen.getSerialization()).toList();
      if(externalForm != null) ret["externalForm"] = externalForm.canvas.toDataUrl();

      return ret;
  }



}