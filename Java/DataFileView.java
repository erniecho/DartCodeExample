
public class DataFileView {

    public static void main (String[] args) {
        DataFileController DataFileObject = new DataFileController();
        DataFileObject.setIndex(5);
        System.out.println(DataFileObject.getWord());
        System.out.println(DataFileObject.getDef());
        System.out.println(DataFileObject.getIndex());
        DataFileObject.setIndex(0);
        DataFileObject.subIndex();
        System.out.println(DataFileObject.getWord());
        System.out.println(DataFileObject.getDef());
        System.out.println(DataFileObject.getIndex());
        DataFileObject.setSwitch(false);
        System.out.println(DataFileObject.getWord());
        System.out.println(DataFileObject.getDef());
        System.out.println(DataFileObject.getIndex());
    }
}