
public class DataFileView {

    public static void main (String[] args) {
        DataFileController DataFileObject = new DataFileController();
        DataFileObject.setIndex(0);
        System.out.println(DataFileObject.getWord());
        System.out.println(DataFileObject.getDef());
        System.out.println(DataFileObject.getIndex());
        DataFileObject.setIndex(500);
        DataFileObject.subIndex();
        System.out.println(DataFileObject.getWord());
        System.out.println(DataFileObject.getDef());
        System.out.println(DataFileObject.getIndex());
        System.out.println(DataFileObject.getSwitch());
        DataFileObject.setSwitch(false);
        //DataFileObject.setSwitch(true);
        System.out.println(DataFileObject.getWord());
        System.out.println(DataFileObject.getDef());
        System.out.println(DataFileObject.getIndex());
        System.out.println(DataFileObject.getSwitch());
    }
}