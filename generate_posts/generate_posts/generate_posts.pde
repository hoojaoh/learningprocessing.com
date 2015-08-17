String what = "example"; //<>//

String[] chapters = {
  "chp01_drawing", 
  "chp02_processing", 
  "chp03_flow", 
  "chp04_variables", 
  "chp05_conditionals", 
  "chp06_loops", 
  "chp07_functions", 
  "chp08_objects", 
  "chp09_arrays", 
  "chp10_algorithms", 
  "chp11_nothing",
  "chp12_nothing",
  "chp13_mathematics", 
  "chp14_transformations", 
  "chp15_images_pixels", 
  "chp16_video", 
  "chp17_strings", 
  "chp18_data", 
  "chp19_data_streams", 
  "chp20_sound", 
  "chp21_exporting", 
  "chp22_advanced_oop", 
  "chp23_java" 
};

void setup() {
  String path = "/Users/danielshiffman/Documents/LP/LearningProcessing";

  ArrayList<File> todo = new ArrayList<File>();
  File[] files = listFiles(path);
  for (int i = 0; i < files.length; i++) {
    if (files[i].getName().charAt(0) == 'c') {
      File[] subfiles = listFiles(files[i].getAbsolutePath());
      for (int j = 0; j < subfiles.length; j++) {
        if (subfiles[j].getName().length() > 8) {
          String n = subfiles[j].getName().substring(0, what.length()); 
          if (n.equals(what)) {
            todo.add(subfiles[j]);
          }
        }
      }
    }
  }

  for (File f : todo) {
    String name = f.getName();
    println(name);
    String originalname = name;
    //println("Processing: " + name);
    int a = name.indexOf("_");
    int b = name.indexOf("_", a+1);
    int c = name.indexOf("_", b+1);
    String chapter = name.substring(a+1, b);
    String number = name.substring(b+1, c);
    name = name.replaceAll("_", "-");
    PrintWriter output = createWriter(what+"s/2015-08-15-"+name+".html");

    String title = name.substring(c+1, name.length());
    title = title.replaceAll("_", " ");
    title = title.replaceAll("-", " ");

    output.println("---");
    output.println("layout: "+what+"s");
    output.println("permalink: /" + what + "s/chp" + chapter +"/" + name);
    output.println("title: " + title);
    output.println("chapter: " + chapter);
    output.println("number: " + number);
    
    String cdn = "/code/LearningProcessing-p5.js/";
    String chpname = chapters[int(chapter)-1]; 
    
    String raw = "/code/LearningProcessing/";
    output.println("js-files: " + cdn + chpname + "/" + originalname + "/sketch.js");
    output.println("pde-files: " + raw + chpname + "/" + originalname + "/" + originalname + ".pde");
    output.println("group: " + what);
    output.println("---");
    output.flush();
    output.close();
  }

  println("complete");
  exit();
}