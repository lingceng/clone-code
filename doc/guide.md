CloneCode Guide
===============

CloneCode can clone code fast

source HelloWorld.java

    public class HelloWorld {
      public static void main(String[] args) {
        System.out.println("Hello, I'm HelloWorld");
        String helloWorld = "HELLOWORLD";
        System.out.println(helloWorld);   
      }
    }



Run commnad `ruby cc.rb -f HelloWorld -t WellDone -d 'doc/*.java'`, replace **HelloWorld** to **WellDone**

    do with [doc/HelloWorld.java]
    replace [doc/HelloWorld.java] to file [doc/WellDone.java]

result WellDone.java

    public class WellDone {
      public static void main(String[] args) {
        System.out.println("Hello, I'm WellDone");
        String wellDone = "WELLDONE";
        System.out.println(wellDone);   
      }
    }

