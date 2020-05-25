//what are the base rules of this story? who are the characters? what are the main events? the driving forces?
import 'dart:async';
import 'dart:html';

import 'package:CommonLib/Random.dart';

import 'DataObject.dart';
import 'Entity.dart';
import 'Game.dart';
import 'Generator.dart';
import 'Scene.dart';
import 'TargetFilters/KeepIfNumIsGreaterThanValue.dart';
import 'TargetFilters/TargetFilter.dart';
/*
    Scenario List
    SBURB/Farragnarok
    Worm (entities distribute prepacks of powers)
    Hogwartz
    Space Infection
    SCP/SBURB
    Star Trek
 */
/*
TODO scenarios to have a list of “suggested players” (so nico is canon for scp scenario)
 and the first thing you unlock is the ability to remix the suggested players (but not add any new prepacks or double up or remove, or add/remove players)
Then you’re allowed to use any prepack from the scenario (including doubling up or removing, or adding/removing players)
Then you’re allowed to use any prepack from the systemwide scenarios
Then you’re allowed to use any prepacks from the internet
Then you’er allowed to just use any prepack at all you can upload

 */
class Scenario extends DataObject {
    static String dataPngFile = "scenario.txt";


    //TODO be able to serialize the scenarios entire current state so you can return to any version of it for time shenanigans
    int seed;
    //TODO when you make a scenario with a builder, need to be able to specify what dollstrings the char creator should be asking for
    //TODO such as godtier, dead, dream etc
    List<String> suggestedDollStringTags = new List<String>();
    Game game;
    //TODO let people sign their work
    String author = "???";

    String description;





    Random rand;


    //optional intro
    List<Scene> frameScenes = new List<Scene>();

    //if ANY of these trigger, then its time to stop ticking
    List<Scene> stopScenes = new List<Scene>();
    String name;

    Scenario(this.name, this.description, this.seed) {
        rand = new Random(seed);

    }












    Scenario.testScenario(){
        description = "A test scenario with a Pigeon/Bro/Doc ecosystem.";
        final Entity alice = new Entity("Alice",[],"Alice%3A___A5G_5sA8JL__4cAf39_cnJyLpYA%3D")..isActive = true..facingRightByDefault=false;
        final Entity bob = new Entity("Bob",[],"Bob%3A___A5GM5n_EOD_AKS7_v1J1tYBKiJY%3D")..isActive = true..facingRightByDefault=false;;
        final Entity eve = new Entity("Eve",[],"Eve%3A___A5GPGpdulkxChkWJS4sAAAALEeA%3D")..isActive = true..facingRightByDefault=false;;
        final Entity carol = new Entity("Carol",[],"Carol%3A___A5GAAAAMzMzA1AOCEcR-NxXKvg%3D%3D")..facingRightByDefault=false;




        Generator messageGenerator = Generator.fromDataString("secretMessageDraft:___ N4Ig1gpgniBcIGcIGMBOEAuBZCCEEMBzCAEVXwDMMQAaEDKABwjhAGUAVAJQEkA5AOK0QjAPZ4AlgCMANhABq+GQFdccANogAwvlSiZAAnzIMypTKgGwEgHYATA6IoGEy5GAQA6b8J4vl6AYAFqLMBjp6hjYQAG4QqAYUtnYIjsoYBgDuEADkcQZSEBA2BhhK1jaERlKi6cHx3p7CEfpGJmYyFlbJjs6u7l4+dCSiNjkZULWlQbZg4br6OanGpuaW+AaEIQgZtgZ2EgiEyocQAPwgALoAvkA");
        Generator reactionGeneratorBob = Generator.fromDataString("reaction:___ N4Ig1gpgniBcICcIEMDGAXAlgewHYgBoR0oAHCOEAZQBUAlASQDkBxQkU7AZy8wCMANhABqyAQFcIXOAG0QMgPIB1JgFE6AOlqNWAWVW6FdAJobcyALYQAugAJOXdF1vJbfFAnaKV6rfWYs+oYmZpY2tgAm2FK4AOTotkhiAlCJKBgg1gC+QA");
        Generator reactionGeneratorEve = Generator.fromDataString("reaction:___ N4Ig1gpgniBcICcIEMDGAXAlgewHYgBoR0oAHCOEAZQBUAlASQDkBxQkU7AZy8wCMANhABqyAQFcIXOAG1qACwgACTFyVdUyXABMxmAF4RtS9POToVFpMm1qA5DJoBBOiwCiNAHS1GrALJufgDydACanlwQqEjoflJcyADmEAC6dp7sdCjamLiJSg7Orh7e9MwsAcFhEVExcTxJqXYE6opK1qiKargQAO5KipiJ8uhq2ABm6po6eobaGUQyQQDqTG50pb4VgSHhuMgAtqlK00q42BYQAG4QuEoAQm4AMgxuwm5KTgKYqMq92OIBMYElACo4XO4vD5ypVdjVohBYvFGmklMg+ACLJxsAglABhZAIbACDIpAC+QA");
        Generator randomNumber =  Generator.fromDataString("randomNumber:___ N4Ig1gpgniBcICcCGA7AJgewLYDkCuWARhAiADQgAuUADhHCDgKoCy5IWAlinALQCM-AMwA6ACwUsSAB5xBogEwBfIA");
        Generator randomNumberInt = Generator.fromDataString("randomNumber:___ N4Ig1gpgniBcICcCGA7AJgewLYDkCuWARhAiADQgAuUADhHCDgKoCy5IWAlinAAwVYkADzgBGUQGYAvkA");

        alice.addGenerator(messageGenerator);
        bob.addGenerator(reactionGeneratorBob);
        bob.addGenerator(randomNumber);
        eve.addGenerator(reactionGeneratorEve);
        carol.addGenerator(randomNumberInt);
        addEntity(alice);
        addEntity(bob);
        addEntity(eve);
        addEntity(carol);

        name = "Alice messages Bob";
        frameScenes.add(new Scene.fromDataString("Introduction:___ N4IghgrgLgFg9gJxALhAKzAEwKaYErYDO2YCAxjNkgDQgC2EhAlmQPIBm7xUKAjAJwA6fgBYArACZevWgCMA5gBk4ZMFCZwAdgFFNmFCADi8CABsA9DEiaouAPoniggA6b5IWg2Zllq9Vt19VDowTRYASU1CODowsDJzADVSeQRQqEE4eXdaKBTsKFZNbBR2MFNiOWx2RGwAMVMwADdEABVsAA8eVEiAAjBesgQAT2coLLTnGBZy02HehGxTbCb0wcRihF64dl7YbF6IMKaqJ0FBD3B2WwQG5rbO7pBLzTA6Ep6bBDhMCDJ-TSXPIIeQFOpMUw3QgoADaAF1aNV2Nh-tDkPCAL5AA")..scenario=this);

        seed = 85;
        rand = new Random(seed);

    }


  @override
  void loadFromSerialization(Map<String, dynamic > serialization) {
    // TODO: implement loadFromSerialization
      //if no seed specified pick a random one
  }

  @override
  Map<String,dynamic > getSerialization() {
    // TODO: implement getSerialization
    return null;
  }

}